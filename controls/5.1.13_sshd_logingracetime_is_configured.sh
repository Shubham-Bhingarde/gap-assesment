#!/usr/bin/env bash
# controls/5.1.13_sshd_logingracetime_is_configured.sh

execute_control() {
    local CONTROL_ID="5.1.13"
    local TITLE="Ensure sshd LoginGraceTime is configured ((Automated)"
    local EXPECTED="Run the following command and verify that output LoginGraceTime is between 1 and
60 seconds:
# sshd -T | grep logingracetime
logingracetime 60"
    local RISK="Unknown"
    local DESC="The LoginGraceTime parameter specifies the time allowed for successful
authentication to the SSH server. The longer the Grace period is the more open
unauthenticated connections can exist. Like other session controls in this session the
Grace Period should be limited to appropriate organizational limits to ensure the service
is available for needed access.

Rationale:
Setting the LoginGraceTime parameter to a low number will minimize the risk of
successful brute force attacks to the SSH server. It will also limit the number of
concurrent unauthenticated connections While the recommended setting is 60 seconds
(1 Minute), set the number based on site policy."
    local ATTACK=""
    local REMEDIATION="Edit the /etc/ssh/sshd_config file to set the LoginGraceTime parameter to 60
seconds or less above any Include entry as follows:
LoginGraceTime 60
Note: First occurrence of a option takes precedence. If Include locations are enabled,
used, and order of precedence is understood in your environment, the entry may be
created in a file in Include location."

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
