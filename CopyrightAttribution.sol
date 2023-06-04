// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CopyrightRegistry {
    struct CopyrightRecord {
        string contentHash;
        uint256 timestamp;
    }

    mapping(string => CopyrightRecord) public copyrightRecords;

    event CopyrightRegistered(string contentHash, uint256 timestamp);

    function registerCopyright(string memory _contentHash) public {
        require(bytes(_contentHash).length > 0, "Invalid content hash.");

        require(copyrightRecords[_contentHash].timestamp == 0, "Copyright already registered.");

        uint256 timestamp = block.timestamp;

        CopyrightRecord memory newRecord = CopyrightRecord(_contentHash, timestamp);
        copyrightRecords[_contentHash] = newRecord;

        emit CopyrightRegistered(_contentHash, timestamp);
    }

    function verifyCopyright(string memory _contentHash) public view returns (uint256) {
        return copyrightRecords[_contentHash].timestamp;
    }
}