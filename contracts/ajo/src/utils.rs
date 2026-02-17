use soroban_sdk::{Address, Env, Vec};

use crate::types::Group;

/// Check if an address is a member of the group
pub fn is_member(members: &Vec<Address>, address: &Address) -> bool {
    for member in members.iter() {
        if member == *address {
            return true;
        }
    }
    false
}

/// Check if all members have contributed for the current cycle
pub fn all_members_contributed(env: &Env, group: &Group) -> bool {
    for member in group.members.iter() {
        if !crate::storage::has_contributed(env, group.id, group.current_cycle, &member) {
            return false;
        }
    }
    true
}

/// Calculate the total payout amount for a cycle
pub fn calculate_payout_amount(group: &Group) -> i128 {
    let member_count = group.members.len() as i128;
    group.contribution_amount * member_count
}

/// Get the current timestamp
pub fn get_current_timestamp(env: &Env) -> u64 {
    env.ledger().timestamp()
}

/// Validate group creation parameters
pub fn validate_group_params(
    contribution_amount: i128,
    cycle_duration: u64,
    max_members: u32,
) -> Result<(), crate::errors::AjoError> {
    if contribution_amount <= 0 {
        return Err(crate::errors::AjoError::InvalidAmount);
    }
    
    if cycle_duration == 0 {
        return Err(crate::errors::AjoError::InvalidCycleDuration);
    }
    
    if max_members < 2 {
        return Err(crate::errors::AjoError::InvalidMaxMembers);
    }
    
    Ok(())
}
