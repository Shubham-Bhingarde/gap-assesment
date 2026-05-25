#!/usr/bin/env bash
# controls/6.2.3.20_the_audit_configuration_is_immutable.sh

execute_control() {
    local CONTROL_ID="6.2.3.20"
    local TITLE="Ensure the audit configuration is immutable ((Automated)"
    local EXPECTED="Run the following command and verify output matches:
# grep -Ph -- '^\h*-e\h+2\b' /etc/audit/rules.d/*.rules | tail -1
-e 2"
    local RISK="Unknown"
    local DESC="Set system audit so that audit rules cannot be modified with auditctl . Setting the flag
\"-e 2\" forces audit to be put in immutable mode. Audit changes can only be made on
system reboot.
Note: This setting will require the system to be rebooted to update the active auditd
configuration settings.

Rationale:
In immutable mode, unauthorized users cannot execute changes to the audit system to
potentially hide malicious activity and then put the audit rules back. Users would most
likely notice a system reboot and that could alert administrators of an attempt to make
unauthorized audit changes."
    local ATTACK=""
    local REMEDIATION="Edit or create the file /etc/audit/rules.d/99-finalize.rules and add the line -e
2 at the end of the file:
Example:
# printf '\n%s' \"-e 2\" >> /etc/audit/rules.d/99-finalize.rules
Load audit rules
Merge and load the rules into active configuration:
# augenrules --load
Check if reboot is required.
# if [[ \$(auditctl -s | grep \"enabled\") =~ \"2\" ]]; then printf \"Reboot
required to load rules\n\"; fi"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
