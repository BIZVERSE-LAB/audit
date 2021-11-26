// SPDX-License-Identifier: MIT

pragma solidity 0.8.0;

import "./openzeppelin/Context.sol";

abstract contract Blacklistable is Context {
    mapping(address => bool) private _blacklist;

    event AddToBlacklist(address indexed account);
    event RemoveFromBlacklist(address indexed account);

    modifier inBlacklistStatus(address account, bool isBlacklisted) {
        require(
            _blacklist[account] == isBlacklisted,
            "Blacklistable: Account not in expected status"
        );
        _;
    }

    function _setBlacklistStatus(address account, bool isBlacklisted)
        internal
        virtual
        inBlacklistStatus(account, !isBlacklisted)
    {
        _blacklist[account] = isBlacklisted;
        if (isBlacklisted) emit AddToBlacklist(account);
        else emit RemoveFromBlacklist(account);
    }

    function isBlacklist(address account) public view virtual returns (bool) {
        return _blacklist[account];
    }
}