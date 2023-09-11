const { expect } = require("chai");
const { ethers } = require("hardhat");
describe("Token contract", function () {
  // ...previous test...

  it("Should transfer tokens between accounts", async function () {
    const [owner, addr1, addr2] = await ethers.getSigners();

    const hardhatToken = await ethers.deployContract("Lending");

    // Người cho vay kí gửi tiền vào hợp đồng
    await hardhatToken.connect(addr1).Deposit(50);
    expect(await hardhatToken.lenderdeposit[addr1.address].deposited).to.equal(
      50
    );

    // Người cho vay rút tiền từ hợp đồng
    await hardhatToken.connect(addr1).withDraw(10);
    expect(await hardhatToken.lenderdeposit[addr1.address].deposited).to.equal(
      40
    );
  });
});
