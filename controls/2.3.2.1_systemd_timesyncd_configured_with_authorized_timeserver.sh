#!/usr/bin/env bash
# controls/2.3.2.1_systemd_timesyncd_configured_with_authorized_timeserver.sh

execute_control() {
    local CONTROL_ID="2.3.2.1"
    local TITLE="Ensure systemd-timesyncd configured with authorized timeserver ((Automated)"
    local EXPECTED="Run the following command to verify the NTP and/or FallbackNTP option is set to local
site approved authoritative time server(s):
#!/usr/bin/env bash
{
a_output=() a_output2=() a_output3=() a_out=() a_out2=() a_parlist=(\"NTP=[^#\n\r]+\"
\"FallbackNTP=[^#\n\r]+\")
l_analyze_cmd=\"\$(readlink -f /bin/systemd-analyze)\"
l_systemd_config_file=\"/etc/systemd/timesyncd.conf\"
f_config_file_parameter_chk()
{
l_used_parameter_setting=\"\"
while IFS= read -r l_file; do
l_file=\"\$(tr -d '# ' <<< \"\$l_file\")\"
l_used_parameter_setting=\"\$(grep -PHs -- '^\h*'\"\$l_parameter_name\"'\b' \"\$l_file\" | tail
-n 1)\"
[ -n \"\$l_used_parameter_setting\" ] && break
done < <(\$l_analyze_cmd cat-config \"\$l_systemd_config_file\" | tac | grep -Pio
'^\h*#\h*\/[^#\n\r\h]+\.conf\b')
if [ -n \"\$l_used_parameter_setting\" ]; then
while IFS=: read -r l_file_name l_file_parameter; do
while IFS=\"=\" read -r l_file_parameter_name l_file_parameter_value; do
if grep -Pq -- \"\$l_parameter_value\" <<< \"\$l_file_parameter_value\"; then
a_out+=(\" - Parameter: \\\"\${l_file_parameter_name// /}\\\"\" \
\"
correctly set to: \\\"\${l_file_parameter_value// /}\\\"\" \
\"
in the file: \\\"\$l_file_name\\\"\")
else
a_out2+=(\" - Parameter: \\\"\${l_file_parameter_name// /}\\\"\" \
\"
incorrectly set to: \\\"\${l_file_parameter_value// /}\\\"\" \
\"
in the file: \\\"\$l_file_name\\\"\" \
\"
Should be set to: \\\"\$l_value_out\\\"\")
fi
done <<< \"\$l_file_parameter\"
done <<< \"\$l_used_parameter_setting\"
else
a_out2+=(\" - Parameter: \\\"\$l_parameter_name\\\" is not set in an included file\" \
\"
*** Note: \\\"\$l_parameter_name\\\" May be set in a file that's ignored by load
procedure ***\")
fi
}
while IFS=\"=\" read -r l_parameter_name l_parameter_value; do # Assess and check parameters
l_parameter_name=\"\${l_parameter_name// /}\"; l_parameter_value=\"\${l_parameter_value// /}\"
l_value_out=\"\${l_parameter_value//-/ through }\"; l_value_out=\"\${l_value_out//|/ or }\"
l_value_out=\"\$(tr -d '(){}' <<< \"\$l_value_out\")\"
f_config_file_parameter_chk
done < <(printf '%s\n' \"\${a_parlist[@]}\")
if [ \"\${#a_out[@]}\" -gt 0 ]; then
a_output+=(\"\${a_out[@]}\"); [ \"\${#a_out2[@]}\" -gt 0 ] && a_output3+=(\" ** INFO: **\"
\"\${a_out2[@]}\")
else
a_output2+=(\"\${a_out2[@]}\")
fi
if [ \"\${#a_output2[@]}\" -le 0 ]; then
printf '%s\n' \"\" \"- Audit Result:\" \" ** PASS **\" \"\${a_output[@]}\" \"\"
[ \"\${#a_output3[@]}\" -gt 0 ] && printf '%s\n' \"\${a_output3[@]}\"
else
printf '%s\n' \"\" \"- Audit Result:\" \" ** FAIL **\" \" - Reason(s) for audit failure:\"
\"\${a_output2[@]}\"
[ \"\${#a_output[@]}\" -gt 0 ] && printf '%s\n' \"\" \"- Correctly set:\" \"\${a_output[@]}\" \"\"
fi
}
Note: Please ensure the output for NTP and/or FallbackNTP is in accordance with local
site policy. The timeservers in the example output are provided as an example of
possible timeservers and they may not follow local site policy."
    local RISK="Unknown"
    local DESC="NTP=
•
A space-separated list of NTP server host names or IP addresses. During
runtime this list is combined with any per-interface NTP servers acquired from
systemd-networkd.service(8). systemd-timesyncd will contact all configured
system or per-interface servers in turn, until one responds. When the empty
string is assigned, the list of NTP servers is reset, and all prior assignments will
have no effect. This setting defaults to an empty list.
FallbackNTP=
•
A space-separated list of NTP server host names or IP addresses to be used as
the fallback NTP servers. Any per-interface NTP servers obtained from systemdnetworkd.service(8) take precedence over this setting, as do any servers set via
NTP= above. This setting is hence only relevant if no other NTP server
information is known. When the empty string is assigned, the list of NTP servers
is reset, and all prior assignments will have no effect. If this option is not given, a
compiled-in list of NTP servers is used.

Rationale:
Time synchronization is important to support time sensitive security mechanisms and to
ensure log files have consistent time records across the enterprise to aid in forensic
investigations"
    local ATTACK=""
    local REMEDIATION="Set NTP and/or FallbackNTP parameters to local site approved authoritative time
server(s) in /etc/systemd/timesyncd.conf or a file in
/etc/systemd/timesyncd.conf.d/ ending in .conf in the [Time] section:
Example file:
[Time]
NTP=time.nist.gov # Uses the generic name for NIST's time servers
FallbackNTP=time-a-g.nist.gov time-b-g.nist.gov time-c-g.nist.gov # Space
separated list of NIST time servers
Example script to create systemd drop-in configuration file:
#!/usr/bin/env bash
{
a_settings=(\"NTP=time.nist.gov\" \"FallbackNTP=time-a-g.nist.gov time-bg.nist.gov time-c-g.nist.gov\")
[ ! -d /etc/systemd/timesyncd.conf.d/ ] && mkdir
/etc/systemd/timesyncd.conf.d/
if grep -Psq -- '^\h*\[Time\]' /etc/systemd/timesyncd.conf.d/60timesyncd.conf; then
printf '%s\n' \"\" \"\${a_settings[@]}\" >>
/etc/systemd/timesyncd.conf.d/60-timesyncd.conf
else
printf '%s\n' \"\" \"[Time]\" \"\${a_settings[@]}\" >>
/etc/systemd/timesyncd.conf.d/60-timesyncd.conf
fi
}
Note: If this setting appears in a canonically later file, or later in the same file, the
setting will be overwritten
Run to following command to update the parameters in the service:
# systemctl reload-or-restart systemd-timesyncd"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
