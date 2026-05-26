#!/usr/bin/env bash
# controls/1.3.1.2_apparmor_is_enabled.sh

execute_control() {
    local CONTROL_ID="1.3.1.2"
    local TITLE="Ensure AppArmor is enabled ((Automated)"
    local EXPECTED="Run the following command to verify that AppArmor has not been disabled:
# grep \"^\s*linux\" /boot/grub/grub.cfg | grep \"apparmor=0\"
Nothing should be returned."
    local RISK="Unknown"
    local DESC="AppArmor is a kernel enhancement to confine programs to a limited set of resources.
AppArmor is enabled by default.
Note: This recommendation is designed around the grub bootloader, if LILO or another
bootloader is in use in your environment enact equivalent settings.

Rationale:
AppArmor is a security mechanism and disabling it is not recommended."
    local ATTACK=""
    local REMEDIATION="Edit /etc/default/grub of file in /etc/default/grub.d and remove the apparmor=0
parameters to the GRUB_CMDLINE_LINUX= line
Run the following commands to update the grub2 configuration and reboot the system:
# update-grub
# reboot"

    local RESULT="PASS"
    local CURRENT=""

    local CMDLINE=$(grep "apparmor=1" /boot/grub/grub.cfg 2>/dev/null || true)
    local SECURITY_CMDLINE=$(grep "security=apparmor" /boot/grub/grub.cfg 2>/dev/null || true)

    if [ -n "$CMDLINE" ] && [ -n "$SECURITY_CMDLINE" ]; then
        CURRENT="apparmor is enabled in boot parameters."
        RESULT="PASS"
    else
        CURRENT="apparmor boot parameters not found."
        RESULT="FAIL"
    fi
    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
