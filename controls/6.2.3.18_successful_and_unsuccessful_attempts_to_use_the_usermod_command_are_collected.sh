#!/usr/bin/env bash
# controls/6.2.3.18_successful_and_unsuccessful_attempts_to_use_the_usermod_command_are_collected.sh

execute_control() {
    local CONTROL_ID="6.2.3.18"
    local TITLE="Ensure successful and unsuccessful attempts to use the usermod command are collected ((Automated)"
    local EXPECTED="On disk configuration
Run the following command to check the on disk rules:
# {
UID_MIN=\$(awk '/^\s*UID_MIN/{print \$2}' /etc/login.defs)
[ -n \"\${UID_MIN}\" ] && awk \"/^ *-a *always,exit/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&/ -F *auid>=\${UID_MIN}/ \
&&/ -F *perm=x/ \
&&/ -F *path=\/usr\/sbin\/usermod/ \
&&(/ key= *[!-~]* *\$/||/ -k *[!-~]* *\$/)\" /etc/audit/rules.d/*.rules \
|| printf \"ERROR: Variable 'UID_MIN' is unset.\n\"
}
Verify the output matches:
-a always,exit -F path=/usr/sbin/usermod -F perm=x -F auid>=1000 -F
auid!=unset -k usermod
Running configuration
Run the following command to check loaded rules:
# {
UID_MIN=\$(awk '/^\s*UID_MIN/{print \$2}' /etc/login.defs)
[ -n \"\${UID_MIN}\" ] && auditctl -l | awk \"/^ *-a *always,exit/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&/ -F *auid>=\${UID_MIN}/ \
&&/ -F *perm=x/ \
&&/ -F *path=\/usr\/sbin\/usermod/ \
&&(/ key= *[!-~]* *\$/||/ -k *[!-~]* *\$/)\" \
|| printf \"ERROR: Variable 'UID_MIN' is unset.\n\"
}
Verify the output matches:
-a always,exit -S all -F path=/usr/sbin/usermod -F perm=x -F auid>=1000 -F
auid!=-1 -F key=usermod"
    local RISK="Unknown"
    local DESC="The operating system must generate audit records for successful/unsuccessful uses of
the usermod command.

Rationale:
The usermod command modifies the system account files to reflect the changes that are
specified on the command line. Without generating audit records that are specific to the
security and mission needs of the organization, it would be difficult to establish,
correlate, and investigate the events relating to an incident or identify those responsible
for one.
Audit records can be generated from various components within the information system
(e.g., module or policy filter)."
    local ATTACK=""
    local REMEDIATION="Create audit rules
Edit or create a file in the /etc/audit/rules.d/ directory, ending in .rules extension,
with the relevant rules to monitor successful and unsuccessful attempts to use the
usermod command.
Example:
# {
UID_MIN=\$(awk '/^\s*UID_MIN/{print \$2}' /etc/login.defs)
[ -n \"\${UID_MIN}\" ] && printf \"
-a always,exit -F path=/usr/sbin/usermod -F perm=x -F auid>=\${UID_MIN} -F
auid!=unset -k usermod
\" >> /etc/audit/rules.d/50-usermod.rules || printf \"ERROR: Variable 'UID_MIN'
is unset.\n\"
}
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
