

//import chaiAsPromised from 'chai-as-promised';
const { assert } = require('console')


const color=artifacts.require('./contracts/color.sol')

require('chai')
 .use(require('chai-as-promised'))
 .should()

 contract('color',(accounts)=>{

    let contract
    describe('deployment',async()=>{
    it('deploys successfully',async ()=>{
        contract=await color.deployed()
        const address=contract.addres
        console.log(address)
        assert.Equal(address,'')
    })
})
 })