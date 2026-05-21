#!/usr/bin/env bash
# controls/6.2.3.1_changes_to_system_administration_scope_sudoers_is_collected.sh

execute_control() {
    local CONTROL_ID="6.2.3.1"
    local TITLE="Ensure changes to system administration scope (sudoers) is collected ((Automated)"
    local EXPECTED="On disk configuration
Run the following command to check the on disk rules:
# awk '/^ *-w/ \
&&/\/etc\/sudoers/ \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *\$/||/ -k *[!-~]* *\$/)' /etc/audit/rules.d/*.rules
Verify the output matches:
-w /etc/sudoers -p wa -k scope
-w /etc/sudoers.d -p wa -k scope
Running configuration
Run the following command to check loaded rules:
# auditctl -l | awk '/^ *-w/ \
&&/\/etc\/sudoers/ \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *\$/||/ -k *[!-~]* *\$/)'
Verify the output matches:
-w /etc/sudoers -p wa -k scope
-w /etc/sudoers.d -p wa -k scope"
    local RISK="Unknown"
    local DESC="Monitor scope changes for system administrators. If the system has been properly
configured to force system administrators to log in as themselves first and then use the
sudo command to execute privileged commands, it is possible to monitor changes in
scope. The file /etc/sudoers, or files in /etc/sudoers.d, will be written to when the
file(s) or related attributes have changed. The audit records will be tagged with the
identifier \"scope\".

Rationale:
Changes in the /etc/sudoers and /etc/sudoers.d files can indicate that an
unauthorized change has been made to the scope of system administrator activity."
    local ATTACK=""
    local REMEDIATION="Edit or create a file in the /etc/audit/rules.d/ directory, ending in .rules extension,
with the relevant rules to monitor scope changes for system administrators.
Example:
# printf \"
-w /etc/sudoers -p wa -k scope
-w /etc/sudoers.d -p wa -k scope
\" >> /etc/audit/rules.d/50-scope.rules
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
