# Drips Wave Contributor Guide

This guide explains how to participate in Soroban Ajo as a Drips Wave contributor and how maintainers should manage Wave-ready issues.

## 🌊 What is Drips Wave?

Drips Wave is a funding mechanism for open-source contributors. Contributors earn points by completing issues, and points convert to funding rewards.

**Wave Points:**
- Trivial issues: **100 points**
- Medium issues: **150 points**
- High complexity: **200 points**

## 👥 For Contributors

### Getting Started

1. **Find Wave-Ready Issues**
   - Look for `wave-ready` label
   - Check issue complexity level
   - Read full issue description

2. **Claim an Issue**
   - Comment: "I'd like to work on this!"
   - Wait for maintainer to assign (usually <24 hours)
   - Only claim issues you can complete

3. **Work on Your Issue**
   - Fork the repository
   - Create a branch: `git checkout -b wave/issue-number-description`
   - Follow [CONTRIBUTING.md](../CONTRIBUTING.md)
   - Complete all acceptance criteria

4. **Submit Your Work**
   - Create Pull Request
   - Reference the issue: "Fixes #123"
   - Complete the PR checklist
   - Respond to review feedback

5. **Get Points**
   - Once PR is merged, you earn the points!
   - Track your points in Drips Wave dashboard

### Picking the Right Issue

#### Trivial (100 pts) - Good for First-Timers

**Characteristics:**
- Well-defined scope
- 1-2 hours of work
- Clear acceptance criteria
- Minimal risk of breaking things

**Examples:**
- Add missing documentation
- Fix typos in error messages
- Add a simple utility function
- Update README with examples
- Add test for existing function

**Skills needed:**
- Basic Rust knowledge
- Can follow patterns
- Attention to detail

#### Medium (150 pts) - For Intermediate Developers

**Characteristics:**
- Moderate complexity
- 3-6 hours of work
- Some design decisions
- May touch multiple files

**Examples:**
- Implement a new contract function
- Refactor existing code for clarity
- Add comprehensive tests for a module
- Improve error handling
- Optimize gas usage

**Skills needed:**
- Solid Rust experience
- Understanding of smart contracts
- Good testing practices
- Can make design decisions

#### High (200 pts) - For Experienced Developers

**Characteristics:**
- Significant complexity
- 1-2 days of work
- Major feature or refactoring
- Requires architectural understanding

**Examples:**
- Implement timeout mechanism
- Add token support
- Major performance optimization
- Security enhancement
- Complex feature addition

**Skills needed:**
- Expert Rust and Soroban
- Deep contract understanding
- Security awareness
- Can handle ambiguity

### Best Practices

✅ **DO:**
- Read the issue completely before claiming
- Ask questions if anything is unclear
- Follow coding standards
- Write comprehensive tests
- Update documentation
- Respond to code review feedback
- Keep your branch updated

❌ **DON'T:**
- Claim multiple issues at once (unless you finish first)
- Make changes beyond the issue scope
- Submit PRs without testing
- Ignore code review feedback
- Copy code without understanding it

### Getting Help

**Stuck? Here's how to get help:**

1. **Read the docs**
   - [Architecture](../docs/architecture.md)
   - [Storage Layout](../docs/storage-layout.md)
   - [Contributing Guide](../CONTRIBUTING.md)

2. **Check existing code**
   - Look for similar implementations
   - Read tests for examples
   - Follow established patterns

3. **Ask in comments**
   - Ask specific questions on the issue
   - Maintainers respond within 24-48 hours

4. **Join Discord**
   - #wave-contributors channel
   - Get real-time help
   - Connect with other contributors

### Quality Standards

All contributions must meet:

- ✅ **Functionality**: Does what the issue asks
- ✅ **Tests**: Comprehensive test coverage
- ✅ **Code Quality**: Clean, readable, idiomatic Rust
- ✅ **Documentation**: Comments and docs updated
- ✅ **CI Passes**: All automated checks pass

## 🔧 For Maintainers

### Creating Wave-Ready Issues

#### Issue Template

Use the [wave_issue.md template](.github/ISSUE_TEMPLATE/wave_issue.md)

#### Required Elements

1. **Clear Description**
   - What needs to be done
   - Why it's needed
   - Expected outcome

2. **Acceptance Criteria**
   - Specific, testable requirements
   - Definition of done
   - No ambiguity

3. **Technical Details**
   - Files to modify
   - Suggested approach
   - Related code references

4. **Complexity Assessment**
   - Accurate point value
   - Estimated time
   - Required skills

#### Complexity Guidelines

**Trivial (100 pts):**
- Single file changes (usually)
- <50 lines of code
- Clear, repeatable pattern
- Low risk

**Medium (150 pts):**
- 2-3 file changes
- 50-200 lines of code
- Some design thinking needed
- Moderate risk

**High (200 pts):**
- Multiple file changes
- 200+ lines of code
- Significant design decisions
- Higher risk

### Issue Labels

Apply these labels to Wave issues:

**Required:**
- `wave-ready` - Issue ready for Wave contributors

**Complexity:**
- `complexity: trivial` - 100 pts
- `complexity: medium` - 150 pts
- `complexity: high` - 200 pts

