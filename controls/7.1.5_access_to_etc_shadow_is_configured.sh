#!/usr/bin/env bash
# controls/7.1.5_access_to_etc_shadow_is_configured.sh

execute_control() {
    local CONTROL_ID="7.1.5"
    local TITLE="Ensure access to /etc/shadow is configured ((Automated)"
    local EXPECTED="Run the following command to verify /etc/shadow is mode 640 or more restrictive, Uid
is 0/root and Gid is 0/root or ({GID}/ shadow):
# stat -Lc 'Access: (%#a/%A)
Uid: ( %u/ %U) Gid: ( %g/ %G)'
/etc/shadow
Example:
Access: (0640/-rw-r-----)
Uid: ( 0/ root) Gid: ( 42/ shadow)"
    local RISK="Unknown"
    local DESC="The /etc/shadow file is used to store the information about user accounts that is critical
to the security of those accounts, such as the hashed password and other security
information.

Rationale:
If attackers can gain read access to the /etc/shadow file, they can easily run a
password cracking program against the hashed password to break it. Other security
information that is stored in the /etc/shadow file (such as expiration) could also be
useful to subvert the user accounts."
    local ATTACK=""
    local REMEDIATION="Run one of the following commands to set ownership of /etc/shadow to root and
group to either root or shadow:
# chown root:shadow /etc/shadow
-OR# chown root:root /etc/shadow
Run the following command to remove excess permissions form /etc/shadow:
# chmod u-x,g-wx,o-rwx /etc/shadow"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
