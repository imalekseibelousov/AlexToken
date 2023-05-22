// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "Users\Aleksei\Desktop\Solidity Projects\alex-token\contracts\AlexToken.sol";

import "@openzeppelin/contracts/access/Ownable.sol";

contract AlexTokenExchangeForETH is Ownable {

  AlexToken AXT;

  uint256 public tokensPerEth = 100;

  event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);

  constructor(address tokenAddress) {
    AXT = AlexToken(tokenAddress);
  }

  function buyTokens() public payable returns (uint256 tokenAmount) {
    require(msg.value > 0, "Send ETH to buy AlexToken");

    uint256 amountToBuy = msg.value * tokensPerEth;

    uint256 Balance = AXT.balanceOf(address(this));
    require(Balance >= amountToBuy, "Contract does not have enough tokens in its balance");

    (bool sent) = AXT.transfer(msg.sender, amountToBuy);
    require(sent, "Failed to transfer the token to this address");

    emit BuyTokens(msg.sender, msg.value, amountToBuy);

    return amountToBuy;
  }