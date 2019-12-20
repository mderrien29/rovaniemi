<template>
  <div id="nav">
    <div v-if="isLoggedIn" id="connectionStatus">
      connected as {{username}}
      <button v-on:click="logout">Logout</button>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'navbar',
    computed: {
      isLoggedIn: function() {
        return this.$store.getters.isLoggedIn;
      },
      username: function() {
        return this.$store.getters.username;
      },
    },
    methods: {
      logout: function() {
        this.$store.dispatch('logout').then(() => {
          this.$router.push('/login');
        });
      },
    },
  };
</script>

<style scoped>
  #nav {
    width: 100%;
    height: 100px;
    background-color: lightgray;
  }

  #connectionStatus {
    float: right;
  }

  #nav {
    a {
      font-weight: bold;
      color: #2c3e50;

      &.router-link-exact-active {
        color: #42b983;
      }
    }
  }
</style>
