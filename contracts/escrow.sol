
pragma solidity >=0.4.22 <0.9.0;
pragma experimental ABIEncoderV2;
import "./color.sol";



contract escrow{


     address acessingContract;
     customContract tempColor;


     enum State{
        awate_payment, awate_delivery, complete 
    }

  

mapping(address=>uint) record;

constructor() public {
   
    
   

}

function setup(address add) public returns(bool)
{

   acessingContract = add;
   customContract temp  = customContract(acessingContract);
   tempColor=temp;
   return true;
 //  accessingContract.call(bytes4(keccak256("fun(uint256)")), a);
  
}



function buyerRequest(uint _tokenID,address add) public returns(bool)
{
    //bytes memory payload = abi.encodeWithSignature("getArtiFactPrice(uint)", _tokenID);
    //(bool success, bytes memory returnData) = address(acessingContract).call(payload);
    address sender=tempColor. ownerOf(_tokenID);
    tempColor.buyArtiFactInfo( _tokenID,add);
    //require(check>0,check);
    //uint nftPrice= acessingContract.call(bytes4(keccak256("getArtiFactPrice(uint)")),_tokenID);
   // require(nftPrice<= msg.value,"insufficient balance entered");
    record[msg.sender]=_tokenID;
    return true;
  
}


function minting(string memory _url,uint  _copies,uint price) public returns(bool)
{
    //bytes memory payload = abi.encodeWithSignature("getArtiFactPrice(uint)", _tokenID);
    //(bool success, bytes memory returnData) = address(acessingContract).call(payload);
    bool check=tempColor.mintMyToken(  _url, _copies, price);
   // require(check>0,"failedddddddddddd");
    //uint nftPrice= acessingContract.call(bytes4(keccak256("getArtiFactPrice(uint)")),_tokenID);
   // require(nftPrice<= msg.value,"insufficient balance entered");
   // record[msg.sender]=_tokenID;
    return true;
  
}











}