#!/usr/bin/env bash
# controls/6.2.1.4_audit_backlog_limit_is_configured.sh

execute_control() {
    local CONTROL_ID="6.2.1.4"
    local TITLE="Ensure audit_backlog_limit is configured ((Automated)"
    local EXPECTED="Run the following command and verify the audit_backlog_limit= parameter is set:
# find /boot -type f -name 'grub.cfg' -exec grep -Ph -- '^\h*linux' {} + |
grep -Pv 'audit_backlog_limit=\d+\b'
Nothing should be returned."
    local RISK="Unknown"
    local DESC="In the kernel-level audit subsystem, a socket buffer queue is used to hold audit events.
Whenever a new audit event is received, it is logged and prepared to be added to this
queue.
The kernel boot parameter audit_backlog_limit=N, with N representing the amount of
messages, will ensure that a queue cannot grow beyond a certain size. If an audit event
is logged which would grow the queue beyond this limit, then a failure occurs and is
handled according to the system configuration

Rationale:
If an audit event is logged which would grow the queue beyond the
audit_backlog_limit, then a failure occurs, auditd records will be lost, and potential
malicious activity could go undetected."
    local ATTACK=""
    local REMEDIATION="Edit /etc/default/grub and add audit_backlog_limit=N to
GRUB_CMDLINE_LINUX. The recommended size for N is 8192 or larger.
Example:
GRUB_CMDLINE_LINUX=\"audit_backlog_limit=8192\"
Run the following command to update the grub2 configuration:
# update-grub"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
