#!/usr/bin/env bash
# controls/2.2.5_ldap_client_is_not_installed.sh

execute_control() {
    local CONTROL_ID="2.2.5"
    local TITLE="Ensure ldap client is not installed ((Automated)"
    local EXPECTED="Verify that ldap-utils is not installed. Use the following command to provide the
needed information:
# dpkg-query -s ldap-utils &>/dev/null && echo \"ldap-utils is installed\"
Nothing should be returned."
    local RISK="Unknown"
    local DESC="The Lightweight Directory Access Protocol (LDAP) was introduced as a replacement for
NIS/YP. It is a service that provides a method for looking up information from a central
database.

Rationale:
If the system will not need to act as an LDAP client, it is recommended that the software
be removed to reduce the potential attack surface."
    local ATTACK="Removing the LDAP client will prevent or inhibit using LDAP for authentication in your
environment."
    local REMEDIATION="Uninstall ldap-utils:
# apt purge ldap-utils"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
