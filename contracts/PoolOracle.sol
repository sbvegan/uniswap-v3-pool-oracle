// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "@uniswap/contracts/interfaces/IUniswapV3Pool.sol";
import "@uniswap/contracts/interfaces/IUniswapV3Factory.sol";
import "@uniswap/contracts/libraries/TickMath.sol";
import "@uniswap/contracts/libraries/FixedPoint96.sol";
import "@uniswap/contracts/libraries/FullMath.sol";

contract PoolOracle {
    IUniswapV3Factory uniswapV3Factory;
    IUniswapV3Pool uniswapV3Pool;

    constructor(address uniswapV3FactoryAddress) {
        uniswapV3Factory = IUniswapV3Factory(uniswapV3FactoryAddress);
    }

    function getPool(
        address _tokenA,
        address _tokenB,
        uint24 _fee
    ) public {
        address uniswapV3PoolAddress = uniswapV3Factory.getPool(
            _tokenA,
            _tokenB,
            _fee
        );
        require(uniswapV3PoolAddress != address(0), "Pool does not exist.");
        uniswapV3Pool = IUniswapV3Pool(uniswapV3PoolAddress);
    }

    function getTWAP(uint32 twapInterval)
        public
        view
        returns (uint160 sqrtPriceX96)
    {
        if (twapInterval == 0) {
            // return the current price if twapInterval == 0
            (sqrtPriceX96, , , , , , ) = uniswapV3Pool.slot0();
        } else {
            uint32[] memory secondsAgos = new uint32[](2);
            secondsAgos[0] = twapInterval; // from (before)
            secondsAgos[1] = 0; // to (now)

            (int56[] memory tickCumulatives, ) = uniswapV3Pool.observe(
                secondsAgos
            );

            // tick(imprecise as it's an integer) to price
            sqrtPriceX96 = TickMath.getSqrtRatioAtTick(
                int24((tickCumulatives[1] - tickCumulatives[0]) / twapInterval)
            );
        }
    }

    function getPriceX96FromSqrtPriceX96(uint160 sqrtPriceX96)
        public
        pure
        returns (uint256 priceX96)
    {
        return FullMath.mulDiv(sqrtPriceX96, sqrtPriceX96, FixedPoint96.Q96);
    }
}
