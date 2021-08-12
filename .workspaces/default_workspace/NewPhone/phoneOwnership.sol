pragma solidity ^0.5.13;
pragma experimental ABIEncoderV2;

import "./FicheTechnique.sol";
import "./erc721.sol";
import "./safemath.sol";

contract PhoneOwnership is FicheTechnique, ERC721 {
    
    using SafeMath for uint256;

  //pour renvoyer le nombre de phone qu'un _owner possede.
  function balanceOf(address _owner) public view returns (uint256 _balance) {
    return ownerPhoneCount[_owner];
  }
  
  //renvoie l'adresse du propriétaire du Phone avec l'ID _phoneId.
  function ownerOf(uint256 _phoneId) public view returns (address _owner) {
    return phoneToOwner[_phoneId];
  }
  //-- 1 -- le propriétaire du phone appelle transfer avec l'address de destination,et _phoneId du phone qu'il veut transférer.
  
 ////////////////////////////-- Begin -- 1 --///////////////////////////////////
 function _transfer(address _from, address _to, uint256 _phoneId) private {
    ownerphoneCount[_to].add(1);
    ownerphoneCount[_from].sub(1);
    phoneOwner[_phoneId] = _to;
    Transfer(_from, _to, _phoneId);
  }
  
  function transfer(address _to, uint256 _phoneId) public onlyOwner(_phoneId) {
    _transfer(msg.sender, _to, _phoneId);
  }
  ////////////////////////////-- End -- 1 --///////////////////////////////////
  
  // -- 2 -- le propriétaire approve et donne l'address du nouveau propriétaire, et le _phoneId que vous voulez qu'il prenne.
  ////////////////////////////-- Begin -- 2 --///////////////////////////////////
  
  mapping (uint => address) phoneApprovals; // quand quelqu'un appelle takeOwnership avec un _phoneId, on peu voir qui est approuvé à prendre ce phone.
  
 function approve(address _to, uint256 _phoneId) public onlyOwner(_phoneId) {
    phoneApprovals[_phoneId] = _to;
    Approval(msg.sender, _to, _phoneId);
  }
  // -- 2 -- Le nouveau propriétaire appelle takeOwnership avec le _phoneId, le contrat vérifie que cela a bien été approuvé, et lui transfère le phone.
  function takeOwnership(uint256 _phoneId) public {
    require(phoneApprovals[_tokenId] == msg.sender);
    address owner = ownerOf(_phoneId);// _from, besoin de connaître l’adresse de la personne qui possède le token
    _transfer(owner, msg.sender, _phoneId);

  }
}
