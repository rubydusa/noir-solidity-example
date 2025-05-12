set -e

echo "Compiling circuit..."
if ! nargo compile; then
    echo "Compilation failed. Exiting..."
    exit 1
fi

echo "Generating vkey..."
sudo docker run --rm -v $(pwd)/target:/app/target -w /app bb-docker write_vk --oracle_hash keccak -b ./target/noir_solidity.json -o ./target

echo "Generating solidity verifier..."
sudo docker run --rm -v $(pwd)/target:/app/target -w /app bb-docker write_solidity_verifier -k ./target/vk -o ./target/Verifier.sol

echo "Done"
