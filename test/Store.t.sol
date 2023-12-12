// SPDX-License-Identifier: WTFPL
pragma solidity 0.8.23;

import {Test, console2} from "forge-std/Test.sol";

contract Store {
    uint256 private _number;

    function store(uint256 num) public {
        _number = num;
    }

    function retrieve() public view returns (uint256) {
        return _number;
    }
}

/**
 * @dev In the `foundry.toml` file we have configured the target EVM to be `shanghai`.
 */
contract StoreTest is Test {
    uint256 private _optimismFork;
    Store private _store;

    function setUp() public {
        _optimismFork = vm.createFork("https://mainnet.optimism.io");
    }

    function testDeployAndInteractOnOptimism() public {
        // We activate the Optimism fork and assert it accordingly.
        vm.selectFork(_optimismFork);
        assertEq(vm.activeFork(), _optimismFork);

        // This deployment should actually fail due to the non-existent `PUSH0` (`5f`) opcode in the init code.
        _store = new Store();
        // 0x6080604052348015600e575f80fd5b5060a58061001b5f395ff3fe6080604052348015600e575f80fd5b50600436106030575f3560e01c80632e64cec11460345780636057361d146048575b5f80fd5b5f5460405190815260200160405180910390f35b605760533660046059565b5f55565b005b5f602082840312156068575f80fd5b503591905056fea264697066735822122066c9c950dae1553a207fada55ceb3c8c4a2cbd99fa68605393a2cae9c2dab02364736f6c63430008150033
        console2.logBytes(type(Store).creationCode);

        // These function interactions should actually fail due to the non-existent `PUSH0` (`5f`) opcode in the runtime code.
        _store.store(1);
        assertEq(_store.retrieve(), 1);
        // 0x6080604052348015600e575f80fd5b50600436106030575f3560e01c80632e64cec11460345780636057361d146048575b5f80fd5b5f5460405190815260200160405180910390f35b605760533660046059565b5f55565b005b5f602082840312156068575f80fd5b503591905056fea2646970667358221220a20cff41929e97651791862ac5880f8582f7ae69d846a86b70433f4db10c6a7464736f6c63430008150033
        console2.logBytes(type(Store).runtimeCode);
    }
}
