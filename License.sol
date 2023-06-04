// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LicenseContract {
    struct License {
        address licensee;
        address licensor;
        uint256 assetId;
        string terms;
        uint256 royaltyRate;
        bool revoked;
    }

    mapping(uint256 => License) public licenses;
    uint256 public licenseCounter;

    event LicenseCreated(uint256 licenseId, address licensee, address licensor, uint256 assetId, string terms, uint256 royaltyRate);
    event LicenseModified(uint256 licenseId, string newTerms, uint256 newRoyaltyRate);
    event LicenseRevoked(uint256 licenseId);

    modifier onlyLicensor(uint256 licenseId) {
        require(msg.sender == licenses[licenseId].licensor, "Only the licensor can call this function.");
        _;
    }

    modifier onlyLicensee(uint256 licenseId) {
        require(msg.sender == licenses[licenseId].licensee, "Only the licensee can call this function.");
        _;
    }

    function createLicense(address _licensee, uint256 _assetId, string memory _terms, uint256 _royaltyRate) public {
        uint256 licenseId = licenseCounter;
        License memory newLicense = License(_licensee, msg.sender, _assetId, _terms, _royaltyRate, false);
        licenses[licenseId] = newLicense;
        licenseCounter++;

        emit LicenseCreated(licenseId, _licensee, msg.sender, _assetId, _terms, _royaltyRate);
    }

    function modifyLicense(uint256 licenseId, string memory newTerms, uint256 newRoyaltyRate) public onlyLicensor(licenseId) {
        licenses[licenseId].terms = newTerms;
        licenses[licenseId].royaltyRate = newRoyaltyRate;

        emit LicenseModified(licenseId, newTerms, newRoyaltyRate);
    }

    function revokeLicense(uint256 licenseId) public onlyLicensor(licenseId) {
        licenses[licenseId].revoked = true;

        emit LicenseRevoked(licenseId);
    }
}
