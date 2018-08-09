const JobsBounty = artifacts.require("JobsBounty");
const IndorseToken = artifacts.require('IndorseToken');

module.exports = function(deployer) {
  // Here we are using the following constructor params for the JobsBounty deploy
  // companyName    = "Indorse"
  // jobPost        = "https://indorse.io/jobs/test_post"
  // endDate        = 1577836800 (1-Jan-2020)  
  // INDToken       = [deployed IND ERC20 token contract address]

  // "0x25a4342fF3E4bF62Ab0b7E0fC3641942F6303a0A", "0xB26c5098Dd0Cb96BfBC137cADF7270D358Ec55D4"
  // "Indorse", "https://indorse.io/jobs/test_post", 1420070400, "0x70a37bf15544f560550ece9980709bb835044204"

  let INDTokenInstance;
  let jobsBountyInstance;

  // We need to use a promise chain to deploy an IND token contract first, then the JobsBounty contract and then transfer some IND into it

  // First deploy the IND ERC20 token contract
  deployer.deploy(IndorseToken)
  .then((instance) => {
    INDTokenInstance = instance;

    console.log(INDTokenInstance.address);

    // Now deploy the JobsBounty using the new IND ERC20 contract address
    return deployer.deploy(JobsBounty, "Indorse", "https://indorse.io/jobs/test_post", 1420070400, INDTokenInstance.address);
  })
  .then((instance) => {
    jobsBountyInstance = instance;

    // Now we have an IND ERC20 token contract and a JobsBounty contract deployed we can transfer some IND into it
    return INDTokenInstance.transfer(jobsBountyInstance.address, 1000);
  });
};