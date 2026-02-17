# Wave-Ready Seed Issues

This document contains 12 ready-to-post GitHub issues for the Drips Wave program. Copy these directly to GitHub Issues and apply the appropriate labels.

---

## Trivial Issues (100 points each)

### Issue #1: Add Input Validation Error Messages

**Labels**: `wave-ready`, `complexity: trivial`, `good first issue`, `enhancement`

**Description**:
Currently, our validation functions return generic errors. We need more descriptive error messages to help users understand what went wrong.

**Acceptance Criteria**:
- [ ] Update error messages in `utils.rs` to be more descriptive
- [ ] Error messages should specify what value was invalid
- [ ] Error messages should suggest valid ranges
- [ ] Update tests to verify new error messages

**Files to Modify**:
- `contracts/ajo/src/utils.rs`
- `contracts/ajo/src/errors.rs` (possibly)
- `contracts/ajo/tests/ajo_flow.rs`

**Suggested Approach**:
```rust
// Current
if contribution_amount <= 0 {
    return Err(AjoError::InvalidAmount);
}

// Improved
if contribution_amount <= 0 {
    panic_with_error!(&env, AjoError::InvalidAmount, 
        "Contribution amount must be positive, got: {}", contribution_amount);
}
```

**Testing Requirements**:
- Add test to verify error message content
- Ensure all existing tests still pass

**Estimated Time**: 1-2 hours  
**Wave Points**: 100

---

### Issue #2: Add Documentation Examples to README

**Labels**: `wave-ready`, `complexity: trivial`, `good first issue`, `documentation`

**Description**:
Our README needs practical code examples showing how to use the contract functions.

**Acceptance Criteria**:
- [ ] Add "Usage Examples" section to README
- [ ] Include example for creating a group
- [ ] Include example for joining and contributing
- [ ] Include example for checking group status
- [ ] Use realistic values in examples

**Files to Modify**:
- `README.md`

**Suggested Approach**:
Add a section after "Quick Start" with shell script examples using `stellar contract invoke`.

**Example**:
```bash
# Create a group
stellar contract invoke \
  --id $CONTRACT_ID \
  --source alice \
  -- \
  create_group \
  --creator alice \
  --contribution_amount 10000000 \
  --cycle_duration 604800 \
  --max_members 5
```

**Estimated Time**: 1 hour  
**Wave Points**: 100

---

### Issue #3: Add Event Emission Tests

**Labels**: `wave-ready`, `complexity: trivial`, `testing`

**Description**:
We emit events for major contract operations, but we don't have tests verifying that events are emitted correctly.

**Acceptance Criteria**:
- [ ] Add test verifying `group_created` event
- [ ] Add test verifying `member_joined` event  
- [ ] Add test verifying `contribution_made` event
- [ ] Add test verifying `payout_executed` event
- [ ] Verify event data is correct

**Files to Modify**:
- `contracts/ajo/tests/ajo_flow.rs`

**Suggested Approach**:
Use Soroban's testutils to capture and verify events:
```rust
let events = env.events().all();
assert_eq!(events.len(), 1);
// Verify event topics and data
```

