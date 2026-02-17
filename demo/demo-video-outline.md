# Demo Video Outline

## Video Specifications

**Title:** Soroban Ajo - Trustless Savings on Stellar  
**Duration:** 2-3 minutes  
**Target Audience:** Crypto-curious, potential users, grant reviewers  
**Tone:** Professional, clear, accessible  
**Format:** Screen recording + voiceover (or talking head intro)

---

## Video Structure

### Opening (0:00 - 0:20)

**Visual:**
- Title card: "Soroban Ajo"
- Subtitle: "Decentralized Rotational Savings"
- Brief animation or transition

**Voiceover:**
> "For generations, African communities have used Ajo - a rotating savings system where groups contribute together and members receive payouts in turn. But traditional Ajo has a problem: it requires trusting a coordinator with everyone's money. What if we could remove that trust requirement entirely?"

**Key Message:** Establish problem and hint at solution

---

### Problem Statement (0:20 - 0:40)

**Visual:**
- Simple infographic showing traditional Ajo flow
- Highlight the coordinator as a single point of failure
- Show risk symbols (💰➡️❌)

**Voiceover:**
> "In traditional Ajo, a coordinator collects contributions and manages payouts. If they disappear with the funds, there's no recourse. Over 1.7 billion adults globally are unbanked, and many rely on informal systems like this - but the risk is real."

**Key Message:** Trust risk is real and affects billions

---

### Solution Introduction (0:40 - 1:00)

**Visual:**
- Transition to Stellar logo
- Show smart contract diagram
- Highlight "no coordinator" and "transparent"

**Voiceover:**
> "Soroban Ajo solves this with a smart contract on the Stellar blockchain. No coordinator. No trust needed. Just transparent, automatic execution. When all members contribute, the smart contract automatically sends the payout to the next person in line."

**Key Message:** Smart contracts eliminate trust requirement

---

### Live Demo (1:00 - 2:20)

#### Part 1: Setup (1:00 - 1:20)

**Visual:**
- Terminal showing commands
- Highlight key steps

**Voiceover:**
> "Let me show you how it works. First, I create a group with three members. I set the contribution amount to 100 XLM per cycle, which is about $15."

**Screen Actions:**
```bash
# Show command execution
soroban contract invoke ... create_group
# Show group ID output
```

**Key Message:** Easy to create groups

#### Part 2: Joining (1:20 - 1:35)

**Visual:**
- Show two more members joining
- Display member list growing

**Voiceover:**
> "Two friends join the group. Now we have three members total. The group is ready to start."

**Screen Actions:**
```bash
# Bob joins
soroban contract invoke ... join_group
# Charlie joins
soroban contract invoke ... join_group
# Show member list
```

**Key Message:** Simple joining process

#### Part 3: Contribution & Payout (1:35 - 2:00)

**Visual:**
- Show all three contributions
- Emphasize "all contributed" check
- Show payout execution

**Voiceover:**
> "All three members contribute their 100 XLM. Once everyone has paid, anyone can trigger the payout function. The smart contract verifies all contributions, calculates the total - 300 XLM - and automatically sends it to the first member. Then the cycle advances."

**Screen Actions:**
```bash
# Show three contributions
# Execute payout
# Show updated group state (cycle 2)
```

**Key Message:** Automatic, verifiable payouts

#### Part 4: Completion (2:00 - 2:20)

**Visual:**
- Fast-forward through cycles 2 and 3
- Show final "is_complete: true" state
- Display summary statistics

**Voiceover:**
> "We fast-forward through cycles two and three. Each member contributes three times and receives one payout. After everyone has received their turn, the group completes successfully. Nine contributions, three payouts, 100% transparent."

**Screen Actions:**
- Show quick cycle progression
- Final group state with is_complete = true
- Stats overlay: "9 contributions, 3 payouts, 0 disputes"

**Key Message:** Full lifecycle works perfectly

---

### Benefits Recap (2:20 - 2:40)

**Visual:**
- Side-by-side comparison:
  - Traditional Ajo vs. Soroban Ajo
- Checkmarks for benefits

**Voiceover:**
> "Compared to traditional Ajo, Soroban Ajo is trustless, transparent, globally accessible, and costs 95% less in fees. It's the same community-based savings system people know and trust, just better."

**On-Screen Text:**
- ✅ No coordinator needed
- ✅ Transparent on-chain
- ✅ Global accessibility
- ✅ 95% lower fees
- ✅ Automatic execution

**Key Message:** Clear advantages over status quo

---

### Call to Action (2:40 - 3:00)

**Visual:**
- GitHub repository on screen
- Documentation highlights
- Community links

**Voiceover:**
> "Soroban Ajo is open source and ready for testing on Stellar testnet. Try the demo, read the documentation, or join our community. Together, we can bring transparent, trustless savings to billions of underserved people worldwide."

**On-Screen Text:**
- GitHub: github.com/yourusername/soroban-ajo
- Demo: [Demo link]
- Community: [Discord/Telegram]

**Key Message:** Open for participation, testing, feedback

