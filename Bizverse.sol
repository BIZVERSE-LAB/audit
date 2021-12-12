// SPDX-License-Identifier: MIT

pragma solidity 0.8.0;

import "./BizverseWorldERC20.sol";

contract BIVE is BizverseWorldERC20 {
    constructor() BizverseWorldERC20("Bizverse", "BIVE") {
        _mint(_msgSender(), 10000000000000);
    }

    function decimals() external pure override returns (uint8) {
        return 4;
    }

    function mint(address, uint256) external virtual override returns (bool) {
        revert("BIVE: Minting is not allowed");
    }
}
