// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./ERC721.sol";

contract SuperMarioWorld is ERC721{
     string public name;//ERC721Metadata
     string public symbol;//ERC721Metadata
     uint256 public tokenCount;

     mapping (uint256 => string) private _tokenURIs;

     constructor(string memory _name, string memory _symbol){
          name = _name;
          symbol = _symbol;
     }

     //tokenURI-> returns a URL that points to metadata(holds all image and properties of NFT)
     function tokenURI(uint256 tokenId)public view returns(string memory){//ERC721Metadata
          require(_owners[tokenId]!=address(0),"TokenId doesnot exist");
          return _tokenURIs[tokenId];
     }
     //mint-> Creates a new NFT inside our collection
     function mint(string memory _tokenURI)public{
          
          tokenCount++;
          _balances[msg.sender]++;
          _owners[tokenCount] = msg.sender;
          _tokenURIs[tokenCount] = _tokenURI;

          emit Transfer(address(0),msg.sender,tokenCount);
     }
     //supportInterface
     function supportsInterface(bytes4 interfaceId)public pure override returns(bool){
          return interfaceId == 0x80ac58cd || interfaceId == 0x5b5e139f;
     }
}