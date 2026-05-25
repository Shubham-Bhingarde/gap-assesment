#!/usr/bin/env bash
# controls/6.2.1.3_auditing_for_processes_that_start_prior_to_auditd_is_enabled.sh

execute_control() {
    local CONTROL_ID="6.2.1.3"
    local TITLE="Ensure auditing for processes that start prior to auditd is enabled ((Automated)"
    local EXPECTED="Run the following command:
# find /boot -type f -name 'grub.cfg' -exec grep -Ph -- '^\h*linux' {} + |
grep -v 'audit=1'
Nothing should be returned."
    local RISK="Unknown"
    local DESC="Configure grub2 so that processes that are capable of being audited can be audited
even if they start up prior to auditd startup.

Rationale:
Audit events need to be captured on processes that start up prior to auditd , so that
potential malicious activity cannot go undetected."
    local ATTACK=""
    local REMEDIATION="Edit /etc/default/grub and add audit=1 to GRUB_CMDLINE_LINUX:
Example:
GRUB_CMDLINE_LINUX=\"audit=1\"
Run the following command to update the grub2 configuration:
# update-grub"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
