# Demo Script: Soroban Ajo Complete Walkthrough

## Overview

This script guides you through a complete demonstration of the Soroban Ajo contract, from installation to completing a full group lifecycle.

**Time Required:** 30-45 minutes  
**Network:** Stellar Testnet  
**Prerequisites:** Basic command line knowledge

---

## Prerequisites

### 1. Install Required Tools

#### Install Rust
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
```

#### Install Soroban CLI
```bash
cargo install --locked soroban-cli --features opt
```

#### Verify Installation
```bash
soroban --version
# Should output: soroban-cli 20.0.0 (or similar)
```

### 2. Set Up Network Configuration

```bash
# Add Stellar testnet
soroban network add \
  --global testnet \
  --rpc-url https://soroban-testnet.stellar.org:443 \
  --network-passphrase "Test SDF Network ; September 2015"

# Verify network added
soroban network ls
```

---

## Part 1: Building the Contract

### Step 1: Clone Repository

```bash
# Clone the repository
git clone https://github.com/yourusername/soroban-ajo.git
cd soroban-ajo

# View structure
ls -la
```

**Expected Output:**
```
README.md
LICENSE
contracts/
docs/
grants/
scripts/
...
```

### Step 2: Build the Contract

```bash
# Navigate to contract directory
cd contracts/ajo

# Build the contract
cargo build --target wasm32-unknown-unknown --release

