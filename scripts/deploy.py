from brownie import config, network, PoolOracle
from scripts.helpful_scripts import get_account


def deploy():

    account = get_account()

    active_network = network.show_active()
    print(f"Network is {active_network}")

    print(f"Deploying...")
    uniswap_v3_factory = config["networks"][active_network]["uniswap_v3_factory"]
    pool_oracle = PoolOracle.deploy(uniswap_v3_factory, {"from": account})
    print(f"Deployed to {pool_oracle.address}")
    return pool_oracle


def main():
    deploy()
