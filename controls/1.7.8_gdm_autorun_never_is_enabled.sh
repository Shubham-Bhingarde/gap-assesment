#!/usr/bin/env bash
# controls/1.7.8_gdm_autorun_never_is_enabled.sh

execute_control() {
    local CONTROL_ID="1.7.8"
    local TITLE="Ensure GDM autorun-never is enabled ((Automated)"
    local EXPECTED="Run the following command to verify that a user profile exists:
# grep -Psi \"user-db|system-db\" /etc/dconf/profile/*/*
/etc/dconf/profile/local:user-db:user
/etc/dconf/profile/local:system-db:local
Run the following command to verify that autorun-never is set to true for GDM:
# gsettings get org.gnome.desktop.media-handling autorun-never
true"
    local RISK="Unknown"
    local DESC="The autorun-never setting allows the GNOME Desktop Display Manager to disable
autorun through GDM.

Rationale:
Malware on removable media may taking advantage of Autorun features when the
media is inserted into a system and execute."
    local ATTACK=""
    local REMEDIATION="- IF - A user profile exist run the following command to set autorun-never to true for
GDM users:
# gsettings set org.gnome.desktop.media-handling autorun-never true
Note:
gsettings commands in this section MUST be done from a command window
on a graphical desktop or an error will be returned.
The system must be restarted after all gsettings configurations have been set
in order for CIS-CAT Assessor to appropriately assess.
•
•
- OR/IF - A user profile does not exist:
1. create the file /etc/dconf/db/local.d/locks/00-media-autorun with the
following content:
[org/gnome/desktop/media-handling]
autorun-never=true
2. Update the systems databases:
# dconf update
Note: Users must log out and back in again before the system-wide settings take effect."

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
