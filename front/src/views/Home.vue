<template>
  <div v-if="category" class="home" :key="category.id">
    <h1>{{category.name}}</h1>
    <hr/>
    <div id="addYourSong">
      <label>Ajouter votre chanson !</label>
      <br/>
      <input id="input" type="text" @keyup.enter="submit" />
    </div>
    <hr/>
    <div v-for="song in category.songs" class="song">
      Added by {{song.name}}
      <br/>
      <iframe
        :src="`https://youtube.com/embed/${song.url.substr(song.url.length - 11)}`"
      >
      </iframe>
      <br/>
    </div>
  </div>
</template>

<script>
  // @ is an alias to /src
  export default {
    name: 'home',
    computed: {
      category: function() {
        const categoryId = this.$store.getters.selectCategory;
        if(categoryId !== 0)
        return this.$store.getters.battles[0].categories.find(
          category => category.id == categoryId);
      },
    },
    methods: {
      async submit(e){
        await this.$store.dispatch('addSong', {categoryId: this.category.id, url: e.target.value});
        this.$store.dispatch('getBattles');
        e.target.value = '';
        setTimeout(Location.reload, 3000);
      } 
    }
  };
</script>

<style>
  .home {
    float: right; 
    width: 75vw;
  }
  iframe {
    width: 80% !important; 
    height: auto !important;
  }
</style>

