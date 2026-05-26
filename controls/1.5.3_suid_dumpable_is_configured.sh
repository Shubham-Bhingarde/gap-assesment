#!/usr/bin/env bash
# controls/1.5.3_suid_dumpable_is_configured.sh

execute_control() {
    local CONTROL_ID="1.5.3"
    local TITLE="Ensure suid_dumpable is configured ((Automated)"
    local EXPECTED="1. Run the following script to verify fs.suid_dumpable is set to 0 in the running
configuration:
# sysctl fs.suid_dumpable
Verify output is:
fs.suid_dumpable = 0
2. Run the following script to verify fs.suid_dumpable is set to 0 in a sysctl conf
file being used by systemd sysctl:
#!/usr/bin/env bash
{
l_parameter_name=\"fs.suid_dumpable\" l_grep=\"\${l_parameter_name//./\\.}\"
a_output=()
l_systemdsysctl=\"\$(readlink -e /lib/systemd/systemd-sysctl || readlink -e
/usr/lib/systemd/systemd-sysctl)\"
l_ufwscf=\"\$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print
\$2}' /etc/default/ufw)\"
l_opt=\"\$(grep -Psoi '^\h*'\"\$l_grep\"'\h*=\h*\H+\b' \"\$l_ufwscf\" | tail -n
1)\"
l_option_value=\"\$(cut -d= -f2 <<< \"\$l_opt\" | xargs)\"
[ -n \"\$l_option_value\" ] && a_output+=(\" - UFW set: \\\"\$l_parameter_name\\\"
to: \\\"\$l_option_value\\\" in: \\\"\$l_file\\\"\")
while IFS= read -r l_file; do
l_file=\"\${l_file//# /}\"
l_opt=\"\$(grep -Poi '^\h*'\"\$l_grep\"'\h*=\h*\H+\b' \"\$l_file\" | tail -n
1)\"
l_option_value=\"\$(cut -d= -f2 <<< \"\$l_opt\" | xargs)\"
[ -n \"\$l_option_value\" ] && a_output+=(\" - \\\"\$l_parameter_name\\\" is set
to: \\\"\$l_option_value\\\" in: \\\"\$l_file\\\"\")
done < <(\"\$l_systemdsysctl\" --cat-config | tac | grep -Pio
'^\h*#\h*\/[^#\n\r\h]+\.conf\b')
[ \"\${#a_output[@]}\" -gt \"0\" ] && printf '%s\n' \"\" \"\${a_output[@]}\" \"\"
}
Example output:
- \"fs.suid_dumpable\" is set to: \"0\" in: \"/etc/sysctl.d/60kernel_sysctl.conf\"
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
    local DESC="fs.suid_dumpable governs whether a privileged process (with the setuid bit) can
generate a core dump, regardless of other configurations.
fs.suid_dumpable values:
•
•
•
0 (default) - Any process that has changed privilege levels (like SUID programs)
or is execute-only will not dump core.
1 (debug) - All processes dump core if possible. The core dump is owned by the
current user and security is not applied. This is primarily intended for system
debugging.
2 (suidsafe) - Any binary that normally wouldn't be dumped is dumped, but only if
the core_pattern is set to a pipe handler or a fully qualified path. This mode is
suitable for administrators debugging in a production environment.

Rationale:
core dumps may contain sensitive in-memory data like password hashes or keys. An
attacker could potentially exploit this to gain access to such data."
    local ATTACK=""
    local REMEDIATION="1. Review all files ending in .conf in the /etc/sysctl.d directory and comment
out or remove all fs.suid_dumpable lines that are not fs.suid_dumpable=0.
Example script:
#!/usr/bin/env bash
{
l_option=\"fs.suid_dumpable\" l_grep=\"\${l_option//./\\.}\" l_value=\"0\"
while IFS= read -r -d \$'\0' l_file; do
grep -Poi '\h*'\"\$l_option\"'\h*=\h*\H+\b' \"\$l_file\" \
| grep -Pivq '^\h*'\"\$l_grep\"'\h*=\h*'\"\$l_value\"'\b' && \
sed -ri '/^\s*kernel.yama.ptrace_scope\s*=/s/^/# /' \"\$l_file\"
done < <(find /etc/sysctl.d/ -type f -name '*.conf' -print0)
}
2. Create or edit a file in the /etc/sysctl.d/ directory ending in .confand edit or
add the following line:
fs.suid_dumpable = 0
Example:
# [ ! -d \"/etc/sysctl.d/\" ] && mkdir -p /etc/sysctl.d/
# printf '%s\n' \"\" \"fs.suid_dumpable = 0\" >> /etc/sysctl.d/60kernel_sysctl.conf
3. Run the following command to load all system configuration filles:
# sysctl --system"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
