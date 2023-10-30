// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "./IWethy.sol";

contract Wethy is IWethy, ERC20, Ownable, ERC20Permit, ERC20Votes {
    constructor(address initialOwner, string memory _name, string memory _symbol)
        ERC20(_name, _symbol)
        Ownable(initialOwner)
        ERC20Permit(_symbol)
    {}

    using Address for address payable;

    function mint(address to) public payable {

        // Make sure "to" is not this contract or the zero address.
        require(to != address(this) && to != address(0), "Wethy: Invalid address");

        _mint(to, msg.value);
    }

    function withdraw(uint256 value) public {
        _burn(_msgSender(), value);
        payable(address(msg.sender)).sendValue(value);
    }

    /**
     * This is an OpenZeppelin function override.
     * The following functions are overrides required by Solidity.
     */

    function _update(address from, address to, uint256 value)
        internal
        override(ERC20, ERC20Votes)
    {
        super._update(from, to, value);
    }

    function nonces(address owner)
        public
        view
        override(ERC20Permit, Nonces)
        returns (uint256)
    {
        return super.nonces(owner);
    }

    /**
     * This is a function that comes from ENS, allowing recovery of ERC20 tokens sent to the contract by mistake. 
     * https://github.com/ensdomains/ens-contracts/blob/dev/contracts/utils/ERC20Recoverable.sol
     */

    /**
    @notice Recover ERC20 tokens sent to the contract by mistake.
    @dev The contract is Ownable and only the owner can call the recover function.
    @param _to The address to send the tokens to.
    @param _token The address of the ERC20 token to recover
    @param _amount The amount of tokens to recover.
    */

    function recoverFunds(
        address _token,
        address _to,
        uint256 _amount
    ) external onlyOwner {
        IERC20(_token).transfer(_to, _amount);
    }
}