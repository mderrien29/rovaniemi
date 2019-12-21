<template>
  <div id="nav">
      </div>
</template>

<script>
  export default {
    name: 'navbar',
    computed: {
      isLoggedIn: function() {
        return this.$store.getters.isLoggedIn;
      },
          },
    methods: {
          },
  };
</script>

<style scoped>
  #nav {
    width: 100%;
    height: 30px;
    background-color: lightgray;
    border: solid black 1px;
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
