const CoreContract = artifacts.require("CoreContract");
const MyUsd = artifacts.require("MyUsd");
const MyToken = artifacts.require("MyToken");
const BondReceipt = artifacts.require("BondReceipt721");

const assert = require("assert");
const truffleAssert = require("truffle-assertions");

contract("basicTestFunction", async (accounts) => {
  const account = accounts[0];
  /*
  it("DepositFunction", async () => {
    const bondCon = await CoreContract.deployed();
    const usd = await MyUsd.deployed();

    await usd.approve(bondCon.address, "10000");
    await bondCon.depositToken(usd.address, "1000");
  });

  it("FindDeposit", async () => {
    const bondCon = await CoreContract.deployed();
    const usd = await MyUsd.deployed();
    const tx = await bondCon.getDepositToken(account, usd.address);
    //console.log(tx)
  });

  it("withdraw Token", async () => {
    const bondCon = await CoreContract.deployed();
    const usd = await MyUsd.deployed();

    await bondCon.withdrawToken(usd.address, "1000");
    const tx = await bondCon.getDepositToken(account, usd.address);
    assert.equal(
      tx.balance.toString(),
      "0",
      "Problem with countability WITHDRAW"
    );
  });

  it("withdraw excess token", async () => {
    const bondCon = await CoreContract.deployed();
    const usd = await MyUsd.deployed();

    await truffleAssert.reverts(
      bondCon.withdrawToken(usd.address, "100000000")
    );
  });
  */

  it("Create  New Bond", async () => {
    const bondCon = await CoreContract.deployed();
    const token = await MyToken.deployed();
    const usd = await MyUsd.deployed();

    await token.approve(bondCon.address, "200000");
    await bondCon.createNewBond(
      token.address, //_tokenCollateral,
      "100000", //_amountCollateral,
      usd.address, //_tokenRequired,
      "10", //_interestCoupon,
      ["10", "15", "30"], //_expireCoupon,
      "1000", //_sizeBond,
      "100" //_amountAvvalible
    );
    await bondCon.createNewBond(
      token.address, //_tokenCollateral,
      "1000", //_amountCollateral,
      usd.address, //_tokenRequired,
      "8", //_interestCoupon,
      ["10", "15", "30"], //_expireCoupon,
      "200", //_sizeBond,
      "10" //_amountAvvalible
    );
  });
  it("take me bond's  informations", async () => {
    const bondCon = await CoreContract.deployed();

    const tx = await bondCon.getBondList(account);
  });
  it("buy two Bonds", async () => {
    const bondCon = await CoreContract.deployed();
    const bondReceipt = await BondReceipt.deployed();
    const usd = await MyUsd.deployed();

    await usd.approve(bondCon.address, "2000");
    await bondCon.buyBond(2, account, 0);

    const bal = await bondReceipt.balanceOfBonds(account, 0);
    assert.equal(bal.toString(), "2", "balance don't correct");
    //console.log(bal.toString())
  });
  it("Take me information on receipt", async () => {
    const bondReceipt = await BondReceipt.deployed();

    const inf = await bondReceipt.getInformationReceipt(1);

    //console.log(inf);
  });
  it("take me Receipt's list", async ()=>{
    //getListBondReceipts
    const bondCon = await CoreContract.deployed();

    const list = await bondCon.getListBondReceipts(0);

    // verify with plus cases
    //console.log(list.toString())
  })
});
