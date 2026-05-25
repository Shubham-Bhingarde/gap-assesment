#!/usr/bin/env bash
# controls/6.2.3.13_file_deletion_events_by_users_are_collected.sh

execute_control() {
    local CONTROL_ID="6.2.3.13"
    local TITLE="Ensure file deletion events by users are collected ((Automated)"
    local EXPECTED="On disk configuration
Run the following command to check the on disk rules:
# {
UID_MIN=\$(awk '/^\s*UID_MIN/{print \$2}' /etc/login.defs)
[ -n \"\${UID_MIN}\" ] && awk \"/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&/ -F *auid>=\${UID_MIN}/ \
&&/ -S/ \
&&(/unlink/||/rename/||/unlinkat/||/renameat/) \
&&(/ key= *[!-~]* *\$/||/ -k *[!-~]* *\$/)\" /etc/audit/rules.d/*.rules \
|| printf \"ERROR: Variable 'UID_MIN' is unset.\n\"
}
Verify the output matches:
-a always,exit -F arch=b64 -S unlink,unlinkat,rename,renameat -F auid>=1000 F auid!=unset -k delete
-a always,exit -F arch=b32 -S unlink,unlinkat,rename,renameat -F auid>=1000 F auid!=unset -k delete
Running configuration
Run the following command to check loaded rules:
# {
UID_MIN=\$(awk '/^\s*UID_MIN/{print \$2}' /etc/login.defs)
[ -n \"\${UID_MIN}\" ] && auditctl -l | awk \"/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&/ -F *auid>=\${UID_MIN}/ \
&&/ -S/ \
&&(/unlink/||/rename/||/unlinkat/||/renameat/) \
&&(/ key= *[!-~]* *\$/||/ -k *[!-~]* *\$/)\" \
|| printf \"ERROR: Variable 'UID_MIN' is unset.\n\"
}
Verify the output matches:
-a always,exit -F arch=b64 -S rename,unlink,unlinkat,renameat -F auid>=1000 F auid!=-1 -F key=delete
-a always,exit -F arch=b32 -S unlink,rename,unlinkat,renameat -F auid>=1000 F auid!=-1 -F key=delete"
    local RISK="Unknown"
    local DESC="Monitor the use of system calls associated with the deletion or renaming of files and file
attributes. This configuration statement sets up monitoring for:
•
•
•
•
unlink - remove a file
unlinkat - remove a file attribute
rename - rename a file
renameat rename a file attribute
system calls and tags them with the identifier \"delete\".

Rationale:
Monitoring these calls from non-privileged users could provide a system administrator
with evidence that inappropriate removal of files and file attributes associated with
protected files is occurring. While this audit option will look at all events, system
administrators will want to look for specific privileged files that are being deleted or
altered."
    local ATTACK=""
    local REMEDIATION="Create audit rules
Edit or create a file in the /etc/audit/rules.d/ directory, ending in .rules extension,
with the relevant rules to monitor file deletion events by users.
Example:
# {
UID_MIN=\$(awk '/^\s*UID_MIN/{print \$2}' /etc/login.defs)
[ -n \"\${UID_MIN}\" ] && printf \"
-a always,exit -F arch=b64 -S rename,unlink,unlinkat,renameat -F
auid>=\${UID_MIN} -F auid!=unset -F key=delete
-a always,exit -F arch=b32 -S rename,unlink,unlinkat,renameat -F
auid>=\${UID_MIN} -F auid!=unset -F key=delete
\" >> /etc/audit/rules.d/50-delete.rules || printf \"ERROR: Variable 'UID_MIN'
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
