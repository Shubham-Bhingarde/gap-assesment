#!/usr/bin/env bash
# controls/6.2.2.1_audit_log_storage_size_is_configured.sh

execute_control() {
    local CONTROL_ID="6.2.2.1"
    local TITLE="Ensure audit log storage size is configured ((Automated)"
    local EXPECTED="Run the following command and ensure output is in compliance with site policy:
# grep -Po -- '^\h*max_log_file\h*=\h*\d+\b' /etc/audit/auditd.conf
max_log_file = <MB>"
    local RISK="Unknown"
    local DESC="Configure the maximum size of the audit log file. Once the log reaches the maximum
size, it will be rotated and a new log file will be started.

Rationale:
It is important that an appropriate size is determined for log files so that they do not
impact the system and audit data is not lost."
    local ATTACK=""
    local REMEDIATION="Set the following parameter in /etc/audit/auditd.conf in accordance with site
policy:
max_log_file = <MB>"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
