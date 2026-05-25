#!/usr/bin/env bash
# controls/1.7.7_gdm_disabling_automatic_mounting_of_removable_media_is_not_overridden.sh

execute_control() {
    local CONTROL_ID="1.7.7"
    local TITLE="Ensure GDM disabling automatic mounting of removable media is not overridden ((Automated)"
    local EXPECTED="Run the following command to verify automount=false and automount-open=false is
correctly configured to ensure automatic mounting of removable media is not
overridden:
# grep -Psi \"automount\" /etc/dconf/db/*/locks/*
/etc/dconf/db/local.d/locks/00-media-automount:automount=false
/etc/dconf/db/local.d/locks/00-media-automount:automount-open=false"
    local RISK="Unknown"
    local DESC="By default GNOME automatically mounts removable media when inserted as a
convenience to the user.
By using the lockdown mode in dconf, you can prevent users from changing specific
settings. To lock down a dconf key or subpath, create a locks subdirectory in the keyfile
directory. The files inside this directory contain a list of keys or subpaths to lock. Just as
with the keyfiles, you may add any number of files to this directory.

Rationale:
With automounting enabled anyone with physical access could attach a USB drive or
disc and have its contents available in system even if they lacked permissions to mount
it themselves."
    local ATTACK="The use of portable hard drives is very common for workstation users"
    local REMEDIATION="1. To prevent the user from overriding these settings, create the file
/etc/dconf/db/local.d/locks/00-media-automount with the following
content:
[org/gnome/desktop/media-handling]
automount=false
automount-open=false
2. Update the systems databases:
# dconf update
Note:
•
•
A user profile must exist in order to apply locks. If a user profile does not exist
review the remediation steps in the previous recommendation.
Users must log out and back in again before the system-wide settings take effect."

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
