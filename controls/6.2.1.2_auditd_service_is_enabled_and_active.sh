#!/usr/bin/env bash
# controls/6.2.1.2_auditd_service_is_enabled_and_active.sh

execute_control() {
    local CONTROL_ID="6.2.1.2"
    local TITLE="Ensure auditd service is enabled and active ((Automated)"
    local EXPECTED="Run the following command to verify auditd is enabled:
# systemctl is-enabled auditd | grep '^enabled'
enabled
Verify result is \"enabled\".
Run the following command to verify auditd is active:
# systemctl is-active auditd | grep '^active'
active
Verify result is active"
    local RISK="Unknown"
    local DESC="Turn on the auditd daemon to record system events.

Rationale:
The capturing of system events provides system administrators with information to allow
them to determine if unauthorized access to their system is occurring."
    local ATTACK=""
    local REMEDIATION="Run the following commands to unmask, enable and start auditd:
# systemctl unmask auditd
# systemctl enable auditd
# systemctl start auditd"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
