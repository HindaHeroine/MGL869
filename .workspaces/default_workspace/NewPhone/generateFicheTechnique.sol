pragma solidity ^0.5.13;
import "./ownable.sol";
import "./newPhone.sol";
import "./facturation.sol";


contract GenerateFicheTechnique is Ownable {

address public vendeur;
address payable verificateur;
Facturation public facture;
NewPhone public newphonechecked; 
FicheTechnique ficheTG;
// un tableau de phone verifiés
NewPhone[] phoneVerified;

struct FicheTechnique {
    address selfAdresse;
    address payable isGeneratedBy;
    
}
constructor () public payable{
   verificateur = msg.sender;
   facture = new Facturation();
 
} 

function _generateFT(uint _index, address payable _verificateur) private {
     require(verificateur != vendeur,"le verificateur ne peut pas etre le vendeur");
    newphonechecked.getPhoneByIndex(_index);
    ficheTG.selfAdresse = msg.sender;
    ficheTG.isGeneratedBy = _verificateur;
    facture.getPayed(_verificateur);
}
}







