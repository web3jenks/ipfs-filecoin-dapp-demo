<template>
  <div id="FileUploader">
    <b-form-file
      v-model="files"
      :state="Boolean(files)"
      placeholder="Choose a file or drop it here..."
      :multiple="true"
    ></b-form-file>

    <br />
    <br /> 

    <b-button
      v-if="sending===false"
      variant="primary"
      @click="uploadFile(files)"
    > 
      Upload via IPFS
    </b-button>

    <div v-if="sending===true">
      <b-spinner label="Spinning"></b-spinner>
      <b-card-text>Sending to IPFS</b-card-text>
    </div>


  </div>
</template>

<script>
import { Web3Storage } from 'web3.storage';

  export default {
    name: "FileUploader",
    data() {
      return {
        files: null,
        sending: false
      }
    },
    methods: {
      async uploadFile(files) {
        console.log(files);
        
        const client = new Web3Storage({ token: process.env.VUE_APP_WEB3STORAGE_API_TOKEN });

        try {
            this.sending = true;
            const rootCid = await client.put(files);
            this.sending = false;
            this.$emit('update-cids', [rootCid]);
            console.log("Successfully sent to IPFS");
            console.log("https://" + rootCid + ".ipfs.dweb.link");
            console.log("rootCid :" + [rootCid]);
            
        } catch {
            this.$emit('update-error', true);
            console.log("Failed to send to IPFS");
        }
      }
      
    }
  }
</script>