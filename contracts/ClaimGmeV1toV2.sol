pragma solidity 0.6.12;

import '@pancakeswap/pancake-swap-lib/contracts/access/Ownable.sol';
import "./GameToken.sol";
contract ClaimGmeV1toV2 is Ownable {
    using SafeMath for uint256;

    // The GME TOKEN!
    GameToken public gme;
    // The old GME TOKEN!
    GameToken public gmeOld;
   
    event tokenSwaped(address indexed user, uint256 amount);

    constructor(
        GameToken _gme,
        GameToken _oldgme
    ) public {
        gme = _gme;
        gmeOld = _oldgme;
    }

    // Mint GME token from old GME token
    function claimV1toV2() public {
        require(gmeOld.balanceOf(msg.sender) > 0, "Insufficient Balance");

        uint256 _amount = gmeOld.balanceOf(msg.sender);
        require(gmeOld.transferFrom(address(msg.sender), address(this), _amount));
        require(gmeOld.transfer(address(0x000000000000000000000000000000000000dEaD), _amount));

        gme.mint(msg.sender, _amount);
        emit tokenSwaped(msg.sender, _amount);
    }

    function sendOwnerOfGME(address _owner) public onlyOwner {
        gme.transferOwnership(_owner);
    }
}
