pragma solidity 0.4.19;

import "./BaseContract.sol";

contract Owned is BaseContract {
    address public owner;
    address public newOwner;

    event OwnerUpdate(address indexed _prevOwner, address indexed _newOwner);

    function Owned()
        internal
    {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner);

        _;
    }

    /// @dev allows transferring the contract ownership
    /// the new owner still needs to accept the transfer
    /// can only be called by the contract owner
    /// @param _newOwner    new contract owner
    function transferOwnership(address _newOwner)
        public
        validParamData(1)
        onlyOwner
        onlyIf(_newOwner != owner)
    {
        newOwner = _newOwner;
    }

    /// @dev used by a new owner to accept an ownership transfer
    function acceptOwnership()
        public
        onlyIf(msg.sender == newOwner)
    {
        OwnerUpdate(owner, newOwner);
        owner = newOwner;
        newOwner = 0x0;
    }
}
