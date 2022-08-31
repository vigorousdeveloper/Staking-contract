//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract ETHPool is AccessControl {
    using SafeMath for uint256;

    event Deposit(address indexed _address, uint256 _value);
    event Withdraw(address indexed _address, uint256 _value);

    bytes32 public constant ETH_TEAM = keccak256("ETH_TEAM");

    uint256 public depositETH;
  
    address[] public stakers;

    address private admin;
    uint256 lastUpdated;
    uint256 public constant WEEKLY = 86400 * 7 * 1000;
      
    struct DepositData {
        uint256 value;
        bool hasValue;
    }

    mapping(address => DepositData) public deposits;

    constructor() {
        _setupRole(ETH_TEAM, msg.sender);
    }

    receive() external payable {
        if(!deposits[msg.sender].hasValue) // only pushes new stakers
            stakers.push(msg.sender);

        deposits[msg.sender].value = deposits[msg.sender].value.add(msg.value);
        deposits[msg.sender].hasValue = true;

        depositETH = depositETH.add(msg.value);

        emit Deposit(msg.sender, msg.value);
    }
    
    function depositRewards() public payable onlyRole(ETH_TEAM)  {
        require(lastUpdated == 0 || lastUpdated + WEEKLY >= block.timestamp , "Admin or ETHPool team can't deposit rewards more than two within a week");
        require(depositETH > 0); // No rewards to distribute if the pool is empty.

        uint256 length = stakers.length;
        for (uint i = 0; i < length; i++){
            
           address user = stakers[i];

           uint256 rewards = (deposits[user].value.mul(msg.value)).div(depositETH);

           deposits[user].value = deposits[user].value.add(rewards);
        }
        
        lastUpdated = block.timestamp;
    }

    function withdraw() public {
        uint256 deposit = deposits[msg.sender].value;
        
        require(deposit > 0, "You don't have anything left to withdraw");

        deposits[msg.sender].value = 0;

        payable(msg.sender).transfer(deposit);

        emit Withdraw(msg.sender, deposit);
    }
}