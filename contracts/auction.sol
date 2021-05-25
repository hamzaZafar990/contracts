

pragma solidity ^0.8.0;


import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";






contract Auction is  IERC721Receiver,ERC165{
    
    uint[] receivedToken;
    //bytes4 constant InterfaceSignature_ERC721 = bytes4(0x9a20483d);
    
    
    constructor() public {
      //  _registerInterface(IERC721Receiver.onERC721Received.selector);
        
    }
    
    
    // implemented the the IERC721Receiver interface 
    //to accept the non funcgible tokens and keep them
    // in a escrow during the time period of auction
    
    
    
    
    
    function onERC721Received
    (address operator, 
    address from, 
    uint256 tokenId, 
    bytes calldata data) 
    external override  returns (bytes4){
        
        receivedToken.push(tokenId);       // we will receive all the necessary info regarding token here
        return IERC721Receiver.onERC721Received.selector;
    }
    
    function getTokenInformation(uint id) public view returns(uint[] memory){
        return  receivedToken;
    }
    
    
    
   // this function will return the address of contract
   // once it is deployed
    
    function getAddress()
    public view returns(address){
        return  address(this);
    }
    
    
    
    
}