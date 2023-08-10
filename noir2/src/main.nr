use dep::std;
global LEVELS: Field = 3;

fn main(
//   leaf: Field,
  message: Field,
  pathIndices: [Field; LEVELS],
  siblings: [Field; LEVELS],
  root: Field
)  {
    let calculated_root = calculate_root(message, pathIndices, siblings);
    assert(calculated_root == root);
}

#[builtin(to_le_bits)]
fn to_le_bits(_x : [Field; LEVELS], _bit_size: u32) -> [u1] {}

fn poseidon1(
  message: Field,
)  -> Field {
    let leaf = std::hash::poseidon::bn254::hash_1([message]);
    leaf
}

fn calculate_root(
    message: Field,
    pathIndices: [Field; LEVELS],
    siblings: [Field; LEVELS],
) -> Field {
    let n = LEVELS;
    let leaf = std::hash::poseidon::bn254::hash_1([message]);
    let mut current = leaf;
    let index_bits = to_le_bits(pathIndices, n as u32);
    for i in 0..n {
        let path_bit = index_bits[i] as bool;
        let (hash_left, hash_right) = if path_bit {
            (siblings[i], current)
         } else {
            (current, siblings[i])
         };

      current = std::hash::poseidon::bn254::hash_2([hash_left, hash_right]);
    }
    current
}