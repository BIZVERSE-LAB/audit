// SPDX-License-Identifier: MIT

pragma solidity 0.8.0;

import "./openzeppelin/ERC20.sol";
import "./openzeppelin/Ownable.sol";
import "./Blacklistable.sol";

abstract contract ERC20Blacklistable is Blacklistable, ERC20 {
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual override {
        super._beforeTokenTransfer(from, to, amount);
        if (!(isBlacklist(from) && to == address(0))) {
            require(
                !isBlacklist(from),
                "ERC20Blacklistable: Sender blacklisted"
            );
            require(
                !isBlacklist(to),
                "ERC20Blacklistable: Recipient blacklisted"
            );
            require(
                !isBlacklist(_msgSender()),
                "ERC20Blacklistable: Caller blacklisted"
            );
        }
    }

    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual override {
        super._approve(owner, spender, amount);
        require(!isBlacklist(owner), "ERC20Blacklistable: Owner blacklisted");
        require(
            !isBlacklist(spender),
            "ERC20Blacklistable: Spender blacklisted"
        );
    }
}
