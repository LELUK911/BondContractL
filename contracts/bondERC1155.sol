// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract BondReceipt is
    ERC1155,
    Pausable,
    Ownable,
    ERC1155Burnable,
    ERC1155Supply
{
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
    using Counters for Counters.Counter;
     Counters.Counter internal idReceipt;

    mapping(uint256 => ReceiptDataStruct) internal receiptData;
    mapping(address => mapping(uint => uint[])) internal listIdforIndexBond;


    constructor() ERC1155("") {}

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function mint(
        address account,
        uint256 amount,
        bytes memory data,
        uint256 indexBond,
        address issuing,
        address tokenCollateral,
        uint256 amountCollateral,
        address tokenRequired,
        uint256 interestCoupon,
        uint256[] memory expireCoupon,
        uint256 sizeBond
    ) public onlyOwner returns(uint _idReceipt) {
        _idReceipt = idReceipt.current();
        idReceipt.increment();
        _mint(account, indexBond, amount, data);
        receiptData[indexBond] = (
            ReceiptDataStruct(
                _idReceipt,
                indexBond,
                issuing,
                tokenCollateral,
                amountCollateral,
                tokenRequired,
                interestCoupon,
                expireCoupon,
                sizeBond
            )
        );
        listIdforIndexBond[account][indexBond].push(_idReceipt);
        return _idReceipt;
    }

    function mintBatch(
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) public onlyOwner {
        _mintBatch(to, ids, amounts, data);
    }

    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal override(ERC1155, ERC1155Supply) whenNotPaused {

        // qui cambio la lista delle ricevute
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
    }








    function _findIdforIndexBond (address _account, uint _id) internal view returns (uint _indexList){
        for (_indexList = 0; _indexList < listIdforIndexBond[_account][_id].length; _indexList++) {
            //if ()
        }



    }

    function getInformationReceipt(uint _id) public view returns(ReceiptDataStruct memory){
        return receiptData[_id];
    }



    function updateReceiptData() external {}
}
