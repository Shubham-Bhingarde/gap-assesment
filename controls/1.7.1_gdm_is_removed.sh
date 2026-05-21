#!/usr/bin/env bash
# controls/1.7.1_gdm_is_removed.sh

execute_control() {
    local CONTROL_ID="1.7.1"
    local TITLE="Ensure GDM is removed ((Automated)"
    local EXPECTED="Run the following command and verify gdm3 is not installed:
# dpkg-query -s gdm3 &>/dev/null && echo \"gdm3 is installed\"
Nothing should be returned"
    local RISK="Unknown"
    local DESC="The GNOME Display Manager (GDM) is a program that manages graphical display
servers and handles graphical user logins.

Rationale:
If a Graphical User Interface (GUI) is not required, it should be removed to reduce the
attack surface of the system."
    local ATTACK="Removing the GNOME Display manager will remove the Graphical User Interface (GUI)
from the system."
    local REMEDIATION="Run the following commands to uninstall gdm3 and remove unused dependencies:
# apt purge gdm3
# apt autoremove gdm3"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
