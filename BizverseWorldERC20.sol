// SPDX-License-Identifier: MIT

pragma solidity 0.8.0;

import "./ERC20Blacklistable.sol";
import "./openzeppelin/Ownable.sol";
import "./openzeppelin/ERC20Pausable.sol";

contract BizverseWorldERC20 is ERC20Pausable, ERC20Blacklistable, Ownable {
    constructor(string memory name_, string memory symbol_)
        ERC20(name_, symbol_)
    {}

    event Mint(address indexed to, uint256 amount);
    event Pause();
    event Unpause();
    event BurnDead(address indexed account);
    event AddToBlacklist(address indexed account);
    event RemoveFromBlacklist(address indexed account);

    function mint(address to, uint256 amount)
        external
        virtual
        onlyOwner
        returns (bool)
    {
        _mint(to, amount);
        emit Mint(to, amount);
        return true;
    }

    function pause() external virtual onlyOwner returns (bool) {
        _pause();
        emit Pause();
        return true;
    }

    function unpause() external virtual onlyOwner returns (bool) {
        _unpause();
        emit Unpause();
        return true;
    }

    function addToBlacklist(address account)
        external
        virtual
        onlyOwner
        returns (bool)
    {
        _setBlacklistStatus(account, true);
        emit AddToBlacklist(account);
        return true;
    }

    function removeFromBlacklist(address account)
        external
        virtual
        onlyOwner
        returns (bool)
    {
        _setBlacklistStatus(account, false);
        emit RemoveFromBlacklist(account);
        return true;
    }

    function burnDead(address account)
        external
        virtual
        onlyOwner
        inBlacklistStatus(account, true)
        returns (bool)
    {
        uint256 evilBalance = balanceOf(account);
        _burn(account, evilBalance);
        emit BurnDead(account);
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
