#!/usr/bin/env bash
# controls/6.2.3.4_events_that_modify_date_and_time_information_are_collected.sh

execute_control() {
    local CONTROL_ID="6.2.3.4"
    local TITLE="Ensure events that modify date and time information are collected ((Automated)"
    local EXPECTED="On disk configuration
Run the following command to check the on disk rules:
# {
awk '/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&/ -S/ \
&&(/adjtimex/ \
||/settimeofday/ \
||/clock_settime/ ) \
&&(/ key= *[!-~]* *\$/||/ -k *[!-~]* *\$/)' /etc/audit/rules.d/*.rules
awk '/^ *-w/ \
&&/\/etc\/localtime/ \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *\$/||/ -k *[!-~]* *\$/)' /etc/audit/rules.d/*.rules
}
Verify output of matches:
-a always,exit -F arch=b64 -S adjtimex,settimeofday -k time-change
-a always,exit -F arch=b32 -S adjtimex,settimeofday -k time-change
-a always,exit -F arch=b64 -S clock_settime -F a0=0x0 -k time-change
-a always,exit -F arch=b32 -S clock_settime -F a0=0x0 -k time-change
-w /etc/localtime -p wa -k time-change
Running configuration
Run the following command to check loaded rules:
# {
auditctl -l | awk '/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&/ -S/ \
&&(/adjtimex/ \
||/settimeofday/ \
||/clock_settime/ ) \
&&(/ key= *[!-~]* *\$/||/ -k *[!-~]* *\$/)'
auditctl -l | awk '/^ *-w/ \
&&/\/etc\/localtime/ \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *\$/||/ -k *[!-~]* *\$/)'
}
Verify the output includes:
-a always,exit -F arch=b64 -S adjtimex,settimeofday -F key=time-change
-a always,exit -F arch=b32 -S settimeofday,adjtimex -F key=time-change
-a always,exit -F arch=b64 -S clock_settime -F a0=0x0 -F key=time-change
-a always,exit -F arch=b32 -S clock_settime -F a0=0x0 -F key=time-change
-w /etc/localtime -p wa -k time-change"
    local RISK="Unknown"
    local DESC="Capture events where the system date and/or time has been modified. The parameters
in this section are set to determine if the;
•
•
•
•
adjtimex - tune kernel clock
settimeofday - set time using timeval and timezone structures
stime - using seconds since 1/1/1970
clock_settime - allows for the setting of several internal clocks and timers
system calls have been executed. Further, ensure to write an audit record to the
configured audit log file upon exit, tagging the records with a unique identifier such as
\"time-change\".

Rationale:
Unexpected changes in system date and/or time could be a sign of malicious activity on
the system."
    local ATTACK=""
    local REMEDIATION="Create audit rules
Edit or create a file in the /etc/audit/rules.d/ directory, ending in .rules extension,
with the relevant rules to monitor events that modify date and time information.
Example:
# printf \"
-a always,exit -F arch=b64 -S adjtimex,settimeofday -k time-change
-a always,exit -F arch=b32 -S adjtimex,settimeofday -k time-change
-a always,exit -F arch=b64 -S clock_settime -F a0=0x0 -k time-change
-a always,exit -F arch=b32 -S clock_settime -F a0=0x0 -k time-change
-w /etc/localtime -p wa -k time-change
\" >> /etc/audit/rules.d/50-time-change.rules
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
