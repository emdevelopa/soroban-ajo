#!/bin/bash

# Build script for Soroban Ajo contract
# This script builds the contract for deployment

set -e  # Exit on error

echo "🔨 Building Soroban Ajo Contract..."
echo ""

# Navigate to contract directory
cd "$(dirname "$0")/../contracts/ajo"

# Check if Rust is installed
if ! command -v cargo &> /dev/null; then
    echo "❌ Error: Rust/Cargo not found"
    echo "Please install Rust: https://rustup.rs/"
    exit 1
fi

# Check if wasm32 target is installed
if ! rustup target list | grep -q "wasm32-unknown-unknown (installed)"; then
    echo "📦 Installing wasm32-unknown-unknown target..."
    rustup target add wasm32-unknown-unknown
    echo ""
fi

# Run tests first
echo "🧪 Running tests..."
cargo test
echo ""

# Build the contract
echo "🏗️  Building contract..."
cargo build --target wasm32-unknown-unknown --release
echo ""

# Check if build was successful
WASM_PATH="target/wasm32-unknown-unknown/release/soroban_ajo.wasm"
if [ -f "$WASM_PATH" ]; then
    SIZE=$(du -h "$WASM_PATH" | cut -f1)
    echo "✅ Build successful!"
    echo "📦 Contract WASM: $WASM_PATH"
    echo "📊 Size: $SIZE"
    echo ""
    echo "Next steps:"
    echo "  - Run tests: ./scripts/test.sh"
    echo "  - Deploy to testnet: ./scripts/deploy_testnet.sh"
else
    echo "❌ Build failed - WASM file not found"
    exit 1
fi
