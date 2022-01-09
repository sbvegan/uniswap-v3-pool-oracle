// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@uniswap/contracts/interfaces/IUniswapV3Pool.sol";
import "@uniswap/contracts/interfaces/IUniswapV3Factory.sol";

contract PoolOracle {
    IUniswapV3Factory uniswapV3Factory;
    IUniswapV3Pool uniswapV3Pool;
    uint32[] secondsAgos;

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

    function latestObservation() public returns (uint256) {
        secondsAgos.push(0);
        (
            int56[] memory tickCumulatives,
            uint160[] memory secondsPerLiquidityCumulativeX128s
        ) = uniswapV3Pool.observe(secondsAgos);
        // TODO: figure out how to calculate price
        return 0;
    }
}
