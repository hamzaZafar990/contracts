

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";




contract farbeArtAuction {
  function setter(uint val) external returns(bool){}
  function getter(uint val) public view returns(uint){}
  function returnAddress()public view returns(address){}
  function getCreator(uint id)public returns(address ){}
  function ownerOf(uint256 _tokenId) external view returns (address owner){}
  function approve(address _to, uint256 _tokenId) external{}
  function transfer(address _to, uint256 _tokenId) external{}
  function transferFrom(address _from, address _to, uint256 _tokenId) external{}
}


contract AuctionBaseLogic{
    
    struct auctionInformation{
        uint tokenID;
        address creatorAddress;
        address sellerAddress;
        address currentBiderAddress;
        uint currentBid;
        
    }
    
    mapping(uint=>auctionInformation)  auctionRepositoy;
    mapping(address=>uint)  bidPayment ;
    uint[] receivedToken;
   
    
    function makeBidTransaction(uint tokenID,uint price) 
    internal returns(bool)
    {
        
        if(auctionRepositoy[tokenID].currentBid<price)
        {
            auctionRepositoy[tokenID].currentBid=price;
            auctionRepositoy[tokenID].currentBiderAddress=msg.sender;
            return true;
        }
            
         return false;
        
    }
    
    function checkValidityOfToken(uint tokenID)
    public  returns( bool)
    {
     for(uint i=0;i<receivedToken.length;i++)
     {
         if(receivedToken[i]==tokenID)
           return true;
     }
      return false;
    }
}

contract Auction is  IERC721Receiver,AuctionBaseLogic{
    
    farbeArtAuction  nonFungibleContract;
    
    constructor(address farbeArtContractAddress)
    public
    {
    farbeArtAuction candidateContract = farbeArtAuction(farbeArtContractAddress);
    nonFungibleContract = farbeArtAuction(farbeArtContractAddress);
    }

    // for the time being setting price as parameter to check the 
    // functionality of bidding
    
    function createBid(uint tokenID,uint price)
    public returns(bool)
    {
        require(checkValidityOfToken(tokenID)==true,"token id is not available for auction");
        require((price>auctionRepositoy[tokenID].currentBid),"insufficent amount");
        auctionRepositoy[tokenID].currentBiderAddress=msg.sender;
        auctionRepositoy[tokenID].currentBid=price;
         bidPayment[msg.sender]=price;
        return true;
    }
    
    
    function  createBidWithPayment(uint tokenID) 
    public payable returns(bool)
    {
        require(checkValidityOfToken(tokenID)==true,"token id is not available for auction");
        require((msg.value>auctionRepositoy[tokenID].currentBid),"insufficent amount");
        if(auctionRepositoy[tokenID].currentBiderAddress==address(0))
        {
            auctionRepositoy[tokenID].currentBiderAddress=msg.sender;
            auctionRepositoy[tokenID].currentBid=msg.value;
        }
        else
        {
            address receiver=auctionRepositoy[tokenID].currentBiderAddress;
            address.transfer(bidPayment[msg.sender]);
            auctionRepositoy[tokenID].currentBiderAddress=msg.sender;
            auctionRepositoy[tokenID].currentBid=msg.value;
            
        }
        bidPayment[msg.sender]=msg.value;
       // payable(address(this)).transfer(msg.value);
        return true;
    }
    
    
    function bidingInfo3(uint tokenID) 
    public view returns
    ( auctionInformation memory)
    {
     auctionInformation memory temp=auctionRepositoy[tokenID];
      return temp;
    }
    
    function onERC721Received
    (address operator, 
    address from, 
    uint256 tokenId, 
    bytes calldata data) 
    external override  returns (bytes4){
        receivedToken.push(tokenId);       // we will all the necessary info regarding token here
        address artCreator=nonFungibleContract.getCreator(tokenId);
        auctionInformation memory newAuction=auctionInformation(tokenId,artCreator,from,address(0),0);
        auctionRepositoy[tokenId]=newAuction;
        return IERC721Receiver.onERC721Received.selector;
    }
    
    function getTokenInformation(uint id) public view returns(auctionInformation memory){
        return  auctionRepositoy[id];
    }
    
    
   // this function will return the address of contract
   // once it is deployed
    
    function getAddress()
    public view returns(address){
        return  address(this);
    }
    function getBalance()
    public view returns(uint){
        return  address(this).balance;
    }
    
  
}