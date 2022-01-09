# Uniswap V3 Pool Oracle

Getting the price from the Uniswap Pool Oracle.

From the uniswap docs:

In addition, you'll notice the X96 suffix at the end of the variable name. This X* naming convention is used throughout the Uniswap V3 codebase to indicate values that are encoded as binary fixed-point numbers. Fixed-point is excellent at representing fractions while maintaining consistent fidelity and high precision in integer-only environments like the EVM, making it a perfect fit for representing prices, which of course are ultimately fractions. The number after X indicates the number of fraction bits - 96 in this case - reserved for encoding the value after the decimal point. The number of integer bits can be trivially derived from the size of the variable and the number of fraction bits. In this case, sqrtPriceX96 is stored as a uint160, meaning that there are 160 - 96 = 64 integer bits.

## Resources
- https://docs.uniswap.org/
- https://github.com/Uniswap/v3-core
- https://medium.com/blockchain-development-notes/a-guide-on-uniswap-v3-twap-oracle-2aa74a4a97c5