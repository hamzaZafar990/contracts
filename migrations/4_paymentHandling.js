const paymentHandling = artifacts.require("paymentHandling");

module.exports = function (deployer) {
  deployer.deploy(paymentHandling);
};
