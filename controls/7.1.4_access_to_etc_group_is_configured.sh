#!/usr/bin/env bash
# controls/7.1.4_access_to_etc_group_is_configured.sh

execute_control() {
    local CONTROL_ID="7.1.4"
    local TITLE="Ensure access to /etc/group- is configured ((Automated)"
    local EXPECTED="Run the following command to verify /etc/group- is mode 644 or more restrictive, Uid
is 0/root and Gid is 0/root:
# stat -Lc 'Access: (%#a/%A)
Access: (0644/-rw-r--r--)
Uid: ( %u/ %U) Gid: ( %g/ %G)'
/etc/group-
Uid: ( 0/ root) Gid: ( 0/ root)"
    local RISK="Unknown"
    local DESC="The /etc/group- file contains a backup list of all the valid groups defined in the
system.

Rationale:
It is critical to ensure that the /etc/group- file is protected from unauthorized access.
Although it is protected by default, the file permissions could be changed either
inadvertently or through malicious actions."
    local ATTACK=""
    local REMEDIATION="Run the following commands to remove excess permissions, set owner, and set group
on /etc/group-:
# chmod u-x,go-wx /etc/group# chown root:root /etc/group-"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
