#!/usr/bin/env bash
# controls/1.7.6_gdm_automatic_mounting_of_removable_media_is_disabled.sh

execute_control() {
    local CONTROL_ID="1.7.6"
    local TITLE="Ensure GDM automatic mounting of removable media is disabled ((Automated)"
    local EXPECTED="Run the following command to verify that a user profile exists:
# grep -Psi \"user-db|system-db\" /etc/dconf/profile/*/*
/etc/dconf/profile/local:user-db:user
/etc/dconf/profile/local:system-db:local
Run the following commands to verify automatic mounting is disabled:
# gsettings get org.gnome.desktop.media-handling automount
false
# gsettings get org.gnome.desktop.media-handling automount-open
false"
    local RISK="Unknown"
    local DESC="By default GNOME automatically mounts removable media when inserted as a
convenience to the user.

Rationale:
With automounting enabled anyone with physical access could attach a USB drive or
disc and have its contents available in system even if they lacked permissions to mount
it themselves."
    local ATTACK="The use of portable hard drives is very common for workstation users. If your
organization allows the use of portable storage or media on workstations and physical
access controls to workstations is considered adequate there is little value add in
turning off automounting."
    local REMEDIATION="- IF - A user profile exists run the following commands to ensure automatic mounting is
disabled:
# gsettings set org.gnome.desktop.media-handling automount false
# gsettings set org.gnome.desktop.media-handling automount-open false
Note:
•
•
gsettings commands in this section MUST be done from a command window
on a graphical desktop or an error will be returned.
The system must be restarted after all gsettings configurations have been set
in order for CIS-CAT Assessor to appropriately assess.
- OR/IF - A user profile does not exist:
1. Create a file /etc/dconf/db/local.d/00-media-automount with following
content:
[org/gnome/desktop/media-handling]
automount=false
automount-open=false
2. After creating the file, apply the changes using below command :
# dconf update
Note: Users must log out and back in again before the system-wide settings take effect."

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