# Verify build
ls -lh target/wasm32-unknown-unknown/release/*.wasm
```

**Expected Output:**
```
soroban_ajo.wasm
```

**What Just Happened:**
- Rust compiled our contract to WebAssembly
- The .wasm file is the deployable contract
- Size should be ~50-100 KB

### Step 3: Run Tests

```bash
# Run all tests
cargo test

# Run with verbose output
cargo test -- --nocapture
```

**Expected Output:**
```
running 15 tests
test test_create_group ... ok
test test_join_group ... ok
test test_contribution_flow ... ok
test test_full_lifecycle ... ok
...
test result: ok. 15 passed; 0 failed
```

**What Tests Cover:**
- Group creation
- Member joining
- Contribution tracking
- Payout execution
- Error handling
- Edge cases

---

## Part 2: Deploying to Testnet

### Step 4: Create Test Identities

```bash
# Create deployer identity
soroban keys generate deployer --network testnet

# Create test user identities
soroban keys generate alice --network testnet
soroban keys generate bob --network testnet
soroban keys generate charlie --network testnet

# View addresses
echo "Deployer: $(soroban keys address deployer)"
echo "Alice: $(soroban keys address alice)"
echo "Bob: $(soroban keys address bob)"
echo "Charlie: $(soroban keys address charlie)"
```

**Expected Output:**
```
Deployer: GDXXX...
Alice: GDYYY...
Bob: GDZZZ...
Charlie: GDWWW...
```

### Step 5: Fund Accounts

```bash
# Fund deployer account (use Stellar testnet faucet)
curl "https://friendbot.stellar.org?addr=$(soroban keys address deployer)"

# Fund user accounts
curl "https://friendbot.stellar.org?addr=$(soroban keys address alice)"
curl "https://friendbot.stellar.org?addr=$(soroban keys address bob)"
curl "https://friendbot.stellar.org?addr=$(soroban keys address charlie)"

# Verify balances (should each have 10,000 XLM)
soroban keys show deployer
```

**Expected Output:**
```
Public Key: GDXXX...
Balance: 10000 XLM
```

### Step 6: Deploy Contract

```bash
# Deploy the contract
CONTRACT_ID=$(soroban contract deploy \
  --wasm target/wasm32-unknown-unknown/release/soroban_ajo.wasm \
  --source deployer \
  --network testnet)

# Save contract ID
echo "Contract ID: $CONTRACT_ID"
echo "$CONTRACT_ID" > contract-id.txt

# Verify deployment
soroban contract inspect --id $CONTRACT_ID --network testnet
```

**Expected Output:**
```
Contract deployed successfully!
Contract ID: CAXXX...
```

**What Just Happened:**
- Contract uploaded to Stellar testnet
- Received unique contract ID
- Contract is now callable by anyone

---

## Part 3: Demo Scenario - 3-Member Group

### Scenario Setup

**Group Configuration:**
- Contribution: 100 XLM per member per cycle
- Cycle Duration: 604,800 seconds (1 week)
- Max Members: 3
- Members: Alice (creator), Bob, Charlie

**Expected Flow:**
1. Alice creates group (becomes member 1)
2. Bob and Charlie join
3. Cycle 1: All contribute → Alice receives payout
4. Cycle 2: All contribute → Bob receives payout
5. Cycle 3: All contribute → Charlie receives payout
6. Group completes

### Step 7: Alice Creates Group

```bash
# Store addresses as variables
ALICE=$(soroban keys address alice)
BOB=$(soroban keys address bob)
CHARLIE=$(soroban keys address charlie)

# Alice creates group
# Parameters: creator, contribution_amount, cycle_duration, max_members
GROUP_ID=$(soroban contract invoke \
  --id $CONTRACT_ID \
  --source alice \
  --network testnet \
  -- \
  create_group \
  --creator "$ALICE" \
  --contribution_amount 1000000000 \
  --cycle_duration 604800 \
  --max_members 3)

echo "Group ID: $GROUP_ID"
```

**Expected Output:**
```
Group ID: 1
```

**Explanation:**
- `contribution_amount`: 1000000000 = 100 XLM (in stroops)
- `cycle_duration`: 604800 = 1 week in seconds
- `max_members`: 3 people in the group
- Alice automatically becomes first member

### Step 8: View Group Details

```bash
# Get group information
soroban contract invoke \
  --id $CONTRACT_ID \
  --source alice \
  --network testnet \
  -- \
  get_group \
  --group_id 1
```

**Expected Output:**
```json
{
  "id": 1,
  "creator": "GDYYY...",
  "contribution_amount": "1000000000",
  "cycle_duration": 604800,
  "max_members": 3,
  "members": ["GDYYY..."],
  "current_cycle": 1,
  "payout_index": 0,
  "created_at": 1234567890,
  "cycle_start_time": 1234567890,
  "is_complete": false
}
```

**Key Fields:**
- `members`: Currently only Alice
- `current_cycle`: 1 (first cycle)
- `payout_index`: 0 (Alice will receive first payout)
- `is_complete`: false (group still active)

### Step 9: Bob Joins

```bash
# Bob joins the group
soroban contract invoke \
  --id $CONTRACT_ID \
  --source bob \
  --network testnet \
  -- \
  join_group \
  --member "$BOB" \
  --group_id 1

# Verify Bob is a member
soroban contract invoke \
  --id $CONTRACT_ID \
  --source bob \
  --network testnet \
  -- \
  is_member \
  --group_id 1 \
  --address "$BOB"
```

**Expected Output:**
```
true
```

### Step 10: Charlie Joins

```bash
# Charlie joins the group
soroban contract invoke \
  --id $CONTRACT_ID \
  --source charlie \
  --network testnet \
  -- \
  join_group \
  --member "$CHARLIE" \
  --group_id 1

# List all members
soroban contract invoke \
  --id $CONTRACT_ID \
  --source alice \
  --network testnet \
  -- \
  list_members \
  --group_id 1
```

**Expected Output:**
```json
["GDYYY...", "GDZZZ...", "GDWWW..."]
```

**Status:** Group is now full (3/3 members)

---

## Part 4: Cycle 1 - Alice Receives Payout

### Step 11: All Members Contribute

```bash
# Alice contributes
echo "Alice contributing..."
soroban contract invoke \
  --id $CONTRACT_ID \
  --source alice \
  --network testnet \
  -- \
  contribute \
  --member "$ALICE" \
  --group_id 1

# Bob contributes
echo "Bob contributing..."
soroban contract invoke \
  --id $CONTRACT_ID \
  --source bob \
  --network testnet \
  -- \
  contribute \
  --member "$BOB" \
  --group_id 1

# Charlie contributes
echo "Charlie contributing..."
soroban contract invoke \
  --id $CONTRACT_ID \
  --source charlie \
  --network testnet \
  -- \
  contribute \
  --member "$CHARLIE" \
  --group_id 1
```

**Expected Output (for each):**
```
Success
```

### Step 12: Check Contribution Status

```bash
# View who has contributed in cycle 1
soroban contract invoke \
  --id $CONTRACT_ID \
  --source alice \
  --network testnet \
  -- \
  get_contribution_status \
  --group_id 1 \
  --cycle_number 1
```

**Expected Output:**
```json
[
  ["GDYYY...", true],
  ["GDZZZ...", true],
  ["GDWWW...", true]
]
```

**All members have contributed!**

### Step 13: Execute Payout to Alice

```bash
# Anyone can execute payout once all contributed
soroban contract invoke \
  --id $CONTRACT_ID \
  --source alice \
  --network testnet \
  -- \
  execute_payout \
  --group_id 1
```

**Expected Output:**
```
Success - Payout executed
```

**What Happened:**
- Contract verified all 3 members contributed
- Calculated payout: 100 XLM × 3 = 300 XLM
- Transferred 300 XLM to Alice (member at index 0)
- Advanced to cycle 2
- Updated payout_index to 1 (Bob next)

### Step 14: Verify Cycle Advanced

```bash
# Check group state
soroban contract invoke \
  --id $CONTRACT_ID \
  --source alice \
  --network testnet \
  -- \
  get_group \
  --group_id 1 | grep -E "(current_cycle|payout_index|is_complete)"
```

**Expected Output:**
```
"current_cycle": 2,
"payout_index": 1,
"is_complete": false
```

**Cycle 1 Complete:**
- ✅ All contributed
- ✅ Alice received payout
- ✅ Now in Cycle 2
- ✅ Bob will receive next payout

---

## Part 5: Cycle 2 - Bob Receives Payout

### Step 15: Contributions for Cycle 2

```bash
# All contribute again (same process)
soroban contract invoke --id $CONTRACT_ID --source alice --network testnet -- contribute --member "$ALICE" --group_id 1
soroban contract invoke --id $CONTRACT_ID --source bob --network testnet -- contribute --member "$BOB" --group_id 1
soroban contract invoke --id $CONTRACT_ID --source charlie --network testnet -- contribute --member "$CHARLIE" --group_id 1

# Execute payout to Bob
soroban contract invoke --id $CONTRACT_ID --source bob --network testnet -- execute_payout --group_id 1

echo "Cycle 2 complete - Bob received payout"
```

**Status:**
- Cycle 2 complete
- Bob received 300 XLM
- Now in Cycle 3
- Charlie will receive next payout

---

## Part 6: Cycle 3 - Charlie Receives Payout & Completion

### Step 16: Final Contributions

```bash
# Final cycle contributions
soroban contract invoke --id $CONTRACT_ID --source alice --network testnet -- contribute --member "$ALICE" --group_id 1
soroban contract invoke --id $CONTRACT_ID --source bob --network testnet -- contribute --member "$BOB" --group_id 1
soroban contract invoke --id $CONTRACT_ID --source charlie --network testnet -- contribute --member "$CHARLIE" --group_id 1

# Execute final payout
soroban contract invoke --id $CONTRACT_ID --source charlie --network testnet -- execute_payout --group_id 1

echo "Cycle 3 complete - Charlie received payout"
```

### Step 17: Verify Group Completion

```bash
# Check if group is complete
soroban contract invoke \
  --id $CONTRACT_ID \
  --source alice \
  --network testnet \
  -- \
  is_complete \
  --group_id 1
```

**Expected Output:**
```
true
```

**Group Complete! 🎉**

### Step 18: Final Group State

```bash
# View final group state
soroban contract invoke \
  --id $CONTRACT_ID \
  --source alice \
  --network testnet \
  -- \
  get_group \
  --group_id 1
```

**Expected Output:**
```json
{
  "id": 1,
  "creator": "GDYYY...",
  "contribution_amount": "1000000000",
  "cycle_duration": 604800,
  "max_members": 3,
  "members": ["GDYYY...", "GDZZZ...", "GDWWW..."],
  "current_cycle": 3,
  "payout_index": 3,
  "created_at": 1234567890,
  "cycle_start_time": 1234567890,
  "is_complete": true
}
```

**Final State:**
- `current_cycle`: 3 (stayed at 3)
- `payout_index`: 3 (all members paid)
- `is_complete`: **true**

---

## Part 7: Verification & Error Testing

### Step 19: Try to Contribute to Completed Group

```bash
# This should fail
soroban contract invoke \
  --id $CONTRACT_ID \
  --source alice \
  --network testnet \
  -- \
  contribute \
  --member "$ALICE" \
  --group_id 1
```

**Expected Output:**
```
Error: GroupComplete
```

**Perfect!** Contract correctly rejects contributions to completed group.

### Step 20: Test Other Error Cases

```bash
# Try double contribution (create new group first)
# Create group 2
GROUP2=$(soroban contract invoke --id $CONTRACT_ID --source alice --network testnet -- create_group --creator "$ALICE" --contribution_amount 1000000000 --cycle_duration 604800 --max_members 3)

# Alice contributes
soroban contract invoke --id $CONTRACT_ID --source alice --network testnet -- contribute --member "$ALICE" --group_id 2

# Try to contribute again (should fail)
soroban contract invoke --id $CONTRACT_ID --source alice --network testnet -- contribute --member "$ALICE" --group_id 2
```

**Expected Output:**
```
Error: AlreadyContributed
```

**Excellent!** Contract prevents double contributions.

---

## Part 8: Summary & Cleanup

### Demo Summary

**What We Demonstrated:**
1. ✅ Built Soroban smart contract from source
2. ✅ Ran comprehensive test suite
3. ✅ Deployed to Stellar testnet
4. ✅ Created 3-member Ajo group
5. ✅ Completed full 3-cycle lifecycle
6. ✅ Verified automatic payouts
7. ✅ Tested error handling
8. ✅ Confirmed group completion

**Total Contributions:** 9 contributions (3 members × 3 cycles)  
**Total Payouts:** 3 payouts (100 XLM × 3 members = 300 XLM each)  
**Final Status:** All members received equal payout, group complete

### Key Takeaways

**For Users:**
- Simple commands for all operations
- Transparent on-chain tracking
- Automatic payout when conditions met
- Clear error messages

**For Developers:**
- Clean contract API
- Comprehensive testing
- Production-ready code
- Easy deployment

### Cleanup (Optional)

```bash
# Remove test keys (if desired)
rm -rf ~/.config/soroban/identity/*

# Keep contract-id.txt for future demos
echo "Contract ID saved in contract-id.txt"
cat contract-id.txt
```

---

## Troubleshooting

### Common Issues

**Issue: Command not found: soroban**
```bash
# Ensure Soroban CLI is in PATH
export PATH="$HOME/.cargo/bin:$PATH"
source ~/.bashrc  # or ~/.zshrc
```

**Issue: Account not found**
```bash
# Fund account via Friendbot
curl "https://friendbot.stellar.org?addr=YOUR_ADDRESS"
```

**Issue: Contract deployment fails**
```bash
# Verify you're on testnet
soroban network ls
# Ensure account has XLM
# Try deploying again
```

**Issue: Transaction fails**
```bash
# Check account balance
soroban keys show IDENTITY_NAME
# Add --verbose flag for details
soroban contract invoke ... --verbose
```

---

## Next Steps

### For Testers
1. Try creating your own group
2. Invite friends to join
3. Complete multiple cycles
4. Report bugs or feedback

### For Developers
1. Review contract code in `contracts/ajo/src/`
2. Read architecture documentation
3. Contribute improvements
4. Build integrations

### For Community
1. Share this demo
2. Organize testing groups
3. Provide feedback
4. Spread the word!

---

## Resources

- **Repository:** https://github.com/yourusername/soroban-ajo
- **Documentation:** [docs/](../docs/)
- **Stellar Docs:** https://developers.stellar.org
- **Soroban Docs:** https://soroban.stellar.org
- **Support:** Discord/Telegram (links in README)

---

**Demo Complete! 🎉**

You've successfully demonstrated a complete Ajo group lifecycle on Stellar using Soroban smart contracts.

*Questions? Issues? Feedback? Open a GitHub issue or join our community channels.*
