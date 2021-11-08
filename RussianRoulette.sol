// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.9;

/**
 * @title RussianRoulette
 * @dev Store & retrieve value in a variable
 */
contract RussianRoulette{

    
    address[] players;
    address[] losers;
    uint256 odds;
    uint256 playersTurn;
    address creator;
    
    constructor()
    {
        creator = msg.sender;
    }
    

    
    
    function setOdds(uint256 oneInThisMany) public{
        require(msg.sender==creator, "Only the creator can change the odds");
        odds = oneInThisMany;
    }
    
    function addPlayer(address Player) public{
        require(isALoser(Player)==false, "You already lost lol");
        require(isAPlayer(Player)==false, "You're already playing!");
        players.push(Player);
    }
    
    function lose(address Player) internal{
        delete players;
        losers.push(Player);
    }
    
    function random() internal returns (uint256) {
        uint randomnumber = uint(keccak256(abi.encodePacked(block.timestamp, msg.sender))) % odds;
        randomnumber = randomnumber + 1;
        return randomnumber;
    }
    
    function play() public{
        uint256 number = random();
        if(number==1)
        {
            lose(players[playersTurn]);
        }
        else
        {
            playersTurn = (playersTurn+1)%players.length;
        }
    }
    
    
    function isALoser(address Person) public view returns(bool){
        for(uint256 i = 0;i<losers.length;i++)
        {
            if(Person==losers[i])
                return true;
        }
        return false;
    }
    function isAPlayer(address Person) public view returns(bool){
        for(uint256 i = 0;i<players.length;i++)
        {
            if(Person==players[i])
                return true;
        }
        return false;
    }
    
    function getOdds() public view returns(uint256){
        return odds;
    }
    
}