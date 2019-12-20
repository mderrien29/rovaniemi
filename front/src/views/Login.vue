<template>
  <div>
    <form class="login" @submit.prevent="login">
      <h1>Sign in</h1>
      <input required v-model="username" type="string" placeholder="username"/>
      <br/>
      <input
        required v-model="password"
        type="password"
        placeholder="Password"
      />
      <br/>
      <br/>
      <button v-on:click="login" type="submit">Login</button>
    </form>
  </div>
</template>

<script>
export default {
  data(){
    return {
      username: "",
      password: ""
    }
  },
  methods: {
    login: function() {
      let username = this.username;
      let password = this.password;
      this.$store
        .dispatch("login", { username, password })
        .then(() => {
          this.$store.dispatch("getBattles");
          this.$router.push("/")
        });
    }
  }
}
</script>
