#!/bin/bash

# Deploy script for Soroban Ajo to Stellar Testnet
# This script deploys the contract and saves the contract ID

set -e  # Exit on error

echo "🚀 Deploying Soroban Ajo to Stellar Testnet..."
echo ""

# Check if Soroban CLI is installed
if ! command -v soroban &> /dev/null; then
    echo "❌ Error: Soroban CLI not found"
    echo "Please install: cargo install --locked soroban-cli --features opt"
    exit 1
fi

# Navigate to repo root
cd "$(dirname "$0")/.."

# Contract WASM path
WASM_PATH="contracts/ajo/target/wasm32-unknown-unknown/release/soroban_ajo.wasm"

# Check if contract is built
if [ ! -f "$WASM_PATH" ]; then
    echo "❌ Error: Contract WASM not found"
    echo "Please build first: ./scripts/build.sh"
    exit 1
fi

# Check if testnet is configured
if ! soroban network ls | grep -q "testnet"; then
    echo "📡 Configuring Stellar testnet..."
    soroban network add \
      --global testnet \
      --rpc-url https://soroban-testnet.stellar.org:443 \
      --network-passphrase "Test SDF Network ; September 2015"
    echo "✅ Testnet configured"
    echo ""
fi

# Check for deployer identity
if ! soroban keys show deployer &> /dev/null; then
    echo "🔑 Creating deployer identity..."
    soroban keys generate deployer --network testnet
    
    DEPLOYER_ADDR=$(soroban keys address deployer)
    echo "✅ Deployer identity created: $DEPLOYER_ADDR"
    echo ""
    echo "⚠️  Fund this account with testnet XLM:"
    echo "    curl \"https://friendbot.stellar.org?addr=$DEPLOYER_ADDR\""
    echo ""
    read -p "Press Enter after funding the account..."
    echo ""
fi

# Deploy the contract
echo "📤 Deploying contract to testnet..."
CONTRACT_ID=$(soroban contract deploy \
  --wasm "$WASM_PATH" \
  --source deployer \
  --network testnet)

# Check if deployment succeeded
if [ -z "$CONTRACT_ID" ]; then
    echo "❌ Deployment failed"
    exit 1
fi

# Save contract ID
echo "$CONTRACT_ID" > .soroban/contract-id-testnet.txt

echo ""
echo "✅ Contract deployed successfully!"
echo ""
echo "📋 Contract Details:"
echo "   Contract ID: $CONTRACT_ID"
echo "   Network: Stellar Testnet"
echo "   WASM: $WASM_PATH"
echo ""
echo "💾 Contract ID saved to: .soroban/contract-id-testnet.txt"
echo ""
echo "Next steps:"
echo "  - View on Stellar Expert: https://stellar.expert/explorer/testnet/contract/$CONTRACT_ID"
echo "  - Run example invocations: ./scripts/invoke_examples.sh"
echo "  - Follow demo script: demo/demo-script.md"
echo ""
echo "To invoke the contract:"
echo "  soroban contract invoke \\"
echo "    --id $CONTRACT_ID \\"
echo "    --source deployer \\"
echo "    --network testnet \\"
echo "    -- \\"
echo "    FUNCTION_NAME --arg1 value1 --arg2 value2"
echo ""
