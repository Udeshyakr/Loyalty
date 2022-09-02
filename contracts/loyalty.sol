// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract loyalty {
    address _admin;
    IERC20 _token;

    modifier onlyAdmin() {
        require(msg.sender == _admin, "not admin");
        _;
    }

    mapping(address => uint256) private _points;

    constructor(address token) {
        _admin = msg.sender;
        _token = IERC20(token);
    }

    function addPoints(address account, uint256 points) external onlyAdmin {
        require(points > 0, "you recieved zero points");
        require(account != address(0), "address cannot be zero");
        _points[account] = points;
    }

    function claimloyalty() external {
        uint256 points = _points[msg.sender];
        require(points > 0, "zero points");
        require(_token.balanceOf(address(this)) >= points, "No loyalty");
        _token.transfer(msg.sender, points);
    }
}
