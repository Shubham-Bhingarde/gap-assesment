#!/usr/bin/env bash
# controls/1.5.2_ptrace_scope_is_configured.sh

execute_control() {
    local CONTROL_ID="1.5.2"
    local TITLE="Ensure ptrace_scope is configured ((Automated)"
    local EXPECTED="Verify kernel.yama.ptrace_scope is set to a value of: 1, 2, or 3.
1. Run the following command to verify kernel.yama.ptrace_scope is set to a
value of: 1, 2, or 3 in the running configuration:
# sysctl kernel.yama.ptrace_scope
Example output:
kernel.yama.ptrace_scope = 1
2. Run the following script to verify kernel.yama.ptrace_scope is set to a value
of: 1, 2, or 3 in a sysctl conf file being used by systemd sysctl:
#!/usr/bin/env bash
{
l_parameter_name=\"kernel.yama.ptrace_scope\"
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
- \"kernel.yama.ptrace_scope\" is set to: \"1\" in: \"/etc/sysctl.d/60kernel_sysctl.conf\"
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
    local DESC="The ptrace() system call provides a means by which one process (the \"tracer\") may
observe and control the execution of another process (the \"tracee\"), and examine and
change the tracee's memory and registers.
The sysctl settings (writable only with CAP_SYS_PTRACE) are:
•
•
•
•
0 - classic ptrace permissions: a process can PTRACE_ATTACH to any other
process running under the same uid, as long as it is dumpable (i.e. did not
transition uids, start privileged, or have called prctl(PR_SET_DUMPABLE...)
already). Similarly, PTRACE_TRACEME is unchanged.
1 - restricted ptrace: a process must have a predefined relationship with the
inferior it wants to call PTRACE_ATTACH on. By default, this relationship is that
of only its descendants when the above classic criteria is also met. To change
the relationship, an inferior can call prctl(PR_SET_PTRACER, debugger, ...) to
declare an allowed debugger PID to call PTRACE_ATTACH on the inferior.
Using PTRACE_TRACEME is unchanged.
2 - admin-only attach: only processes with CAP_SYS_PTRACE may use ptrace
with PTRACE_ATTACH, or through children calling PTRACE_TRACEME.
3 - no attach: no processes may use ptrace with PTRACE_ATTACH nor via
PTRACE_TRACEME. Once set, this sysctl value cannot be changed.

Rationale:
If one application is compromised, it would be possible for an attacker to attach to other
running processes (e.g. Bash, Firefox, SSH sessions, GPG agent, etc) to extract
additional credentials and continue to expand the scope of their attack.
Enabling restricted mode will limit the ability of a compromised process to
PTRACE_ATTACH on other processes running under the same user. With restricted
mode, ptrace will continue to work with root user."tracer\") may
observe and control the execution of another process (the \"tracee\"), and examine and
change the tracee's memory and registers.
The sysctl settings (writable only with CAP_SYS_PTRACE) are:
•
•
•
•
0 - classic ptrace permissions: a process can PTRACE_ATTACH to any other
process running under the same uid, as long as it is dumpable (i.e. did not
transition uids, start privileged, or have called prctl(PR_SET_DUMPABLE...)
already). Similarly, PTRACE_TRACEME is unchanged.
1 - restricted ptrace: a process must have a predefined relationship with the
inferior it wants to call PTRACE_ATTACH on. By default, this relationship is that
of only its descendants when the above classic criteria is also met. To change
the relationship, an inferior can call prctl(PR_SET_PTRACER, debugger, ...) to
declare an allowed debugger PID to call PTRACE_ATTACH on the inferior.
Using PTRACE_TRACEME is unchanged.
2 - admin-only attach: only processes with CAP_SYS_PTRACE may use ptrace
with PTRACE_ATTACH, or through children calling PTRACE_TRACEME.
3 - no attach: no processes may use ptrace with PTRACE_ATTACH nor via
PTRACE_TRACEME. Once set, this sysctl value cannot be changed.

Rationale:
If one application is compromised, it would be possible for an attacker to attach to other
running processes (e.g. Bash, Firefox, SSH sessions, GPG agent, etc) to extract
additional credentials and continue to expand the scope of their attack.
Enabling restricted mode will limit the ability of a compromised process to
PTRACE_ATTACH on other processes running under the same user. With restricted
mode, ptrace will continue to work with root user."
    local ATTACK=""
    local REMEDIATION="1. Review all files ending in .conf in the /etc/sysctl.d directory and comment
out or remove all kernel.yama.ptrace_scope lines that are not
kernel.yama.ptrace_scope=1, kernel.yama.ptrace_scope=2, or
kernel.yama.ptrace_scope=3.
Example script:
#!/usr/bin/env bash
{
l_option=\"kernel.yama.ptrace_scope\" l_grep=\"\${l_option//./\\.}\"
l_value=\"(1|2|3)\"
while IFS= read -r -d \$'\0' l_file; do
grep -Poi '\h*'\"\$l_option\"'\h*=\h*\H+\b' \"\$l_file\" \
| grep -Pivq '^\h*'\"\$l_grep\"'\h*=\h*'\"\$l_value\"'\b' && \
sed -ri '/^\s*kernel.yama.ptrace_scope\s*=/s/^/# /' \"\$l_file\"
done < <(find /etc/sysctl.d/ -type f -name '*.conf' -print0)
}
2. Create or edit a file in the /etc/sysctl.d/ directory ending in .confand edit or
add the following line:
kernel.yama.ptrace_scope = 1
Example:
# [ ! -d \"/etc/sysctl.d/\" ] && mkdir -p /etc/sysctl.d/
# printf '%s\n' \"\" \"kernel.yama.ptrace_scope = 1\" >> /etc/sysctl.d/60kernel_sysctl.conf
Note: The example uses kernel.yama.ptrace_scope = 1 but value may be set to 1,
2, or 3
3. Run the following command to load all system configuration filles:
# sysctl --system"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
