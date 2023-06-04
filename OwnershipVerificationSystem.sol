// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IntellectualPropertyRegistry {
    struct IPAsset {
        string title;
        string description;
        address owner;
    }

    mapping(uint256 => IPAsset) public assets;
    uint256 public assetCounter;

    event AssetRegistered(uint256 assetId, string title, address owner);
    event OwnershipTransferred(uint256 assetId, address from, address to);

    modifier onlyOwner(uint256 assetId) {
        require(msg.sender == assets[assetId].owner, "Only the owner can call this function.");
        _;
    }

    function registerAsset(string memory _title, string memory _description) public {
        uint256 assetId = assetCounter;
        IPAsset memory newAsset = IPAsset(_title, _description, msg.sender);
        assets[assetId] = newAsset;
        assetCounter++;

        emit AssetRegistered(assetId, _title, msg.sender);
    }

    function transferOwnership(uint256 assetId, address newOwner) public onlyOwner(assetId) {
        assets[assetId].owner = newOwner;

        emit OwnershipTransferred(assetId, msg.sender, newOwner);
    }

    function verifyOwnership(uint256 assetId) public view returns (address) {
        require(assetId < assetCounter, "Invalid asset ID.");

        return assets[assetId].owner;
    }
}