#!/usr/bin/env bash
# controls/1.4.2_access_to_bootloader_config_is_configured.sh

execute_control() {
    local CONTROL_ID="1.4.2"
    local TITLE="Ensure access to bootloader config is configured ((Automated)"
    local EXPECTED="Run the following command and verify Uid and Gid are both 0/root and Access is
0600 or more restrictive.
# stat -Lc 'Access: (%#a/%A)
/boot/grub/grub.cfg
Access: (0600/-rw-------)
Uid: ( %u/ %U) Gid: ( %g/ %G)'
Uid: ( 0/ root) Gid: ( 0/ root)"
    local RISK="Unknown"
    local DESC="The grub configuration file contains information on boot settings and passwords for
unlocking boot options.

Rationale:
Setting the permissions to read and write for root only prevents non-root users from
seeing the boot parameters or changing them. Non-root users who read the boot
parameters may be able to identify weaknesses in security upon boot and be able to
exploit them."
    local ATTACK=""
    local REMEDIATION="Run the following commands to set permissions on your grub configuration:
# chown root:root /boot/grub/grub.cfg
# chmod u-x,go-rwx /boot/grub/grub.cfg"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
