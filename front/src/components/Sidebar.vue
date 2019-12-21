<template>
  <div id="sidenav" v-if="isLoggedIn">
    <div v-if="isLoggedIn" id="connectionStatus">
      connected as {{username}}
      <button v-on:click="logout">Logout</button>
    </div>

    <h2>{{battles[0].name}}</h2>
    <div v-for="category in battles[0].categories">
      <br />
      <button class="catButton" v-on:click="selectCategory(category.id)">
        {{category.name}}
      </button>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'Sidebar',
    computed: {
      battles: function() {
        return this.$store.getters.battles;
      },
      isLoggedIn: function() {
        return this.$store.getters.isLoggedIn;
      },
      username: function() {
        return this.$store.getters.username;
      },
    },
    methods: {
      selectCategory(id) {
        this.$store.commit('selectCategory', id);
      },
      logout: function() {
        this.$store.dispatch('logout').then(() => {
          this.$router.push('/login');
        });
      },
    },
    created() {
      this.$store.subscribe((mutation, state) => {
        if (mutation.type === 'loadCategories') {
          console.log('updating sidebar');
          this.$forceUpdate();
        }
      });
    },
  };
</script>

<style scoped>
  #sidenav {
    width: 20vw;
    height: 100vh;
    float: left;
    box-sizing: border-box;
    padding: 10px;
    background-color: lightblue;
  }

  .catButton {
    color: #494949 !important;
    text-transform: uppercase;
    text-decoration: none;
    background: #ffffff;
    padding: 20px;
    border: 4px solid #494949 !important;
    display: inline-block;
    transition: all 0.4s ease 0s;
  }

  .catButton:hover {
    color: #ffffff !important;
    background: #03c2fc;
    border-color: #03c2fc !important;
    transition: all 0.4s ease 0s;
  }
</style>
