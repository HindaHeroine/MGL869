pragma solidity ^0.5.13;

contract Ownable {
  address public owner;



  constructor () public {
    owner = msg.sender;
  }

  
  modifier onlyOwner() {
    require(msg.sender == owner, "error owner");
    _;
  }
  
  

 

}
