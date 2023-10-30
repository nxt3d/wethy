// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Address} from "@openzeppelin/contracts/utils/Address.sol";
import {Wethy} from "./Wethy.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract WethyFactory is Ownable{

    // Setup the base strings for the name and symbol.
    string baseName = "Wethy_";
    string baseSymbol = "WETHY_";

    /**
     * @notice A mapping of Wethy contracts to booleans.
     */
     
    mapping (address => bool) public isWethyToken;

    /**
     * The fee to deploy a Wethy contract.
     */

    uint256 public deployFee;

    constructor(address initialOwner)
        Ownable(initialOwner)
    {}

    /**
     * @notice Deploy a Wethy contract for the sender.
     */

    function deployWethy(string calldata _name, string calldata _symbol) public payable{

        // Make sure the sender has paid the fee
        require(msg.value >= deployFee, "WethyFactory: Insufficient fee");

        string memory tokenName = string(abi.encodePacked(baseName,_name));
        string memory tokenSymbol = string(abi.encodePacked(baseSymbol,_symbol));

        isWethyToken[address(new Wethy(msg.sender, tokenName, tokenSymbol))] = true; 
    }

    /**
     * @notice Set the fee to deploy a Wethy contract.
     * @param _fee The fee in wei.
     */

    function setDeployFee(uint256 _fee) public onlyOwner {
        deployFee = _fee;
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