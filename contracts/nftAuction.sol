// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8;

contract NftAuction {
  struct Auction {
     address seller;
     uint256 duration;
     uint256 startTime;
     uint256 startPrice;
     bool ended;
     address highestBidder;
     uint256 highestBid;
     address NftContract;
     uint256 tokenId;
  }
  mapping(uint256 Id => Auction) public auctions;
  uint256 public nextAuctionId;
  address public admin;

  constructor() {
    admin = msg.sender;
  }

  function createAuction(uint256 _duration, uint256 _startPrice, address, address _NftAddress, uint256 _tokenId) public {
    require(msg.sender == admin, "Only admin can create auction");
    require(_duration > 0, "Duration must be greater than 0");
    require(_startPrice > 0, "Start price must be greater than 0");

    auctions[nextAuctionId] = Auction({
      seller: msg.sender,
      duration: _duration,
      startPrice: _startPrice,
      ended: false,
      highestBid: 0,
      highestBidder: address(0),
      startTime: block.timestamp,
      NftContract: _NftAddress,
      tokenId: _tokenId
    });
    nextAuctionId++;
  }

  function placeBId(uint256 _auctionId) external payable {
    Auction storage auction = auctions[_auctionId];
    require(!auction.ended && auction.startTime + auction.duration > block.timestamp, "Auction has ended");
    require(msg.value > auction.highestBid && msg.value > auction.startPrice, "BId must higher than the current highest bId");
    if (msg.sender != address(0)) {
      payable(auction.highestBidder).transfer(auction.highestBid);
    }
    auction.highestBidder = msg.sender;
    auction.highestBid = msg.value;
  }
}