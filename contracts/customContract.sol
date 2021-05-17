pragma solidity >=0.4.22 <0.9.0;
pragma experimental ABIEncoderV2;
import "@openzeppelin/contracts/token/ERC721/ERC721Full.sol";
import "@openzeppelin/contracts/access/Roles.sol";
//import "@openzeppelin/contracts/ownership/Ownable.sol";




contract Artist  {
    /*address owner;
    constructor() public{
      owner=msg.sender;

    }*/
    // Mapping of address to boolean indicating whether the address is whitelisted
    mapping(address => bool) private whitelistMap;

    // flag controlling whether whitelist is enabled.
    bool private whitelistEnabled = true;

    event AddToWhitelist(address indexed _newAddress);
    event RemoveFromWhitelist(address indexed _removedAddress);

    /**
   * @dev Enable or disable the whitelist
   * @param _enabled bool of whether to enable the whitelist.
   */
    function enableWhitelist(bool _enabled) public  {
        whitelistEnabled = _enabled;
    }

    /**
   * @dev Adds the provided address to the whitelist
   * @param _newAddress address to be added to the whitelist
   */
    function addToWhitelist(address _newAddress) public  {
        _whitelist(_newAddress);
        emit AddToWhitelist(_newAddress);
    }

    /**
   * @dev Removes the provided address to the whitelist
   * @param _removedAddress address to be removed from the whitelist
   */ 
     function removeFromWhitelist(address _removedAddress) public  {
        _unWhitelist(_removedAddress);
        emit RemoveFromWhitelist(_removedAddress);
    }

    /**
   * @dev Returns whether the address is whitelisted
   * @param _address address to check
   * @return bool
   */
    function isWhitelisted(address _address) public view returns (bool) {
        if (whitelistEnabled) {
            return whitelistMap[_address];
        } else {
            return true;
        }
    }

    /**
   * @dev Internal function for removing an address from the whitelist
   * @param _removedAddress address to unwhitelisted
   */
    function _unWhitelist(address _removedAddress) internal {
        whitelistMap[_removedAddress] = false;
    }

    /**
   * @dev Internal function for adding the provided address to the whitelist
   * @param _newAddress address to be added to the whitelist
   */
    function _whitelist(address _newAddress) internal {
        whitelistMap[_newAddress] = true;
    }
}







contract customContract is ERC721Full,Artist{

using Roles for Roles.Role;

Roles.Role private artist;
Roles.Role private buyer;

Artist public authorizedArtist;




struct artiFact{
    uint tokenID;
    string url;
    uint noOfCopies;
    uint price;
}




//mapping(address=>buyerRequest) requestLog;


mapping(address=>artiFact) Records;
artiFact[] public tokenList;
string[] public urlList;



 
address public owner ;
address public artistArray;

  constructor() ERC721Full("color","COLOR") public {
      owner=msg.sender;
  }
  
function addArtist(address add) public returns (bool)
{
    require(msg.sender==owner,"access error");
   // authorizedArtist.
    _whitelist(add);
    //artist.add(add);
    return true;
}


function addBuyer(address add) public returns (bool)
{ 
    require(msg.sender==owner,"access error");
    buyer.add(add);
    return true;
}


function mintMyToken(string memory  _url,uint  _copies,uint price) public returns(bool){

   require(isWhitelisted(msg.sender)==true,"not authorized for minting");
   for(uint i=0;i<_copies;i++){
    uint _id=urlList.push(_url);
    _mint(msg.sender,_id);
    artiFact memory tempArtifact= artiFact(_id,_url,_copies,price);
    Records[msg.sender]=tempArtifact; 
   }
    return true;

   

  /*  require(artist.has(msg.sender),'artist is not registered yet');
    uint _id=urlList.push(_url);
    _mint(msg.sender,_id);
    artiFact memory tempArtifact= artiFact(_id,_url,_copies,price);
   // tempArtifact.tokenID=_id;
   // tempArtifact.url=_url;
    //tempArtifact.noOfCopies=_copies;
    //(_id,_url,_copies)
    Records[msg.sender]=tempArtifact;
    return true;
  */
}

function totalToken() public view  returns(uint){
    uint num=totalSupply();
    return num;
}

function getArtiFactPrice(uint _Id) external returns(uint )
{
    for(uint i=0;i<tokenList.length;i++)
    {
        if(tokenList[i].tokenID==_Id)
        {
            return tokenList[i].price;
        }
    }
}


function getArtiFact(uint _Id) public view returns(artiFact memory )
{
    for(uint i=0;i<tokenList.length;i++)
    {
        if(tokenList[i].tokenID==_Id)
        {
            return tokenList[i];
        }
    }
}

function buyArtiFactInfo(uint tokenID,address to)public payable returns(bool){
    require(buyer.has(to),'Buyer is not registered');
    artiFact memory temp=getArtiFact(tokenID);
    transferFrom(ownerOf(tokenID),to,tokenID);
  //  require(msg.value>=temp.price,'insufficient amount');
  //  buyerRequest memory tempRequest=buyerRequest(tokenID,msg.value,msg.sender);

    return true;  
}

  
}




