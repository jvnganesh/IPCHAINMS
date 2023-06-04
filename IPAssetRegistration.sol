// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IPRegistry {
    struct Asset {
        address owner;
        string name;
        string description;
        bool isRegistered;
    }
    
    mapping(uint256 => Asset) public assets;
    uint256 public assetCount;
    
    event AssetRegistered(uint256 indexed assetId, address indexed owner, string name);
    event AssetTransferred(uint256 indexed assetId, address indexed previousOwner, address indexed newOwner);
    
    modifier onlyAssetOwner(uint256 assetId) {
        require(assets[assetId].owner == msg.sender, "Only asset owner can perform this action");
        _;
    }
    
    function registerAsset(string memory name, string memory description) public {
        assetCount++;
        assets[assetCount] = Asset(msg.sender, name, description, true);
        
        emit AssetRegistered(assetCount, msg.sender, name);
    }
    
    function transferOwnership(uint256 assetId, address newOwner) public onlyAssetOwner(assetId) {
        assets[assetId].owner = newOwner;
        
        emit AssetTransferred(assetId, msg.sender, newOwner);
    }
}

contract Licensing {
    struct License {
        address licensee;
        uint256 assetId;
        uint256 royaltyPercentage;
        bool isActive;
    }
    
    mapping(uint256 => License) public licenses;
    uint256 public licenseCount;
    
    event LicenseGranted(uint256 indexed licenseId, address indexed licensee, uint256 assetId, uint256 royaltyPercentage);
    event RoyaltyPaid(uint256 indexed licenseId, address indexed licensee, uint256 amount);
    
    modifier onlyLicensee(uint256 licenseId) {
        require(licenses[licenseId].licensee == msg.sender, "Only licensee can perform this action");
        _;
    }
    
    function grantLicense(uint256 assetId, address licensee, uint256 royaltyPercentage) public {
        licenseCount++;
        licenses[licenseCount] = License(licensee, assetId, royaltyPercentage, true);
        
        emit LicenseGranted(licenseCount, licensee, assetId, royaltyPercentage);
    }
    
    function payRoyalty(uint256 licenseId, uint256 amount) public onlyLicensee(licenseId) {
        // Perform royalty payment logic, e.g., transfer funds to the IP owner
        // ...
        
        emit RoyaltyPaid(licenseId, msg.sender, amount);
    }
}

contract DisputeResolution {
    struct Dispute {
        uint256 licenseId;
        string description;
        bool isResolved;
    }
    
    mapping(uint256 => Dispute) public disputes;
    uint256 public disputeCount;
    
    event DisputeRaised(uint256 indexed disputeId, uint256 indexed licenseId, string description);
    event DisputeResolved(uint256 indexed disputeId, uint256 indexed licenseId);
    
    modifier onlyDisputeParticipant(uint256 disputeId) {
        require(
            licenses[disputes[disputeId].licenseId].licensee == msg.sender ||
            assets[licenses[disputes[disputeId].licenseId].assetId].owner == msg.sender,
            "Only dispute participant can perform this action"
        );
        _;
    }
    
    function raiseDispute(uint256 licenseId, string memory description) public {
        disputeCount++;
        disputes[disputeCount] = Dispute(licenseId, description, false);
        
        emit DisputeRaised(disputeCount, licenseId, description);
    }
    
    function resolveDispute(uint256 disputeId) public onlyDisputeParticipant(disputeId) {
        disputes[disputeId].isResolved = true;
        
        emit DisputeResolved(disputeId, disputes[disputeId].licenseId);
    }
}