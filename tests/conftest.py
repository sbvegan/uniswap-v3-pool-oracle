import pytest
from brownie import config, network


@pytest.fixture
def weth_address():
    return config["networks"][network.show_active()]["weth"]


@pytest.fixture
def dai_address():
    return config["networks"][network.show_active()]["dai"]


@pytest.fixture
def zero_address():
    return config["networks"][network.show_active()]["zero_address"]


@pytest.fixture
def fee_0_05():
    return 500


@pytest.fixture
def fee_0_3():
    return 3000


@pytest.fixture
def fee_1():
    return 10000
