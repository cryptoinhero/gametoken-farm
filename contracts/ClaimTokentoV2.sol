pragma solidity 0.6.12;
// SPDX-License-Identifier: MIT

import './GameToken.sol';

contract ClaimTokentoV2 is Ownable {
    using SafeMath for uint256;

    // The GME TOKEN!
    GameToken public tokenV1;
    // The old GME TOKEN!
    GameToken public tokenV2;
   
    event tokenSwaped(address indexed user, uint256 amount);

    constructor(
        address _tokenV1,
        address _tokenV2
    ) public {
        tokenV1 = GameToken(_tokenV1);
        tokenV2 = GameToken(_tokenV2);
    }

    // Mint GME token from old GME token
    function claimV1toV2() public {
        uint256 _amount = tokenV1.balanceOf(msg.sender);
        require(_amount > 0, "Insufficient Balance");

        require(tokenV1.transferFrom(address(msg.sender), address(this), _amount));
        require(tokenV1.transfer(address(0x000000000000000000000000000000000000dEaD), _amount));

        tokenV2.mint(msg.sender, _amount);
        emit tokenSwaped(msg.sender, _amount);
    }

    function sendOwnerOfGME(address _owner) public onlyOwner {
        tokenV2.transferOwnership(_owner);
    }
}
