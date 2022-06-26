//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Dwetransfer {
    address payable developer_address;

    struct File {
        uint id;
        string cid;
        address[] downloaders;
        address uploader;
    }

    File file;

    mapping(uint => File) public files; //file.id => File

    event FileUploaded(File file);
    event FileDownload(File file);

    receive() external payable {} 

    constructor() payable {
        developer_address = payable(msg.sender); //explain msg.sender and transaction origin <= owner of the person who deployed 
    }

    function uploadFile(uint _file_id, string memory _file_cid) external payable {
        require(msg.value == 100, "You need at least 100 wei in your account"); // change message 

        file.id = _file_id;
        file.cid = _file_cid;
        file.uploader = msg.sender;

        developer_address.transfer(1 ether);
        
        files[file.id] = file;

        emit FileUploaded(file);
    }

    function downloadFile(uint _file_id) external payable returns (string memory) {
        require(msg.value == 10, "You need to pay 10 wei exactly.");

        payable(files[_file_id].uploader).transfer(8);
        payable(msg.sender).transfer(2);

        emit FileDownload(files[_file_id]);

        return files[_file_id].cid;
    }
}