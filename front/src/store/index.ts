import Vue from 'vue';
import Vuex from 'vuex';
import {getToken, getBattles, getCategories, getSongs} from './request';

Vue.use(Vuex);

interface User {
  username?: string;
}

export default new Vuex.Store({
  state: {
    status: '',
    username: '',
    token: localStorage.getItem('token') || '',
    battles: [],
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
      try {
        const battles = await getBattles(this.getters.token);
        battles.forEach( async (battle: {id: number, categories: []}) => {
          battle.categories = await getCategories(this.getters.token, battle.id);
          battle.categories.forEach( async (category: {id: number, songs: []}) => {
            category.songs = await getSongs(this.getters.token, category.id);
          });
        });

        console.log(battles);
      } catch(err) {
        console.log(err);
      }
    }
  },
  getters: {
    isLoggedIn: state => !!state.token,
    token: state => state.token,
    authStatus: state => state.status,
    username: state => state.username,
    battles: state => state.battles,
  },
  modules: {},
});