**Type:**
- `bug` - Something isn't working
- `enhancement` - New feature or improvement
- `documentation` - Documentation improvements
- `good first issue` - Good for newcomers
- `help wanted` - Extra attention needed

**Status:**
- `status: available` - Open for claiming
- `status: claimed` - Someone is working on it
- `status: in-review` - PR submitted, under review

### Managing Contributors

#### When Issue is Claimed

1. **Assign the issue** to the contributor
2. **Change label** from `status: available` to `status: claimed`
3. **Set expectations**: Mention estimated timeline
4. **Offer support**: "Let me know if you have questions!"

#### During Development

1. **Be responsive**: Answer questions within 24-48 hours
2. **Be encouraging**: Especially for first-timers
3. **Be helpful**: Point to resources, examples
4. **Be patient**: Learning takes time

#### During Code Review

1. **Be thorough**: Check functionality, tests, docs
2. **Be constructive**: Explain *why*, not just *what*
3. **Be specific**: Point to exact lines, suggest fixes
4. **Be appreciative**: Thank them for their contribution

#### Example Review Comments

✅ **Good:**
```
Great work! The logic looks solid. A few suggestions:

1. Line 45: Consider extracting this into a helper function for reusability
2. Can you add a test for the edge case where max_members = 2?
3. The documentation is clear - nice job!

Let me know if you have questions!
```

❌ **Bad:**
```
This doesn't work.
```

### Issue Lifecycle

```
Created → Labeled → Published → Claimed → In Progress → PR Submitted → Reviewed → Merged → Closed
```

**Timeline expectations:**
- **Claimed → PR**: 1 week for trivial, 2 weeks for high
- **PR → Review**: 1-2 days
- **Review → Merge**: 2-3 days (with iterations)

### When Issues Stall

If no progress for:
- **Trivial**: 1 week
- **Medium**: 2 weeks
- **High**: 3 weeks

**Actions:**
1. **Check in**: "Hi! How's it going? Need any help?"
2. **Wait 3-5 days** for response
3. **If no response**: Unassign, make available again
4. **Be kind**: "No worries! Making this available for others."

## 📊 Tracking Wave Impact

### Metrics to Monitor

**Contributor Engagement:**
- Number of contributors
- Repeat contributors
- Time to first contribution
- Contribution retention

**Issue Health:**
- Time to claim
- Time to complete
- Completion rate
- Quality of submissions

**Project Health:**
- Code quality trends
- Test coverage changes
- Community growth
- Feature velocity

### Success Indicators

✅ **Healthy Wave Program:**
- Issues claimed within days
- High completion rate (>80%)
- Repeat contributors
- Quality submissions
- Positive community sentiment

⚠️ **Needs Attention:**
- Issues sit unclaimed
- Low completion rate
- One-time contributors only
- Many revisions needed
- Contributor frustration

## 🎯 Wave Program Goals

### Short-Term (3 months)

- 20+ wave contributors
- 50+ wave issues completed
- 10+ repeat contributors
- Active contributor community

### Long-Term (12 months)

- 100+ wave contributors
- 200+ wave issues completed
- Core contributor pipeline
- Self-sustaining community

## 🏆 Recognition

### Top Contributors

We recognize Wave contributors:

1. **Monthly highlights** in releases
2. **Contributor spotlight** on social media
3. **Invitation to maintainer track** (for exceptional contributors)
4. **Recommendation letters** (if requested)

### Hall of Fame

Top 10 Wave contributors listed in:
- README.md
- Contributor page on website
- Annual report

## 📋 Wave-Ready Issue Checklist

Before marking an issue `wave-ready`:

- [ ] Description is clear and complete
- [ ] Acceptance criteria are specific
- [ ] Complexity is accurately assessed
- [ ] Files to modify are listed
- [ ] Testing requirements are stated
- [ ] Resources are linked
- [ ] Labels are applied correctly
- [ ] Issue is actually doable by external contributor

## ❓ FAQ

### For Contributors

**Q: Can I work on multiple issues?**
A: Finish one before claiming another, to be fair to others.

**Q: What if I can't finish?**
A: That's okay! Let us know, we'll reassign. No penalty.

**Q: How long do I have?**
A: Varies by complexity, but communicate if you need more time.

**Q: Can I ask questions?**
A: Absolutely! That's what we're here for.

**Q: What if my PR isn't accepted?**
A: We'll work with you to address feedback. Rarely rejected outright.

### For Maintainers

**Q: How many Wave issues should we have?**
A: Aim for 10-20 available at any time, across complexity levels.

**Q: What if contributor delivers poor quality?**
A: Provide constructive feedback, request changes. Teaching moment!

**Q: Should we make everything Wave-ready?**
A: No. Some issues require too much context or are too sensitive.

**Q: How to handle scope creep?**
A: Politely redirect: "Great idea! Let's handle that in a separate issue."

## 📞 Contact

**Wave Program Questions:**
- Discord: #wave-contributors
- Email: wave@soroban-ajo.example.com

**Technical Questions:**
- GitHub Discussions
- Discord: #dev

---

**Thank you for participating in Drips Wave!** 🌊

Together, we're building financial inclusion tools while supporting open-source contributors.

*Last updated: February 2026*
