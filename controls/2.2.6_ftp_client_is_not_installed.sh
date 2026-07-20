#!/usr/bin/env bash
# controls/2.2.6_ftp_client_is_not_installed.sh

execute_control() {
    local CONTROL_ID="2.2.6"
    local TITLE="Ensure ftp client is not installed ((Automated)"
    local EXPECTED="Verify tnftp & ftp is not installed. Use the following command to provide the needed
information:
# dpkg-query -l | awk '{print \$2}' | grep -E '^ftp|^tnftp' &>/dev/null &&
echo \"ftp is installed\"
Nothing should be returned."
    local RISK="Unknown"
    local DESC="tnftp an enhanced FTP client, is the user interface to the Internet standard File
Transfer Protocol. The program allows a user to transfer files to and from a remote
network site.

Rationale:
Unless there is a need to run the system using Internet standard File Transfer Protocol
(for example, to allow anonymous downloads), it is recommended that the package be
removed to reduce the potential attack surface."
    local ATTACK=""
    local REMEDIATION="Run the following commands to uninstall tnftp & ftp:
# apt purge ftp
# apt purge tnftp"

    local RESULT="PASS"
    local CURRENT=""

    # 1. Check if the package is installed
    local PKG_CHECK=$(dpkg-query -W -f='${Status}' "ftp" 2>/dev/null | grep -c "install ok installed" || true)

    if [ "$PKG_CHECK" -eq 0 ]; then
        CURRENT="ftp package is not installed."
        RESULT="PASS"
    else
        CURRENT="ftp package is installed."
        RESULT="FAIL"
    fi

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
