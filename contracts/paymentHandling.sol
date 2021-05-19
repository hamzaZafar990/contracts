// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
pragma experimental ABIEncoderV2;


import "@OpenZeppelin/contracts/payment/PaymentSplitter.sol";










// SPDX-License-Identifier: MIT



contract payment is PaymentSplitter{
    
    constructor(address [] memory addArray,uint [] memory intArray) public PaymentSplitter(addArray,intArray){
        
        
    }
    
    function receivePayment(address add) public payable{
        
       // this.buyTokens.value(_amount)(msg.sender);
         
         emit PaymentReceived(_msgSender(), 0.02);
    }
    
     function sendPayment(uint _amount) public payable{
         
         
         this.receivePayment.value(_amount)(msg.sender);
        
       // this.buyTokens.value(_amount)(msg.sender);
         
       //  emit PaymentReceived(_msgSender(), msg.value);
    }
    
    
}




contract  payment {
    
    
    constructor () public {
        // solhint-disable-previous-line no-empty-blocks
    }


  PaymentSplitter [] paymentRecords;
 
  function add(address payable add1,address payable add2) public  returns(uint256) {
      
      
      
   
   address[] memory tempAdd = new address[](2);
   tempAdd[0]=add1;
   tempAdd[1]=add2;
    uint[] memory tempInt = new uint[](2);
    tempInt[0]=1;
    tempInt[1]=1;
  /* tempAdd.push(add1);
   tempAdd.push(add2);
   tempInt.push(1);
   tempInt.push(2);*/

   PaymentSplitter  temp=new PaymentSplitter(tempAdd,tempInt);
   address  e=temp.payee(0);
   //temp._addPayee(add1, 2);
   paymentRecords.push(temp);
   //return true;
  // ERC20 e1=new ERC20();
  // uint f=e1.totalSupply();
  uint256 s=1111;
   return s;
  }



function getPaymentFromBuyer() public view returns (address ) {
    
    PaymentSplitter  temp=paymentRecords[0];
    //paymentRecords[0]._addPayee(_msgSender, 2);
   // temp.PaymentReceived(_msgSender(), msg.value);
  //  return paymentRecords.length;

    
   //address add3=paymentRecords[0].payee(id);
  return temp.payee(id);
   //return true;
  }



}
