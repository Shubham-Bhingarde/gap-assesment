#!/usr/bin/env bash
# controls/6.2.3.14_events_that_modify_the_system_s_mandatory_access_controls_are_collected.sh

execute_control() {
    local CONTROL_ID="6.2.3.14"
    local TITLE="Ensure events that modify the system's Mandatory Access Controls are collected ((Automated)"
    local EXPECTED="On disk configuration
Run the following command to check the on disk rules:
# awk '/^ *-w/ \
&&(/\/etc\/apparmor/ \
||/\/etc\/apparmor.d/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *\$/||/ -k *[!-~]* *\$/)' /etc/audit/rules.d/*.rules
Verify the output matches:
-w /etc/apparmor/ -p wa -k MAC-policy
-w /etc/apparmor.d/ -p wa -k MAC-policy
Running configuration
Run the following command to check loaded rules:
# auditctl -l | awk '/^ *-w/ \
&&(/\/etc\/apparmor/ \
||/\/etc\/apparmor.d/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *\$/||/ -k *[!-~]* *\$/)'
Verify the output matches:
-w /etc/apparmor/ -p wa -k MAC-policy
-w /etc/apparmor.d/ -p wa -k MAC-policy"
    local RISK="Unknown"
    local DESC="Monitor AppArmor, an implementation of mandatory access controls. The parameters
below monitor any write access (potential additional, deletion or modification of files in
the directory) or attribute changes to the /etc/apparmor/ and /etc/apparmor.d/
directories.
Note: If a different Mandatory Access Control method is used, changes to the
corresponding directories should be audited.

Rationale:
Changes to files in the /etc/apparmor/ and /etc/apparmor.d/ directories could
indicate that an unauthorized user is attempting to modify access controls and change
security contexts, leading to a compromise of the system."
    local ATTACK=""
    local REMEDIATION="Edit or create a file in the /etc/audit/rules.d/ directory, ending in .rules extension,
with the relevant rules to monitor events that modify the system's Mandatory Access
Controls.
Example:
# printf \"
-w /etc/apparmor/ -p wa -k MAC-policy
-w /etc/apparmor.d/ -p wa -k MAC-policy
\" >> /etc/audit/rules.d/50-MAC-policy.rules
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
