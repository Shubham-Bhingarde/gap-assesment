#!/usr/bin/env bash
# controls/1.4.1_bootloader_password_is_set.sh

execute_control() {
    local CONTROL_ID="1.4.1"
    local TITLE="Ensure bootloader password is set ((Automated)"
    local EXPECTED="Run the following commands and verify output matches:
# grep \"^set superusers\" /boot/grub/grub.cfg
set superusers=\"<username>\"
# awk -F. '/^\s*password/ {print \$1\".\"\$2\".\"\$3}' /boot/grub/grub.cfg
password_pbkdf2 <username> grub.pbkdf2.sha512"
    local RISK="Unknown"
    local DESC="Setting the boot loader password will require that anyone rebooting the system must
enter a password before being able to set command line boot parameters

Rationale:
Requiring a boot password upon execution of the boot loader will prevent an
unauthorized user from entering boot parameters or changing the boot partition. This
prevents users from weakening security (e.g. turning off AppArmor at boot time)."
    local ATTACK="If password protection is enabled, only the designated superuser can edit a GRUB 2
menu item by pressing \"e\" or access the GRUB 2 command line by pressing \"c\"
If GRUB 2 is set up to boot automatically to a password-protected menu entry the user
has no option to back out of the password prompt to select another menu entry. Holding
the SHIFT key will not display the menu in this case. The user must enter the correct
username and password. If unable to do so, the configuration files will have to be edited
via a LiveCD or other means to fix the problem
You can add --unrestricted to the menu entries to allow the system to boot without
entering a password. A password will still be required to edit menu items.
More Information: https://help.ubuntu.com/community/Grub2/Passwords"
    local REMEDIATION="Create an encrypted password with grub-mkpasswd-pbkdf2:
# grub-mkpasswd-pbkdf2 --iteration-count=600000 --salt=64
Enter password: <password>
Reenter password: <password>
PBKDF2 hash of your password is <encrypted-password>
Add the following into a custom /etc/grub.d configuration file:
set superusers=\"<username>\"
password_pbkdf2 <username> <encrypted-password>
The superuser/user information and password should not be contained in the
/etc/grub.d/00_header file as this file could be overwritten in a package update.
If there is a requirement to be able to boot/reboot without entering the password, edit
/etc/grub.d/10_linux and add --unrestricted to the line CLASS=
Example:
CLASS=\"--class gnu-linux --class gnu --class os --unrestricted\"
Run the following command to update the grub2 configuration:
# update-grub"

    local RESULT="PASS"
    local CURRENT=""

    local HAS_PASS=$(grep -E "^set superusers=" /boot/grub/grub.cfg 2>/dev/null || true)

    if [ -n "$HAS_PASS" ]; then
        CURRENT="Bootloader password is set."
        RESULT="PASS"
    else
        CURRENT="Bootloader password is not set."
        RESULT="FAIL"
    fi
    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
