#!/usr/bin/env bash
# controls/5.4.2.2_root_is_the_only_gid_0_account.sh

execute_control() {
    local CONTROL_ID="5.4.2.2"
    local TITLE="Ensure root is the only GID 0 account ((Automated)"
    local EXPECTED="Run the following command to verify the root user's primary GID is 0, and no other
user's have GID 0 as their primary GID:
# awk -F: '(\$1 !~ /^(sync|shutdown|halt|operator)/ && \$4==\"0\") {print
\$1\":\"\$4}' /etc/passwd
root:0
Note: User's: sync, shutdown, halt, and operator are excluded from the check for other
user's with GID 0"
    local RISK="Unknown"
    local DESC="The usermod command can be used to specify which group the root account belongs
to. This affects permissions of files that are created by the root account.

Rationale:
Using GID 0 for the root account helps prevent root -owned files from accidentally
becoming accessible to non-privileged users."
    local ATTACK=""
    local REMEDIATION="Run the following command to set the root user's GID to 0:
# usermod -g 0 root
Run the following command to set the root group's GID to 0:
# groupmod -g 0 root
Remove any users other than the root user with GID 0 or assign them a new GID if
appropriate."

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
