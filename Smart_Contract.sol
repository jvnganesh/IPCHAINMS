// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract IntellectualPropertyContract is ERC721 {
    uint256 public tokenIdCounter;
    address public admin;

    struct IntellectualProperty {
        string name;
        string description;
        address owner;
    }

    mapping(uint256 => IntellectualProperty) public intellectualProperties;

    event IntellectualPropertyCreated(uint256 indexed tokenId, string name, string description, address indexed owner);
    event IntellectualPropertyTransferred(uint256 indexed tokenId, address indexed from, address indexed to);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this function.");
        _;
    }

    constructor() ERC721("Intellectual Property Token", "IP") {
        admin = msg.sender;
    }

    function createIntellectualProperty(string memory _name, string memory _description) external {
        uint256 newTokenId = tokenIdCounter;
        tokenIdCounter++;

        _mint(msg.sender, newTokenId);
        intellectualProperties[newTokenId] = IntellectualProperty(_name, _description, msg.sender);

        emit IntellectualPropertyCreated(newTokenId, _name, _description, msg.sender);
    }

    function transferIntellectualProperty(uint256 _tokenId, address _to) external {
        require(ownerOf(_tokenId) == msg.sender, "You can only transfer your own intellectual property.");
        require(_to != address(0), "Invalid address.");

        safeTransferFrom(msg.sender, _to, _tokenId);
        intellectualProperties[_tokenId].owner = _to;

        emit IntellectualPropertyTransferred(_tokenId, msg.sender, _to);
    }

    function setAdmin(address _admin) external onlyAdmin {
        require(_admin != address(0), "Invalid address.");

        admin = _admin;
    }
}