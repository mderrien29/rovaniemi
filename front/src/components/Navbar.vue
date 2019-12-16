<template>
  <div id="nav">
    <router-link to="/">Home</router-link> |
    <button v-on:click="logout">Logout</button>
  </div>
</template>

<script>
export default {
  name: "navbar",
  computed: {
    isLoggedIn: function() {
      return this.$store.getters.isLoggedIn;
    }
  },
  methods: {
    logout: function(){
      this.$store.dispatch("logout").then(() => {
        this.$router.push("/login")
      });
    }
  }
}
</script>

