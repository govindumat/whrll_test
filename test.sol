// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC721, ERC721URIStorage,ERC721Burnable, Ownable {
    constructor(address initialOwner)
        ERC721("MyToken", "MTK")
        Ownable(initialOwner)
    {}

    function safeMint(address to, uint256 tokenId ,string memory uri) public payable onlyOwner {
          require(msg.value == 1000000000000000, "Not enough ETH sent; check price!"); 
        _safeMint(to, tokenId);
        _setTokenURI(tokenId,uri);
    }

    function maxmint(uint8 num,address to, uint256[9] memory tokenId ,string[9] memory uri) private {
        for(uint count=0; count <num;count++){
                require(num>0 && num<9);
                    safeMint(to, tokenId[count], uri[count]);
        }
    }

    function tokenURI(uint256 tokenId) public view  override (ERC721, ERC721URIStorage)
         returns (string memory) 
    {

        return super.tokenURI(tokenId);
    }
    function supportsInterface(bytes4 interfaceId)
    public view override (ERC721,ERC721URIStorage)
    returns  (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function withdraw(uint256 amount, address payable _to) public payable onlyOwner {
        require(amount <= address(this).balance);
        _to.transfer(amount);
    }
    
    receive() external payable {}

}