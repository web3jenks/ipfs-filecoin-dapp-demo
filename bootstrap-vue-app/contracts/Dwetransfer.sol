//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Dwetransfer {
    address payable owner_address;

    uint fileId = 0; //set fileId to 0

    struct File {
        uint id;
        string cid;
        address[] downloaders;
        address uploader;
    } //declaring the File struct

    File file;

    mapping(uint => File) public files; //to store files (fileId, File Object)

    //declaring events to emit to ETH chain
    event FileIdCreated(uint fileId);
    event FileGetCid(string cid);

    receive() external payable {} 

    constructor() payable {
        owner_address = payable(msg.sender);
    }

    function uploadFile(string memory _filecid) external payable {
        require(msg.value == 1 ether, "1 ether is required to upload a file."); //checks the amount

        fileId += 1; //increment fileId

        file.id = fileId;
        file.cid = _filecid;
        file.uploader = msg.sender;

        owner_address.transfer(1 ether);
        
        files[file.id] = file;

        emit FileIdCreated(fileId);
    }

    function downloadFile(uint _file_id) external payable {
        require(msg.value == 1 ether, "10 ehter is reuqired to download a file.");

        payable(files[_file_id].uploader).transfer(0.8 ether);
        owner_address.transfer(0.2 ether);

        emit FileGetCid(files[_file_id].cid);
    }

    function uploaderWithdraw(uint _amount, uint _file_id) public {
        require(msg.sender == files[_file_id].uploader);
        payable(msg.sender).transfer(_amount);
    }

    function ownerWithdraw(uint _amount) public {
        require(payable(msg.sender) == owner_address );
        owner_address.transfer(_amount);
    }
}