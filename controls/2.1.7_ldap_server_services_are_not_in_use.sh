#!/usr/bin/env bash
# controls/2.1.7_ldap_server_services_are_not_in_use.sh

execute_control() {
    local CONTROL_ID="2.1.7"
    local TITLE="Ensure ldap server services are not in use ((Automated)"
    local EXPECTED="Run the following command to verify slapd is not installed:
# dpkg-query -s slapd &>/dev/null && echo \"slapd is installed\"
Nothing should be returned.
- OR - IF - the package is required for dependencies:
Run the following command to verify slapd.service is not enabled:
# systemctl is-enabled slapd.service 2>/dev/null | grep 'enabled'
Nothing should be returned
Run the following command to verify slapd.service is not active:
# systemctl is-active slapd.service 2>/dev/null | grep '^active'
Nothing should be returned
Note: If the package is required for a dependency
•
•
Ensure the dependent package is approved by local site policy
Ensure stopping and masking the service and/or socket meets local site policy"
    local RISK="Unknown"
    local DESC="The Lightweight Directory Access Protocol (LDAP) was introduced as a replacement for
NIS/YP. It is a service that provides a method for looking up information from a central
database.

Rationale:
If the system will not need to act as an LDAP server, it is recommended that the
software be removed to reduce the potential attack surface."
    local ATTACK="There may be packages that are dependent on the slapd package. If the slapd
package is removed, these dependent packages will be removed as well. Before
removing the slapd package, review any dependent packages to determine if they are
required on the system.
- IF - a dependent package is required: stop and mask the slapd.service leaving the
slapd package installed."
    local REMEDIATION="Run the following commands to stop slapd.service and remove the slapd package:
# systemctl stop slapd.service
# apt purge slapd
- OR - IF - the slapd package is required as a dependency:
Run the following commands to stop and mask slapd.service:
# systemctl stop slapd.service
# systemctl mask slapd.service"

    local RESULT="PASS"
    local CURRENT=""

    # 1. Check if the package is installed
    local PKG_CHECK=$(dpkg-query -W -f='${Status}' "slapd" 2>/dev/null | grep -c "install ok installed" || true)

    if [ "$PKG_CHECK" -eq 0 ]; then
        CURRENT="slapd package is not installed."
        RESULT="PASS"
    else
        # 2. Package is installed, check if the service is enabled/active
        local SVC_ENABLED=$(systemctl is-enabled "slapd" 2>/dev/null || echo "unknown")
        local SVC_ACTIVE=$(systemctl is-active "slapd" 2>/dev/null || echo "unknown")

        if [ "$SVC_ENABLED" = "masked" ] || [ "$SVC_ENABLED" = "disabled" ] || [ "$SVC_ENABLED" = "unknown" ]; then
            if [ "$SVC_ACTIVE" != "active" ]; then
                CURRENT="slapd is installed, but service slapd is $SVC_ENABLED and $SVC_ACTIVE."
                RESULT="PASS"
            else
                CURRENT="Service slapd is $SVC_ENABLED but actively running ($SVC_ACTIVE)."
                RESULT="FAIL"
            fi
        else
            CURRENT="slapd is installed and service slapd is enabled ($SVC_ENABLED)."
            RESULT="FAIL"
        fi
    fi

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
