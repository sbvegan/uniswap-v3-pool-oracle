from scripts.deploy import deploy
from brownie import config, network


def get_weth_dai_pool():
    pool_oracle = deploy()
    active_network = network.show_active()
    weth_address = config["networks"][active_network]["weth"]
    dai_address = config["networks"][active_network]["dai"]
    pool_oracle.getPool(weth_address, dai_address, 3000)
    return pool_oracle


def latest_observation():
    pool_oracle = get_weth_dai_pool()
    pool_oracle.latestObservation()


def main():
    latest_observation()
