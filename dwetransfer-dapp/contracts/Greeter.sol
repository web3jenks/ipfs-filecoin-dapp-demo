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
    address payable developer_address;

    struct File {
        uint id;
        string cid;
        address[] downloaders;
    }

    File file;

    mapping(uint => File) public files; //file.id => File
    mapping(address => uint) public uploads; //address => 

    constructor() {
        developer_address = payable(msg.sender); //explain msg.sender and transaction origin <= owner of the person who deployed 
    }

    function uploadFile(uint _file_id, string memory _file_cid) public payable {
        require(msg.value >= 100 wei, "You need at least 100 wei in your account"); // change message 
        
        developer_address.transfer(msg.value);

        file.id = _file_id;
        file.cid = _file_cid;
        
        files[file.id] = file;
        uploads[msg.sender] = file.id;
    }

    function downloadFile(address payable _uploader_address, uint _file_id) public payable {
        require(uploads[_uploader_address] == _file_id, "The file you requested does not exist.");
        require(msg.value >= 10 wei, "You need to pay 10 wei exactly.");

        _uploader_address.transfer(8 wei);
        developer_address.transfer(2 wei);
    }

}