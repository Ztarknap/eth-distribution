pragma solidity ^0.5.0;

import "./ownable.sol";

contract PicDistribution is Ownable{

mapping (uint => address) picToOwner;

uint picPrice = 0.001 ether;

function _grantRight(uint picHash) internal {
    picToOwner [picHash] = msg.sender;
   
}

function buyRights(uint picHash) external payable returns (bool) {
    if (picToOwner[picHash] == msg.sender)
    return false;
    else 
    require(msg.value == picPrice);
    _grantRight(picHash);
    return true;
}

function checkAccess(uint picHash) external view returns (bool) {
    if(picToOwner[picHash] == msg.sender)
    return true;
    else return false;
}

}
