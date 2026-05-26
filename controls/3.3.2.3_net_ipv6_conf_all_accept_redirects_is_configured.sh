#!/usr/bin/env bash
# controls/3.3.2.3_net_ipv6_conf_all_accept_redirects_is_configured.sh

execute_control() {
    local CONTROL_ID="3.3.2.3"
    local TITLE="Ensure net.ipv6.conf.all.accept_redirects is configured ((Automated)"
    local EXPECTED="- IF IPv6 is enabled on the system Verify net.ipv6.conf.all.accept_redirects is set to 0.
1. Run the following command to verify net.ipv6.conf.all.accept_redirects
is set to 0 in the running configuration:
# sysctl net.ipv6.conf.all.accept_redirects
Verify output is:
net.ipv6.conf.all.accept_redirects = 0
2. Run the following script to verify net.ipv6.conf.all.accept_redirects = 0
is set in a file being used by systemd sysctl to configure
net.ipv6.conf.all.accept_redirects:
#!/usr/bin/env bash
{
l_parameter_name=\"net.ipv6.conf.all.accept_redirects\"
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
- \"net.ipv6.conf.all.accept_redirects = 0\" is set in: \"/etc/sysctl.d/60ipv6_sysctl.conf\"
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
    local DESC="ICMP redirect messages are packets that convey routing information and tell your host
(acting as a router) to send packets via an alternate path. It is a way of allowing an
outside routing device to update your system routing tables.
net.ipv6.conf.all.accept_redirects controls accepting of all IPv6 ICMP
redirected packets on all interfaces.
Note: If IPv6 has been disabled, or this system is a router, this recommendation is
not applicable.

Rationale:
ICMP redirect messages are packets that convey routing information and tell your host
(acting as a router) to send packets via an alternate path. It is a way of allowing an
outside routing device to update your system routing tables.
By setting net.ipv6.conf.all.accept_redirects to 0, the system will not accept
any IPv6 ICMP redirect messages, and therefore, won't allow outsiders to update the
system's routing tables."
    local ATTACK=""
    local REMEDIATION="1. Review all files being used by systemd sysctl and comment out or remove all
net.ipv6.conf.all.accept_redirects lines that are not
net.ipv6.conf.all.accept_redirects=0.
Example script:
#!/usr/bin/env bash
{
l_option=\"net.ipv6.conf.all.accept_redirects\" l_value=\"0\"
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
sed -ri '/^\s*'\"\$l_grep\"'\s*=\s*(1[0-9]*)/s/^/# /' \"\$l_file\"
done
}
2. Create or edit a file in the /etc/sysctl.d/ directory ending in .confand edit or
add the following line:
net.ipv6.conf.all.accept_redirects = 0
Example:
# [ ! -d \"/etc/sysctl.d/\" ] && mkdir -p /etc/sysctl.d/
# printf '%s\n' \"\" \"net.ipv6.conf.all.accept_redirects = 0\" \
>> /etc/sysctl.d/60-ipv6_sysctl.conf
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
