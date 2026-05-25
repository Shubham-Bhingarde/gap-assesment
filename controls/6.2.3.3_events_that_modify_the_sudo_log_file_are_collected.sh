#!/usr/bin/env bash
# controls/6.2.3.3_events_that_modify_the_sudo_log_file_are_collected.sh

execute_control() {
    local CONTROL_ID="6.2.3.3"
    local TITLE="Ensure events that modify the sudo log file are collected ((Automated)"
    local EXPECTED="Note: This recommendation requires that the sudo logfile is configured. See guidance
provided in the recommendation \"Ensure sudo log file exists\"
On disk configuration
Run the following command to check the on disk rules:
# {
SUDO_LOG_FILE=\$(grep -r logfile /etc/sudoers* | sed -e 's/.*logfile=//;s/,?
.*//' -e 's/\"//g' -e 's|/|\\/|g')
[ -n \"\${SUDO_LOG_FILE}\" ] && awk \"/^ *-w/ \
&&/\"\${SUDO_LOG_FILE}\"/ \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *\$/||/ -k *[!-~]* *\$/)\" /etc/audit/rules.d/*.rules \
|| printf \"ERROR: Variable 'SUDO_LOG_FILE' is unset.\n\"
}
Verify output of matches:
-w /var/log/sudo.log -p wa -k sudo_log_file
Running configuration
Run the following command to check loaded rules:
# {
SUDO_LOG_FILE=\$(grep -r logfile /etc/sudoers* | sed -e 's/.*logfile=//;s/,?
.*//' -e 's/\"//g' -e 's|/|\\/|g')
[ -n \"\${SUDO_LOG_FILE}\" ] && auditctl -l | awk \"/^ *-w/ \
&&/\"\${SUDO_LOG_FILE}\"/ \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *\$/||/ -k *[!-~]* *\$/)\" \
|| printf \"ERROR: Variable 'SUDO_LOG_FILE' is unset.\n\"
}
Verify output matches:
-w /var/log/sudo.log -p wa -k sudo_log_file"
    local RISK="Unknown"
    local DESC="Monitor the sudo log file. If the system has been properly configured to disable the use
of the su command and force all administrators to have to log in first and then use sudo
to execute privileged commands, then all administrator commands will be logged to
/var/log/sudo.log . Any time a command is executed, an audit event will be
triggered as the /var/log/sudo.log file will be opened for write and the executed
administration command will be written to the log.

Rationale:
Changes in /var/log/sudo.log indicate that an administrator has executed a
command or the log file itself has been tampered with. Administrators will want to
correlate the events written to the audit trail with the records written to
/var/log/sudo.log to verify if unauthorized commands have been executed."
    local ATTACK=""
    local REMEDIATION="Note: This recommendation requires that the sudo logfile is configured. See guidance
provided in the recommendation \"Ensure sudo log file exists\"
Edit or create a file in the /etc/audit/rules.d/ directory, ending in .rules extension,
with the relevant rules to monitor events that modify the sudo log file.
Example:
# {
SUDO_LOG_FILE=\$(grep -r logfile /etc/sudoers* | sed -e 's/.*logfile=//;s/,?
.*//' -e 's/\"//g')
[ -n \"\${SUDO_LOG_FILE}\" ] && printf \"
-w \${SUDO_LOG_FILE} -p wa -k sudo_log_file
\" >> /etc/audit/rules.d/50-sudo.rules || printf \"ERROR: Variable
'SUDO_LOG_FILE' is unset.\n\"
}
Merge and load the rules into active configuration:
# augenrules --load
Check if reboot is required.
# if [[ \$(auditctl -s | grep \"enabled\") =~ \"2\" ]]; then printf \"Reboot
required to load rules\n\"; fi
Additional Information:
Potential reboot required
If the auditing configuration is locked (-e 2), then augenrules will not warn in any way
that rules could not be loaded into the running configuration. A system reboot will be
required to load the rules into the running configuration.
System call structure
For performance (man 7 audit.rules) reasons it is preferable to have all the system
calls on one line. However, your configuration may have them on one line each or some
other combination. This is important to understand for both the auditing and remediation
sections as the examples given are optimized for performance as per the man page."

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
