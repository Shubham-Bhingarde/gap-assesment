#!/usr/bin/env bash
# controls/3.2.3_rds_kernel_module_is_not_available.sh

execute_control() {
    local CONTROL_ID="3.2.3"
    local TITLE="Ensure rds kernel module is not available ((Automated)"
    local EXPECTED="Verify the rds kernel module is not available on the system or has been disabled.
1. Run the following script to determine if the rds kernel module is available on the
system:
#!/usr/bin/env bash
{
l_mod_name=\"rds\" l_mod_type=\"net\"
while IFS= read -r l_mod_path; do
if [ -d \"\$l_mod_path/\${l_mod_name//-/\/}\" ] && \
[ -n \"\$(ls -A \"\$l_mod_path/\${l_mod_name//-/\/}\")\" ]; then
printf '%s\n' \"\$l_mod_name exists in \$l_mod_path\"
fi
done < <(readlink -e /usr/lib/modules/**/kernel/\$l_mod_type \
|| readlink -e /lib/modules/**/kernel/\$l_mod_type)
}
If nothing is returned, the rds kernel module is not available on the system and no
further audit steps are required.
Note: Some systems may include the rds filesystem as part of the kernel opposed to
being available as a kernel module. In this case, the above audit will not return anything.
This is also considered a passing state.
If anything is returned by the above script:
2. verify the rds kernel module is not loaded and not loadable by performing the
following:
Run the following command to verify the rds kernel module is not loaded:
# lsmod | grep 'rds'
Nothing should be returned
Run the following command to verify the rds kernel module is not loadable:
# modprobe --showconfig | grep -P -- '\b(install|blacklist)\h+rds\b'
Verify the output includes:
blacklist rds
-ANDinstall rds /bin/false
-ORinstall rds /bin/true
Example output:
blacklist rds
install rds /bin/false"
    local RISK="Unknown"
    local DESC="The Reliable Datagram Sockets (RDS) protocol is a transport layer protocol designed to
provide low-latency, high-bandwidth communications between cluster nodes. It was
developed by the Oracle Corporation.

Rationale:
Removing support for unneeded protocols reduces the local attack surface of the
system. If this protocol is not needed, disable it."
    local ATTACK=""
    local REMEDIATION="Unload and disable the rds kernel module.
1. Run the following commands to unload the rds kernel module:
# modprobe -r rds 2>/dev/null
# rmmod rds 2>/dev/null
2. Perform the following to disable the rds kernel module:
Create a file ending in .conf with install rds /bin/false in the /etc/modprobe.d/
directory
Example:
# printf '\n%s\n' \"install rds /bin/false\" >> /etc/modprobe.d/60-rds.conf
Create a file ending in .conf with blacklist rds in the /etc/modprobe.d/ directory
Example:
# printf '\n%s\n' \"blacklist rds\" >> /etc/modprobe.d/60-rds.conf"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
