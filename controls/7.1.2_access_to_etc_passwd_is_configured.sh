#!/usr/bin/env bash
# controls/7.1.2_access_to_etc_passwd_is_configured.sh

execute_control() {
    local CONTROL_ID="7.1.2"
    local TITLE="Ensure access to /etc/passwd- is configured ((Automated)"
    local EXPECTED="Run the following command to verify /etc/passwd- is mode 644 or more restrictive,
Uid is 0/root and Gid is 0/root:
# stat -Lc 'Access: (%#a/%A)
Access: (0644/-rw-r--r--)
Uid: ( %u/ %U) Gid: { %g/ %G)' /etc/passwd-
Uid: ( 0/ root) Gid: { 0/ root)"
    local RISK="Unknown"
    local DESC="The /etc/passwd- file contains backup user account information.

Rationale:
It is critical to ensure that the /etc/passwd- file is protected from unauthorized access.
Although it is protected by default, the file permissions could be changed either
inadvertently or through malicious actions."
    local ATTACK=""
    local REMEDIATION="Run the following commands to remove excess permissions, set owner, and set group
on /etc/passwd-:
# chmod u-x,go-wx /etc/passwd# chown root:root /etc/passwd-"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
