pragma solidity ^0.8.0;

contract AkshunSeasonPassNft  {

    string contractURI;
    event ContractURIUpdated(string); 
    error ParamInvalid(uint8 paramPosIdx);

function updateContractURI(string memory _contractURI)
        public
        
    {
        // Validate input params.

        if (bytes(_contractURI).length == 0) revert ParamInvalid(0);

        // Update/set state vars.

        contractURI = _contractURI;

        // Emit events.

        emit ContractURIUpdated(_contractURI);
    }

}
