#!/usr/bin/env bash
# controls/1.1.1.9_usb_storage_kernel_module_is_not_available.sh

execute_control() {
    local CONTROL_ID="1.1.1.9"
    local TITLE="Ensure usb-storage kernel module is not available ((Automated)"
    local EXPECTED="Verify the usb-storage kernel module is not available on the system or has been
disabled.
1. Run the following script to determine if the usb-storage kernel module is
available on the system:
#!/usr/bin/env bash
{
l_mod_name=\"usb-storage\" l_mod_type=\"drivers\"
while IFS= read -r l_mod_path; do
if [ -d \"\$l_mod_path/\${l_mod_name//-/\/}\" ] && \
[ -n \"\$(ls -A \"\$l_mod_path/\${l_mod_name//-/\/}\")\" ]; then
printf '%s\n' \"\$l_mod_name exists in \$l_mod_path\"
fi
done < <(readlink -e /usr/lib/modules/**/kernel/\$l_mod_type \
|| readlink -e /lib/modules/**/kernel/\$l_mod_type)
}
If nothing is returned, the usb-storage kernel module is not available on the system
and no further audit steps are required.
Note: Some systems may include the usb-storage filesystem as part of the kernel
opposed to being available as a kernel module. In this case, the above audit will not
return anything. This is also considered a passing state.
If anything is returned by the above script:
2. Verify the usb-storage kernel module is not loaded and not loadable by
performing the following:
Run the following command to verify the usb-storage kernel module is not loaded:
# lsmod | grep -P -- 'usb(_|-)storage'
Nothing should be returned
Run the following command to verify the usb-storage kernel module is not loadable:
# modprobe --showconfig | grep -P -- '\b(install|blacklist)\h+usb_storage\b'
Verify the output includes:
blacklist usb_storage
-ANDinstall usb_storage /bin/false
-ORinstall usb_storage /bin/true
Example output:
blacklist usb_storage
install usb_storage /bin/false"
    local RISK="Unknown"
    local DESC="USB storage provides a means to transfer and store files ensuring persistence and
availability of the files independent of network connection status. Its popularity and utility
has led to USB-based malware being a simple and common means for network
infiltration and a first step to establishing a persistent threat within a networked
environment.

Rationale:
Restricting USB access on the system will decrease the physical attack surface for a
device and diminish the possible vectors to introduce malware.
Satisfies: SRG-OS-000114-GPOS-00059, SRG-OS-000378-GPOS-00163"
    local ATTACK="Disabling the usb-storage module will disable any usage of USB storage devices.
If requirements and local site policy allow the use of such devices, other solutions
should be configured accordingly instead. One example of a commonly used solution is
USBGuard."
    local REMEDIATION="Unload and disable the usb-storage kernel module.
1. Run the following commands to unload the usb-storage kernel module:
# modprobe -r usb-storage 2>/dev/null
# rmmod usb-storage 2>/dev/null
2. Perform the following to disable the usb-storage kernel module:
Create a file ending in .conf with install usb_storage /bin/false in the
/etc/modprobe.d/ directory
Example:
# printf '%s\n' \"\" \"install usb_storage /bin/false\" >> /etc/modprobe.d/60usb-storage.conf
Create a file ending in .conf with blacklist usb_storage in the /etc/modprobe.d/
directory
Example:
# printf '%s\n' \"\" \"blacklist usb_storage\" >> /etc/modprobe.d/60-usbstorage.conf"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
