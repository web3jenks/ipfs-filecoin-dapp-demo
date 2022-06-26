<template>
  <div id="app">
      <b-container>
        <b-card
          id="uploadcard"
          style="max-width: 30rem;"
          padding=40
        >
        <b-card-img :src="require('./assets/dwetransfer-logo.png')" />
        <b-card-title>WeTransfer in the Web 3.0</b-card-title>

        <FileUploader 
          v-if="
            error === false && 
            cids.length === 0 && 
            sending === false
            "
            @update-cids="updateCids" @update-error="updateError" 
        />
        <Success
          v-if="
            cids.length !== 0
            "
            @update-cids="updateCids"
        />
        <Error 
          v-if="
            error === true
            " 
            @update-error="updateError"
        />

        <br/>

        </b-card>
      </b-container>
  </div>
</template>

<script>
import FileUploader from "./components/FileUploader.vue";
import Success from "./components/Success.vue";
import Error from "./components/Error.vue";

export default {
  name: 'App',
  components: {
    FileUploader,
    Success,
    Error
  },
  data() {
    return {
      cids: [],
      sending: false,
      error: false
    }
  },
  methods: {
    updateCids(c) {
      this.cids = c
    },
    updateError(e) {
      this.error = e
    }
  }
}
</script>

<style>
#app {
  background-image: url('./assets/background.jpg');
  padding: 25px
}

#uploadcard {
  margin: 25px
}
</style>
