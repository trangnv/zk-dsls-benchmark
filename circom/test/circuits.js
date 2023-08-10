const { assert } = require("chai");
const wasm_tester = require("circom_tester").wasm;

describe("Merkle tree circuit", function () {
  let merkleTreeCircuit;

  before(async function () {
    merkleTreeCircuit = await wasm_tester("circuits/merkle_tree_proof.circom");
  });

  it("Should generate the witness successfully", async function () {
    let input = {
      leaf: "19065150524771031435284970883882288895168425523179566388456001105768498065277",
      siblings: [
        "4204312525841135841975512941763794313765175850880841168060295322266705003157",
        "2726335411039788585896957567768248633036459827752774254958654549098091577013",
        "4924824719679653695544344112002466960362482050425504983922056625160325123496",
      ],
      pathIndices: ["0", "0", "1"],
      root: "12926426738483865258950692701584522114385179899773452321739143007058691921961",
    };
    const witness = await merkleTreeCircuit.calculateWitness(input);
    await merkleTreeCircuit.assertOut(witness, {});
  });
});
