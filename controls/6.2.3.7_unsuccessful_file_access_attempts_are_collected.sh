#!/usr/bin/env bash
# controls/6.2.3.7_unsuccessful_file_access_attempts_are_collected.sh

execute_control() {
    local CONTROL_ID="6.2.3.7"
    local TITLE="Ensure unsuccessful file access attempts are collected ((Automated)"
    local EXPECTED="On disk configuration
Run the following command to check the on disk rules:
# {
UID_MIN=\$(awk '/^\s*UID_MIN/{print \$2}' /etc/login.defs)
[ -n \"\${UID_MIN}\" ] && awk \"/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&/ -F *auid>=\${UID_MIN}/ \
&&(/ -F *exit=-EACCES/||/ -F *exit=-EPERM/) \
&&/ -S/ \
&&/creat/ \
&&/open/ \
&&/truncate/ \
&&(/ key= *[!-~]* *\$/||/ -k *[!-~]* *\$/)\" /etc/audit/rules.d/*.rules \
|| printf \"ERROR: Variable 'UID_MIN' is unset.\n\"
}
Verify the output includes:
-a always,exit -F arch=b64 -S creat,open,openat,truncate,ftruncate -F exit=EACCES -F auid>=1000 -F auid!=unset -k access
-a always,exit -F arch=b64 -S creat,open,openat,truncate,ftruncate -F exit=EPERM -F auid>=1000 -F auid!=unset -k access
-a always,exit -F arch=b32 -S creat,open,openat,truncate,ftruncate -F exit=EACCES -F auid>=1000 -F auid!=unset -k access
-a always,exit -F arch=b32 -S creat,open,openat,truncate,ftruncate -F exit=EPERM -F auid>=1000 -F auid!=unset -k access
Running configuration
Run the following command to check loaded rules:
# {
UID_MIN=\$(awk '/^\s*UID_MIN/{print \$2}' /etc/login.defs)
[ -n \"\${UID_MIN}\" ] && auditctl -l | awk \"/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&/ -F *auid>=\${UID_MIN}/ \
&&(/ -F *exit=-EACCES/||/ -F *exit=-EPERM/) \
&&/ -S/ \
&&/creat/ \
&&/open/ \
&&/truncate/ \
&&(/ key= *[!-~]* *\$/||/ -k *[!-~]* *\$/)\" \
|| printf \"ERROR: Variable 'UID_MIN' is unset.\n\"
}
Verify the output includes:
-a always,exit -F arch=b64 -S open,truncate,ftruncate,creat,openat -F exit=EACCES -F auid>=1000 -F auid!=-1 -F key=access
-a always,exit -F arch=b64 -S open,truncate,ftruncate,creat,openat -F exit=EPERM -F auid>=1000 -F auid!=-1 -F key=access
-a always,exit -F arch=b32 -S open,truncate,ftruncate,creat,openat -F exit=EACCES -F auid>=1000 -F auid!=-1 -F key=access
-a always,exit -F arch=b32 -S open,truncate,ftruncate,creat,openat -F exit=EPERM -F auid>=1000 -F auid!=-1 -F key=access"
    local RISK="Unknown"
    local DESC="Monitor for unsuccessful attempts to access files. The following parameters are
associated with system calls that control files:
•
•
•
creation - creat
opening - open , openat
truncation - truncate , ftruncate
An audit log record will only be written if all of the following criteria is met for the user
when trying to access a file:
•
•
•
a non-privileged user (auid>=UID_MIN)
is not a Daemon event (auid=4294967295/unset/-1)
if the system call returned EACCES (permission denied) or EPERM (some other
permanent error associated with the specific system call)

Rationale:
Failed attempts to open, create or truncate files could be an indication that an individual
or process is trying to gain unauthorized access to the system."
    local ATTACK=""
    local REMEDIATION="Create audit rules
Edit or create a file in the /etc/audit/rules.d/ directory, ending in .rules extension,
with the relevant rules to monitor unsuccessful file access attempts.
Example:
# {
UID_MIN=\$(awk '/^\s*UID_MIN/{print \$2}' /etc/login.defs)
[ -n \"\${UID_MIN}\" ] && printf \"
-a always,exit -F arch=b64 -S creat,open,openat,truncate,ftruncate -F exit=EACCES -F auid>=\${UID_MIN} -F auid!=unset -k access
-a always,exit -F arch=b64 -S creat,open,openat,truncate,ftruncate -F exit=EPERM -F auid>=\${UID_MIN} -F auid!=unset -k access
-a always,exit -F arch=b32 -S creat,open,openat,truncate,ftruncate -F exit=EACCES -F auid>=\${UID_MIN} -F auid!=unset -k access
-a always,exit -F arch=b32 -S creat,open,openat,truncate,ftruncate -F exit=EPERM -F auid>=\${UID_MIN} -F auid!=unset -k access
\" >> /etc/audit/rules.d/50-access.rules || printf \"ERROR: Variable 'UID_MIN'
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
