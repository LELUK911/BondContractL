// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

import "../storage.sol";
import "../../node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol";

//import "../library/utils.sol";

contract DepositWithdrawFunction is StorageStruct {


function _issuingWithdraw (address _issuing,address _token) internal {
    uint _balanceIssuing = balanceIssuing[_issuing][_token];
    balanceIssuing[_issuing][_token] = 0;
    IERC20(_token).transfer(_issuing, _balanceIssuing);
}





















/*
    function _depositToken(
        address _user,
        address _token,
        uint256 _amount
    ) internal {
        IERC20(_token).transferFrom(_user, address(this), _amount);
        (uint256 _index, bool response) = serchIndex(_user, _token);

        if (!response) {
            depositUserToken[_user].push(
                DepositUser({tokenAddress: _token, balance: _amount})
            );
        } else {
            depositUserToken[_user][_index] = DepositUser({
                tokenAddress: _token,
                balance: _amount
            });
        }
    }

    function _withdrawToken(
        address _user,
        address _token,
        uint256 _amount
    ) internal {
        (uint256 index, bool response) = serchIndex(_user, _token);
        require(response, "deposit don't find");
        require(
            _amount <= depositUserToken[_user][index].balance,
            "balance insufficient for this withdraw"
        );
        depositUserToken[_user][index].balance -= _amount;
        IERC20(_token).transfer(_user, _amount);
    }

    function getDepositToken(address _user, address _token)
        public
        view
        returns (DepositUser memory _deposit)
    {
        (uint256 index, bool response) = serchIndex(_user, _token);
        require(response, "deposit don't find");
        return _deposit = depositUserToken[_user][index];
    }

    function getListDepositToken(address _user) public view returns(DepositUser[] memory){
        return depositUserToken[_user];
    }

    function serchIndex(address _user, address _token)
        internal
        view
        returns (uint256 index, bool response)
    {
        for (index = 0; index < depositUserToken[_user].length; index++) {
            if (depositUserToken[_user][index].tokenAddress == _token) {
                response = true;
                return (index, response);
            }
        }
        return (index = 0, response = false);
    }
    */
}
