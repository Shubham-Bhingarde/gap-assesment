#!/usr/bin/env bash
# controls/7.1.6_access_to_etc_shadow_is_configured.sh

execute_control() {
    local CONTROL_ID="7.1.6"
    local TITLE="Ensure access to /etc/shadow- is configured ((Automated)"
    local EXPECTED="Run the following command to verify /etc/shadow- is mode 640 or more restrictive,
Uid is 0/root and Gid is 0/root or {GID}/shadow:
# stat -Lc 'Access: (%#a/%A)
Uid: ( %u/ %U) Gid: ( %g/ %G)'
/etc/shadow-
Example:
Access: (0640/-rw-r-----)
Uid: ( 0/ root) Gid: ( 42/ shadow)"
    local RISK="Unknown"
    local DESC="The /etc/shadow- file is used to store backup information about user accounts that is
critical to the security of those accounts, such as the hashed password and other
security information.

Rationale:
It is critical to ensure that the /etc/shadow- file is protected from unauthorized access.
Although it is protected by default, the file permissions could be changed either
inadvertently or through malicious actions."
    local ATTACK=""
    local REMEDIATION="Run one of the following commands to set ownership of /etc/shadow- to root and
group to either root or shadow:
# chown root:shadow /etc/shadow-OR# chown root:root /etc/shadow-
Run the following command to remove excess permissions form /etc/shadow-:
# chmod u-x,g-wx,o-rwx /etc/shadow-"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
