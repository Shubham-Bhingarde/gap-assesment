#!/usr/bin/env bash
# controls/6.1.2.1_rsyslog_is_installed.sh

execute_control() {
    local CONTROL_ID="6.1.2.1"
    local TITLE="Ensure rsyslog is installed ((Automated)"
    local EXPECTED="- IF - rsyslog is being used for logging on the system:
Run the following command to verify rsyslog is installed:
# dpkg-query -s rsyslog &>/dev/null && echo \"rsyslog is installed\"
Verify the output matches:
rsyslog is installed"
    local RISK="Unknown"
    local DESC="The rsyslog software is recommended in environments where journald does not
meet operation requirements.

Rationale:
The security enhancements of rsyslog such as connection-oriented (i.e. TCP)
transmission of logs, the option to log to database formats, and the encryption of log
data en route to a central logging server) justify installing and configuring the package."
    local ATTACK=""
    local REMEDIATION="Run the following command to install rsyslog:
# apt install rsyslog"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
