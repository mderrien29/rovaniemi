<template>
  <div v-if="category.id" class="home" :key="category.id">
    <div id="title">
      <h1>{{category.name}}</h1>
      <hr />
      <div id="addYourSong">
        <label
          >Ajoutez ou modifiez votre choix (lien youtube uniquement, appuyez sur
          entrée)</label
        >
        <br />
        <input
          id="input"
          type="text"
          @keyup.enter="submit"
          placeholder="https://www.youtube.com/watch?v=yXQViqx6GMY"
        />
      </div>
    </div>
    <hr />
    <div class="songs">
      <div v-for="song in category.songs" class="song">
        Added by {{song.name}}
        <br />
        <iframe
          :src="`https://youtube.com/embed/${song.url.substr(song.url.length - 11)}`"
        >
        </iframe>
        <br />
      </div>
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
        if (categoryId !== 0)
          return this.$store.getters.battles[0].categories.find(
            category => category.id == categoryId,
          );
      },
    },
    methods: {
      async submit(e) {
        await this.$store.dispatch('addSong', {
          categoryId: this.category.id,
          url: e.target.value,
        });
        await this.$store.dispatch('getBattles');
        e.target.value = '';
        setTimeout(() => location.reload(), 3000);
      },
    },
    created() {
      this.$store.dispatch('getBattles');
    },
  };
</script>

<style>
  .home {
    float: right;
    width: 80%;
  }
  .songs {
    overflow-y: scroll; 
  }
  #title {
    margin-bottom: 30px;
  }
  iframe {
    width: 80% !important;
    height: auto !important;
  }
  input {
    width: 80%;
  }
</style>
