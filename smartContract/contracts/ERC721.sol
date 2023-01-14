// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract ERC721{
     event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);
     event  Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId); 
     event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);        

     mapping (address => uint256) internal _balances;
     mapping (uint256 => address) internal _owners;
     mapping (address => mapping (address => bool)) private _operatorApprovals;
     mapping (uint256 => address) private _tokenApprovals;

     //Returns number of NFT assigned to owner
     function balanceOf(address owner)public view returns(uint256){
          require(owner!=address(0),"Address is 0");
          return _balances[owner];
     }

     //Returns owner of NFT
     function ownerOf(uint256 tokenId)public view returns(address){
          address owner = _owners[tokenId]; 
          require(owner!=address(0),"TokenId doesnot exist");
          return owner;
     }

     // Enables or disables an operator to manage all of msg.senders assets.
     function setApprovalForAll(address operator, bool approved)public{
          require(operator!=msg.sender,"Operator is msg.sender");
          _operatorApprovals[msg.sender][operator] = approved;
          emit ApprovalForAll(msg.sender,operator,approved);
     }

     //Returns true if operator is approved by owner
     function isApprovedForAll(address owner, address operator)public view returns(bool){
          return _operatorApprovals[owner][operator];
     }

     //Updates an approved address of an NFT
     function approve(address to, uint256 tokenId)public{
          address owner = ownerOf(tokenId);
          require(to!=owner,"To is owner");
          require(msg.sender==owner || isApprovedForAll(owner,msg.sender),"Msg.sender is not the owner or Not approved");
          _tokenApprovals[tokenId] = to;
          emit Approval(owner,to,tokenId);
     }

     //Returns approved address of an NFT
     function getApproved(uint256 tokenId)public view returns(address){
          require(_owners[tokenId]!=address(0),"TokenId doesnot exist");
          return _tokenApprovals[tokenId];
     }

     //Transfer ownership of an NFT
     function transferFrom(address from, address to, uint256 tokenId)public{
          address owner=ownerOf(tokenId);
          require(msg.sender==owner || getApproved(tokenId)==msg.sender || isApprovedForAll(owner,msg.sender),"Msg.sender is not the owner or Not approved");
          require(owner ==  from,"from address is not the owner");
          require(to != address(0),"to address is 0");
          require(_owners[tokenId] != address(0),"TokenId doesnot exist"); 
          approve(address(0),tokenId);
          _balances[from] -= 1;
          _balances[to] += 1;
          _owners[tokenId] = to;
  
          emit Transfer(from,to,tokenId);
     }

     //Standard transferFrom
     //Checks if onERC721Recieved is implemented WHEN sending to smart contracts
     function safeTransferFrom(address from,address to,uint256 tokenId,bytes memory _data) public {
          transferFrom(from,to,tokenId);
          require(_checkOnERC721Reccieved(),"Reciever not implemented");
     }

     function safeTransferFrom(address from,address to,uint256 tokenId) public {
          safeTransferFrom(from,to,tokenId,"");
     }
     
     function _checkOnERC721Reccieved() private pure returns(bool){
          return true;
     }

     //EIP165: Query if a contract implements another interface
     function supportsInterface(bytes4 interfaceId) public pure virtual returns (bool) {
          return interfaceId == 0x80ac58cd;
     }

}
