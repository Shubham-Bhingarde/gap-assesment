#!/usr/bin/env bash
# controls/6.1.2.4_rsyslog_log_file_creation_mode_is_configured.sh

execute_control() {
    local CONTROL_ID="6.1.2.4"
    local TITLE="Ensure rsyslog log file creation mode is configured ((Automated)"
    local EXPECTED="Run the following command
Run the following command to verify \$FileCreateMode:
# grep -Ps '^\h*\$FileCreateMode\h+0[0,2,4,6][0,2,4]0\b' /etc/rsyslog.conf
/etc/rsyslog.d/*.conf
Verify the output is includes 0640 or more restrictive:
\$FileCreateMode 0640
Should a site policy dictate less restrictive permissions, ensure to follow said policy.
NOTE: More restrictive permissions such as 0600 is implicitly sufficient."
    local RISK="Unknown"
    local DESC="rsyslog will create logfiles that do not already exist on the system.
The global() configuration object umask, available in rsyslog 8.26.0+, sets the
rsyslogd process’ umask. If not specified, the system-provided default is used. The
value given must always be a 4-digit octal number, with the initial digit being zero.
The legacy \$umask parameter sets the rsyslogd process' umask. If not specified, the
system-provided default is used. The value given must always be a 4-digit octal
number, with the initial digit being zero.
The legacy \$FileCreateMode parameter allows the setting of the mode with which
rsyslogd creates new files. If not specified, the value 0644 is used. The value given
must always be a 4-digit octal number, with the initial digit being zero. Please note that
the actual permission depend on rsyslogd process umask. If in doubt, use \$umask
0000 right at the beginning of the configuration file to remove any restrictions.
The legacy \$FileCreateMode may be specified multiple times. If so, it specifies the
creation mode for all selector lines that follow until the next \$FileCreateMode
parameter. Order of lines is vitally important.

Rationale:
It is important to ensure that log files have the correct permissions to ensure that
sensitive data is archived and protected."
    local ATTACK=""
    local REMEDIATION="Edit either /etc/rsyslog.conf or a dedicated .conf file in /etc/rsyslog.d/ and set
\$FileCreateMode to 0640 or more restrictive:
\$FileCreateMode 0640
Restart the service:
# systemctl restart rsyslog"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
