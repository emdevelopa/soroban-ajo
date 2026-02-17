#!/bin/bash

# Example invocations for Soroban Ajo contract
# Demonstrates the full contract API with a 3-member group

set -e  # Exit on error

echo "🎯 Soroban Ajo - Example Contract Invocations"
echo ""

# Check if Soroban CLI is installed
if ! command -v soroban &> /dev/null; then
    echo "❌ Error: Soroban CLI not found"
    exit 1
fi

# Load contract ID
CONTRACT_ID_FILE=".soroban/contract-id-testnet.txt"
if [ ! -f "$CONTRACT_ID_FILE" ]; then
    echo "❌ Error: Contract ID not found"
    echo "Please deploy first: ./scripts/deploy_testnet.sh"
    exit 1
fi

CONTRACT_ID=$(cat "$CONTRACT_ID_FILE")
echo "📋 Using Contract ID: $CONTRACT_ID"
echo ""

# Setup test identities
echo "🔑 Setting up test identities..."

# Create identities if they don't exist
for identity in alice bob charlie; do
    if ! soroban keys show "$identity" &> /dev/null; then
        soroban keys generate "$identity" --network testnet
    fi
done

ALICE=$(soroban keys address alice)
BOB=$(soroban keys address bob)
CHARLIE=$(soroban keys address charlie)

echo "   Alice: $ALICE"
echo "   Bob: $BOB"
echo "   Charlie: $CHARLIE"
echo ""

# Fund accounts
echo "💰 Funding test accounts..."
echo "   (This may take a few seconds...)"
curl -s "https://friendbot.stellar.org?addr=$ALICE" > /dev/null
curl -s "https://friendbot.stellar.org?addr=$BOB" > /dev/null
curl -s "https://friendbot.stellar.org?addr=$CHARLIE" > /dev/null
echo "   ✅ All accounts funded"
echo ""

# Example 1: Create Group
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📝 Example 1: Create Group"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Creating group with:"
echo "  - Contribution: 100 XLM (1,000,000,000 stroops)"
echo "  - Cycle Duration: 1 week (604,800 seconds)"
echo "  - Max Members: 3"
echo ""

GROUP_ID=$(soroban contract invoke \
  --id "$CONTRACT_ID" \
  --source alice \
  --network testnet \
  -- \
  create_group \
  --creator "$ALICE" \
  --contribution_amount 1000000000 \
  --cycle_duration 604800 \
  --max_members 3)

echo "✅ Group created with ID: $GROUP_ID"
echo ""

# Example 2: Get Group Info
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔍 Example 2: Get Group Information"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

soroban contract invoke \
  --id "$CONTRACT_ID" \
  --source alice \
  --network testnet \
  -- \
  get_group \
  --group_id "$GROUP_ID"

echo ""

# Example 3: Bob Joins
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "👥 Example 3: Bob Joins Group"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

soroban contract invoke \
  --id "$CONTRACT_ID" \
  --source bob \
  --network testnet \
  -- \
  join_group \
  --member "$BOB" \
  --group_id "$GROUP_ID"

echo "✅ Bob joined group $GROUP_ID"
echo ""

# Example 4: Charlie Joins
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "👥 Example 4: Charlie Joins Group"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

soroban contract invoke \
  --id "$CONTRACT_ID" \
  --source charlie \
  --network testnet \
  -- \
  join_group \
  --member "$CHARLIE" \
  --group_id "$GROUP_ID"

echo "✅ Charlie joined group $GROUP_ID"
echo ""

# Example 5: List Members
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📋 Example 5: List All Members"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

soroban contract invoke \
  --id "$CONTRACT_ID" \
  --source alice \
  --network testnet \
  -- \
  list_members \
  --group_id "$GROUP_ID"

echo ""

# Example 6: Check Membership
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✓ Example 6: Check if Bob is Member"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

IS_MEMBER=$(soroban contract invoke \
  --id "$CONTRACT_ID" \
  --source alice \
  --network testnet \
  -- \
  is_member \
  --group_id "$GROUP_ID" \
  --address "$BOB")

echo "Is Bob a member? $IS_MEMBER"
echo ""

# Example 7: Contributions (Cycle 1)
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "💵 Example 7: All Members Contribute (Cycle 1)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "Alice contributing..."
soroban contract invoke \
  --id "$CONTRACT_ID" \
  --source alice \
  --network testnet \
  -- \
  contribute \
  --member "$ALICE" \
  --group_id "$GROUP_ID"
echo "✅ Alice contributed"

echo "Bob contributing..."
soroban contract invoke \
  --id "$CONTRACT_ID" \
  --source bob \
  --network testnet \
  -- \
  contribute \
  --member "$BOB" \
  --group_id "$GROUP_ID"
echo "✅ Bob contributed"

echo "Charlie contributing..."
soroban contract invoke \
  --id "$CONTRACT_ID" \
  --source charlie \
  --network testnet \
  -- \
  contribute \
  --member "$CHARLIE" \
  --group_id "$GROUP_ID"
echo "✅ Charlie contributed"
echo ""

# Example 8: Check Contribution Status
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 Example 8: Check Contribution Status"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

soroban contract invoke \
  --id "$CONTRACT_ID" \
  --source alice \
  --network testnet \
  -- \
  get_contribution_status \
  --group_id "$GROUP_ID" \
  --cycle_number 1

echo ""

# Example 9: Execute Payout
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "💰 Example 9: Execute Payout (Alice receives)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

soroban contract invoke \
  --id "$CONTRACT_ID" \
  --source alice \
  --network testnet \
  -- \
  execute_payout \
  --group_id "$GROUP_ID"

echo "✅ Payout executed to Alice (300 XLM)"
echo ""

# Example 10: Check if Complete
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🏁 Example 10: Check if Group is Complete"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

IS_COMPLETE=$(soroban contract invoke \
  --id "$CONTRACT_ID" \
  --source alice \
  --network testnet \
  -- \
  is_complete \
  --group_id "$GROUP_ID")

echo "Is group complete? $IS_COMPLETE"
echo "(Should be false - still 2 more cycles to go)"
echo ""

# Final Summary
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Example Invocations Complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "What we demonstrated:"
echo "  1. ✓ Created a 3-member group"
echo "  2. ✓ Two members joined"
echo "  3. ✓ Listed all members"
echo "  4. ✓ Verified membership"
echo "  5. ✓ All members contributed"
echo "  6. ✓ Checked contribution status"
echo "  7. ✓ Executed payout to first member"
echo "  8. ✓ Verified group is not yet complete"
echo ""
echo "Current State:"
echo "  - Group ID: $GROUP_ID"
echo "  - Members: 3 (Alice, Bob, Charlie)"
echo "  - Current Cycle: 2"
echo "  - Next Payout: Bob"
echo "  - Remaining Cycles: 2"
echo ""
echo "To continue:"
echo "  - Repeat contribution and payout for cycles 2 and 3"
echo "  - After cycle 3, group will be complete"
echo ""
echo "View contract on Stellar Expert:"
echo "  https://stellar.expert/explorer/testnet/contract/$CONTRACT_ID"
echo ""
echo "For detailed walkthrough, see: demo/demo-script.md"
echo ""
