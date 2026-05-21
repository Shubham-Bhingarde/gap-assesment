#!/usr/bin/env bash
# controls/6.2.2.4_system_warns_when_audit_logs_are_low_on_space.sh

execute_control() {
    local CONTROL_ID="6.2.2.4"
    local TITLE="Ensure system warns when audit logs are low on space ((Automated)"
    local EXPECTED="Run the following command and verify the space_left_action is set to email, exec,
single, or halt:
grep -Pi -- '^\h*space_left_action\h*=\h*(email|exec|single|halt)\b'
/etc/audit/auditd.conf
Verify the output is email, exec, single, or halt
Example output
space_left_action = email
Run the following command and verify the admin_space_left_action is set to single
- OR - halt:
grep -Pi -- '^\h*admin_space_left_action\h*=\h*(single|halt)\b'
/etc/audit/auditd.conf
Verify the output is single or halt
Example output:
admin_space_left_action = single
Note: A Mail Transfer Agent (MTA) must be installed and configured properly to set
space_left_action = email"
    local RISK="Unknown"
    local DESC="The auditd daemon can be configured to halt the system, put the system in single user
mode or send a warning message, if the partition that holds the audit log files is low on
space.
The space_left_action parameter tells the system what action to take when the
system has detected that it is starting to get low on disk space. Valid values are ignore,
syslog, rotate, email, exec, suspend, single, and halt.
•
•
•
•
•
•
•
•
ignore, the audit daemon does nothing
syslog, the audit daemon will issue a warning to syslog
rotate, the audit daemon will rotate logs, losing the oldest to free up space
email, the audit daemon will send a warning to the email account specified in
action_mail_acct as well as sending the message to syslog
exec, /path-to-script will execute the script. You cannot pass parameters to the
script. The script is also responsible for telling the auditd daemon to resume
logging once its completed its action
suspend, the audit daemon will stop writing records to the disk
single, the audit daemon will put the computer system in single user mode
halt, the audit daemon will shut down the system
The admin_space_left_action parameter tells the system what action to take when
the system has detected that it is low on disk space. Valid values are ignore, syslog,
rotate, email, exec, suspend, single, and halt.
•
•
•
•
•
•
•
•
ignore, the audit daemon does nothing
syslog, the audit daemon will issue a warning to syslog
rotate, the audit daemon will rotate logs, losing the oldest to free up space
email, the audit daemon will send a warning to the email account specified in
action_mail_acct as well as sending the message to syslog
exec, /path-to-script will execute the script. You cannot pass parameters to the
script. The script is also responsible for telling the auditd daemon to resume
logging once its completed its action
suspend, the audit daemon will stop writing records to the disk
single, the audit daemon will put the computer system in single user mode
halt, the audit daemon will shut down the system

Rationale:
In high security contexts, the risk of detecting unauthorized access or nonrepudiation
exceeds the benefit of the system's availability."
    local ATTACK="If the admin_space_left_action is set to single the audit daemon will put the
computer system in single user mode."
    local REMEDIATION="Set the space_left_action parameter in /etc/audit/auditd.conf to email, exec,
single, or halt:
Example:
space_left_action = email
Set the admin_space_left_action parameter in /etc/audit/auditd.conf to
single or halt:
Example:
admin_space_left_action = single
Note: A Mail Transfer Agent (MTA) must be installed and configured properly to set
space_left_action = email"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
