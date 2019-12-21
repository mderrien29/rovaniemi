import Vue from 'vue';
import Vuex from 'vuex';
import {getToken, getBattles, getCategories, getSongs, addSong} from './request';

Vue.use(Vuex);

interface User {
  username?: string;
}

export default new Vuex.Store({
  state: {
    status: '',
    username: '',
    token: localStorage.getItem('token') || '',
    battles: [] as any,
    selectedCategoryId: 0,
  },
  mutations: {
    auth_success(state, {token, user}) {
      state.status = 'success';
      state.username = user.username;
      state.token = token;
    },
    logout(state) {
      state.status = '';
      state.token = '';
    },
    loadBattle(state, battle: any) {
      state.battles[0] = battle;
    },
    loadCategories(state, {battleId, categories}){
      const battles = state.battles;
      battles.find((battle:any) => battle.id == battleId).categories = categories;
      state.battles = battles;
    },
    loadSongs(state, {battleId, categoryId, songs}){
      const battles = state.battles;
      battles.find((battle:any) => battle.id == battleId)
        .categories.find( (category: any) => category.id === categoryId).songs = songs;
      state.battles = battles;

      console.log(state.battles);
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
      if(this.getters.battles.length > 0) return;

      try {
        const battles = await getBattles(this.getters.token);
        commit('loadBattle', battles[0]); // only the first battle for now

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
      console.log('addsong')
      return addSong(this.getters.token, categoryId, url);
    }
  },
  getters: {
    isLoggedIn: state => !!state.token,
    token: state => state.token,
    authStatus: state => state.status,
    username: state => state.username,
    battles: state => state.battles,
    selectCategory: state => state.selectedCategoryId,
  },
  modules: {},
});
