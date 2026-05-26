#!/usr/bin/env bash
# controls/3.3.1.17_net_ipv4_conf_default_log_martians_is_configured.sh

execute_control() {
    local CONTROL_ID="3.3.1.17"
    local TITLE="Ensure net.ipv4.conf.default.log_martians is configured ((Automated)"
    local EXPECTED="Verify net.ipv4.conf.default.log_martians is set to 1.
1. Run the following command to verify net.ipv4.conf.default.log_martians
is set to 1 in the running configuration:
# sysctl net.ipv4.conf.default.log_martians
Verify output is:
net.ipv4.conf.default.log_martians = 1
2. Run the following script to verify net.ipv4.conf.default.log_martians = 1
is set in a file being used by systemd sysctl to configure
net.ipv4.conf.default.log_martians:
#!/usr/bin/env bash
{
l_parameter_name=\"net.ipv4.conf.default.log_martians\"
l_grep=\"\${l_parameter_name//./(\\.|\\/)}\" a_output=() a_files=()
l_systemdsysctl=\"\$(readlink -e /lib/systemd/systemd-sysctl \
|| readlink -e /usr/lib/systemd/systemd-sysctl)\"
l_ufw_file=\"\$([ -f /etc/default/ufw ] && \
awk -F= '/^\s*IPT_SYSCTL=/ {print \$2}' /etc/default/ufw)\"
[ -f \"\$(readlink -e \"\$l_ufw_file\")\" ] && \
a_files+=(\"\$l_ufw_file\"); a_files+=(\"/etc/sysctl.conf\")
while IFS= read -r l_fname; do
l_file=\"\$(readlink -e \"\${l_fname//# /}\")\"
[ -n \"\$l_file\" ] && ! grep -Psiq -- '(^|\h+)'\"\$l_file\"'\b' \
<<< \"\${a_files[*]}\" && a_files+=(\"\$l_file\")
done < <(\"\$l_systemdsysctl\" --cat-config | tac | \
grep -Pio '^\h*#\h*\/[^#\n\r\h]+\.conf\b')
for l_file in \"\${a_files[@]}\"; do
l_opt=\"\$(grep -Poi '^\h*'\"\$l_grep\"'\h*=\h*\H+\b' \"\$l_file\" | tail -n
1)\"
l_option_value=\"\$(cut -d= -f2 <<< \"\$l_opt\" | xargs)\"
[ -n \"\$l_option_value\" ] && \
a_output+=(\" - \\\"\$l_parameter_name = \$l_option_value\\\" is set in:\" \
\"
\\\"\$l_file\\\"\")
done
[ \"\${#a_output[@]}\" -gt \"0\" ] && printf '%s\n' \"\" \"\${a_output[@]}\" \"\"
}
Example output:
- \"net.ipv4.conf.default.log_martians = 1\" is set in: \"/etc/sysctl.d/60ipv4_sysctl.conf\"
Note:
•
•
•
This script looks at all files used by systemd sysctl.
More information about these files and their location is available in the section
overview.
If multiple lines are returned:
o The first line includes the value being used by systemd sysctl. If this is a
correct value, this is considered a passing state. If the file listed is not in
the /etc/sysctl.d/ directory, it is highly recommended to follow the
remediation procedure to create a .conf file in the /etc/sysctl.d/
directory with the correct setting to prevent a potential change due to an
update to the system.
o Any files in the /etc/sysctl.d/ directory that include an incorrect value
should be modified to comment out or change the incorrect value to
minimize the potential of the incorrect value being used by systemd
sysctl due to system configuration changes.
•
SYSTEM FILE PRECEDENCE
o When using the --system option, sysctl will read files from directories in
the following list in given order from top to bottom. Once a file of a given
filename is loaded, any file of the same name in subsequent directories is
ignored.
/etc/sysctl.d/*.conf /run/sysctl.d/*.conf
/usr/local/lib/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf
/lib/sysctl.d/*.conf /etc/sysctl.conf
o
All configuration files are sorted in lexicographic order, regardless of the
directory they reside in. Configuration files can either be completely
replaced (by having a new configuration file with the same name in a
directory of higher priority) or partially replaced (by having a configuration
file that is ordered later)--"
    local RISK="Unknown"
    local DESC="When enabled, this feature logs packets with un-routable source addresses to the
kernel log.
net.ipv4.conf.default.log_martians controls if IPv4 packets with un-routable
source addresses on a newly added network interface is logged to the kernel log.

Rationale:
Setting net.ipv4.conf.default.log_martians to 1 enables this feature. Logging
these packets allows an administrator to investigate the possibility that an attacker is
sending spoofed packets to their system."
    local ATTACK=""
    local REMEDIATION="1. Review all files being used by systemd sysctl and comment out or remove all
net.ipv4.conf.default.log_martians lines that are not
net.ipv4.conf.default.log_martians=1.
Example script:
#!/usr/bin/env bash
{
l_option=\"net.ipv4.conf.default.log_martians\" l_value=\"1\"
l_grep=\"\${l_option//./(\\.|\\/)}\" a_files=()
l_systemdsysctl=\"\$(readlink -e /lib/systemd/systemd-sysctl \
|| readlink -e /usr/lib/systemd/systemd-sysctl)\"
l_ufw_file=\"\$([ -f /etc/default/ufw ] && \
awk -F= '/^\s*IPT_SYSCTL=/ {print \$2}' /etc/default/ufw)\"
[ -f \"\$(readlink -e \"\$l_ufw_file\")\" ] && \
a_files+=(\"\$l_ufw_file\"); a_files+=(\"/etc/sysctl.conf\")
while IFS= read -r l_fname; do
l_file=\"\$(readlink -e \"\${l_fname//# /}\")\"
[ -n \"\$l_file\" ] && ! grep -Psiq -- '(^|\h+)'\"\$l_file\"'\b' \
<<< \"\${a_files[*]}\" && a_files+=(\"\$l_file\")
done < <(\"\$l_systemdsysctl\" --cat-config | tac | \
grep -Pio -- '^\h*#\h*\/[^#\n\r\h]+\.conf\b')
for l_file in \"\${a_files[@]}\"; do
grep -Poi -- '\h*'\"\$l_grep\"'\h*=\h*\H+\b' \"\$l_file\" \
| grep -Pivq -- '^\h*'\"\$l_grep\"'\h*=\h*'\"\$l_value\"'\b' && \
sed -ri '/^\s*'\"\$l_grep\"'\s*=\s*(0|[2-9]|1[0-9]+)/s/^/# /' \"\$l_file\"
done
}
2. Create or edit a file in the /etc/sysctl.d/ directory ending in .confand edit or
add the following line:
net.ipv4.conf.default.log_martians = 1
Example:
# [ ! -d \"/etc/sysctl.d/\" ] && mkdir -p /etc/sysctl.d/
# printf '%s\n' \"\" \"net.ipv4.conf.default.log_martians = 1\" \
>> /etc/sysctl.d/60-ipv4_sysctl.conf
Note: If the UFW file was the first file listed in the audit, the entry will be commented out
as part of the first step, however updating Uncomplicated Firewall (UFW) may update
this change. In this case the updated entry will supersede the entry being created as
part of this step.
3. Run the following command to load all sysctl configuration filles:
# sysctl --system"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
