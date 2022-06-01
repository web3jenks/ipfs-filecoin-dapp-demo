//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Greeter {
    string private greeting;

    constructor(string memory _greeting) {
        console.log("Deploying a Greeter with greeting:", _greeting);
        greeting = _greeting;
    }

    function greet() public view returns (string memory) {
        return greeting;
    }

    function setGreeting(string memory _greeting) public {
        console.log("Changing greeting from '%s' to '%s'", greeting, _greeting);
        greeting = _greeting;
    }
}

contract Dwetransfer {
    address payable developer_address = payable(0xcd3B766CCDd6AE721141F452C550Ca635964ce71);

    struct File {
        uint id;
        string cid;
        address[] downloaders;
    }

    mapping(address => File) public files;

    constructor() {}

    function uploadFile(uint _file_id, string memory _file_cid) public payable {
        require(msg.value > 100 wei, "You need at least 100 wei in your account");
        
        developer_address.transfer(100 wei);

        File memory file;

        file.id = _file_id;
        file.cid = _file_cid;
        
        files[msg.sender] = file;
    }

    function downloadFile(address payable _uploader_address, uint _file_id) public payable {
        require(files[_uploader_address].id == _file_id, "The file you requested does not exist");
        require(msg.value > 10 wei, "You need at least 10 wei in your account");

        _uploader_address.transfer(8 wei);
        developer_address.transfer(2 wei);
    }

}