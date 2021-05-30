


pragma solidity ^0.8.0;



import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
//import "@openzeppelin/contracts/access/Roles.sol";


contract farbeToken is ERC721, ERC721URIStorage, AccessControl{
    
    struct artiFactDetails{
        address creator; 
        uint basePrice;
        uint noOfCopies;
    }
    
    bool checkValue;
    address contractAddress;
    uint [] escrowedTokens;
    uint tokenCounter;
    mapping(uint=>artiFactDetails) tokenDetails;
    
    
    constructor() ERC721("farbe", "fbr") {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        tokenCounter=0;
        checkValue=false;
    }
    
    
    function safeMint
    (address to, 
    uint256 tokenId) 
    public {
        require(hasRole("Artists", msg.sender),"not authorized to mint tokens");
        _safeMint(to, tokenId);
    }

    function _baseURI() internal pure override returns (string memory) {
        return "www.abc.com";
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, AccessControl)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
    
    
    
    function addArtist(address add) 
    public returns (bool)
    {
     require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender),"not authorized to add artists");
    grantRole("Artists", add);
    return true;
    }


    function addBuyer(address add) public returns (bool)
   { 
     require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender),"not authorized to add buyers");
     grantRole("Artists", add);
     return true;
   }
   
   
   function mintToken
   (uint price,uint copies,string memory url)
   public returns(bool)
   {
    require(hasRole("Artists", msg.sender),"not authorized to add buyers");
    artiFactDetails memory newtokenDetails= artiFactDetails(msg.sender,price,copies);
    for(uint i=1;i<=copies;i++)
    {
        tokenCounter++;
        _safeMint(msg.sender, tokenCounter);
        _setTokenURI(tokenCounter, url);
        tokenDetails[tokenCounter]=newtokenDetails;
    }
    
    return true;
   }
   
   
   function getCreator(uint id)
   public returns(address ){
       address add=tokenDetails[id].creator;
       return add;
       }
       
}


contract farbeArtAuction is farbeToken{
    

  address AuctionHandler;
  IERC721 addr;
 
 
   function setAuctionAddress(address add) 
   public returns(bool)
   {
        require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender),"not authorized to add artists");
        contractAddress=add;
         addr = IERC721(add);
    }
    
    
    function listForAuction(uint tokenID)
    public payable returns(bool)
    {
        require(hasRole("Artists", msg.sender),"not a authorized artist");
        address temp=0x6Dff488192F2D820AEB354Ee0fe0baf81071c784;

        safeTransferFrom(msg.sender,temp,tokenID,"");
    }
    
    function listForAuction2(uint tokenID)
    public returns(bool)
    {
        require(hasRole("Artists", msg.sender),"not a authorized artist");
        safeTransferFrom(msg.sender,address(addr),tokenID,"");
    }
    
    
    function returnAddress()
    public view returns(address)
    {
        return address(this);
    }
    
}












