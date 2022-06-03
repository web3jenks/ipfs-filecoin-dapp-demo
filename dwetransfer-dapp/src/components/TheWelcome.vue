<script setup>
import WelcomeItem from './WelcomeItem.vue'
import DocumentationIcon from './icons/IconDocumentation.vue'
import ToolingIcon from './icons/IconTooling.vue'
import EcosystemIcon from './icons/IconEcosystem.vue'
import CommunityIcon from './icons/IconCommunity.vue'
import SupportIcon from './icons/IconSupport.vue'
import Greeter from '../../artifacts/contracts/Greeter.sol/Greeter.json'
import Dwetransfer from '../../artifacts/contracts/Greeter.sol/Dwetransfer.json'
import { ethers } from "ethers";


var currentAccount = null;
// const contractAddress = "0x5FbDB2315678afecb367f032d93F642f64180aa3";
// const contractAddress = "0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512";
const contractAddress = "0x5FbDB2315678afecb367f032d93F642f64180aa3";

console.log("currentAccount:" + currentAccount);

async function requestAccount() {
  currentAccount = await window.ethereum.request({ method: 'eth_requestAccounts' });
  console.log(currentAccount);
}

async function uploadFile() {
  console.log("uploadFile fired...");
    const provider = new ethers.providers.Web3Provider(window.ethereum)
    signer = provider.getSigner()
    const contract = new ethers.Contract(contractAddress, Dwetransfer.abi, provider)
    try {
      const data = await contract.uploadFile(1,"bafybeib5vdjq4aclwfolc4f3ajcnef4iutd7v7lkiq3savagrtlbwqlbti")
      console.log('data: ', data)
    } catch (err) {
      console.log("Error: ", err)
    } 
}
</script>

<template>
  <WelcomeItem>
    <template #icon>
      <SupportIcon />
    </template>
    <template #heading>Greeter ABI</template>

    <p>Greeter.abi: {{ Greeter.abi }}</p>

    <p>Dwetransfer.abi: {{ Dwetransfer.abi }}</p>

    <div v-if="currentAccount = []">
        <button class="primaryButton" @click="requestAccount">Connect Wallet</button>
    </div>

    <div v-if="currentAccount != []">
      <button class="primaryButton" @click="uploadFile">Upload File</button>
    </div>
  </WelcomeItem>
  <WelcomeItem>
    <template #icon>
      <DocumentationIcon />
    </template>
    <template #heading>Documentation</template>

    Vue’s
    <a target="_blank" href="https://vuejs.org/">official documentation</a>
    provides you with all information you need to get started.
  </WelcomeItem>

  <WelcomeItem>
    <template #icon>
      <ToolingIcon />
    </template>
    <template #heading>Tooling</template>

    This project is served and bundled with
    <a href="https://vitejs.dev/guide/features.html" target="_blank">Vite</a>. The recommended IDE
    setup is <a href="https://code.visualstudio.com/" target="_blank">VSCode</a> +
    <a href="https://github.com/johnsoncodehk/volar" target="_blank">Volar</a>. If you need to test
    your components and web pages, check out
    <a href="https://www.cypress.io/" target="_blank">Cypress</a> and
    <a href="https://docs.cypress.io/guides/component-testing/introduction" target="_blank"
      >Cypress Component Testing</a
    >.

    <br />

    More instructions are available in <code>README.md</code>.
  </WelcomeItem>

  <WelcomeItem>
    <template #icon>
      <EcosystemIcon />
    </template>
    <template #heading>Ecosystem</template>

    Get official tools and libraries for your project:
    <a target="_blank" href="https://pinia.vuejs.org/">Pinia</a>,
    <a target="_blank" href="https://router.vuejs.org/">Vue Router</a>,
    <a target="_blank" href="https://test-utils.vuejs.org/">Vue Test Utils</a>, and
    <a target="_blank" href="https://github.com/vuejs/devtools">Vue Dev Tools</a>. If you need more
    resources, we suggest paying
    <a target="_blank" href="https://github.com/vuejs/awesome-vue">Awesome Vue</a>
    a visit.
  </WelcomeItem>

  <WelcomeItem>
    <template #icon>
      <CommunityIcon />
    </template>
    <template #heading>Community</template>

    Got stuck? Ask your question on
    <a target="_blank" href="https://chat.vuejs.org">Vue Land</a>, our official Discord server, or
    <a target="_blank" href="https://stackoverflow.com/questions/tagged/vue.js">StackOverflow</a>.
    You should also subscribe to
    <a target="_blank" href="https://news.vuejs.org">our mailing list</a> and follow the official
    <a target="_blank" href="https://twitter.com/vuejs">@vuejs</a>
    twitter account for latest news in the Vue world.
  </WelcomeItem>

  <WelcomeItem>
    <template #icon>
      <SupportIcon />
    </template>
    <template #heading>Support Vue</template>

    As an independent project, Vue relies on community backing for its sustainability. You can help
    us by
    <a target="_blank" href="https://vuejs.org/sponsor/">becoming a sponsor</a>.
  </WelcomeItem>
</template>
