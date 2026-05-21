#!/usr/bin/env bash
# controls/6.2.2.2_audit_logs_are_not_automatically_deleted.sh

execute_control() {
    local CONTROL_ID="6.2.2.2"
    local TITLE="Ensure audit logs are not automatically deleted ((Automated)"
    local EXPECTED="Run the following command and verify output matches:
# grep max_log_file_action /etc/audit/auditd.conf
max_log_file_action = keep_logs"
    local RISK="Unknown"
    local DESC="The max_log_file_action setting determines how to handle the audit log file reaching
the max file size. A value of keep_logs will rotate the logs but never delete old logs.

Rationale:
In high security contexts, the benefits of maintaining a long audit history exceed the cost
of storing the audit history."
    local ATTACK=""
    local REMEDIATION="Set the following parameter in /etc/audit/auditd.conf:
max_log_file_action = keep_logs"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
