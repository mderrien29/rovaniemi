import Vue from 'vue';
import Vuex from 'vuex';
import {getToken, getBattles, getCategories, getSongs, addSong} from './request';
import VuexPersist from 'vuex-persist';

Vue.use(Vuex);
const vuexPersist = new VuexPersist({
  key: 'rovaniemi',
  storage: window.sessionStorage
});

interface User {
  username?: string;
}

export default new Vuex.Store({
  plugins: [vuexPersist.plugin],
  state: {
    status: '',
    username: '',
    token: localStorage.getItem('token') || '',
    battles: [] as any,
    selectedCategoryId: 0,
  },
  mutations: {
    auth_success(state: any, {token, user}) {
      state.status = 'success';
      state.username = user.username;
      state.token = token;
    },
    logout(state) {
      state.status = '';
      state.token = '';
    },
    loadBattles(state, battles: any) {
      console.log(`loadBattles: ${JSON.stringify(battles)}`);
      state.battles = battles;
    },
    loadCategories(state, {battleId, categories}){
      state.battles.find((battle:any) => battle.id == battleId).categories = categories;
    },
    loadSongs(state, {battleId, categoryId, songs}){
      state.battles.find((battle:any) => battle.id == battleId)
        .categories.find( (category: any) => category.id === categoryId).songs = songs;
    },
    selectCategory(state, id: number){
      state.selectedCategoryId = id;
    }
  },
  actions: {
    logout({commit}) {
      return new Promise((resolve, reject) => {
        commit('logout');
        localStorage.removeItem('token');
        localStorage.removeItem('username');
        resolve();
      });
    },
    async login({commit}, user) {
      try {
        const token = await getToken(user.username, user.password);
        commit('auth_success', {token, user});
      } catch (err) {
        console.log(err);
      }
    },
    async getBattles({commit}) {
      console.log("getting data...")

      try {
        const battles = await getBattles(this.getters.token);
        commit('loadBattles', battles);

        battles.forEach( async (battle: any) => {
          const categories = await getCategories(this.getters.token, battle.id);
          commit('loadCategories', {battleId: battle.id, categories});

          categories.forEach( async (category: any) => {
            const songs = await getSongs(this.getters.token, category.id);
            commit('loadSongs', {battleId: battle.id, categoryId: category.id, songs });
          });
        });

      } catch(err) {
        console.log(err);
      }
    },
    async addSong({commit}, {categoryId, url}){
      return addSong(this.getters.token, categoryId, url);
    }
  },
  getters: {
    isLoggedIn: state => !!state.token,
    token: state => state.token,
    authStatus: state => state.status,
    username: state => state.username,
    battles: state => state.battles,
    selectedCategory: state => state.selectedCategoryId,
  },
  modules: {},
});
