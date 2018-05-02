pragma solidity 0.4.19;

import "./common/BaseContract.sol";
import "./common/Owned.sol";
import "./common/TokenRetriever.sol";
import "./XBPToken.sol";

contract TokenIssuer is BaseContract, Owned, TokenRetriever {
    XBPToken public token;

    function TokenIssuer(XBPToken _token)
        public
    {
        token = _token;
    }

    /// @dev Issues tokens to all provided addresses.
    /// @param _recipients address[] The addresses of recipients of the tokens to be issued
    /// @param _amounts uint256[] The number of tokens to issue to each receipient, in wei
    function issueTokens(address[] _recipients, uint256[] _amounts)
        external
        onlyOwner
        onlyIf(_recipients.length == _amounts.length)
    {
        for (uint256 i = 0; i < _recipients.length; ++i) {
            token.issue(_recipients[i], _amounts[i]);
        }
    }

    /// @dev Proposes to transfer control of the token contract to a new owner.
    /// @param newOwner address The address to transfer ownership to.
    ///
    /// Note: The new owner will need to call token's acceptOwnership directly in order to accept the ownership.
    function transferTokenOwnership(address newOwner)
        external
        onlyOwner
    {
        token.transferOwnership(newOwner);
    }

    /// @dev Accepts ownership of the token contract
    function acceptTokenOwnership()
        external
        onlyOwner
    {
        token.acceptOwnership();
    }
}
