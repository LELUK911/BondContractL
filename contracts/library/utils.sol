// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
    

library HelperDepositFunction{


  function _returnDayTime(uint[] memory _listData) view internal returns(uint[] memory listDataDay){
        listDataDay = _listData;
        for (uint256 index = 0; index < _listData.length; index++) {
            listDataDay[index] = ((_listData[index] * 1 days) + block.timestamp) ;
        }
        return listDataDay;
  }

}