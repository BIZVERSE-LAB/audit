// SPDX-License-Identifier: MIT

pragma solidity 0.8.0;

import "./ERC20Blacklistable.sol";
import "./openzeppelin/Ownable.sol";
import "./openzeppelin/ERC20Pausable.sol";

contract BizverseWorldERC20 is ERC20Pausable, ERC20Blacklistable, Ownable {
    constructor(string memory name_, string memory symbol_)
        ERC20(name_, symbol_)
    {}

    function mint(address to, uint256 amount)
        public
        virtual
        onlyOwner
        returns (bool)
    {
        _mint(to, amount);
        return true;
    }

    function pause() public virtual onlyOwner returns (bool) {
        _pause();
        return true;
    }

    function unpause() public virtual onlyOwner returns (bool) {
        _unpause();
        return true;
    }

    function addToBlacklist(address account)
        public
        virtual
        onlyOwner
        returns (bool)
    {
        _setBlacklistStatus(account, true);
        return true;
    }

    function removeFromBlacklist(address account)
        public
        virtual
        onlyOwner
        returns (bool)
    {
        _setBlacklistStatus(account, false);
        return false;
    }

    function burnDead(address account)
        public
        virtual
        onlyOwner
        inBlacklistStatus(account, true)
        returns (bool)
    {
        uint256 evilBalance = balanceOf(account);
        _burn(account, evilBalance);
        return true;
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual override(ERC20Pausable, ERC20Blacklistable) {
        super._beforeTokenTransfer(from, to, amount);
    }

    function _approve(
        address from,
        address spender,
        uint256 amount
    ) internal virtual override(ERC20, ERC20Blacklistable) {
        super._approve(from, spender, amount);
    }
}