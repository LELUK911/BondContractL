// SPDX-License-Identifier: MIT

import "../node_modules/@openzeppelin/contracts/utils/Counters.sol";

pragma solidity 0.8.16;

contract StorageStruct{

    struct DepositUser{
        address tokenAddress;
        uint balance;
    }

    struct BondStruct {
        uint indexBond;
        address issuing;
        address tokenCollateral;
        uint amountCollateral;
        address tokenRequired;
        uint interestCoupon;
        uint[] expireCoupon;
        uint sizeBond;
        uint amountAvvalible;
        uint amountSellBond;
    }

   
    //mapping (address => DepositUser[]) depositUserToken;
    //uint internal bondIndex;


    Counters.Counter internal bondIndex;

    mapping (address => BondStruct[]) bonds;

    address internal bondReceiptContract;

    mapping (address =>mapping (address=>uint)) internal balanceIssuing;
    mapping (uint =>mapping (address=>uint)) internal balanceCoupon;
    mapping(address=>mapping(address => uint)) internal balancUser;



    //struct CouponLists{
    //    uint idReceipt;
    //    uint[] expireds;
//
    //}

    mapping(uint => uint[]) internal listBondReceipts;

    mapping(uint=>mapping(uint=>mapping(uint=>bool))) internal couponPaid;

    
   
}