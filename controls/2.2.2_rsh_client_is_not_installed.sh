#!/usr/bin/env bash
# controls/2.2.2_rsh_client_is_not_installed.sh

execute_control() {
    local CONTROL_ID="2.2.2"
    local TITLE="Ensure rsh client is not installed ((Automated)"
    local EXPECTED="Verify rsh-client is not installed. Use the following command to provide the needed
information:
# dpkg-query -s rsh-client &>/dev/null && echo \"rsh-client is installed\"
Nothing should be returned."
    local RISK="Unknown"
    local DESC="The rsh-client package contains the client commands for the rsh services.

Rationale:
These legacy clients contain numerous security exposures and have been replaced with
the more secure SSH package. Even if the server is removed, it is best to ensure the
clients are also removed to prevent users from inadvertently attempting to use these
commands and therefore exposing their credentials. Note that removing the rshclient package removes the clients for rsh , rcp and rlogin ."
    local ATTACK="Many insecure service clients are used as troubleshooting tools and in testing
environments. Uninstalling them can inhibit capability to test and troubleshoot. If they
are required it is advisable to remove the clients after use to prevent accidental or
intentional misuse."
    local REMEDIATION="Uninstall rsh:
# apt purge rsh-client"

    local RESULT="PASS"
    local CURRENT=""

    # 1. Check if the package is installed
    local PKG_CHECK=$(dpkg-query -W -f='${Status}' "rsh-client" 2>/dev/null | grep -c "install ok installed" || true)

    if [ "$PKG_CHECK" -eq 0 ]; then
        CURRENT="rsh-client package is not installed."
        RESULT="PASS"
    else
        CURRENT="rsh-client package is installed."
        RESULT="FAIL"
    fi

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
