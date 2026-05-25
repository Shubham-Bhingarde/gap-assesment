#!/usr/bin/env bash
# controls/6.1.2.3_journald_is_configured_to_send_logs_to_rsyslog.sh

execute_control() {
    local CONTROL_ID="6.1.2.3"
    local TITLE="Ensure journald is configured to send logs to rsyslog ((Automated)"
    local EXPECTED="- IF - rsyslog is the preferred method for capturing logs
Run the following script to verify that logs are forwarded to rsyslog by setting
ForwardToSyslog to yes in the systemd-journald configuration:
#!/usr/bin/env bash
{
l_analyze_cmd=\"\$(readlink -e /bin/systemd-analyze || \
readlink -e /usr/bin/systemd-analyze)\"
l_conf_file=\"systemd/journald.conf\" l_block=\"Journal\"
l_option=\"ForwardToSyslog\" l_option_value=\"yes\" a_output=()
while IFS= read -r l_file; do
l_file=\"\${l_file//# /}\"
l_opt=\"\$(awk '/\['\"\$l_block\"'\]/{a=1;next}/\[/{a=0}a' \"\$l_file\" \
2>/dev/null | grep -Poi '^\h*'\"\$l_option\"'\h*=\h*\H+\b' | tail -n 1)\"
l_option_value=\"\$(cut -d= -f2 <<< \"\$l_opt\" | xargs)\"
[ -n \"\$l_option_value\" ] && \
a_output+=(\" - \\"\$l_option\\" is set to: \\"\$l_option_value\\"\" \
\"
in: \\"\$l_file\\"\")
done < <(\"\$l_analyze_cmd\" cat-config \"\$l_conf_file\" | tac | \
grep -Pio '^\h*#\h*\/[^#\n\r\h]+\.conf\b')
if [ \"\${#a_output[@]}\" -le \"0\" ]; then
l_file=\"/etc/\$l_conf_file\"
l_opt=\"\$(awk '/\['\"\$l_block\"'\]/{a=1;next}/\[/{a=0}a' \"\$l_file\" \
2>/dev/null | grep -Poim 1 '^(\h*#)?\h*'\"\$l_option\"'\h*=\h*\H+\b')\"
l_option_value=\"\$(cut -d= -f2 <<< \"\${l_opt//# /}\" | xargs)\"
[ -n \"\$l_option_value\" ] && \
a_output+=(\" - The default value: \\"\${l_opt//#/}\\"\" \
\"
is being used in the configuration\")
fi
[ \"\${#a_output[@]}\" -gt \"0\" ] && printf '%s\n' \"\" \"\${a_output[@]}\" \"\"
}
Run the following command to verify systemd-journald.service and
rsyslog.service are loaded and active:
# systemctl list-units --type service | grep -P -- '(journald|rsyslog)'
Output should be similar to:
rsyslog.service
System Logging Service
systemd-journald.service
Journal Service
loaded active running
loaded active running"
    local RISK="Unknown"
    local DESC="Data from systemd-journald may be stored in volatile memory or persisted locally on
the server. Utilities exist to accept remote export of systemd-journald logs, however,
use of the rsyslog service provides a consistent means of log collection and export.

Rationale:
- IF - rsyslog is the preferred method for capturing logs, all logs of the system should
be sent to it for further processing.
Note: This recommendation only applies if rsyslog is the chosen method for client
side logging. Do not apply this recommendation if systemd-journald is used."
    local ATTACK=""
    local REMEDIATION="- IF - Journald is the preferred method for capturing logs, this section and
Recommendation should be skipped and the \"Configure Journald\" section followed.
- IF - rsyslog is the preferred method for capturing logs:
Set the following parameter in the [Journal] section in
/etc/systemd/journald.conf or a file in /etc/systemd/journald.conf.d/ ending
in .conf:
ForwardToSyslog=yes
Example:
#!/usr/bin/env bash
{
[ ! -d /etc/systemd/journald.conf.d/ ] && mkdir
/etc/systemd/journald.conf.d/
if grep -Psq -- '^\h*\[Journal\] /etc/systemd/journald.conf.d/60journald.conf; then
printf '%s\n' \"ForwardToSyslog=yes\" >> /etc/systemd/journald.conf.d/60journald.conf
else
printf '%s\n' \"[Journal]\" \"ForwardToSyslog=yes\" >>
/etc/systemd/journald.conf.d/60-journald.conf
fi
}
Note: Drop-in configuration files have higher precedence and override the main
configuration file. Files in the *.conf.d/ configuration subdirectories are sorted by their
filename in lexicographic order, regardless of in which of the subdirectories they reside.
When multiple files specify the same option, for options which accept just a single value,
the entry in the file sorted last takes precedence, and for options which accept a list of
values, entries are collected as they occur in the sorted files.
Run to following command to update the parameters in the service:
Restart systemd-journald.service:
# systemctl reload-or-restart systemd-journald.service"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
