pragma solidity ^0.5.13;
import "./ownable.sol";
import "./safemath.sol";
import "./facturation.sol";

contract NewPhone is Ownable {
    
    using SafeMath for uint256;
    address private owner;
    uint private phoneIndex;
    Phone[] private Phones;
 
     constructor () public {
        owner = msg.sender;
    }
    struct Phone {
        address vendeur;
        string nserie;
        string couleur;
        string nom;
        string version;
        string nommodel;
        uint prix;
        uint capacstock;}
    
    mapping (uint => address) public phoneOwner; // associer l'adresse de owner a uint qui est l'index de phone 
    mapping (address => uint) public ownerPhoneCount; //associer uint qui  le chiffre ownerphonecount a l'addresse de phone
     // creer le telephone et l'ajouter au tableau de telephones
    function _createPhone(
    string memory _nserie,
    string memory _couleur,
    string memory _nom,
    string memory _version,
    string memory _nommodel,
    uint _prix,
    uint _capacstock) private onlyOwner(){ 
       phoneIndex = (Phones.push(Phone(msg.sender, _nserie, _couleur, _nom, _version, _nommodel, 
        _prix, _capacstock)))-1;
       phoneOwner[phoneIndex] = msg.sender; // recuperer l'adresse du vendeur et l'associer a id de phone
       ownerPhoneCount[msg.sender]++;
        
    }
       
    function getPhoneByIndex(uint _phoneIndex) public view onlyOwner returns (
    address _vendeur,
    string memory _nserie,
    string memory _couleur,
    string memory _nom,
    string memory _version,
    string memory _nommodel,
    uint _prix,
    uint _capacstock) {
    Phone storage newphone = Phones[_phoneIndex];
    _vendeur = newphone.vendeur;
    _nserie = newphone.nserie;
    _couleur = newphone.couleur;
    _nom = newphone.nom;
    _version = newphone.version;
    _nommodel = newphone.nommodel;
    _prix = newphone.prix;
    _capacstock = newphone.capacstock;}
    
//returne un tableau des index des phones de Owner 
 function searchPhoneByOwner(address _owner) public view returns(uint[] memory) {
     uint nbrPhonebyOwner = ownerPhoneCount[_owner];
     require(nbrPhonebyOwner != 0); // verifier que le owner possede au moins un phone
     //declarer un tab uint de taille nombre de phone que l'owner possede
    uint[] memory resultIndex = new uint[](nbrPhonebyOwner);
    // faire le parcour de tous les phones
    uint counter = 0;
    for (uint phIndex = 0; phIndex < Phones.length; phIndex++) {
      if (phoneOwner[phIndex] == _owner) {
        resultIndex[counter] = phIndex;
        counter++;}
    }
    return resultIndex;
  }}