// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract AlexToken is ERC20 {

    address payable public owner;
    uint256 _totalSupply;
    mapping(address => uint256) private _balances;

    constructor(uint256 UnlimitedSupplyOfTheToken) ERC20("AlexToken", "AXT") {
        owner = payable(msg.sender);
        _mint(msg.sender, UnlimitedSupplyOfTheToken);
    }

    function _mint(address account, uint256 amount) internal virtual override {
        require(account != address(0), "mint to the invalid address");

        _beforeTokenTransfer(address(0), account, amount);

        _totalSupply += amount;
        _balances[account] += amount;
        emit Transfer(address(0), account, amount);

        _afterTokenTransfer(address(0), account, amount);
    }

    function _transfer(
        address buyer,
        address seller,
        uint256 amount
    ) internal virtual override {
        require(buyer != address(0), "Transfer from the unknown address");
        require(seller != address(0),"Transfer to the unknown address");

        _beforeTokenTransfer(buyer, seller, amount);
        
        uint256 buyerBalance = _balances[buyer];
        require(buyerBalance >= amount, "Insuficient funds");
        unchecked {
            _balances[buyer] = buyerBalance - amount;
        }
        _balances[seller] +=amount;
        
        emit Transfer(buyer, seller, amount);

        _afterTokenTransfer(buyer, seller, amount);
    }
}