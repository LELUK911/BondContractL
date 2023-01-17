// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract BondReceipt721 is ERC721, Pausable, Ownable, ERC721Burnable {
    using Counters for Counters.Counter;


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
    mapping(uint256 => ReceiptDataStruct) internal receiptData;
    mapping(address => mapping(uint => uint[])) internal listIdforIndexBond;

    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("MyToken", "MTK") {}

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
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
    ) public onlyOwner returns (uint[] memory ){
        uint[] memory tokensId = new uint[](amount);
        for (uint256 index = 0; index < amount;index++) {
            uint tokenId = _tokenIdCounter.current();
            _tokenIdCounter.increment();
            _safeMint(to, tokenId);
            receiptData[tokenId] = (
            ReceiptDataStruct(
                tokenId,
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
        listIdforIndexBond[to][indexBond].push(tokenId);
       
            tokensId[index]=tokenId;

        
      
        }
        return tokensId;
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
        internal
        whenNotPaused
        override
    {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }


      function getInformationReceipt(uint _id) public view returns(ReceiptDataStruct memory){
        return receiptData[_id];
    }
    


    function _findIdforIndexBond (address _account, uint _id) internal view returns (uint _indexList){
        for (_indexList = 0; _indexList < listIdforIndexBond[_account][_id].length; _indexList++) {

        }
    }

    function balanceOfBonds(address  _user, uint  _bondIndex) public view returns(uint balanceBonds){
        return listIdforIndexBond[_user][_bondIndex].length;
    }
    function ListIdReceiptForBonds(address  _user, uint  _bondIndex) public view returns(uint[] memory){
        return listIdforIndexBond[_user][_bondIndex];
    }


}
