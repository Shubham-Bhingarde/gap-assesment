#!/usr/bin/env bash
# controls/7.1.7_access_to_etc_gshadow_is_configured.sh

execute_control() {
    local CONTROL_ID="7.1.7"
    local TITLE="Ensure access to /etc/gshadow is configured ((Automated)"
    local EXPECTED="Run the following command to verify /etc/gshadow is mode 640 or more restrictive,
Uid is 0/root and Gid is 0/root or \`{GID}/shadow:
# stat -Lc 'Access: (%#a/%A)
Uid: ( %u/ %U) Gid: ( %g/ %G)'
/etc/gshadow
Example:
Access: (0640/-rw-r-----)
Uid: ( 0/ root) Gid: ( 42/ shadow)"
    local RISK="Unknown"
    local DESC="The /etc/gshadow file is used to store the information about groups that is critical to
the security of those accounts, such as the hashed password and other security
information.

Rationale:
If attackers can gain read access to the /etc/gshadow file, they can easily run a
password cracking program against the hashed password to break it. Other security
information that is stored in the /etc/gshadow file (such as group administrators) could
also be useful to subvert the group."
    local ATTACK=""
    local REMEDIATION="Run one of the following commands to set ownership of /etc/gshadow to root and
group to either root or shadow:
# chown root:shadow /etc/gshadow
-OR# chown root:root /etc/gshadow
Run the following command to remove excess permissions form /etc/gshadow:
# chmod u-x,g-wx,o-rwx /etc/gshadow"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
