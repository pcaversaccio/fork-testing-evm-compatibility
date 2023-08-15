# Fork Testing – EVM Compatibility

[![🕵️‍♂️ Test smart contracts](https://github.com/pcaversaccio/fork-testing-evm-compatibility/actions/workflows/test.yml/badge.svg)](https://github.com/pcaversaccio/fork-testing-evm-compatibility/actions/workflows/test.yml)
[![License: WTFPL](https://img.shields.io/badge/License-WTFPL-blue.svg)](http://www.wtfpl.net/about)

This repository implements a [simple fork test](./test/Store.t.sol) on Optimism that proves that the EVM behaviour of the forked chain is _not_ identically replicated locally. This can lead to problems due to new opcodes such as [`PUSH0`](https://www.evm.codes/#5f?fork=shanghai) which would lead to untested behaviour as the EVM behaviour is not correctly replicated as part of the test suite. The underlying issue is that fork tests are local simulations with accounts, states, and storage slot information fetched from the RPC. This means that one does not get the full behaviour of the chain and therefore cannot identify specific EVM difference problems.

### Test

Simply invoke:

```console
forge test
```

### `PUSH0`-Rollout

![image](https://github.com/pcaversaccio/fork-testing-evm-compatibility/assets/25297591/d09ab338-511d-4211-b5ba-93e32dddd479)
