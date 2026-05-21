#!/usr/bin/env bash
# controls/3.2.2_tipc_kernel_module_is_not_available.sh

execute_control() {
    local CONTROL_ID="3.2.2"
    local TITLE="Ensure tipc kernel module is not available ((Automated)"
    local EXPECTED="Verify the tipc kernel module is not available on the system or has been disabled.
1. Run the following script to determine if the tipc kernel module is available on the
system:
#!/usr/bin/env bash
{
l_mod_name=\"tipc\" l_mod_type=\"net\"
while IFS= read -r l_mod_path; do
if [ -d \"\$l_mod_path/\${l_mod_name//-/\/}\" ] && \
[ -n \"\$(ls -A \"\$l_mod_path/\${l_mod_name//-/\/}\")\" ]; then
printf '%s\n' \"\$l_mod_name exists in \$l_mod_path\"
fi
done < <(readlink -e /usr/lib/modules/**/kernel/\$l_mod_type \
|| readlink -e /lib/modules/**/kernel/\$l_mod_type)
}
If nothing is returned, the tipc kernel module is not available on the system and no
further audit steps are required.
Note: Some systems may include the tipc filesystem as part of the kernel opposed to
being available as a kernel module. In this case, the above audit will not return anything.
This is also considered a passing state.
If anything is returned by the above script:
2. verify the tipc kernel module is not loaded and not loadable by performing the
following:
Run the following command to verify the tipc kernel module is not loaded:
# lsmod | grep 'tipc'
Nothing should be returned
Run the following command to verify the tipc kernel module is not loadable:
# modprobe --showconfig | grep -P -- '\b(install|blacklist)\h+tipc\b'
Verify the output includes:
blacklist tipc
-ANDinstall tipc /bin/false
-ORinstall tipc /bin/true
Example output:
blacklist tipc
install tipc /bin/false"
    local RISK="Unknown"
    local DESC="The Transparent Inter-Process Communication (TIPC) protocol is designed to provide
communication between cluster nodes.

Rationale:
Removing support for unneeded protocols reduces the local attack surface of the
system. If this protocol is not needed, disable it."
    local ATTACK=""
    local REMEDIATION="Unload and disable the tipc kernel module.
1. Run the following commands to unload the tipc kernel module:
# modprobe -r tipc 2>/dev/null
# rmmod tipc 2>/dev/null
2. Perform the following to disable the tipc kernel module:
Create a file ending in .conf with install tipc /bin/false in the
/etc/modprobe.d/ directory
Example:
# printf '\n%s\n' \"install tipc /bin/false\" >> /etc/modprobe.d/60-tipc.conf
Create a file ending in .conf with blacklist tipc in the /etc/modprobe.d/ directory
Example:
# printf '\n%s\n' \"blacklist tipc\" >> /etc/modprobe.d/60-tipc.conf"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
