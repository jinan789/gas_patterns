# @version 0.3.10

"""
@title yPRISMA Forwarder Callback Minter
@license GNU AGPLv3
@author Yearn Finance
"""
from vyper.interfaces import ERC20

interface IYPRISMA:
    def delegate_mint(_recipient: address, _amount: uint256) -> uint256: nonpayable
    def ylocker() -> address: view

interface IYLOCKER:
    def proxy() -> address: view
    def governance() -> address: view

interface IYPROXY:
    def collectTokensFromLocker(token: address, amount: uint256, recipient: address) -> uint256: nonpayable

event FeesConfigured:
    fee_on_mints: uint256
    fee_on_rentals: uint256

event RewardTokenSet:
    token: indexed(address)

PRECISION: constant(uint256) = 10_000
YPRISMA: public(constant(address)) =        0xe3668873D944E4A949DA05fc8bDE419eFF543882
YEARN_LOCKER: public(immutable(address))
FACTORY: public(immutable(address))
fee_on_mints: public(uint256)
fee_on_rentals: public(uint256)
reward_tokens: public(DynArray[address, 10])

@external
def __init__(
    _factory: address,
    _fee_on_mints: uint256,
    _fee_on_rentals: uint256
):
    YEARN_LOCKER = IYPRISMA(YPRISMA).ylocker()
    FACTORY = _factory
    self.fee_on_mints = _fee_on_mints
    self.fee_on_mints = _fee_on_rentals

@external
def getFeePct(
    claimant: address,
    receiver: address,
    boost_delegate: address,
    amount: uint256,
    previous_amount: uint256,
    total_weekly_emissions: uint256
) -> uint256:

    if receiver == YEARN_LOCKER:
        return self.fee_on_mints

    return self.fee_on_rentals

@external
def delegateCallback(
    _claimant: address,
    _receiver: address,
    _boost_delegate: address,
    _amount: uint256,
    _adjusted_amount: uint256,
    _fee: uint256,
    _previous_amount: uint256,
    _total_weekly_emissions: uint256
) -> bool:
    """
    @dev 
        logic here will execute when Yearn boost is 
        selected as a boost delegate
    """
    assert msg.sender == FACTORY, "!factory"
    return True

@external
def receiverCallback(
    _claimant: address,
    _receiver: address,
    _adjusted_amount: uint256
) -> bool:
    """
    @notice Allow users to mint yPRISMA using boost from any delegate.
    """
    assert msg.sender == FACTORY, "!factory"

    if _receiver != YEARN_LOCKER: # Don't mint if not locking to ylocker
        return True

    # Mint yPRISMA
    IYPRISMA(YPRISMA).delegate_mint(
        _claimant, 
        (_adjusted_amount / 10 ** 18) * 10 ** 18 # We must trim precision to match the actual lock amount
    )

    # Fetch any extra rewards earned by users
    for token in self.reward_tokens:
        amount: uint256 = ERC20(token).balanceOf(YEARN_LOCKER)
        if amount == 0:
            continue

        IYPROXY(
            IYLOCKER(YEARN_LOCKER).proxy()
        ).collectTokensFromLocker(token, amount, _claimant)

    return True

@external
def configure_fees(_fee_on_mints: uint256, _fee_on_rentals: uint256):
    assert (
        msg.sender == IYLOCKER(YEARN_LOCKER).governance() or 
        msg.sender == YEARN_LOCKER
    ), "!authorized"
    assert _fee_on_mints <= PRECISION
    assert _fee_on_rentals <= PRECISION
    self.fee_on_mints = _fee_on_mints
    self.fee_on_rentals = _fee_on_rentals
    log FeesConfigured(_fee_on_mints, _fee_on_rentals)

@external
def set_reward_tokens(_token_addresses: DynArray[address, 10]):
    assert (
        msg.sender == IYLOCKER(YEARN_LOCKER).governance() or 
        msg.sender == YEARN_LOCKER
    ), "!authorized"
    self.reward_tokens = _token_addresses
    for token in _token_addresses:
        log RewardTokenSet(token)