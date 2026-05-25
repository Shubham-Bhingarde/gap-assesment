#!/usr/bin/env bash
# controls/6.2.3.12_login_and_logout_events_are_collected.sh

execute_control() {
    local CONTROL_ID="6.2.3.12"
    local TITLE="Ensure login and logout events are collected ((Automated)"
    local EXPECTED="On disk configuration
Run the following command to check the on disk rules:
# awk '/^ *-w/ \
&&(/\/var\/log\/lastlog/ \
||/\/var\/run\/faillock/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *\$/||/ -k *[!-~]* *\$/)' /etc/audit/rules.d/*.rules
Verify the output matches:
-w /var/log/lastlog -p wa -k logins
-w /var/run/faillock -p wa -k logins
Running configuration
Run the following command to check loaded rules:
# auditctl -l | awk '/^ *-w/ \
&&(/\/var\/log\/lastlog/ \
||/\/var\/run\/faillock/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *\$/||/ -k *[!-~]* *\$/)'
Verify the output matches:
-w /var/log/lastlog -p wa -k logins
-w /var/run/faillock -p wa -k logins"
    local RISK="Unknown"
    local DESC="Monitor login and logout events. The parameters below track changes to files
associated with login/logout events.
•
•
/var/log/lastlog - maintain records of the last time a user successfully logged
in.
/var/run/faillock - directory maintains records of login failures via the
pam_faillock module.

Rationale:
Monitoring login/logout events could provide a system administrator with information
associated with brute force attacks against user logins."
    local ATTACK=""
    local REMEDIATION="Edit or create a file in the /etc/audit/rules.d/ directory, ending in .rules extension,
with the relevant rules to monitor login and logout events.
Example:
# printf \"
-w /var/log/lastlog -p wa -k logins
-w /var/run/faillock -p wa -k logins
\" >> /etc/audit/rules.d/50-login.rules
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
