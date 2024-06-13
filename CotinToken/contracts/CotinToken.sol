//contracts/CotinToken.sol
//SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";

contract CotinToken is ERC20, ERC20Capped, ERC20Burnable, ERC20Pausable {
    address payable public owner;
    uint256 public blockReward;
    
    constructor(uint256 cap, uint256 reward, uint256 initialMintAmount) ERC20("CotinToken", "COTIN") ERC20Capped(cap * (10 ** decimals())){
        owner = payable(msg.sender);
        _mint(owner, initialMintAmount * (10 ** decimals())); 
        blockReward = reward * (10 ** decimals ());
    }
    function pause() public onlyOwner {
        _pause();
    }
    function unpause() public onlyOwner {
        _unpause();
    }
    function _mint(address account, uint256 amount) internal virtual override(ERC20Capped, ERC20) {
        require(ERC20.totalSupply() + amount <= cap(), "ERC20Capped: cap exceeded");
        super._mint(account, amount);
    }
    function postLaunchMint(uint256 postLaunchAmount) public onlyOwner {
        require(msg.sender == owner, "Caller does not have the minter role");
        require(ERC20.totalSupply() + postLaunchAmount <= cap(), "ERC20Capped: cap exceeded");
        super._mint(owner, postLaunchAmount * (10 ** decimals ()));
    }
    function _mintMinerReward() internal{
        _mint(block.coinbase, blockReward);    
    }    
    function _beforeTokenTransfer(address from, address to, uint256 value) internal whenNotPaused override (ERC20, ERC20Pausable) {
        if(from != address(0) && to != block.coinbase && block.coinbase != address(0)){
        _mintMinerReward();        
        }  
        super._beforeTokenTransfer(from, to, value);
        require(!paused(), "ERC20Pausable: token transfer while paused");
    }
    function setBlockReward (uint256 reward) public{
        blockReward = reward * (10 ** decimals());
    }
    modifier onlyOwner{
       require(msg.sender == owner, "Only the owner can call this function");
        _; 
    }
}
