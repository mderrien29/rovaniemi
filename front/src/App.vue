<template>
  <div id="app">
    <Navbar />
    <Sidebar />
    <router-view />
  </div>
</template>

<script>
  import Navbar from '@/components/Navbar.vue';
  import Sidebar from '@/components/Sidebar.vue';

  export default {
    components: {
      Navbar,
      Sidebar,
    },
  };
</script>

<style lang="scss">
  #app {
    font-family: 'Avenir', Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-align: center;
    color: #2c3e50;
    width: 100%;
    min-height: 100vh;
    margin: 0;
    padding: 0;
    overflow: hidden;
  }

  body {
    margin: 0; 
  }
</style>
