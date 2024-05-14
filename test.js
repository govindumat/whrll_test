const {Web3} = require("web3")
require('dotenv').config()
infura_key = process.env.INFURA_ID;
private_key = process.env.PRIVATE_KEY;
const web3 = new Web3( new Web3.providers.HttpProvider(infura_key))

const ABI = require("./ABI.json");

const contractAddr = "0xC92e4e0aF842d6c1Ec195aBf467D3992F351dd3b";

const contract= new web3.eth.Contract(ABI,contractAddr);

async function mintToken(){
     const account = "0xBd0aDEFb7360889f410d12F6B9AC507DD4d4643B";

     const tokenid = 1;
     const uri = "abc"; 

     try {
        const tx = await contract.methods.safeMint(account, tokenid, uri).send({
            from:"0xBd0aDEFb7360889f410d12F6B9AC507DD4d4643B",
            to: contractAddr,

        })

        const signedTx = await web3.eth.accounts.signTransaction(tx, private_key);

        // const signed  = await web3.eth.sendTransaction(tx,private_key);
        const receipt = await web3.eth.sendSignedTransaction(signedTx.rawTransaction);
        console.log(receipt.wait()) // print receipt


     } catch (error) {
        console.log("error : ",error);
     }
}

mintToken();