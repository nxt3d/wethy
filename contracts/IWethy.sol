//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/**
 * @notice An interface for the Wethy contract.
 */

interface IWethy is IERC20 {

    /**
     * @notice Mint Wethy tokens.
     * @param to The address to mint to.
     */

    function mint(address to) external payable;

    /**
     * @notice Withdraw Wethy tokens.
     * @param value The amount of tokens to withdraw.
     */

    function withdraw(uint256 value) external;

    /**
     * @notice Recover ERC20 tokens sent to the contract by mistake.
     * @dev The contract is Ownable and only the owner can call the recover funds function.
     * @param _token The address of the ERC20 token to recover
     * @param _to The address to send the tokens to.
     * @param _amount The amount of tokens to recover.
     */

    function recoverFunds(address _token, address _to, uint256 _amount) external;


}