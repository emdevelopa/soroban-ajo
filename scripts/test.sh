#!/bin/bash

# Test script for Soroban Ajo contract
# Runs all unit and integration tests

set -e  # Exit on error

echo "🧪 Testing Soroban Ajo Contract..."
echo ""

# Navigate to contract directory
cd "$(dirname "$0")/../contracts/ajo"

# Check if Rust is installed
if ! command -v cargo &> /dev/null; then
    echo "❌ Error: Rust/Cargo not found"
    echo "Please install Rust: https://rustup.rs/"
    exit 1
fi

# Run tests with output
echo "Running test suite..."
echo ""

cargo test --verbose

# Check exit code
if [ $? -eq 0 ]; then
    echo ""
    echo "✅ All tests passed!"
    echo ""
    echo "Test coverage includes:"
    echo "  ✓ Group creation and validation"
    echo "  ✓ Member joining and authorization"
    echo "  ✓ Contribution tracking"
    echo "  ✓ Payout execution and rotation"
    echo "  ✓ Group completion lifecycle"
    echo "  ✓ Error handling and edge cases"
    echo ""
    echo "Next steps:"
    echo "  - Build contract: ./scripts/build.sh"
    echo "  - Deploy to testnet: ./scripts/deploy_testnet.sh"
else
    echo ""
    echo "❌ Tests failed"
    echo "Please review the errors above and fix before deploying"
    exit 1
fi
