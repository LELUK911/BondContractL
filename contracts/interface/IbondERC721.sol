// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface IBondReceipt721 {


struct ReceiptDataStruct {
        uint id;
        uint256 indexBond;
        address issuing;
        address tokenCollateral;
        uint256 amountCollateral;
        address tokenRequired;
        uint256 interestCoupon;
        uint256[] expireCoupon;
        uint256 sizeBond;
    }

    function safeMint(
        address to,
        uint256 amount,
        uint256 indexBond,
        address issuing,
        address tokenCollateral,
        uint256 amountCollateral,
        address tokenRequired,
        uint256 interestCoupon,
        uint256[] memory expireCoupon,
        uint256 sizeBond
    ) external returns (uint256[] memory tokensId);

    function getInformationReceipt(uint256 _id)
        external
        view
        returns (ReceiptDataStruct memory);

    function balanceOfBonds(address _user, uint256 _bondIndex)
        external
        view
        returns (uint256 balanceBonds);

         function ListIdReceiptForBonds(address  _user, uint  _bondIndex) external view returns(uint[] memory);
}
