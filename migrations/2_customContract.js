const customContract = artifacts.require("customContract");

module.exports = function (deployer) {
  deployer.deploy(customContract);
};
  