#!/usr/bin/env bash
# controls/5.4.2.1_root_is_the_only_uid_0_account.sh

execute_control() {
    local CONTROL_ID="5.4.2.1"
    local TITLE="Ensure root is the only UID 0 account ((Automated)"
    local EXPECTED="Run the following command and verify that only \"root\" is returned:
# awk -F: '(\$3 == 0) { print \$1 }' /etc/passwd
root"
    local RISK="Unknown"
    local DESC="Any account with UID 0 has superuser privileges on the system.

Rationale:
This access must be limited to only the default root account and only from the system
console. Administrative access must be through an unprivileged account using an
approved mechanism as noted in the Recommendation \"Ensure access to the su
command is restricted\"."
    local ATTACK=""
    local REMEDIATION="Run the following command to change the root account UID to 0:
# usermod -u 0 root
Modify any users other than root with UID 0 and assign them a new UID."

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
