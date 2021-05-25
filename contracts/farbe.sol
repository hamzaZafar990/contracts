pragma solidity ^0.8.0;



import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
//import "@openzeppelin/contracts/access/Roles.sol";

contract farbeToken is ERC721, ERC721URIStorage, AccessControl {
    
  //  using Counters for Counters.Counter;
 //   using AccessControl for Roles.Role;
    
   // Counters.Counter private tokenIds;
    
    /*
     * defined roles for the users
     * 
     * 
    */
    //Roles.Role private Artists;
    //Roles.Role private Buyers;
     struct artiFactDetails{
        address creator; 
        uint basePrice;
        uint noOfCopies;
        
        
    }
    
    uint tokenCounter;
    mapping(uint=>artiFactDetails) tokenDetails;
    /*mapping(uint=>uint) bidRecordPrice;
    mapping(uint=>uint) listingRecordPrice;
    mapping(uint=>address) bidRecordofAddress;
    mapping(uint=>address) listingRecordofAddress;
     
    mapping (uint256 => address) approvedAddresses ;*/
    
    
   
    
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    
    
 

    constructor() ERC721("farbe", "fbr") {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _setupRole(MINTER_ROLE, msg.sender);
        tokenCounter=0;
    }  

    function safeMint(address to, uint256 tokenId) public {
        require(hasRole(MINTER_ROLE, msg.sender));
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
    
    
    
    function addArtist(address add) public returns (bool)
    {
     require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender));
    grantRole("Artists", add);
    return true;
    }


    function addBuyer(address add) public returns (bool)
   { 
    require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender));
     grantRole("Artists", add);
   // _setupRole(Buyers, msg.sender);
    return true;
   }
   
   
   function mintTokenAndList(string memory  _url,address add,uint price,uint copies) public returns(bool){

   require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender));
   require(hasRole("Artists", add));
   artiFactDetails memory newtokenDetails= artiFactDetails(add,price,copies);
   tokenCounter++;
    _safeMint(add, tokenCounter);
    //listingRecordPrice[tokenCounter]=price;
    //listingRecordofAddress[tokenCounter]=add;
    //tokenDetails[tokenCounter]=newtokenDetails;
 /*  for(uint i=0;i<_copies;i++){
    uint _id=urlList.push(_url);
    _mint(msg.sender,_id);
    artiFact memory tempArtifact= artiFact(_id,_url,_copies,price);
    Records[msg.sender]=tempArtifact; 
   }*/
    return true;

   }
   
   
   function mintToken(string memory  _url,address add,uint price,uint copies) public returns(bool){

   require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender));
   //require(hasRole("Artists", add));
   artiFactDetails memory newtokenDetails= artiFactDetails(add,price,copies);
   tokenCounter++;
    _safeMint(add, tokenCounter);
  // bidRecordPrice[tokenCounter]=price;
  // bidRecordofAddress[tokenCounter]=add;
   //[tokenCounter]=newtokenDetails;
 /* for(uint i=0;i<_copies;i++){
    uint _id=urlList.push(_url);
    _mint(msg.sender,_id);
    artiFact memory tempArtifact= artiFact(_id,_url,_copies,price);
    Records[msg.sender]=tempArtifact; 
   }*/
    return true;

   }
   
   
   // transfer the tokens to our intermediatery contracts
   
   function giveRight(uint tokenID,address artist,address escrow) public returns(bool){
       _safeTransfer( artist,  escrow,  tokenID, "");
       //super.safeTransferFrom( artist,  escrow,  tokenID,"");
   }
   
   
   
  // function mintTokenAndList(string memory  _url,address add,uint price,uint copies) public returns(bool){
   
   
   
   
  /* function makeBid(uint tokenID,uint amount) public returns(bool){
   
       require(amount>bidRecordPrice[tokenID],"current price is greater than bid price");
       bidRecordPrice[tokenID]=amount;
       bidRecordofAddress[tokenID]=msg.sender;
       return true;
   }
   
   
   function getBids(uint tokenID) public view returns(uint){
       
    
    return bidRecordPrice[tokenID];
       
   }
   */
   
   
   
   
   
    
}



























