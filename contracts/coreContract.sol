// SPDX-License-Identifier: MIT

import "./componentContract/DepositWithdrawFunction.sol";
import  "./componentContract/bondFunction.sol";

pragma solidity 0.8.16;

contract CoreContract is BondFunction ,DepositWithdrawFunction{
    

       constructor(address _bondReceiptContract) BondFunction(_bondReceiptContract){}

    function createNewBond(
  
        address _tokenCollateral,
        uint256 _amountCollateral,
        address _tokenRequired,
        uint256 _interestCoupon,
        uint256[] memory _expireCoupon,
        uint256 _sizeBond,
        uint256 _amountAvvalible
    ) external {
        _createNewBond(msg.sender, _tokenCollateral, _amountCollateral, _tokenRequired, _interestCoupon, _expireCoupon, _sizeBond, _amountAvvalible);
    }


    function buyBond(
        uint256 _amount,
        address _issuing,
        uint256 _bondIndex
    ) external {
        _buyBond(msg.sender, _amount, _issuing, _bondIndex);
    }

     function depositInterestCoupon(
        address _issuing,
        uint256 _bondIndex,
        uint256 _amount
    ) external {

        _depositInterestCoupon(_issuing, _bondIndex, _amount);
    }


    function claimCouponExpired(
        address _issuing,
        uint256 _bondIndex,
        uint256 _receiptID,
        uint256 _expired
    ) external {
        _claimCouponExpired(msg.sender, _issuing, _bondIndex, _receiptID, _expired);
    }

    function withdrawCouponInterestAsset(address _asset) external {
        _withdrawCouponExpired(msg.sender, _asset);
    } 

}







    /*
    event NewDeposit (address indexed user, address indexed token,uint amount);
    event NewWithdraw (address indexed user, address indexed token,uint amount);
    function depositToken(address _token,uint _amount) external {
        _depositToken(msg.sender, _token, _amount);
        emit NewDeposit(msg.sender, _token, _amount);
    }
    function withdrawToken(address  _token,uint _amount) external {
        _withdrawToken(msg.sender, _token, _amount);
        emit NewWithdraw(msg.sender, _token, _amount);
    }
    */