// SPDX-License-Identifier: MIT

pragma solidity 0.8.0;

import "./openzeppelin/Context.sol";

abstract contract Blacklistable is Context {
    mapping(address => bool) private _blacklist;

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
    {
        _blacklist[account] = isBlacklisted;
    }

    function isBlacklist(address account) public view virtual returns (bool) {
        return _blacklist[account];
    }
}
