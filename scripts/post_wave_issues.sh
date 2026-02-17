#!/bin/bash
# Script to help post Wave-ready issues to GitHub
# This creates the GitHub CLI commands needed to post all 12 issues

set -e

REPO="Christopherdominic/soroban-ajo"

echo "🌊 Wave Issue Posting Script"
echo "=============================="
echo ""
echo "This script will generate GitHub CLI commands to post all 12 Wave-ready issues."
echo "Prerequisites:"
echo "  - Install GitHub CLI: https://cli.github.com/"
echo "  - Authenticate: gh auth login"
echo ""
echo "Press Enter to generate commands..."
read

cat << 'EOF'

# Issue #1: Add Input Validation Error Messages (Trivial - 100 points)
gh issue create \
  --repo ${REPO} \
  --title "Add Input Validation Error Messages" \
  --label "wave-ready,good first issue,help wanted,trivial" \
  --body "## Description
Enhance error messages in the Ajo contract to provide more descriptive feedback when input validation fails.

## Current Behavior
Error messages like \`Error::InvalidContribution\` don't explain what went wrong.

## Expected Behavior
Error messages should clearly state: minimum value, maximum members exceeded, invalid cycle duration, etc.

## Acceptance Criteria
- [ ] Update error enum with descriptive variants
- [ ] Add validation helper with clear messages
- [ ] Update all validation points to use new errors
- [ ] Add tests verifying error messages

## Files to Modify
- \`contracts/ajo/src/errors.rs\` - Add descriptive error variants
- \`contracts/ajo/src/contract.rs\` - Update validation logic
- \`contracts/ajo/tests/\` - Add error message tests

## Suggested Approach
1. Review current error enum
2. Create descriptive error variants (e.g., \`ContributionBelowMinimum\`)
3. Update validation logic
4. Test each error case

## Testing Requirements
- Unit tests for each validation case
- Verify error messages match expected output

## Estimated Time
2-3 hours

## Wave Points
100 points

## Resources
- [Error Handling Best Practices](https://doc.rust-lang.org/book/ch09-00-error-handling.html)
- [Soroban Error Documentation](https://soroban.stellar.org/docs/learn/errors)"

# Issue #2: Create Unit Test for Edge Cases (Trivial - 100 points)
gh issue create \
  --repo ${REPO} \
  --title "Create Unit Test for Edge Cases" \
  --label "wave-ready,good first issue,help wanted,trivial" \
  --body "## Description
Add comprehensive unit tests for edge cases in contribution and payout logic.

## Current State
Basic tests exist but don't cover all edge cases (zero contributions, single member groups, etc.).

## Required Tests
- Zero contribution attempts
- Single-member groups
- Contributions after group completion
- Duplicate member joining
- Payout with incomplete contributions

## Acceptance Criteria
- [ ] At least 5 new edge case tests
- [ ] Tests use Soroban test framework
- [ ] All tests pass
- [ ] Code coverage maintained above 80%

## Files to Modify
- \`contracts/ajo/tests/edge_cases.rs\` (new file)
- \`contracts/ajo/tests/mod.rs\` - Add edge_cases module

## Suggested Approach
1. Review existing test structure
2. Identify uncovered edge cases
3. Write tests using \`#[test]\` macro
4. Run with \`cargo test\`

## Testing Requirements
- All new tests must pass
- Use \`assert_eq!\` for clear comparisons
- Document test purpose with comments

## Estimated Time
2-4 hours

## Wave Points
100 points

## Resources
- [Soroban Testing Guide](https://soroban.stellar.org/docs/learn/testing)
- [Rust Testing Documentation](https://doc.rust-lang.org/book/ch11-01-writing-tests.html)"

# Issue #3: Add Code Comments to Core Functions (Trivial - 100 points)
gh issue create \
  --repo ${REPO} \
  --title "Add Code Comments to Core Functions" \
  --label "wave-ready,good first issue,help wanted,trivial,documentation" \
  --body "## Description
Improve code documentation by adding detailed comments to all core contract functions.

## Current State
Core functions lack inline documentation explaining logic, parameters, and return values.

## Required Documentation
- Function-level doc comments (///)
- Parameter explanations
- Return value descriptions
- Example usage where helpful
- Complex logic inline comments

## Acceptance Criteria
- [ ] All public functions have /// doc comments
- [ ] Complex logic has inline explanations
- [ ] Examples provided for key functions
- [ ] Documentation follows Rust conventions

## Files to Modify
- \`contracts/ajo/src/contract.rs\` - Main contract functions
- \`contracts/ajo/src/storage.rs\` - Storage helpers
- \`contracts/ajo/src/utils.rs\` - Utility functions

## Suggested Approach
1. Review Rust documentation guidelines
2. Add /// comments above each function
3. Explain parameters with \`# Arguments\`
4. Add \`# Returns\` and \`# Errors\` sections
5. Include usage examples where helpful

## Testing Requirements
- Run \`cargo doc\` to verify documentation builds
- Check generated docs for clarity

## Estimated Time
3-4 hours

## Wave Points
100 points

## Resources
- [Rust Documentation Guidelines](https://doc.rust-lang.org/rustdoc/how-to-write-documentation.html)
- [Soroban Documentation Examples](https://soroban.stellar.org/docs)"

# Issue #4: Update README with Deployment Instructions (Trivial - 100 points)
gh issue create \
  --repo ${REPO} \
  --title "Update README with Deployment Instructions" \
  --label "wave-ready,good first issue,help wanted,trivial,documentation" \
  --body "## Description
Enhance README.md with detailed deployment instructions for testnet and mainnet.

## Current State
README has basic quick start but lacks step-by-step deployment guide.

## Required Additions
1. Prerequisites section (Rust, Stellar CLI, wallet setup)
2. Testnet deployment walkthrough
3. Contract configuration examples
4. Mainnet deployment checklist
5. Troubleshooting common issues

## Acceptance Criteria
- [ ] Step-by-step testnet deployment guide
- [ ] Mainnet deployment section
- [ ] Example commands with sample output
- [ ] Prerequisites clearly listed
- [ ] Troubleshooting section

## Files to Modify
- \`README.md\` - Add deployment section after Quick Start

## Suggested Approach
1. Review existing README structure
2. Follow deployment script (\`scripts/deploy_testnet.sh\`)
3. Document each step with explanations
4. Add example commands and expected output
5. Include wallet setup instructions

## Testing Requirements
- Follow instructions to deploy to testnet
- Verify all commands work as documented

## Estimated Time
2-3 hours

## Wave Points
100 points

## Resources
- [demo/demo-script.md](demo/demo-script.md) - Existing deployment walkthrough
- [Stellar CLI Documentation](https://developers.stellar.org/docs/tools/cli)"

# Issue #5: Create Helper Function for Group Status (Medium - 150 points)
gh issue create \
  --repo ${REPO} \
  --title "Create Helper Function for Group Status" \
  --label "wave-ready,help wanted,medium" \
  --body "## Description
Create a helper function to compute and return comprehensive group status information.

## Current State
Group status requires multiple storage reads and manual computation.

## Required Functionality
Return a struct containing:
- Current cycle number
- Next recipient address
- Contributions collected this cycle
- Members remaining to contribute
- Group completion status
- Time until cycle deadline

## Acceptance Criteria
- [ ] New \`get_group_status\` function
- [ ] Returns comprehensive GroupStatus struct
- [ ] Efficient (minimal storage reads)
- [ ] Unit tests for all status scenarios
- [ ] Integration test with active group

## Files to Modify
- \`contracts/ajo/src/contract.rs\` - Add public function
- \`contracts/ajo/src/types.rs\` - Define GroupStatus struct
- \`contracts/ajo/src/utils.rs\` - Helper logic
- \`contracts/ajo/tests/\` - Add status query tests

## Suggested Approach
1. Define GroupStatus struct in types.rs
2. Create helper to compute current cycle
3. Add logic to determine next recipient
4. Count pending contributions
5. Implement get_group_status function
6. Write comprehensive tests

## Testing Requirements
- Test with group in various states
- Verify all status fields are accurate
- Test edge cases (completed groups, new groups)

## Estimated Time
4-6 hours

## Wave Points
150 points

## Resources
- [Soroban Storage Patterns](https://soroban.stellar.org/docs/learn/storage)
- [docs/architecture.md](docs/architecture.md)"

# Issue #6: Add Validation for Contribution Timing (Medium - 150 points)
gh issue create \
  --repo ${REPO} \
  --title "Add Validation for Contribution Timing" \
  --label "wave-ready,help wanted,medium" \
  --body "## Description
Implement validation to ensure contributions happen within the correct cycle window.

## Current Behavior
Contract accepts contributions without validating cycle timing.

## Expected Behavior
- Reject contributions outside current cycle window
- Enforce cycle duration (e.g., weekly, monthly)
- Prevent duplicate contributions in same cycle
- Clear error messages for timing violations

## Acceptance Criteria
- [ ] Cycle timing validation logic
- [ ] Error returned for early contributions
- [ ] Error returned for late contributions
- [ ] Duplicate contribution prevention
- [ ] Unit tests for all timing scenarios

## Files to Modify
- \`contracts/ajo/src/contract.rs\` - Add timing validation to contribute()
- \`contracts/ajo/src/utils.rs\` - Cycle timing helpers
- \`contracts/ajo/src/errors.rs\` - Add timing-related errors
- \`contracts/ajo/tests/\` - Timing validation tests

## Suggested Approach
1. Define cycle start/end calculation logic
2. Add helper: \`is_contribution_window_open()\`
3. Check timing in \`contribute()\` function
4. Add duplicate contribution check
5. Return descriptive errors
6. Write comprehensive timing tests

## Testing Requirements
- Test contributions before cycle starts
- Test contributions after cycle ends
- Test duplicate contributions
- Verify error messages are clear

## Estimated Time
5-7 hours

## Wave Points
150 points

## Resources
- [Soroban Time & Ledgers](https://soroban.stellar.org/docs/learn/ledger-data)
- [docs/storage-layout.md](docs/storage-layout.md)"

# Issue #7: Implement Group Cancellation Feature (Medium - 150 points)
gh issue create \
  --repo ${REPO} \
  --title \"Implement Group Cancellation Feature\" \
  --label "wave-ready,help wanted,medium" \
  --body "## Description
Add ability for group creator to cancel a group before it completes, with fund refunds.

## Current State
No mechanism to cancel a group once created.

## Required Functionality
- Only creator can cancel group
- Can only cancel before all cycles complete
- Refund all contributions to members
- Emit GroupCancelled event
- Clear all group storage

## Acceptance Criteria
- [ ] New \`cancel_group()\` function
- [ ] Authorization: only creator
- [ ] Refund logic for all contributions
- [ ] GroupCancelled event emission
- [ ] Storage cleanup
- [ ] Comprehensive tests

## Files to Modify
- \`contracts/ajo/src/contract.rs\` - Add cancel_group() function
- \`contracts/ajo/src/events.rs\` - Add GroupCancelled event
- \`contracts/ajo/src/errors.rs\` - Add cancellation errors
- \`contracts/ajo/tests/\` - Cancellation tests

## Suggested Approach
1. Add cancel_group() function with creator auth
2. Iterate through members and refund
3. Emit cancellation event
4. Clear group storage
5. Test cancellation at various stages

## Testing Requirements
- Test cancellation by creator
- Test unauthorized cancellation attempts
- Verify refunds sent correctly
- Test storage cleanup

## Estimated Time
6-8 hours

## Wave Points
150 points

## Resources
- [Soroban Authorization](https://soroban.stellar.org/docs/learn/authorization)
- [docs/architecture.md](docs/architecture.md)"

# Issue #8: Add Event Emission for All State Changes (Medium - 150 points)
gh issue create \
  --repo ${REPO} \
  --title "Add Event Emission for All State Changes" \
  --label "wave-ready,help wanted,medium" \
  --body "## Description
Ensure all contract state changes emit corresponding events for transparency.

## Current State
Some operations lack event emission.

## Required Events
- GroupCreated
- MemberJoined
- ContributionMade
- PayoutExecuted
- GroupCompleted
- GroupCancelled (if implemented)

## Acceptance Criteria
- [ ] All state changes emit events
- [ ] Events include relevant data (group_id, member, amount)
- [ ] Events use Soroban event system
- [ ] Unit tests verify event emission
- [ ] Documentation of event structure

## Files to Modify
- \`contracts/ajo/src/events.rs\` - Define all event types
- \`contracts/ajo/src/contract.rs\` - Emit events on state changes
- \`contracts/ajo/tests/\` - Event emission tests

## Suggested Approach
1. Define event structs in events.rs
2. Add event emission to all state-changing functions
3. Use \`env.events().publish()\`
4. Document event schemas
5. Test event data is correct

## Testing Requirements
- Verify each operation emits correct event
- Check event data matches operation
- Test event topics are properly indexed

## Estimated Time
5-6 hours

## Wave Points
150 points

## Resources
- [Soroban Events](https://soroban.stellar.org/docs/learn/events)
- [docs/architecture.md](docs/architecture.md)"

# Issue #9: Create Integration Test Suite (Medium - 150 points)
gh issue create \
  --repo ${REPO} \
  --title "Create Integration Test Suite" \
  --label "wave-ready,help wanted,medium,testing" \
  --body "## Description
Build comprehensive integration tests covering full group lifecycle scenarios.

## Current State
Unit tests exist but lack end-to-end integration tests.

## Required Test Scenarios
1. Complete group lifecycle (create → join → contribute → payout → complete)
2. Multiple concurrent groups
3. Group with different cycle configurations
4. Error handling across operations
5. Event sequence verification

## Acceptance Criteria
- [ ] At least 5 integration test scenarios
- [ ] Tests cover full lifecycle
- [ ] Multi-group scenarios tested
- [ ] All tests pass
- [ ] Documentation of test scenarios

## Files to Modify
- \`contracts/ajo/tests/integration_tests.rs\` (new file)
- \`contracts/ajo/tests/mod.rs\` - Add integration module

## Suggested Approach
1. Set up test environment with Soroban test framework
2. Create helper functions for common operations
3. Write end-to-end test scenarios
4. Verify state at each step
5. Test error conditions

## Testing Requirements
- All integration tests must pass
- Tests should be self-contained
- Clear assertions at each step

## Estimated Time
6-8 hours

## Wave Points
150 points

## Resources
- [Soroban Testing Guide](https://soroban.stellar.org/docs/learn/testing)
- [demo/demo-script.md](demo/demo-script.md) - Manual testing scenarios"

# Issue #10: Implement Group Metadata Storage (High - 200 points)
gh issue create \
  --repo ${REPO} \
  --title "Implement Group Metadata Storage" \
  --label "wave-ready,help wanted,high" \
  --body "## Description
Add ability to store and retrieve optional group metadata (name, description, rules).

## Current State
Groups only store operational data (amount, cycle, members).

## Required Functionality
- Optional group name (max 50 chars)
- Optional description (max 200 chars)
- Optional custom rules text (max 500 chars)
- Query function to retrieve metadata
- Update function (creator only)

## Acceptance Criteria
- [ ] GroupMetadata struct defined
- [ ] Storage implementation for metadata
- [ ] set_group_metadata() function
- [ ] get_group_metadata() function
- [ ] Authorization for updates
- [ ] Comprehensive tests

## Files to Modify
- \`contracts/ajo/src/types.rs\` - Define GroupMetadata struct
- \`contracts/ajo/src/storage.rs\` - Metadata storage functions
- \`contracts/ajo/src/contract.rs\` - Add metadata functions
- \`contracts/ajo/tests/\` - Metadata tests

## Suggested Approach
1. Design GroupMetadata struct with size limits
2. Add persistent storage for metadata
3. Implement set_group_metadata() with auth
4. Implement get_group_metadata() query
5. Add validation for string lengths
6. Write comprehensive tests

## Testing Requirements
- Test metadata storage and retrieval
- Test authorization for updates
- Test string length limits
- Verify storage efficiency

## Estimated Time
8-10 hours

## Wave Points
200 points

## Resources
- [Soroban Storage](https://soroban.stellar.org/docs/learn/storage)
- [docs/storage-layout.md](docs/storage-layout.md)"

# Issue #11: Add Emergency Withdrawal Mechanism (High - 200 points)
gh issue create \
  --repo ${REPO} \
  --title "Add Emergency Withdrawal Mechanism" \
  --label "wave-ready,help wanted,high,security" \
  --body "## Description
Implement emergency withdrawal feature for members to exit group under specific conditions.

## Current State
No mechanism for members to exit after joining.

## Required Functionality
- Member can withdraw after N missed cycles
- Withdrawal returns member's contributions minus penalty
- Cannot withdraw if already received payout
- Rebalances remaining group members
- Emits EmergencyWithdrawal event

## Acceptance Criteria
- [ ] emergency_withdraw() function
- [ ] Configurable withdrawal conditions
- [ ] Refund calculation with penalty
- [ ] Group rebalancing logic
- [ ] Authorization checks
- [ ] Event emission
- [ ] Comprehensive security tests

## Files to Modify
- \`contracts/ajo/src/contract.rs\` - Add emergency_withdraw()
- \`contracts/ajo/src/utils.rs\` - Withdrawal logic
- \`contracts/ajo/src/events.rs\` - EmergencyWithdrawal event
- \`contracts/ajo/src/errors.rs\` - Withdrawal errors
- \`contracts/ajo/tests/\` - Withdrawal tests

## Suggested Approach
1. Define withdrawal eligibility conditions
2. Calculate refund amount (contributions - penalty)
3. Implement member removal logic
4. Rebalance group if needed
5. Add security checks
6. Emit events
7. Write extensive tests

## Testing Requirements
- Test withdrawal eligibility
- Test refund calculations
- Test unauthorized withdrawal attempts
- Test group rebalancing
- Security audit recommended

## Estimated Time
10-12 hours

## Wave Points
200 points

## Resources
- [Soroban Authorization](https://soroban.stellar.org/docs/learn/authorization)
- [docs/threat-model.md](docs/threat-model.md)"

# Issue #12: Design Frontend Architecture (High - 200 points)
gh issue create \
  --repo ${REPO} \
  --title "Design Frontend Architecture" \
  --label "wave-ready,help wanted,high,frontend" \
  --body "## Description
Design comprehensive frontend architecture for Soroban Ajo web interface.

## Current State
No frontend exists. Need complete architecture design.

## Required Deliverables
1. **Technology Stack Decision**
   - Framework (React/Next.js/Svelte)
   - Stellar wallet integration
   - State management approach
   - Styling solution

2. **Architecture Document**
   - Component hierarchy
   - State management strategy
   - Contract interaction patterns
   - Wallet connection flow
   - Error handling approach

3. **UI/UX Design**
   - Wireframes for key screens
   - User flow diagrams
   - Responsive design considerations

4. **Implementation Roadmap**
   - Phase 1: Core features
   - Phase 2: Advanced features
   - Phase 3: Polish & optimization

## Acceptance Criteria
- [ ] Complete architecture document
- [ ] Technology stack recommendation with rationale
- [ ] Component structure diagram
- [ ] Wallet integration design
- [ ] Wireframes for 5+ key screens
- [ ] Implementation roadmap

## Files to Create
- \`frontend/ARCHITECTURE.md\` - Complete architecture doc
- \`frontend/TECH_STACK.md\` - Technology decisions
- \`frontend/ROADMAP.md\` - Implementation phases
- \`frontend/wireframes/\` - UI wireframes (can be images/links)

## Suggested Approach
1. Research Stellar wallet integration options
2. Evaluate frontend frameworks
3. Design component hierarchy
4. Create wireframes for key screens
5. Document contract interaction patterns
6. Write implementation roadmap

## Testing Requirements
- Architecture review by maintainers
- Peer review of technology choices
- Validation against contract API

## Estimated Time
12-15 hours

## Wave Points
200 points

## Resources
- [Freighter Wallet Docs](https://docs.freighter.app/)
- [Stellar SDK](https://developers.stellar.org/docs/tools/sdks)
- [frontend/README.md](frontend/README.md) - Initial planning"

EOF

echo ""
echo "✅ Commands generated!"
echo ""
echo "To post all issues, copy the commands above and run them in your terminal."
echo "Make sure you've set the REPO variable to your GitHub repository."
echo ""
echo "Or run this script with: bash post_wave_issues.sh | bash"
echo ""
