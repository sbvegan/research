// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "@openzeppelin/contracts/math/SafeMath.sol";

contract Fallback {
    using SafeMath for uint256;
    // maps addresses to the amount they have contributed
    mapping(address => uint256) public contributions;
    // owner address
    address payable public owner;

    // sets the owner to the deployer of the contract
    // sets the owners contributions to 1000ETH
    constructor() public {
        owner = msg.sender;
        contributions[msg.sender] = 1000 * (1 ether);
    }

    // modifier that only allows the owner to call the function
    modifier onlyOwner() {
        require(msg.sender == owner, "caller is not the owner");
        _;
    }

    // payable function to contribute ETH to the contract
    function contribute() public payable {
        require(msg.value < 0.001 ether); // contributions must be < 0.001ETH
        contributions[msg.sender] += msg.value; // updates the contribution mapping

        // possible way to become the owner, looks like this was a red herring
        // if personal contributions are greater than owner contributrions
        if (contributions[msg.sender] > contributions[owner]) {
            owner = msg.sender; // I'm the owner now.
        }
    }

    // returns the amount the contributor has made
    function getContribution() public view returns (uint256) {
        return contributions[msg.sender];
    }

    // withdraw the balance of the contract to the owner
    function withdraw() public onlyOwner {
        owner.transfer(address(this).balance);
    }

    // fallback function
    receive() external payable {
        // must pay some amount of ETH
        // must have contributed some amout of ETH
        require(msg.value > 0 && contributions[msg.sender] > 0);
        // HERE: this is acutally where you become owner
        owner = msg.sender; // become the owner
    }
}
