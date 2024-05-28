# @version 0.3.7
"""
@notice Connext bridge wrapper
"""
from vyper.interfaces import ERC20


interface Connext:
    def xcall(
        _destination: uint32,
        _to: address,
        _asset: address,
        _delegate: address,
        _amount: uint256,
        _slippage: uint256,
        _callData: Bytes[128]
    ) -> bytes32: payable


interface XERC20Lockbox:
    def deposit(_amount: uint256): nonpayable
    def depositTo(_to: address, _amount: uint256): nonpayable
    def XERC20() -> address: view
    def ERC20() -> address: view


event TransferOwnership:
    _old_owner: address
    _new_owner: address


CONNEXT: immutable(address)
TOKEN: immutable(address)
XTOKEN: immutable(address)
LOCKBOX: immutable(address)
DESTINATION_DOMAIN: immutable(uint32)

is_approved: public(HashMap[address, bool])

owner: public(address)
future_owner: public(address)

xcall_cost: uint256


@external
def __init__(_connext: address, _lockbox: address, _destination_domain: uint32, _xcall_cost: uint256, _owner: address):
    CONNEXT = _connext
    LOCKBOX = _lockbox
    DESTINATION_DOMAIN = _destination_domain

    # fetch token addresses from lockbox
    token: address = XERC20Lockbox(_lockbox).ERC20()
    xtoken: address = XERC20Lockbox(_lockbox).XERC20()
    TOKEN = token
    XTOKEN = xtoken

    # approve raw token to lockbox and xtoken to connext bridge
    assert ERC20(token).approve(_lockbox, max_value(uint256), default_return_value=True)
    assert ERC20(xtoken).approve(_connext, max_value(uint256), default_return_value=True)
    self.is_approved[token] = True
    self.is_approved[xtoken] = True

    self.owner = _owner
    log TransferOwnership(empty(address), _owner)

    self.xcall_cost = _xcall_cost


@payable
@external
def __default__():
    pass


@payable
@external
def bridge(_token: address, _to: address, _amount: uint256):
    """
    @notice Bridge an asset using the Connext Bridge
    @param _token The ERC20 asset to bridge
    @param _to The receiver on the destination chain
    @param _amount The amount of `_token` to bridge
    """
    assert ERC20(_token).transferFrom(msg.sender, self, _amount, default_return_value=True)

    if _token == TOKEN:
        # use lockbox to wrap token into xtoken first
        XERC20Lockbox(LOCKBOX).deposit(_amount)
        Connext(CONNEXT).xcall(DESTINATION_DOMAIN, _to, XTOKEN, msg.sender, _amount, 0, b"", value=self.xcall_cost)
    else:
        if not self.is_approved[_token]:
            assert ERC20(_token).approve(CONNEXT, max_value(uint256), default_return_value=True)
            self.is_approved[_token] = True
        Connext(CONNEXT).xcall(DESTINATION_DOMAIN, _to, _token, msg.sender, _amount, 0, b"", value=self.xcall_cost)


    if self.balance != 0:
        raw_call(msg.sender, b"", value=self.balance)


@view
@external
def cost() -> uint256:
    """
    @notice Cost in ETH to bridge
    """
    return self.xcall_cost


@pure
@external
def check(_account: address) -> bool:
    """
    @notice Check if `_account` may bridge via `transmit_emissions`
    @param _account The account to check
    """
    return True


@external
def set_xcall_cost(_new_cost: uint256):
    assert msg.sender == self.owner  # dev: only owner

    self.xcall_cost = _new_cost


@external
def commit_transfer_ownership(_future_owner: address):
    """
    @notice Transfer ownership to `_future_owner`
    @param _future_owner The account to commit as the future owner
    """
    assert msg.sender == self.owner  # dev: only owner

    self.future_owner = _future_owner


@external
def accept_transfer_ownership():
    """
    @notice Accept the transfer of ownership
    @dev Only the committed future owner can call this function
    """
    assert msg.sender == self.future_owner  # dev: only future owner

    log TransferOwnership(self.owner, msg.sender)
    self.owner = msg.sender