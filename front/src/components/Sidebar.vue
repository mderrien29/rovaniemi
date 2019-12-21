<template>
  <div id="sidenav" v-if="isLoggedIn">
    <h2>{{battles[0].name}}</h2>
    <button v-for="category in battles[0].categories" v-on:click="selectCategory(category.id)">{{category.name}}</button>
  </div>
</template>

<script>

  export default {
    name: 'Sidebar',
    computed: {
      battles: function(){
        return this.$store.getters.battles; 
      },
      isLoggedIn: function(){
        return this.$store.getters.isLoggedIn; 
      }
    },
    methods: {
      selectCategory(id) {
        this.$store.commit('selectCategory', id);
      }
    },
    created() {
      this.$store.subscribe((mutation, state) => {
        if(mutation.type === 'loadCategories'){
          this.$forceUpdate();
        }
      }) 
    }
  };
</script>

<style>
  #sidenav {
    width: 20vw;
    height: 100vh;
    float: left;
    border: solid black 1px;
  }
</style>
