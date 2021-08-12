pragma solidity ^0.5.13;
import "./ownable.sol";


contract Facturation is Ownable {
    
    uint private profit;
    address payable private vendeur = msg.sender; // l'adresse vendeur qui paye la prime
    
    constructor () payable public{
        profit = 0.35 ether; // la prime associée 
        /* profit = msg.value; dans le cas ou on specifie 
        pas la valeur de la prime a payer par le vendeur
        */
        vendeur = msg.sender;
    }
    
    function setmyprofit(uint _newprofit) external onlyOwner {
    profit = _newprofit;
  }
  
   function getPayed(address payable _verificateur) external onlyOwner payable {
    require(msg.value == profit  //value ne doit pas etre differente du profit exigée
    &&  _verificateur != vendeur);// le verificateur ne peut pas etre le vendeur
    _verificateur.transfer(profit);
  }
 
 
}


      

    


