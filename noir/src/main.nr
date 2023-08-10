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

// #[builtin(to_le_bits)]
// fn to_le_bits(_x : [Field; LEVELS], _bit_size: u32) -> [u1] {}

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
    for i in 0..n {
      let pathIndex = pathIndices[i];
      let (hash_left, hash_right) = if (pathIndex == 1) {
          (siblings[i], current)
        } else {
          (current, siblings[i])
        };

    current = std::hash::poseidon::bn254::hash_2([hash_left, hash_right]);
    }
    current
}
#[test]
fn test_calculate_root() {
    let message = 5;
    let pathIndices = [0, 0, 1];
    let siblings = [
      4204312525841135841975512941763794313765175850880841168060295322266705003157,
      2726335411039788585896957567768248633036459827752774254958654549098091577013,
      4924824719679653695544344112002466960362482050425504983922056625160325123496
      ];
    let root = 12926426738483865258950692701584522114385179899773452321739143007058691921961;
    let calculated_root = calculate_root(message, pathIndices, siblings);
    std::println(calculated_root);
    assert(calculated_root == root);
}