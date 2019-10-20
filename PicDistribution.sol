pragma solidity ^0.5.0;

import "./ownable.sol";

contract PicDistribution is Ownable{


//uint picPrice = 0.001 ether;

struct Pic {
    
    address picOwner;
    
    uint picHash;
    
    uint price;
    
    //uint id;
}

Pic[] Pics;

uint256 defaultPrice= 1 wei;


function _grantRight(uint picHash) internal {
    //picToOwner [picHash] = msg.sender;
    
    Pics.push(Pic(msg.sender, picHash, defaultPrice));
   
}

function buyRights(uint picHash) external payable returns (uint8) {
    
    uint i=0;
    for (i; i<Pics.length; i++)
    {
        if (Pics[i].picHash==picHash && Pics[i].picOwner==msg.sender)
        {
            
            return 1;
        }
    }
    
    
    
    require(msg.value == defaultPrice);
    _grantRight(picHash);
    return 0;
}

function checkAccess(uint picHash) external view returns (uint8) {
      for (uint i=0; i<Pics.length; i++)
    {
        if (Pics[i].picHash==picHash && Pics[i].picOwner==msg.sender)
        {
            return 0;
        }
    }
    
     return 2;
}

function setPrice(uint picHash, uint NewpicPrice) external returns (uint8) {
    for (uint i=0; i<Pics.length; i++) {
       
        if (Pics[i].picHash==picHash && Pics[i].picOwner==msg.sender)
        {
            Pics[i].price=NewpicPrice;
            return 0;
        } 
        
    }
    return 2;
}

function setDefaultPrice(uint newDefaultPrice) external onlyOwner() {
    
    defaultPrice=newDefaultPrice;
}


}


/* Коды ошибок: 

0 - успех
1 - ошибка при покупке прав - права на эту картинку для этого пользователя уже куплены
2 - ошибка при проверка прав - у этого пользователя нет прав на эту картинку
*/
