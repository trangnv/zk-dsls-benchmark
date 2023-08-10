circom merkle_tree_proof.circom --r1cs --wasm -o build

node build/merkle_tree_proof_js/generate_witness.js build/merkle_tree_proof_js/merkle_tree_proof.wasm input.json build/witness.wtns