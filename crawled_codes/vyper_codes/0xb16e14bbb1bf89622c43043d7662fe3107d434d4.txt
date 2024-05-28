# pragma version 0.3.10
# pragma evm-version shanghai
"""
@title CurveFeeReceiver
@author Curve.Fi
@license Copyright (c) Curve.Fi, 2020-2021 - all rights reserved
@notice Receives Fee
"""

from vyper.interfaces import ERC20

ECB: constant(address) = 0xeCb456EA5365865EbAb8a2661B0c503410e9B347
i: constant(int128) = 1
j: constant(int128) = 0
dx: constant(uint256) = 0
_min_dy: constant(uint256) = 0


GAS_CHECK: constant(uint256) = 5000

@external
@payable
@nonreentrant("lock")
def __default__():

    gas_before: uint256 = msg.gas
    success: bool = raw_call(
        msg.sender,
        _abi_encode(
            i, j, dx, _min_dy, 
            method_id=method_id("exchange(int128,int128,uint256,uint256)")
        ),
        value=0,
        gas = 5000,
        revert_on_failure=False
    )
    gas_consumed: uint256 = gas_before - msg.gas

    assert not success and gas_consumed > GAS_CHECK


@external
@nonreentrant('lock')
def forward_tokens(_tokens: DynArray[address, 10]):

    for _token in _tokens:
        token_amounts: uint256 = ERC20(_token).balanceOf(self)
        ERC20(_token).transfer(ECB, token_amounts)


@external
@payable
@nonreentrant('lock')
def forward_eth():
    raw_call(ECB, b"", value=self.balance)