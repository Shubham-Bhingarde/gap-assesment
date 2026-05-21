#!/usr/bin/env bash
# controls/6.1.1.1.5_journald_storage_is_configured.sh

execute_control() {
    local CONTROL_ID="6.1.1.1.5"
    local TITLE="Ensure journald Storage is configured ((Automated)"
    local EXPECTED="Run the following script to verify Storage is set to persistent:
#!/usr/bin/env bash
{
l_analyze_cmd=\"\$(readlink -e /bin/systemd-analyze || \
readlink -e /usr/bin/systemd-analyze)\"
l_conf_file=\"systemd/journald.conf\" l_block=\"Journal\"
l_option=\"Storage\" l_option_value=\"persistent\" a_output=()
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
l_file=\"\$(readlink -e /etc/\"\$l_conf_file\" || \
readlink -e /usr/lib/\"\$l_conf_file\")\"
l_opt=\"\$(awk '/\['\"\$l_block\"'\]/{a=1;next}/\[/{a=0}a' \"\$l_file\" \
2>/dev/null | grep -Poim 1 '^(\h*#)?\h*'\"\$l_option\"'\h*=\h*\H+\b')\"
l_option_value=\"\$(cut -d= -f2 <<< \"\${l_opt//# /}\" | xargs)\"
[ -n \"\$l_option_value\" ] && \
a_output+=(\" - The default value: \\"\${l_opt//#/}\\"\" \
\"
is being used in the configuration\")
fi
[ \"\${#a_output[@]}\" -gt \"0\" ] && printf '%s\n' \"\" \"\${a_output[@]}\" \"\"
}"
    local RISK="Unknown"
    local DESC="Data from journald may be stored in volatile memory or persisted locally on the server.
Logs in memory will be lost upon a system reboot. By persisting logs to local disk on the
server they are protected from loss due to a reboot.

Rationale:
Writing log data to disk will provide the ability to forensically reconstruct events which
may have impacted the operations or security of a system even after a system crash or
reboot."
    local ATTACK=""
    local REMEDIATION="Set the following parameter in the [Journal] section in
/etc/systemd/journald.conf or a file in /etc/systemd/journald.conf.d/ ending
in .conf:
Storage=persistent
Example:
#!/usr/bin/env bash
{
[ ! -d /etc/systemd/journald.conf.d/ ] && mkdir -p
/etc/systemd/journald.conf.d/
if grep -Psq -- '^\h*\[Journal\]' /etc/systemd/journald.conf.d/60journald.conf; then
printf '%s\n' \"Storage=persistent\" >> /etc/systemd/journald.conf.d/60journald.conf
else
printf '%s\n' \"\" \"[Journal]\" \"Storage=persistent\" >>
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
# systemctl reload-or-restart systemd-journald"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
