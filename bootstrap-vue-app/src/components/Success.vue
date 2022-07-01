<template>
  <div>
    <b-card-text>
      <b-alert show variant="info">Files have been sent to Web3.Storage & IPFS successfully</b-alert>
      <ul> 
        <li><a :href="'http://localhost:8080/#/?downloadfileid=' + fileId">http://localhost:8080/#/?downloadfileid={{ fileId }}</a></li>
      </ul>
      <b-button
        @click="$emit('update-cids', [])"
        variant="primary"
      >
        Go Back
      </b-button>
    </b-card-text>
  </div>
</template>

<script>

export default {
  name: 'SuccessPage',
  props: {
    fileId: Number
  }
}

</script>

<style >
</style>
