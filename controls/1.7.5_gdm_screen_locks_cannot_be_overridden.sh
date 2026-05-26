#!/usr/bin/env bash
# controls/1.7.5_gdm_screen_locks_cannot_be_overridden.sh

execute_control() {
    local CONTROL_ID="1.7.5"
    local TITLE="Ensure GDM screen locks cannot be overridden ((Automated)"
    local EXPECTED="Run the following commands to verify that the screen lock cannot be overridden:
# grep -Psi \"idle-delay|lock-delay|lock-enabled\" /etc/dconf/db/*/locks/*
/org/gnome/desktop/session/idle-delay
/org/gnome/desktop/screensaver/lock-delay
/org/gnome/desktop/screensaver/lock-enabled"
    local RISK="Unknown"
    local DESC="GNOME Desktop Manager can lock down specific settings by using the lockdown mode
in dconf to prevent users from changing specific settings.
To lock down a dconf key or subpath, create a locks subdirectory in the keyfile directory.
The files inside this directory contain a list of keys or subpaths to lock. Just as with the
keyfiles, you may add any number of files to this directory.

Rationale:
Setting a lock-out value reduces the window of opportunity for unauthorized user access
to another user's session that has been left unattended.
Without locking down the system settings, user settings take precedence over the
system settings."
    local ATTACK=""
    local REMEDIATION="1. To prevent the user from overriding these settings, create the file
/etc/dconf/db/local.d/locks/00-screensaver with the following content:
# Lock desktop screensaver settings
/org/gnome/desktop/session/idle-delay
/org/gnome/desktop/screensaver/lock-delay
/org/gnome/desktop/screensaver/lock-enabled
2. Update the system databases:
# dconf update
Note:
•
•
A user profile must exist in order to apply locks. If a user profile does not exist
review the remediation steps in the previous recommendation.
Users must log out and back in again before the system-wide settings take effect."

    local RESULT="PASS"
    local CURRENT=""

    local OVERRIDE=$(grep -E "^idle-delay" /etc/dconf/db/local.d/locks/* 2>/dev/null || true)

    if [ -n "$OVERRIDE" ]; then
        CURRENT="Screen lock cannot be overridden."
        RESULT="PASS"
    else
        CURRENT="Screen lock can be overridden."
        RESULT="FAIL"
    fi
    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
