pragma solidity ^0.8.18;

contract InitialFairOffering {
    int24 public constant TICK_SPACING = 60; // Tick space is 60
    
    function getInitialRate (uint, uint, uint, uint) internal returns (uint) {
        return 1;
    }

    function priceToSqrtPriceX96(int, int24) internal returns (uint160) {
        return 1;
    }

    function _initializePool(
        address _weth,
        address _token
    )
        public
        returns (
            address _token0,
            address _token1,
            uint _uintRate,
            uint160 _sqrtPriceX96,
            address _pool
        )
    {
        _token0 = _token;
        _token1 = _weth;

        _uintRate = getInitialRate(
            100,
            200,
            300,
            400
        ); // weth quantity per token
        require(_uintRate > 0, "uint rate zero");

        if (_token < _weth) {
            _sqrtPriceX96 = priceToSqrtPriceX96(
                int(_uintRate),
                TICK_SPACING
            );
        } else {
            _token0 = _weth;
            _token1 = _token;
            _uintRate = 10 ** 36 / _uintRate; // token quantity per weth
            _sqrtPriceX96 = priceToSqrtPriceX96(
                int(_uintRate),
                TICK_SPACING
            );
        }
    }

}