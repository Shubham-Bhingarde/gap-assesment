#!/usr/bin/env bash
# controls/3.2.1_dccp_kernel_module_is_not_available.sh

execute_control() {
    local CONTROL_ID="3.2.1"
    local TITLE="Ensure dccp kernel module is not available ((Automated)"
    local EXPECTED="Verify the dccp kernel module is not available on the system or has been disabled.
1. Run the following script to determine if the dccp kernel module is available on the
system:
#!/usr/bin/env bash
{
l_mod_name=\"dccp\" l_mod_type=\"net\"
while IFS= read -r l_mod_path; do
if [ -d \"\$l_mod_path/\${l_mod_name//-/\/}\" ] && \
[ -n \"\$(ls -A \"\$l_mod_path/\${l_mod_name//-/\/}\")\" ]; then
printf '%s\n' \"\$l_mod_name exists in \$l_mod_path\"
fi
done < <(readlink -e /usr/lib/modules/**/kernel/\$l_mod_type \
|| readlink -e /lib/modules/**/kernel/\$l_mod_type)
}
If nothing is returned, the dccp kernel module is not available on the system and no
further audit steps are required.
Note: Some systems may include the dccp filesystem as part of the kernel opposed to
being available as a kernel module. In this case, the above audit will not return anything.
This is also considered a passing state.
If anything is returned by the above script:
2. verify the dccp kernel module is not loaded and not loadable by performing the
following:
Run the following command to verify the dccp kernel module is not loaded:
# lsmod | grep 'dccp'
Nothing should be returned
Run the following command to verify the dccp kernel module is not loadable:
# modprobe --showconfig | grep -P -- '\b(install|blacklist)\h+dccp\b'
Verify the output includes:
blacklist dccp
-ANDinstall dccp /bin/false
-ORinstall dccp /bin/true
Example output:
blacklist dccp
install dccp /bin/false"
    local RISK="Unknown"
    local DESC="The Datagram Congestion Control Protocol (DCCP) is a transport layer protocol that
supports streaming media and telephony. DCCP provides a way to gain access to
congestion control, without having to do it at the application layer, but does not provide
in-sequence delivery.

Rationale:
Removing support for unneeded protocols reduces the local attack surface of the
system. If this protocol is not needed, disable it."
    local ATTACK=""
    local REMEDIATION="Unload and disable the dccp kernel module.
1. Run the following commands to unload the dccp kernel module:
# modprobe -r dccp 2>/dev/null
# rmmod dccp 2>/dev/null
2. Perform the following to disable the dccp kernel module:
Create a file ending in .conf with install dccp /bin/false in the
/etc/modprobe.d/ directory
Example:
# printf '\n%s\n' \"install dccp /bin/false\" >> /etc/modprobe.d/60-dccp.conf
Create a file ending in .conf with blacklist dccp in the /etc/modprobe.d/ directory
Example:
# printf '\n%s\n' \"blacklist dccp\" >> /etc/modprobe.d/60-dccp.conf"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
