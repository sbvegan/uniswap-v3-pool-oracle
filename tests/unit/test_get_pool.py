from scripts.deploy import deploy
from brownie import exceptions
import pytest


def test_get_existing_pool(weth_address, dai_address, fee_0_3):
    pool_oracle = deploy()
    pool_oracle.getPool(weth_address, dai_address, fee_0_3)


def test_get_nonexisting_pool(weth_address, fee_0_3):
    pool_oracle = deploy()
    with pytest.raises(exceptions.VirtualMachineError):
        pool_oracle.getPool(weth_address, weth_address, fee_0_3)
