// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract MyToken is ERC20("MyToken", "MYT") {
    address _owner;

    modifier onlyOwner() {
        require(msg.sender == _owner, "not owner");
        _;
    }

    constructor() {
        _owner = msg.sender;
    }

    function mint(address account, uint256 amount) external onlyOwner {
        _mint(account, amount);
    }
}
