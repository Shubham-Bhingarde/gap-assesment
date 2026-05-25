#!/usr/bin/env bash
# controls/6.2.4.7_audit_configuration_files_group_owner_is_configured.sh

execute_control() {
    local CONTROL_ID="6.2.4.7"
    local TITLE="Ensure audit configuration files group owner is configured ((Automated)"
    local EXPECTED="Run the following command to verify that the audit configuration files are owned by the
group root:
# find /etc/audit/ -type f \( -name '*.conf' -o -name '*.rules' \) ! -group
root
Nothing should be returned"
    local RISK="Unknown"
    local DESC="Audit configuration files control auditd and what events are audited.

Rationale:
Access to the audit configuration files could allow unauthorized personnel to prevent the
auditing of critical events.
Misconfigured audit configuration files may prevent the auditing of critical events or
impact the system's performance by overwhelming the audit log. Misconfiguration of the
audit configuration files may also make it more difficult to establish and investigate
events relating to an incident."
    local ATTACK=""
    local REMEDIATION="Run the following command to change group to root:
# find /etc/audit/ -type f \( -name '*.conf' -o -name '*.rules' \) ! -group
root -exec chgrp root {} +"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