**Resources**:
- [Soroban Events Documentation](https://soroban.stellar.org/docs/events)

**Estimated Time**: 2 hours  
**Wave Points**: 100

---

### Issue #4: Improve Error Documentation

**Labels**: `wave-ready`, `complexity: trivial`, `good first issue`, `documentation`

**Description**:
The `errors.rs` file lists error codes but doesn't explain when each error occurs or how to fix it.

**Acceptance Criteria**:
- [ ] Add comprehensive doc comments to each error variant
- [ ] Explain when the error occurs
- [ ] Suggest how to fix/avoid the error
- [ ] Include example scenarios

**Files to Modify**:
- `contracts/ajo/src/errors.rs`

**Example**:
```rust
/// Member has already contributed for this cycle
///
/// This error occurs when a member tries to contribute twice in the same cycle.
/// Each member can only contribute once per cycle.
///
/// **Example scenario**: Alice contributes in cycle 1, then tries to contribute
/// again in cycle 1 before the payout executes.
///
/// **How to fix**: Wait for the cycle to advance before contributing again.
AlreadyContributed = 5,
```

**Estimated Time**: 1 hour  
**Wave Points**: 100

---

## Medium Issues (150 points each)

### Issue #5: Add Helper Function for Group Status Summary

**Labels**: `wave-ready`, `complexity: medium`, `enhancement`

**Description**:
Users need an easy way to get a complete status summary of a group (contributions, next payout, etc.). Currently, they need to make multiple function calls.

**Acceptance Criteria**:
- [ ] Create `get_group_summary()` function
- [ ] Returns group info + current cycle status
- [ ] Include: pending contributions, next recipient, completion status
- [ ] Add comprehensive tests
- [ ] Update documentation

**Files to Modify**:
- `contracts/ajo/src/contract.rs`
- `contracts/ajo/src/types.rs` (add summary struct)
- `contracts/ajo/tests/ajo_flow.rs`
- `README.md`

**Suggested Approach**:
```rust
#[contracttype]
pub struct GroupSummary {
    pub group: Group,
    pub pending_contributions: u32,
    pub next_recipient: Address,
    pub can_execute_payout: bool,
}

pub fn get_group_summary(env: Env, group_id: u64) -> Result<GroupSummary, AjoError>
```

**Testing Requirements**:
- Test at various cycle stages
- Test edge cases (empty group, completed group)

**Estimated Time**: 4-5 hours  
**Wave Points**: 150

---

### Issue #6: Implement Group Member List Pagination

**Labels**: `wave-ready`, `complexity: medium`, `enhancement`

**Description**:
For large groups, returning all members in one call is inefficient. Implement pagination support.

**Acceptance Criteria**:
- [ ] Add `list_members_paginated()` function
- [ ] Accept `start_index` and `limit` parameters
- [ ] Return members slice and total count
- [ ] Maintain backward compatibility with `list_members()`
- [ ] Add tests for pagination logic
- [ ] Handle edge cases (out of bounds, empty groups)

**Files to Modify**:
- `contracts/ajo/src/contract.rs`
- `contracts/ajo/tests/ajo_flow.rs`

**Suggested Approach**:
```rust
pub fn list_members_paginated(
    env: Env,
    group_id: u64,
    start_index: u32,
    limit: u32,
) -> Result<(Vec<Address>, u32), AjoError> {
    // Return (members_slice, total_count)
}
```

**Testing Requirements**:
- Test with various page sizes
- Test boundary conditions
- Test empty results

**Estimated Time**: 5 hours  
**Wave Points**: 150

---

### Issue #7: Add Storage Key Constants

**Labels**: `wave-ready`, `complexity: medium`, `refactoring`

**Description**:
Storage keys are currently defined inline with string literals. Extract them to constants for better maintainability and to prevent typos.

**Acceptance Criteria**:
- [ ] Create constants module or section in `storage.rs`
- [ ] Define all storage key symbols as constants
- [ ] Replace all inline symbol definitions with constants
- [ ] Ensure all tests pass
- [ ] Add documentation explaining key structure

**Files to Modify**:
- `contracts/ajo/src/storage.rs`
- Any files using storage directly

**Suggested Approach**:
```rust
pub mod keys {
    use soroban_sdk::{symbol_short, Symbol};
    
    pub const GROUP_COUNTER: Symbol = symbol_short!("GCOUNTER");
    pub const GROUP: Symbol = symbol_short!("GROUP");
    // ... more constants
}
```

**Testing Requirements**:
- All existing tests must pass
- Verify no regression in functionality

**Estimated Time**: 3-4 hours  
**Wave Points**: 150

---

### Issue #8: Improve Test Helper Functions

**Labels**: `wave-ready`, `complexity: medium`, `testing`

**Description**:
Our tests have repeated setup code. Extract common patterns into helper functions for DRYer tests.

**Acceptance Criteria**:
- [ ] Create `test_helpers.rs` module
- [ ] Add helper for creating and fully setting up a group
- [ ] Add helper for advancing through a complete cycle
- [ ] Add helper for creating test addresses with names
- [ ] Refactor at least 3 existing tests to use helpers
- [ ] All tests pass

**Files to Modify**:
- `contracts/ajo/tests/test_helpers.rs` (new file)
- `contracts/ajo/tests/mod.rs`
- `contracts/ajo/tests/ajo_flow.rs`

**Suggested Approach**:
```rust
pub fn create_test_group(
    client: &AjoContractClient,
    creator: &Address,
    num_members: u32,
) -> u64 {
    // Create group, join members, return group_id
}

pub fn complete_cycle(
    client: &AjoContractClient,
    group_id: u64,
    members: &[Address],
) {
    // All members contribute, execute payout
}
```

**Estimated Time**: 5-6 hours  
**Wave Points**: 150

---

### Issue #9: Add Logging/Event for Errors

**Labels**: `wave-ready`, `complexity: medium`, `enhancement`

**Description**:
When errors occur, we should emit events to help with debugging and monitoring. This is especially important for mainnet deployment.

**Acceptance Criteria**:
- [ ] Emit events for all error conditions
- [ ] Include error code and context
- [ ] Don't expose sensitive information
- [ ] Add tests verifying error events
- [ ] Update documentation

**Files to Modify**:
- `contracts/ajo/src/events.rs`
- `contracts/ajo/src/contract.rs`
- `contracts/ajo/tests/ajo_flow.rs`

**Suggested Approach**:
```rust
pub fn emit_error(env: &Env, error_code: u32, context: &str) {
    let topics = (symbol_short!("error"), error_code);
    env.events().publish(topics, context);
}
```

**Testing Requirements**:
- Verify events emitted for each error type
- Ensure no sensitive data in events

**Estimated Time**: 4-5 hours  
**Wave Points**: 150

---

## High Complexity Issues (200 points each)

### Issue #10: Implement Group Metadata Storage

**Labels**: `wave-ready`, `complexity: high`, `enhancement`

**Description**:
Add ability for group creators to store metadata like group name, description, and purpose. This makes groups more discoverable and understandable.

**Acceptance Criteria**:
- [ ] Add `GroupMetadata` type with name, description, tags
- [ ] Add `set_group_metadata()` function (creator only)
- [ ] Add `get_group_metadata()` function
- [ ] Store metadata separately to keep Group struct lean
- [ ] Add validation (length limits, etc.)
- [ ] Comprehensive tests
- [ ] Update documentation

**Files to Modify**:
- `contracts/ajo/src/types.rs`
- `contracts/ajo/src/contract.rs`
- `contracts/ajo/src/storage.rs`
- `contracts/ajo/tests/ajo_flow.rs`
- `README.md`

**Suggested Approach**:
```rust
#[contracttype]
pub struct GroupMetadata {
    pub name: String,        // max 50 chars
    pub description: String, // max 200 chars
    pub tags: Vec<String>,   // max 5 tags
}

pub fn set_group_metadata(
    env: Env,
    group_id: u64,
    metadata: GroupMetadata,
) -> Result<(), AjoError>
```

**Testing Requirements**:
- Test authorization (only creator)
- Test validation (length limits)
- Test retrieval
- Test update scenarios

**Estimated Time**: 8-10 hours  
**Wave Points**: 200

---

### Issue #11: Add Comprehensive Integration Test Suite

**Labels**: `wave-ready`, `complexity: high`, `testing`

**Description**:
Create a comprehensive integration test that simulates realistic usage scenarios across multiple groups and lifecycles.

**Acceptance Criteria**:
- [ ] Create `integration_tests.rs` file
- [ ] Test scenario: 3 groups running concurrently
- [ ] Test scenario: Member participates in multiple groups
- [ ] Test scenario: Group completion while others active
- [ ] Test error handling in realistic scenarios
- [ ] Test performance with larger groups (20+ members)
- [ ] Documentation of test scenarios

**Files to Modify**:
- `contracts/ajo/tests/integration_tests.rs` (new)
- `contracts/ajo/tests/mod.rs`

**Test Scenarios**:
1. **Multi-Group Participant**: User joins 3 groups, contributes to all, receives payouts
2. **Sequential Groups**: Complete one group, immediately start another
3. **Concurrent Execution**: Multiple groups execute payouts simultaneously
4. **Error Recovery**: Handle failures gracefully
5. **Large Group**: Test with 20-50 members

**Testing Requirements**:
- All scenarios pass
- Performance benchmarks documented
- Edge cases covered

**Estimated Time**: 10-12 hours  
**Wave Points**: 200

---

### Issue #12: Implement Contribution History Query

**Labels**: `wave-ready`, `complexity: high`, `enhancement`

**Description**:
Add ability to query a member's complete contribution history across all groups and cycles. This is important for reputation and audit trails.

**Acceptance Criteria**:
- [ ] Add `get_member_history()` function
- [ ] Returns all groups member has participated in
- [ ] Include contribution status for each cycle
- [ ] Include payout received status
- [ ] Implement efficient storage/retrieval
- [ ] Handle pagination for members in many groups
- [ ] Comprehensive tests
- [ ] Performance considerations documented

**Files to Modify**:
- `contracts/ajo/src/contract.rs`
- `contracts/ajo/src/storage.rs`
- `contracts/ajo/src/types.rs`
- `contracts/ajo/tests/ajo_flow.rs`
- `docs/storage-layout.md`

**Suggested Approach**:
```rust
#[contracttype]
pub struct MemberHistory {
    pub groups_participated: Vec<u64>,
    pub total_contributions: u32,
    pub total_payouts_received: u32,
    pub active_groups: Vec<u64>,
}

pub fn get_member_history(
    env: Env,
    member: Address,
) -> Result<MemberHistory, AjoError>
```

**Challenges**:
- Efficient storage (store member→group mappings)
- Scaling to many groups
- Gas costs for large histories

**Testing Requirements**:
- Test with 1, 5, 10+ groups
- Test pagination
- Test performance

**Estimated Time**: 12-15 hours  
**Wave Points**: 200

---

## How to Use These Issues

### For Maintainers:

1. Copy issue content to GitHub
2. Apply appropriate labels:
   - `wave-ready`
   - Complexity label (`complexity: trivial|medium|high`)
   - Type label (`enhancement`, `testing`, `documentation`, etc.)
   - `good first issue` (for trivial issues)
   - `status: available`

3. Add Wave points in description:
   ```
   **Wave Points**: 100/150/200
   ```

4. Monitor and assign to contributors who comment

### For Contributors:

1. Find an issue matching your skill level
2. Comment "I'd like to work on this!"
3. Wait for assignment
4. Follow the Contributing Guide
5. Submit high-quality PR

---

## Additional Issue Ideas

Once these 12 are completed, consider:

- **Trivial**: Add inline documentation examples, improve error messages, add more tests
- **Medium**: Refactor modules, add validation utilities, improve CI workflow
- **High**: Add admin pause mechanism, implement optional collateral, add reputation scoring

---

*These seed issues should provide 2-3 months of Wave contributor activity while building valuable features.*

*Last updated: February 2026*
