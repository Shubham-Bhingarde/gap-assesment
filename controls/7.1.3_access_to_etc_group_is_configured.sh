#!/usr/bin/env bash
# controls/7.1.3_access_to_etc_group_is_configured.sh

execute_control() {
    local CONTROL_ID="7.1.3"
    local TITLE="Ensure access to /etc/group is configured ((Automated)"
    local EXPECTED="Run the following command to verify /etc/group is mode 644 or more restrictive, Uid
is 0/root and Gid is 0/root:
# stat -Lc 'Access: (%#a/%A)
Access: (0644/-rw-r--r--)
Uid: ( %u/ %U) Gid: ( %g/ %G)' /etc/group
Uid: ( 0/ root) Gid: ( 0/ root)"
    local RISK="Unknown"
    local DESC="The /etc/group file contains a list of all the valid groups defined in the system. The
command below allows read/write access for root and read access for everyone else.

Rationale:
The /etc/group file needs to be protected from unauthorized changes by nonprivileged users, but needs to be readable as this information is used with many nonprivileged programs."
    local ATTACK=""
    local REMEDIATION="Run the following commands to remove excess permissions, set owner, and set group
on /etc/group:
# chmod u-x,go-wx /etc/group
# chown root:root /etc/group"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
