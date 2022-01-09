from scripts.deploy import deploy
from brownie import config, network


def get_weth_dai_pool():
    pool_oracle = deploy()
    active_network = network.show_active()
    weth_address = config["networks"][active_network]["weth"]
    dai_address = config["networks"][active_network]["dai"]
    pool_oracle.getPool(weth_address, dai_address, 3000)
    return pool_oracle


def getTWAP(pool_oracle):
    print("Getting TWAP...")
    sqrtPriceX96 = pool_oracle.getTWAP(0)
    print(sqrtPriceX96)
    return sqrtPriceX96


def getPriceX96FromSqrtPriceX96(pool_oracle, sqrtPriceX96):
    print("Getting priceX96...")
    priceX96 = pool_oracle.getPriceX96FromSqrtPriceX96(sqrtPriceX96)
    print(priceX96)
    return priceX96


def main():
    pool_oracle = get_weth_dai_pool()
    sqrtPriceX96 = getTWAP(pool_oracle)
    priceX96 = getPriceX96FromSqrtPriceX96(pool_oracle, sqrtPriceX96)
