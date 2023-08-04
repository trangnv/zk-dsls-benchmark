# Readme

benchmarking circom/snarkjs groth16, circom/snarkjs plonk and noir ultraplonk

## circuits description

- input INPUT_SIZE length array of "0"
- output 32 length array which is hash of input
- constraint: hash(input) = output

## circom groth16

- setup `gtime` on macos if you haven't already

```bash
brew install gnu-time
```

- single circom test

```bash
./circom/groth16/test_sha256_groth16_macos.sh 64 16
```
