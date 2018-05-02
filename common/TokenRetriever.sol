pragma solidity 0.4.19;

import "./IToken.sol";
import "./Owned.sol";

contract TokenRetriever is Owned {
    function TokenRetriever()
        internal
    {
    }

    /// @dev Failsafe mechanism - Allows owner to retrieve tokens from the contract
    /// @param _token The address of ERC20 compatible token
    function retrieveTokens(IToken _token)
        public
        onlyOwner
    {
        uint256 tokenBalance = _token.balanceOf(this);
        if (tokenBalance > 0) {
            _token.transfer(owner, tokenBalance);
        }
    }
}
