import Web3 from 'web3';
import { abi } from './abi/abi.js';

const web3 = new Web3(new Web3.providers.HttpProvider("https://ropsten.infura.io/v3/17634bdcbec14cdcbdaffbcefbde6b17"));

const contract_address = "0xBBb24899Df82d7810a999459543175c2ABBdDE33";
const PoolContract = new web3.eth.Contract(abi, contract_address);

console.log("Total deposited ETH", await PoolContract.methods.depositETH().call());
