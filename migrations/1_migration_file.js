// 1_migration_file.js
const CoreContract = artifacts.require("CoreContract");
const BondReceipt = artifacts.require("BondReceipt721");
const MyToken = artifacts.require("MyToken");

const MyUsd = artifacts.require("MyUsd");

module.exports = async function (deployer, network, accounts) {
  //const admin = accounts[0];
  await deployer.deploy(BondReceipt);
  await deployer.deploy(CoreContract, BondReceipt.address); //, admin);
  await deployer.deploy(MyUsd);
  await deployer.deploy(MyToken);

  const bondReceipt = await BondReceipt.deployed();
  await bondReceipt.transferOwnership(CoreContract.address);
};
