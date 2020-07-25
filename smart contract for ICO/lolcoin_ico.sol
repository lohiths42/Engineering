// Lol coin ICO - Intial Coin Offering

pragma solidity >=0.4.22 <0.7.0;

contract lolcoin_ico {
    
    // introducing the maximum number of lolcoins available for seal
    uint public max_lolcoin = 1000000;
    
    // introducing the rupees conversion 
    uint public inr_to_lolcoin = 10;
    
    // introducing total number of lolcoin sold 
    uint public total_lolcoin_bought = 0;
    
    // mapping the lolcoin from investor to its equity
    mapping(address => uint) equity_lolcoin;
    mapping(address => uint) equity_inr;
    
    // checking if there are lolcoins left
    modifier can_buy_lolcoin(uint inr_invested){
        require (inr_invested * inr_to_lolcoin + total_lolcoin_bought <= max_lolcoin);
        _;
    }
    
    //getting the equity for the investor
    function equity_in_lolcoin(address investor)external constant returns(uint) {
        returns equity_lolcoin[investor]; 
    }
    
    //getting the equity for investor in inr 
    function equity_in_inr(address investor)external constant returns(uint){
        returns equity_inr[investor];
    }
    
    // buying the lolcoin 
    function buy_lolcoin (address investor, uint inr_invested)external 
    can_buy_lolcoin(inr_invested) {
        uint lolcoin_bought = inr_invested*inr_to_lolcoin; 
        equity_lolcoin[investor] += lolcoin_bought ;
        equity_inr[investor] =equity_lolcoin[investor]/inr_to_lolcoin;
        total_lolcoin_bought += lolcoin_bought;
    }
    
    //selling lolcoin
    function sell_lolcoin(address investor, uint lolcoin_sold)external {
        equity_lolcoin[investor] -= lolcoin_sold;
        equity_inr[investor] = equity_lolcoin[investor]/inr_to_lolcoin;
        total_lolcoin_bought -= lolcoin_sold;
        
    }
    
    
}