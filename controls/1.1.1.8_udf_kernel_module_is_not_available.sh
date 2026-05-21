#!/usr/bin/env bash
# controls/1.1.1.8_udf_kernel_module_is_not_available.sh

execute_control() {
    local CONTROL_ID="1.1.1.8"
    local TITLE="Ensure udf kernel module is not available ((Automated)"
    local EXPECTED="Verify the udf kernel module is not available on the system or has been disabled.
1. Run the following script to determine if the udf kernel module is available on the
system:
#!/usr/bin/env bash
{
l_mod_name=\"udf\" l_mod_type=\"fs\"
while IFS= read -r l_mod_path; do
if [ -d \"\$l_mod_path/\${l_mod_name//-/\/}\" ] && \
[ -n \"\$(ls -A \"\$l_mod_path/\${l_mod_name//-/\/}\")\" ]; then
printf '%s\n' \"\$l_mod_name exists in \$l_mod_path\"
fi
done < <(readlink -e /usr/lib/modules/**/kernel/\$l_mod_type \
|| readlink -e /lib/modules/**/kernel/\$l_mod_type)
}
If nothing is returned, the udf kernel module is not available on the system and no
further audit steps are required.
Note: Some systems may include the udf filesystem as part of the kernel opposed to
being available as a kernel module. In this case, the above audit will not return anything.
This is also considered a passing state.
If anything is returned by the above script:
2. Verify the udf kernel module is not loaded and not loadable by performing the
following:
Run the following command to verify the udf kernel module is not loaded:
# lsmod | grep 'udf'
Nothing should be returned
Run the following command to verify the udf kernel module is not loadable:
# modprobe --showconfig | grep -P -- '\b(install|blacklist)\h+udf\b'
Verify the output includes:
blacklist udf
-ANDinstall udf /bin/false
-ORinstall udf /bin/true
Example output:
blacklist udf
install udf /bin/false"
    local RISK="Unknown"
    local DESC="The udf filesystem type is the universal disk format used to implement ISO/IEC 13346
and ECMA-167 specifications. This is an open vendor filesystem type for data storage
on a broad range of media. This filesystem type is necessary to support writing DVDs
and newer optical disc formats.

Rationale:
Removing support for unneeded filesystem types reduces the local attack surface of the
system. If this filesystem type is not needed, disable it."
    local ATTACK="Microsoft Azure requires the usage of udf.
udf should not be disabled on systems run on Microsoft Azure."
    local REMEDIATION="Unload and disable the udf kernel module.
1. Run the following commands to unload the udf kernel module:
# modprobe -r udf 2>/dev/null
# rmmod udf 2>/dev/null
2. Perform the following to disable the udf kernel module:
Create a file ending in .conf with install udf /bin/false in the /etc/modprobe.d/
directory
Example:
# printf '%s\n' \"\" \"install udf /bin/false\" >> /etc/modprobe.d/60-udf.conf
Create a file ending in .conf with blacklist udf in the /etc/modprobe.d/ directory
Example:
# printf '%s\n' \"\" \"blacklist udf\" >> /etc/modprobe.d/60-udf.conf"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
