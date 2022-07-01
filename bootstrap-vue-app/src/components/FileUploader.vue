<template>
  <div id="FileUploader">
    <b-form-file
      v-model="files"
      v-if="address!==null"
      :state="Boolean(files)"
      placeholder="Choose a file or drop it here..."
      :multiple="true"
    ></b-form-file>

    <p v-if="address===null">Make 1 ether payment to upload file. </p>
    
    <br />
    <br />

    <b-button-group v-if="sending===false">
      <b-button
        v-if="address===null"
        variant="secondary"
        @click="requestAccount()"
      > 
        Connect My Wallet
      </b-button>


      <b-button
        v-if="address!==null"
        variant="primary"
        @click="uploadFile(files)"
      > 
        Upload via IPFS
      </b-button>
      
    </b-button-group>

    <p v-if="address!==null && sending===false">Connected wallet: {{ address[0] }}</p>

    <div v-if="sending===true">
      <b-spinner label="Spinning"></b-spinner>
      <b-card-text>Sending to IPFS</b-card-text>
    </div>


  </div>
</template>

<script>
  import { Web3Storage } from 'web3.storage';
  import Dwetransfer from '../../artifacts/contracts/Dwetransfer.sol/Dwetransfer.json'
  import { BigNumber, ethers } from "ethers";

  export default {
    name: "FileUploader",
    data() {
      return {
        files: null,
        sending: false,
        address: null,
        fileId: null,
      }
    },
    methods: {

      async requestAccount() {
        var currentAccount = null;

        if(window.ethereum) {
          console.log("Metamask detected");
        } else {
          console.log("Metamask not detected...");
        }

        currentAccount = await window.ethereum.request({ method: 'eth_requestAccounts' });

        this.address = currentAccount;
        
        console.log("Current Account :" + currentAccount);
      },

      async uploadFile(files) {
        console.log(files);

        const client = new Web3Storage({ token: process.env.VUE_APP_WEB3STORAGE_API_TOKEN });

        const contractAddress = "0x5FbDB2315678afecb367f032d93F642f64180aa3";
        const provider = new ethers.providers.Web3Provider(window.ethereum);
        const signer = provider.getSigner()

        try {
          const contract = new ethers.Contract(contractAddress, Dwetransfer.abi, signer)
          const options = {value: ethers.utils.parseEther("1")};
          let rootCid = "";

          
          try {
              this.sending = true;
              rootCid = await client.put(files);
              console.log("Successfully sent to IPFS");
              console.log("rootCid :" + [rootCid]);
          } catch {
            this.sending = false;
            this.$emit('update-error', true);
            console.log("Failed to send file... ");
          }

          let tx = await contract.uploadFile(rootCid, options);
          let rc = await tx.wait();
          let BigNumberFileIdHex = rc.events[0].args["fileId"]._hex;
          this.fileId = BigNumber.from(BigNumberFileIdHex).toNumber();
          console.log(tx);
          console.log("rc:");
          console.log(rc);
          console.log(rc.events[0].args["fileId"]._hex);
          console.log("fileId");
          console.log(this.fileId);

          this.sending = false;
          this.$emit('update-fileid', this.fileId);
          this.$emit('update-cids', [rootCid]);
          console.log("contract executed successfully!")
          console.log("https://localhost:8080/download/" + this.fileId);
          
            
        } catch {
            this.$emit('update-error', true);
            console.log("Failed to execute contract!");
        }
      } 
    }
  }
</script>