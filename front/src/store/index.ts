import Vue from "vue";
import Vuex from "vuex";

Vue.use(Vuex);

interface User {
  username?: string
}

export default new Vuex.Store({
  state: {
    status: "",
    token: localStorage.getItem("token") || "",
  },
  mutations: {
    auth_success(state, token){
      state.status = "success"
      state.token = token
    },
    logout(state){
      state.status = ""
      state.token = ""
    },
  },
  actions: {
    logout({ commit }){
      return new Promise((resolve, reject) => {
        commit("logout")
        localStorage.removeItem("token")
        resolve()
      })
    },
    login({ commit }, user){
      return new Promise((resolve, reject) => {
        console.log("in login"); // tslint:disable-next-line:no-console
        (async () => {})()
          .then(() => {
            const token = "1234567abc";
            localStorage.setItem("token", token);
            commit("auth_success", token);
            resolve();
          })
          .catch(err => {
            localStorage.removeItem("token");
            reject();
          })
      })
    },
  },
  getters: {
    isLoggedIn: state => !!state.token,
    authStatus: state => state.status
  },
  modules: {}
});
