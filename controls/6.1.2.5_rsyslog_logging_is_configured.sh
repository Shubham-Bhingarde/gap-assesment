#!/usr/bin/env bash
# controls/6.1.2.5_rsyslog_logging_is_configured.sh

execute_control() {
    local CONTROL_ID="6.1.2.5"
    local TITLE="Ensure rsyslog logging is configured ((Manual)"
    local EXPECTED="Review the contents of /etc/rsyslog.conf and /etc/rsyslog.d/*.conf files to
ensure appropriate logging is set. In addition, run the following command and verify that
the log files are logging information as expected:
# ls -l /var/log/"
    local RISK="Unknown"
    local DESC="The /etc/rsyslog.conf and /etc/rsyslog.d/*.conf files specifies rules for logging
and which files are to be used to log certain classes of messages.

Rationale:
A great deal of important security-related information is sent via rsyslog (e.g.,
successful and failed su attempts, failed login attempts, root login attempts, etc.)."
    local ATTACK=""
    local REMEDIATION="Edit the following lines in the /etc/rsyslog.conf and /etc/rsyslog.d/*.conf files
as appropriate for your environment.
Note: The below configuration is shown for example purposes only. Due care should be
given to how the organization wishes to store log data.
*.emerg
auth,authpriv.*
mail.*
mail.info
mail.warning
mail.err
cron.*
*.=warning;*.=err
*.crit
*.*;mail.none;news.none
local0,local1.*
local2,local3.*
local4,local5.*
local6,local7.*
:omusrmsg:*
/var/log/secure
-/var/log/mail
-/var/log/mail.info
-/var/log/mail.warn
/var/log/mail.err
/var/log/cron
-/var/log/warn
/var/log/warn
-/var/log/messages
-/var/log/localmessages
-/var/log/localmessages
-/var/log/localmessages
-/var/log/localmessages
Run the following command to reload the rsyslogd configuration:
# systemctl restart rsyslog"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
