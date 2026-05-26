#!/usr/bin/env bash
# controls/1.7.4_gdm_screen_locks_when_the_user_is_idle.sh

execute_control() {
    local CONTROL_ID="1.7.4"
    local TITLE="Ensure GDM screen locks when the user is idle ((Automated)"
    local EXPECTED="Run the following command to verify that a user profile exists:
# grep -Psi \"user-db|system-db\" /etc/dconf/profile/*/*
/etc/dconf/profile/local:user-db:user
/etc/dconf/profile/local:system-db:local
Run the following commands to verify that the screen locks when the user is idle:
# gsettings get org.gnome.desktop.screensaver lock-delay
uint32 5
# gsettings get org.gnome.desktop.session idle-delay
uint32 900
# gsettings get org.gnome.desktop.screensaver lock-enabled
true
Notes:
•
•
•
lock-delay=uint32 {n} - should be 5 seconds or less and follow local site
policy
idle-delay=uint32 {n} - Should be 900 seconds (15 minutes) or less, not 0
(disabled) and follow local site policy
lock-enabled - must be set to true for screen locks to lock when the user is
idle"
    local RISK="Unknown"
    local DESC="GNOME Desktop Manager can make the screen lock automatically whenever the user
is idle for some amount of time.

Rationale:
Setting a lock-out value reduces the window of opportunity for unauthorized user access
to another user's session that has been left unattended."
    local ATTACK=""
    local REMEDIATION="- IF - A user profile is already created run the following commands to enable screen
locks when the user is idle:
# gsettings set org.gnome.desktop.screensaver lock-delay 5
# gsettings set org.gnome.desktop.session idle-delay 900
# gsettings set org.gnome.desktop.screensaver lock-enabled true
Note:
•
•
gsettings commands in this section MUST be done from a command window
on a graphical desktop or an error will be returned.
The system must be restarted after all gsettings configurations have been set
in order for CIS-CAT Assessor to appropriately assess.
- OR/IF- A user profile does not exist:
1. Create or edit the user profile in the /etc/dconf/profile/ and verify it includes
the following:
user-db:user
system-db:{NAME_OF_DCONF_DATABASE}
Note: local is the name of a dconf database used in the examples.
2. Create the directory /etc/dconf/db/local.d/ if it doesn't already exist:
3. Create the key file /etc/dconf/db/local.d/00-screensaver to provide
information for the local database:
Example key file:
# Specify the dconf path
[org/gnome/desktop/session]
# Number of seconds of inactivity before the screen goes blank
# Set to 0 seconds if you want to deactivate the screensaver.
idle-delay=uint32 180
# Specify the dconf path
[org/gnome/desktop/screensaver]
# Number of seconds after the screen is blank before locking the screen
lock-delay=uint32 0
# Ensure screen locks after inactivity
lock-enabled=true
Note: You must include the uint32 along with the integer key values as shown.
4. Run the following command to update the system databases:
# dconf update
5. Users must log out and back in again before the system-wide settings take effect."

    local RESULT="PASS"
    local CURRENT=""

    local IDLE_DELAY=$(gsettings get org.gnome.desktop.session idle-delay 2>/dev/null || echo "missing")
    local LOCK_DELAY=$(gsettings get org.gnome.desktop.screensaver lock-delay 2>/dev/null || echo "missing")

    if [ "$IDLE_DELAY" != "missing" ] && [ "$IDLE_DELAY" != "uint32 0" ]; then
        CURRENT="Screen locks when idle."
        RESULT="PASS"
    else
        CURRENT="Screen does not lock when idle."
        RESULT="FAIL"
    fi
    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
