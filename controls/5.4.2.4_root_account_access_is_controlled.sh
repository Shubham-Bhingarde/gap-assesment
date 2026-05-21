#!/usr/bin/env bash
# controls/5.4.2.4_root_account_access_is_controlled.sh

execute_control() {
    local CONTROL_ID="5.4.2.4"
    local TITLE="Ensure root account access is controlled ((Automated)"
    local EXPECTED="Run the following command to verify that either the root user's password is set or the
root user's account is locked:
# passwd -S root | awk '\$2 ~ /^(P|L)/ {print \"User: \\"\" \$1 \"\\" Password is
status: \" \$2}'
Verify the output is either:
User: \"root\" Password is status: P
- OR User: \"root\" Password is status: L
Note:
•
•
P - Password is set
L - Password is locked"
    local RISK="Unknown"
    local DESC="There are a number of methods to access the root account directly. Without a password
set any user would be able to gain access and thus control over the entire system.

Rationale:
Access to root should be secured at all times."
    local ATTACK="If there are any automated processes that relies on access to the root account without
authentication, they will fail after remediation."
    local REMEDIATION="Run the following command to set a password for the root user:
# passwd root
- OR Run the following command to lock the root user account:
# usermod -L root"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
