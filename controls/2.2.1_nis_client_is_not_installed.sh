#!/usr/bin/env bash
# controls/2.2.1_nis_client_is_not_installed.sh

execute_control() {
    local CONTROL_ID="2.2.1"
    local TITLE="Ensure nis client is not installed ((Automated)"
    local EXPECTED="Verify nis is not installed. Use the following command to provide the needed
information:
# dpkg-query -s nis &>/dev/null && echo \"nis is installed\"
Nothing should be returned."
    local RISK="Unknown"
    local DESC="The Network Information Service (NIS), formerly known as Yellow Pages, is a clientserver directory service protocol used to distribute system configuration files. The NIS
client was used to bind a machine to an NIS server and receive the distributed
configuration files.

Rationale:
The NIS service is inherently an insecure system that has been vulnerable to DOS
attacks, buffer overflows and has poor authentication for querying NIS maps. NIS
generally has been replaced by such protocols as Lightweight Directory Access
Protocol (LDAP). It is recommended that the service be removed."
    local ATTACK="Many insecure service clients are used as troubleshooting tools and in testing
environments. Uninstalling them can inhibit capability to test and troubleshoot. If they
are required it is advisable to remove the clients after use to prevent accidental or
intentional misuse."
    local REMEDIATION="Uninstall nis:
# apt purge nis"

    local RESULT="PASS"
    local CURRENT=""

    # 1. Check if the package is installed
    local PKG_CHECK=$(dpkg-query -W -f='${Status}' "nis" 2>/dev/null | grep -c "install ok installed" || true)

    if [ "$PKG_CHECK" -eq 0 ]; then
        CURRENT="nis package is not installed."
        RESULT="PASS"
    else
        CURRENT="nis package is installed."
        RESULT="FAIL"
    fi

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
