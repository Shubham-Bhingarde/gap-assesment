#!/usr/bin/env bash
# controls/1.5.1_randomize_va_space_is_configured.sh

execute_control() {
    local CONTROL_ID="1.5.1"
    local TITLE="Ensure randomize_va_space is configured ((Automated)"
    local EXPECTED="Verify kernel.randomize_va_space is set to 2.
1. Run the following command to verify kernel.randomize_va_space is set to 2 in
the running configuration:
# sysctl kernel.randomize_va_space
Verify output is:
kernel.randomize_va_space = 2\`
2. Run the following script to verify kernel.randomize_va_space is set to 2 in a
sysctl conf file being used by systemd sysctl:
#!/usr/bin/env bash
{
l_parameter_name=\"kernel.randomize_va_space\"
l_grep=\"\${l_parameter_name//./\\.}\" a_output=()
l_systemdsysctl=\"\$(readlink -e /lib/systemd/systemd-sysctl || readlink -e
/usr/lib/systemd/systemd-sysctl)\"
l_ufwscf=\"\$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print
\$2}' /etc/default/ufw)\"
l_opt=\"\$(grep -Psoi '^\h*'\"\$l_grep\"'\h*=\h*\H+\b' \"\$l_ufwscf\" | tail -n
1)\"
l_option_value=\"\$(cut -d= -f2 <<< \"\$l_opt\" | xargs)\"
[ -n \"\$l_option_value\" ] && a_output+=(\" - UFW set: \\"\$l_parameter_name\\"
to: \\"\$l_option_value\\" in: \\"\$l_file\\"\")
while IFS= read -r l_file; do
l_file=\"\${l_file//# /}\"
l_opt=\"\$(grep -Poi '^\h*'\"\$l_grep\"'\h*=\h*\H+\b' \"\$l_file\" | tail -n
1)\"
l_option_value=\"\$(cut -d= -f2 <<< \"\$l_opt\" | xargs)\"
[ -n \"\$l_option_value\" ] && a_output+=(\" - \\"\$l_parameter_name\\" is set
to: \\"\$l_option_value\\" in: \\"\$l_file\\"\")
done < <(\"\$l_systemdsysctl\" --cat-config | tac | grep -Pio
'^\h*#\h*\/[^#\n\r\h]+\.conf\b')
[ \"\${#a_output[@]}\" -gt \"0\" ] && printf '%s\n' \"\" \"\${a_output[@]}\" \"\"
}
Example output:
- \"kernel.randomize_va_space\" is set to: \"2\" in: \"/etc/sysctl.d/60kernel_sysctl.conf\"
Note:
•
•
If the UFW set value is displayed, and is the correct value, this is considered a
passing state. If this value is incorrect, it must be updated in the file shown in the
audit script output.
If multiple lines are returned:
o The first line includes the value being used by systemd sysctl. If this is a
correct value, this is considered a passing state. If the file listed is not in
the /etc/sysctl.d/ directory, it is highly recommended to follow the
remediation procedure to create a .conf file in the /etc/sysctl.d/
directory with the correct setting to prevent a potential change due to an
update to the system.
o Any files in the /etc/sysctl.d/ directory that include an incorrect value
should be modified to correct or comment out the incorrect value to
minimize the potential of the incorrect value being used by systemd
sysctl do to system configuration changes."
    local RISK="Unknown"
    local DESC="Address space layout randomization (ASLR) is an exploit mitigation technique which
randomly arranges the address space of key data areas of a process.

Rationale:
Randomly placing virtual memory regions will make it difficult to write memory page
exploits as the memory placement will be consistently shifting."
    local ATTACK=""
    local REMEDIATION="1. Review all files ending in .conf in the /etc/sysctl.d directory and comment
out or remove all kernel.randomize_va_space lines that are not
kernel.randomize_va_spacee=2.
Example script:
#!/usr/bin/env bash
{
l_option=\"kernel.randomize_va_space\" l_grep=\"\${l_option//./\\.}\"
l_value=\"2\"
while IFS= read -r -d \$'\0' l_file; do
grep -Poi '\h*'\"\$l_option\"'\h*=\h*\H+\b' \"\$l_file\" \
| grep -Pivq '^\h*'\"\$l_grep\"'\h*=\h*'\"\$l_value\"'\b' && \
sed -ri '/^\s*kernel.yama.ptrace_scope\s*=/s/^/# /' \"\$l_file\"
done < <(find /etc/sysctl.d/ -type f -name '*.conf' -print0)
}
2. Create or edit a file in the /etc/sysctl.d/ directory ending in .confand edit or
add the following line:
kernel.randomize_va_space = 2
Example:
# [ ! -d \"/etc/sysctl.d/\" ] && mkdir -p /etc/sysctl.d/
# printf '%s\n' \"\" \"kernel.randomize_va_space = 2\" >> /etc/sysctl.d/60kernel_sysctl.conf
3. Run the following command to load all system configuration filles:
# sysctl --system"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
