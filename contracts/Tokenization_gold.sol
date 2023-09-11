// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

import {ITokenWithPoR} from "./interfaces/ITokenWithPoR.sol";
import {IAggregator} from "@bisonai/orakl-contracts/src/v0.1/interfaces/IAggregator.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "hardhat/console.sol";

contract Tokenization is ITokenWithPoR, ERC20, Ownable {
    constructor()
        // address _feedAddr,
        // uint256 _heartbeat
        Ownable()
        ERC20("Huster's Gold", "HGT")
    {
        s_feed = IAggregator(0x555E072996d0335Ec63B448ddD507CB99379C723);
        // s_heartbeat = _heartbeat;
    }

    uint256 private constant MAX_HEARTBEAT_DAYS = 7;

    uint256 private s_heartbeat;
    IAggregator private s_feed;

    function mint(address _to, uint256 _amount) external onlyOwner {
        (, int256 answer, , uint256 updatedAt, ) = s_feed.latestRoundData();
        require(answer > 0, "invalid answer from PoR feed");
        require(updatedAt >= block.timestamp - s_heartbeat, "answer outdated");

        uint256 reserves = uint256(answer);
        uint256 currentSupply = totalSupply();

        uint8 trueDecimals = decimals();
        uint8 reserveDecimals = s_feed.decimals();
        // Normalise currencies
        if (trueDecimals < reserveDecimals) {
            currentSupply =
                currentSupply *
                10 ** uint256(reserveDecimals - trueDecimals);
        } else if (trueDecimals > reserveDecimals) {
            reserves = reserves * 10 ** uint256(trueDecimals - reserveDecimals);
        }
        require(
            currentSupply + _amount <= reserves,
            "total supply would exceed reserves after mint"
        );
        _mint(_to, _amount);
    }

    function setFeed(address _newFeed) external onlyOwner {
        s_feed = IAggregator(_newFeed);
        emit ReserveFeedSet(_newFeed);
    }

    function setHeartbeat(uint256 _newHeartbeat) external onlyOwner {
        s_heartbeat = _newHeartbeat;
        emit ReserveHeartbeatSet(_newHeartbeat);
    }

    function getFeed() external view returns (address) {
        return address(s_feed);
    }

    function getHeartbeat() external view returns (uint256) {
        return s_heartbeat;
    }

    function getMaxHeartbeatDays() external pure returns (uint256) {
        return MAX_HEARTBEAT_DAYS;
    }
}
