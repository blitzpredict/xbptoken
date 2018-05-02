pragma solidity 0.4.19;

import "./common/BaseContract.sol";
import "./common/TokenRetriever.sol";
import "./common/ERC20Token.sol";
import "./common/Owned.sol";

contract XBPToken is BaseContract, Owned, TokenRetriever, ERC20Token {
    using SafeMath for uint256;

    bool public issuanceEnabled = true;

    event Issuance(uint256 _amount);

    function XBPToken()
        public
        ERC20Token("BlitzPredict", "XBP", 18)
    {
    }

    /// @dev disables/enables token issuance
    /// can only be called by the contract owner
    function disableIssuance()
        public
        onlyOwner
        onlyIf(issuanceEnabled)
    {
        issuanceEnabled = false;
    }

    /// @dev increases the token supply and sends the new tokens to an account
    /// can only be called by the contract owner
    /// @param _to         account to receive the new amount
    /// @param _amount     amount to increase the supply by
    function issue(address _to, uint256 _amount)
        public
        onlyOwner
        validParamData(2)
        validAddress(_to)
        onlyIf(issuanceEnabled)
        notThis(_to)
    {
        totalSupply = totalSupply.add(_amount);
        balanceOf[_to] = balanceOf[_to].add(_amount);

        Issuance(_amount);
        Transfer(this, _to, _amount);
    }
}
