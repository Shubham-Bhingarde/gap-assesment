#!/usr/bin/env bash
# controls/1.7.3_gdm_disable_user_list_option_is_enabled.sh

execute_control() {
    local CONTROL_ID="1.7.3"
    local TITLE="Ensure GDM disable-user-list option is enabled ((Automated)"
    local EXPECTED="Run the following command to verify that a user profile exists:
# grep -Psi \"user-db|system-db\" /etc/dconf/profile/*/*
/etc/dconf/profile/local:user-db:user
/etc/dconf/profile/local:system-db:local
Run the following command and to verify that the disable-user-list option is
enabled:
# gsettings get org.gnome.login-screen disable-user-list
true"
    local RISK="Unknown"
    local DESC="GDM is the GNOME Display Manager which handles graphical login for GNOME based
systems.
The disable-user-list option controls if a list of users is displayed on the login
screen

Rationale:
Displaying the user list eliminates half of the Userid/Password equation that an
unauthorized person would need to log on."
    local ATTACK=""
    local REMEDIATION="- IF - A user profile exists run the following command to enable the disable-userlist:
# gsettings set org.gnome.login-screen disable-user-list true
Note:
•
•
gsettings commands in this section MUST be done from a command window
on a graphical desktop or an error will be returned.
The system must be restarted after all gsettings configurations have been set
in order for CIS-CAT Assessor to appropriately assess.
- OR/IF - A user profile does not exist:
1. Create or edit the gdm profile in /etc/dconf/profile/gdm with the following
lines:
user-db:user
system-db:gdm
file-db:/usr/share/gdm/greeter-dconf-defaults
Note: gdm is the name of a dconf database.
2. Create a gdm keyfile for machine-wide settings in /etc/dconf/db/gdm.d/00login-screen:
[org/gnome/login-screen]
# Do not show the user list
disable-user-list=true
3. Update the system databases:
# dconf update
Note: When the user profile is created or changed, the user will need to log out and log
in again before the changes will be applied."

    local RESULT="PASS"
    local CURRENT=""

    local DISABLE_USER_LIST=$(grep -E "^disable-user-list=true" /etc/gdm3/greeter.dconf-defaults 2>/dev/null || true)

    if [ -n "$DISABLE_USER_LIST" ]; then
        CURRENT="GDM user list is disabled."
        RESULT="PASS"
    else
        CURRENT="GDM user list is not disabled."
        RESULT="FAIL"
    fi
    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
