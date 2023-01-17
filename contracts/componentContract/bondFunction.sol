// SPDX-License-Identifier: MIT

import "../storage.sol";
//import "../bondERC721.sol";
import "../library/utils.sol";
import "../../node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../../node_modules/@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "../../node_modules/@openzeppelin/contracts/utils/Counters.sol";
import "../interface/IbondERC721.sol";

pragma solidity 0.8.16;

contract BondFunction is StorageStruct {
    using Counters for Counters.Counter;

    constructor(address _bondReceiptContract) {
        bondReceiptContract = _bondReceiptContract;
    }

    function _createNewBond(
        address _issuing,
        address _tokenCollateral,
        uint256 _amountCollateral,
        address _tokenRequired,
        uint256 _interestCoupon,
        uint256[] memory _expireCoupon,
        uint256 _sizeBond,
        uint256 _amountAvvalible
    ) internal {
        IERC20(_tokenCollateral).transferFrom(
            _issuing,
            address(this),
            _amountCollateral
        );
        uint256 _bondIndex = bondIndex.current();
        bondIndex.increment();
        bonds[_issuing].push(
            BondStruct(
                _bondIndex,
                _issuing,
                _tokenCollateral,
                _amountCollateral,
                _tokenRequired,
                _interestCoupon,
                HelperDepositFunction._returnDayTime(_expireCoupon),
                _sizeBond,
                _amountAvvalible,
                0
            )
        );
    }

    function _buyBond(
        address _user,
        uint256 _amount,
        address _issuing,
        uint256 _bondIndex
    ) internal {
        (uint256 index, bool response) = searchIndexListBond(
            _issuing,
            _bondIndex
        );
        require(response, "Bond don't find");
        IERC20(bonds[_issuing][index].tokenRequired).transferFrom(
            _user,
            address(this),
            (_amount * bonds[_issuing][index].sizeBond)
        );
        _callMintFunction(
            _user,
            _amount,
            bonds[_issuing][index].indexBond,
            bonds[_issuing][index].issuing,
            bonds[_issuing][index].tokenCollateral,
            bonds[_issuing][index].amountCollateral,
            bonds[_issuing][index].tokenRequired,
            bonds[_issuing][index].interestCoupon,
            bonds[_issuing][index].expireCoupon,
            bonds[_issuing][index].sizeBond
        );

        bonds[_issuing][index].amountAvvalible -= 1;
        bonds[_issuing][index].amountSellBond += (_amount *
            bonds[_issuing][index].sizeBond);

        balanceIssuing[_issuing][
            bonds[_issuing][index].tokenRequired
        ] = (_amount * bonds[_issuing][index].sizeBond);
    }

    function _callMintFunction(
        address account,
        uint256 amount,
        uint256 indexBond,
        address issuing,
        address tokenCollateral,
        uint256 amountCollateral,
        address tokenRequired,
        uint256 interestCoupon,
        uint256[] memory expireCoupon,
        uint256 sizeBond
    ) internal {
        //BondReceipt721 _bondReceipt = BondReceipt721(bondReceiptContract);

        uint256[] memory _idReceipt = IBondReceipt721(bondReceiptContract)
            .safeMint(
                account,
                amount,
                indexBond,
                issuing,
                tokenCollateral,
                amountCollateral,
                tokenRequired,
                interestCoupon,
                expireCoupon,
                sizeBond
            );

        listBondReceipts[indexBond] = _idReceipt;
    }

    function getListBondReceipts(uint256 indexBond)
        public
        view
        returns (uint256[] memory)
    {
        return listBondReceipts[indexBond];
    }

    function _depositInterestCoupon(
        address _issuing,
        uint256 _bondIndex,
        uint256 _amount
    ) internal {
        (uint256 index, bool response) = searchIndexListBond(
            _issuing,
            _bondIndex
        );
        require(response, "Bond don't find");
        IERC20(bonds[_issuing][index].tokenRequired).transferFrom(
            _issuing,
            address(this),
            _amount
        );
        balanceCoupon[_bondIndex][
            bonds[_issuing][index].tokenRequired
        ] += _amount;
    }

    function _claimCouponExpired(
        address _user,
        address _issuing,
        uint256 _bondIndex,
        uint256 _receiptID,
        uint256 _expired
    ) internal {
        (uint256 index, bool response) = searchIndexListBond(
            _issuing,
            _bondIndex
        );
        require(response, "Bond don't find");
        uint256[] memory expireds = bonds[_issuing][_bondIndex].expireCoupon;
        if (expireds[_expired] <= block.timestamp) {
            if (!couponPaid[_bondIndex][_receiptID][expireds[_expired]]) {
                require(
                    balanceCoupon[_bondIndex][
                        bonds[_issuing][index].tokenRequired
                    ] >= bonds[_issuing][index].interestCoupon,
                    "Balance insufficient for paid this Coupon"
                );

                couponPaid[_bondIndex][_receiptID][expireds[_expired]] = true;
                balanceCoupon[_bondIndex][
                    bonds[_issuing][index].tokenRequired
                ] -= (bonds[_issuing][index].interestCoupon);

                balancUser[_user][bonds[_issuing][index].tokenRequired] += (
                    bonds[_issuing][index].interestCoupon
                );
            }
        }
    }

    function _withdrawCouponExpired() internal {}

    function searchIndexListBond(address _issuing, uint256 _bondIndex)
        internal
        view
        returns (uint256 index, bool response)
    {
        for (index = 0; index < bonds[_issuing].length; index++) {
            if (bonds[_issuing][index].indexBond == _bondIndex) {
                response = true;
                return (index, response);
            }
        }
        return (index = 0, response = false);
    }

    function getBondList(address _issuing)
        public
        view
        returns (BondStruct[] memory)
    {
        return bonds[_issuing];
    }
}
