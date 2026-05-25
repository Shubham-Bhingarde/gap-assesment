#!/usr/bin/env bash
# controls/6.1.2.2_rsyslog_service_is_enabled_and_active.sh

execute_control() {
    local CONTROL_ID="6.1.2.2"
    local TITLE="Ensure rsyslog service is enabled and active ((Automated)"
    local EXPECTED="- IF - rsyslog is being used for logging on the system:
Run the following command to verify rsyslog.service is enabled:
# systemctl is-enabled rsyslog
enabled
Run the following command to verify rsyslog.service is active:
# systemctl is-active rsyslog.service
active"
    local RISK="Unknown"
    local DESC="Once the rsyslog package is installed, ensure that the service is enabled.

Rationale:
If the rsyslog service is not enabled to start on boot, the system will not capture
logging events."
    local ATTACK=""
    local REMEDIATION="- IF - rsyslog is being used for logging on the system:
Run the following commands to unmask, enable, and start rsyslog.service:
# systemctl unmask rsyslog.service
# systemctl enable rsyslog.service
# systemctl start rsyslog.service"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
