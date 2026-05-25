#!/usr/bin/env bash
# controls/5.4.3.1_nologin_is_not_listed_in_etc_shells.sh

execute_control() {
    local CONTROL_ID="5.4.3.1"
    local TITLE="Ensure nologin is not listed in /etc/shells ((Automated)"
    local EXPECTED="Run the following command to verify that nologin is not listed in the /etc/shells file:
# grep -Ps '^\h*([^#\n\r]+)?\/nologin\b' /etc/shells
Nothing should be returned"
    local RISK="Unknown"
    local DESC="/etc/shells is a text file which contains the full pathnames of valid login shells. This
file is consulted by chsh and available to be queried by other programs.
Be aware that there are programs which consult this file to find out if a user is a normal
user; for example, FTP daemons traditionally disallow access to users with shells not
included in this file.

Rationale:
A user can use chsh to change their configured shell.
If a user has a shell configured that isn't in in /etc/shells, then the system assumes
that they're somehow restricted. In the case of chsh it means that the user cannot
change that value.
Other programs might query that list and apply similar restrictions.
By putting nologin in /etc/shells, any user that has nologin as its shell is
considered a full, unrestricted user. This is not the expected behavior for nologin."
    local ATTACK=""
    local REMEDIATION="Edit /etc/shells and remove any lines that include nologin"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
