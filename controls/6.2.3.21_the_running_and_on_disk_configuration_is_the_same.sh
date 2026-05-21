#!/usr/bin/env bash
# controls/6.2.3.21_the_running_and_on_disk_configuration_is_the_same.sh

execute_control() {
    local CONTROL_ID="6.2.3.21"
    local TITLE="Ensure the running and on disk configuration is the same  ((Manual)"
    local EXPECTED="Merged rule sets
Ensure that all rules in /etc/audit/rules.d have been merged into
/etc/audit/audit.rules:
# augenrules --check
/usr/sbin/augenrules: No change
Should there be any drift, run augenrules --load to merge and load all rules."
    local RISK="Unknown"
    local DESC="The Audit system have both on disk and running configuration. It is possible for these
configuration settings to differ.
Note: Due to the limitations of augenrules and auditctl, it is not absolutely
guaranteed that loading the rule sets via augenrules --load will result in all rules
being loaded or even that the user will be informed if there was a problem loading the
rules.

Rationale:
Configuration differences between what is currently running and what is on disk could
cause unexpected problems or may give a false impression of compliance
requirements."
    local ATTACK=""
    local REMEDIATION="If the rules are not aligned across all three () areas, run the following command to
merge and load all rules:
# augenrules --load
Check if reboot is required.
if [[ \$(auditctl -s | grep \"enabled\") =~ \"2\" ]]; then echo \"Reboot required
to load rules\"; fi"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
