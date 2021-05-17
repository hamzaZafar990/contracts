const escrow = artifacts.require("escrow");

module.exports = function (deployer) {
  deployer.deploy(escrow);
};
