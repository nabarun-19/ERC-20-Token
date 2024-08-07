// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.0.0) (token/ERC20/IERC20.sol)

pragma solidity ^0.8.20;

// we are dealing with token remember
interface IERC20 {
   
    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(address indexed owner, address indexed spender, uint256 value);

  // total supply of token
    function totalSupply() external view returns (uint256);
// balence of token
    
    function balanceOf(address account) external view returns (uint256);

   
    function transfer(address to, uint256 value) external returns (bool);
//allowing someone to use your token
    function allowance(address owner, address spender) external view returns (uint256);

  //approving some one to use your token
    function approve(address spender, uint256 value) external returns (bool);

    function transferFrom(address from, address to, uint256 value) external returns (bool);
}


   contract Nabarun is IERC20{
      
      uint public totalSupply=1000;//number of tokens
       mapping (address=>uint) public  BalanceOfUser;
       mapping(address=>mapping (address=>uint)) public AllowerdTokens;
        address public founder;
        uint public decimal=0;

       constructor(){   
           
            founder = msg.sender;
            BalanceOfUser[founder]=totalSupply;// initially founder will have all the tokens


       }

       function balanceOf(address account) external view returns (uint256){
           return BalanceOfUser[account];
       }

      function transfer(address to, uint256 value) external   returns (bool){
          require(to!= address(0),"invalid address");
               require( BalanceOfUser[msg.sender]>=value,"Insufficient balance");
                BalanceOfUser[msg.sender]-=value;
                     BalanceOfUser[to]+=value;
                      emit Transfer( msg.sender, to,value);
                                   return true;
           }


    // writing a cheque       
    function approve(address spender, uint256 value) external returns (bool){
          require(spender!= address(0),"invalid address");
               require( BalanceOfUser[msg.sender]>=value,"Insufficient balance");
                              AllowerdTokens[msg.sender][spender]=value;
                             emit  Approval( msg.sender, spender,  value);
                                       return true;
    }



      // it's like a cheque paper
      function allowance(address owner, address spender) external view returns (uint256){
        /*this function specifieces that 
        how much token an owner allow spender to spend*/

        return AllowerdTokens[owner][spender];
      }
      
    function transferFrom(address from, address to, uint256 value) external returns (bool){
           require(from==msg.sender,"not a authorized");
               require(from!= address(0),"invalid address");
               require(to!= address(0),"invalid address");
                   require(AllowerdTokens[from][to]>=value,"Insufficient balance");
                   
                         AllowerdTokens[from][to]-=value;
                  BalanceOfUser[from]-=value;
                         BalanceOfUser[to]+=value;
                                emit Transfer( from, to,value);
                                      return true;  
              
                 
    }









      



}