---

### Closing (3:00 - 3:05)

**Visual:**
- Title card: "Soroban Ajo"
- Tagline: "Savings. Transparent. Trustless."
- Logo and links

**Voiceover:**
> "Soroban Ajo. Building financial inclusion, one group at a time."

---

## Production Notes

### Filming Guidelines

**Screen Recording:**
- Use high-quality screen capture (1080p minimum)
- Clean desktop, minimal distractions
- Terminal with large, readable font (18pt+)
- Syntax highlighting enabled
- Slow down typing for key commands

**Audio:**
- Professional microphone (Blue Yeti or similar)
- Quiet environment
- Clear enunciation
- Moderate pace (not too fast)
- Enthusiastic but professional tone

**Editing:**
- Add subtle transitions
- Highlight important text on screen
- Zoom in on key outputs
- Background music (soft, non-intrusive)
- Color-code terminal output if possible

### Visual Enhancements

**Graphics to Create:**
1. Opening title card
2. Traditional Ajo flow diagram
3. Smart contract flow diagram
4. Side-by-side comparison table
5. Closing title card

**Animations:**
- Simple transitions (fade, slide)
- Highlight boxes around important commands
- Checkmarks appearing for benefits
- Progress indicators for cycle advancement

### Script Variations

**2-Minute Version (Shorter):**
- Skip detailed command explanations
- Show only cycle 1 in detail
- Fast-forward cycles 2-3
- Shorter benefits recap

**5-Minute Version (Educational):**
- Include installation steps
- Explain each command in detail
- Show error case (double contribution)
- Deeper explanation of how smart contracts work
- Q&A style addressing common questions

---

## Alternative Formats

### Format 1: Talking Head + Screen Share

**Structure:**
- Open with presenter on camera (0:00-0:20)
- Switch to screen share for demo (0:20-2:20)
- Return to presenter for closing (2:20-3:00)

**Pros:**
- More personal connection
- Better for building trust
- Can show emotion/enthusiasm

**Cons:**
- Requires good lighting and camera
- More editing complexity

### Format 2: Animated Explainer

**Structure:**
- Use animated graphics throughout
- No live demo, just visualization
- Narration over animations

**Pros:**
- Very polished look
- Easier to convey concepts
- More engaging for non-technical viewers

**Cons:**
- More expensive to produce
- Takes longer to create
- Less "proof" of actual working system

### Format 3: User Testimonial

**Structure:**
- Brief intro to problem
- Real user sharing experience
- Quick demo walkthrough
- User explaining impact

**Pros:**
- Most authentic
- Strong emotional appeal
- Perfect for grant applications

**Cons:**
- Need real users first
- Coordination complexity
- May lack technical detail

**Recommended:** Start with Format 1 (Talking Head + Screen Share), create Format 3 after beta testing.

---

## Distribution Strategy

### Where to Share

**Primary:**
- YouTube (main hosting)
- GitHub repository (embed)
- Grant application (direct link)

**Secondary:**
- Twitter/X (clips)
- LinkedIn (professional audience)
- Reddit (r/Stellar, r/CryptoCurrency)
- Stellar community forum

**Targeted:**
- Email to Drips Wave reviewers
- Stellar Foundation slack/discord
- African tech communities
- Fintech newsletters

### SEO Optimization

**YouTube:**
- Title: "Soroban Ajo - Decentralized Savings on Stellar (Full Demo)"
- Tags: Stellar, Soroban, blockchain, savings, DeFi, African fintech, ROSCA
- Description: Full transcript + links
- Thumbnail: Eye-catching with key benefit text

**Social Media:**
- Quote graphics with key stats
- 30-second teaser clips
- Behind-the-scenes content
- User testimonials (when available)

---

## Success Metrics

**View Targets:**
- Week 1: 100+ views
- Month 1: 500+ views
- Month 3: 2,000+ views

**Engagement:**
- Average watch time: >60%
- Like/dislike ratio: >90%
- Comments: 20+ positive interactions
- Shares: 50+ across platforms

**Conversion:**
- Click-through to GitHub: 10%+
- Demo signups: 5%+
- Community joins: 3%+

---

## Next Steps

1. **Script finalization:** Review and approve final script
2. **Recording:** Schedule recording session
3. **Editing:** 2-3 days for professional editing
4. **Review:** Internal review, gather feedback
5. **Publishing:** Upload to YouTube, share widely
6. **Promotion:** Coordinated social media campaign

**Timeline:** 1-2 weeks from script approval to publication

---

## Budget (Optional)

| Item | Cost | Notes |
|------|------|-------|
| Script writing | $200 | If outsourced |
| Voiceover artist | $100 | Professional VO (or DIY free) |
| Video editing | $300 | Professional editor |
| Graphics/animations | $200 | Fiverr or DIY |
| Background music | $30 | Royalty-free license |
| **Total** | **$830** | Or ~$100 if fully DIY |

---

**This outline provides everything needed to create a compelling demo video that showcases Soroban Ajo's value, ease of use, and real-world impact.**
