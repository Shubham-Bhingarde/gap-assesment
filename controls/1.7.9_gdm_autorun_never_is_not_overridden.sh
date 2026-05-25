#!/usr/bin/env bash
# controls/1.7.9_gdm_autorun_never_is_not_overridden.sh

execute_control() {
    local CONTROL_ID="1.7.9"
    local TITLE="Ensure GDM autorun-never is not overridden ((Automated)"
    local EXPECTED="Run the following command to verify that autorun-never=true cannot be overridden:
# grep -Psi \"autorun-never\" /etc/dconf/db/*/locks/*
/etc/dconf/db/local.d/locks/00-media-autorun:autorun-never=true"
    local RISK="Unknown"
    local DESC="The autorun-never setting allows the GNOME Desktop Display Manager to disable
autorun through GDM.
By using the lockdown mode in dconf, you can prevent users from changing specific
settings.
To lock down a dconf key or subpath, create a locks subdirectory in the keyfile directory.
The files inside this directory contain a list of keys or subpaths to lock. Just as with the
keyfiles, you may add any number of files to this directory.

Rationale:
Malware on removable media may taking advantage of Autorun features when the
media is inserted into a system and execute."
    local ATTACK=""
    local REMEDIATION="1. To prevent the user from overriding these settings, create the file
/etc/dconf/db/local.d/locks/00-media-autorun with the following content:
[org/gnome/desktop/media-handling]
autorun-never=true
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
