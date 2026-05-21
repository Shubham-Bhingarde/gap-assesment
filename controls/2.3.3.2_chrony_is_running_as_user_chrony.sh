#!/usr/bin/env bash
# controls/2.3.3.2_chrony_is_running_as_user_chrony.sh

execute_control() {
    local CONTROL_ID="2.3.3.2"
    local TITLE="Ensure chrony is running as user _chrony ((Automated)"
    local EXPECTED="- IF - chrony is in use on the system, run the following command to verify the chronyd
service is being run as the _chrony user:
# ps -ef | awk '(/[c]hronyd/ && \$1!=\"_chrony\") { print \$1 }'
Nothing should be returned"
    local RISK="Unknown"
    local DESC="The chrony package is installed with a dedicated user account _chrony. This account
is granted the access required by the chronyd service

Rationale:
The chronyd service should run with only the required privlidges"
    local ATTACK=""
    local REMEDIATION="Add or edit the user line to /etc/chrony/chrony.conf or a file ending in .conf in
/etc/chrony/conf.d/:
user _chrony
- OR If another time synchronization service is in use on the system, run the following
command to remove chrony from the system:
# apt purge chrony
# apt autoremove chrony"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
