#!/usr/bin/env bash
# controls/6.2.3.2_actions_as_another_user_are_always_logged.sh

execute_control() {
    local CONTROL_ID="6.2.3.2"
    local TITLE="Ensure actions as another user are always logged ((Automated)"
    local EXPECTED="On disk configuration
Run the following command to check the on disk rules:
# awk '/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&(/ -C *euid!=uid/||/ -C *uid!=euid/) \
&&/ -S *execve/ \
&&(/ key= *[!-~]* *\$/||/ -k *[!-~]* *\$/)' /etc/audit/rules.d/*.rules
Verify the output matches:
-a always,exit -F arch=b64 -C euid!=uid -F auid!=unset -S execve -k
user_emulation
-a always,exit -F arch=b32 -C euid!=uid -F auid!=unset -S execve -k
user_emulation
Running configuration
Run the following command to check loaded rules:
# auditctl -l | awk '/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&(/ -F *auid!=unset/||/ -F *auid!=-1/||/ -F *auid!=4294967295/) \
&&(/ -C *euid!=uid/||/ -C *uid!=euid/) \
&&/ -S *execve/ \
&&(/ key= *[!-~]* *\$/||/ -k *[!-~]* *\$/)'
Verify the output matches:
-a always,exit -F arch=b64 -S execve -C uid!=euid -F auid!=-1 -F
key=user_emulation
-a always,exit -F arch=b32 -S execve -C uid!=euid -F auid!=-1 -F
key=user_emulation"
    local RISK="Unknown"
    local DESC="sudo provides users with temporary elevated privileges to perform operations, either as
the superuser or another user.

Rationale:
Creating an audit log of users with temporary elevated privileges and the operation(s)
they performed is essential to reporting. Administrators will want to correlate the events
written to the audit trail with the records written to sudo's logfile to verify if unauthorized
commands have been executed."
    local ATTACK=""
    local REMEDIATION="Create audit rules
Edit or create a file in the /etc/audit/rules.d/ directory, ending in .rules extension,
with the relevant rules to monitor elevated privileges.
Example:
# printf \"
-a always,exit -F arch=b64 -C euid!=uid -F auid!=unset -S execve -k
user_emulation
-a always,exit -F arch=b32 -C euid!=uid -F auid!=unset -S execve -k
user_emulation
\" >> /etc/audit/rules.d/50-user_emulation.rules
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
