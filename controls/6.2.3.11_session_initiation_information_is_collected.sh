#!/usr/bin/env bash
# controls/6.2.3.11_session_initiation_information_is_collected.sh

execute_control() {
    local CONTROL_ID="6.2.3.11"
    local TITLE="Ensure session initiation information is collected ((Automated)"
    local EXPECTED="On disk configuration
Run the following command to check the on disk rules:
# awk '/^ *-w/ \
&&(/\/var\/run\/utmp/ \
||/\/var\/log\/wtmp/ \
||/\/var\/log\/btmp/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *\$/||/ -k *[!-~]* *\$/)' /etc/audit/rules.d/*.rules
Verify the output matches:
-w /var/run/utmp -p wa -k session
-w /var/log/wtmp -p wa -k session
-w /var/log/btmp -p wa -k session
Running configuration
Run the following command to check loaded rules:
# auditctl -l | awk '/^ *-w/ \
&&(/\/var\/run\/utmp/ \
||/\/var\/log\/wtmp/ \
||/\/var\/log\/btmp/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *\$/||/ -k *[!-~]* *\$/)'
Verify the output matches:
-w /var/run/utmp -p wa -k session
-w /var/log/wtmp -p wa -k session
-w /var/log/btmp -p wa -k session"
    local RISK="Unknown"
    local DESC="Monitor session initiation events. The parameters in this section track changes to the
files associated with session events.
•
•
•
/var/run/utmp - tracks all currently logged in users.
/var/log/wtmp - file tracks logins, logouts, shutdown, and reboot events.
/var/log/btmp - keeps track of failed login attempts and can be read by
entering the command /usr/bin/last -f /var/log/btmp.
All audit records will be tagged with the identifier \"session.\"

Rationale:
Monitoring these files for changes could alert a system administrator to logins occurring
at unusual hours, which could indicate intruder activity (i.e. a user logging in at a time
when they do not normally log in)."
    local ATTACK=""
    local REMEDIATION="Edit or create a file in the /etc/audit/rules.d/ directory, ending in .rules extension,
with the relevant rules to monitor session initiation information.
Example:
# printf \"
-w /var/run/utmp -p wa -k session
-w /var/log/wtmp -p wa -k session
-w /var/log/btmp -p wa -k session
\" >> /etc/audit/rules.d/50-session.rules
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
