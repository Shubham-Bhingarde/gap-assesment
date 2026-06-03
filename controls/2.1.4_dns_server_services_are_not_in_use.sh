#!/usr/bin/env bash
# controls/2.1.4_dns_server_services_are_not_in_use.sh

execute_control() {
    local CONTROL_ID="2.1.4"
    local TITLE="Ensure dns server services are not in use ((Automated)"
    local EXPECTED="Run the following command to verify bind9 is not installed:
# dpkg-query -s bind9 &>/dev/null && echo \"bind9 is installed\"
Nothing should be returned.
- OR - IF - the package is required for dependencies:
Run the following command to verify named.service is not enabled:
# systemctl is-enabled named.service 2>/dev/null | grep 'enabled'
Nothing should be returned
Run the following command to verify the named.service is not active:
# systemctl is-active named.service 2>/dev/null | grep '^active'
Nothing should be returned
Note: If the package is required for a dependency
•
•
Ensure the dependent package is approved by local site policy
Ensure stopping and masking the service and/or socket meets local site policy"
    local RISK="Unknown"
    local DESC="The Domain Name System (DNS) is a hierarchical naming system that maps names to
IP addresses for computers, services and other resources connected to a network.
Note: bind9 is the package and bind.service is the alias for named.service.

Rationale:
Unless a system is specifically designated to act as a DNS server, it is recommended
that the package be deleted to reduce the potential attack surface."
    local ATTACK="There may be packages that are dependent on the bind9 package. If the bind9
package is removed, these dependent packages will be removed as well. Before
removing the bind9 package, review any dependent packages to determine if they are
required on the system.
- IF - a dependent package is required: stop and mask named.service leaving the
bind9 package installed."
    local REMEDIATION="Run the following commands to stop named.service and remove the bind9 package:
# systemctl stop named.service
# apt purge bind9
- OR - IF - the bind9 package is required as a dependency:
Run the following commands to stop and mask bind9.service:
# systemctl stop named.service
# systemctl mask named.service"

    local RESULT="PASS"
    local CURRENT=""

    # 1. Check if the package is installed
    local PKG_CHECK=$(dpkg-query -W -f='${Status}' "bind9" 2>/dev/null | grep -c "install ok installed" || true)

    if [ "$PKG_CHECK" -eq 0 ]; then
        CURRENT="bind9 package is not installed."
        RESULT="PASS"
    else
        # 2. Package is installed, check if the service is enabled/active
        local SVC_ENABLED=$(systemctl is-enabled "bind9" 2>/dev/null || echo "unknown")
        local SVC_ACTIVE=$(systemctl is-active "bind9" 2>/dev/null || echo "unknown")

        if [ "$SVC_ENABLED" = "masked" ] || [ "$SVC_ENABLED" = "disabled" ] || [ "$SVC_ENABLED" = "unknown" ]; then
            if [ "$SVC_ACTIVE" != "active" ]; then
                CURRENT="bind9 is installed, but service bind9 is $SVC_ENABLED and $SVC_ACTIVE."
                RESULT="PASS"
            else
                CURRENT="Service bind9 is $SVC_ENABLED but actively running ($SVC_ACTIVE)."
                RESULT="FAIL"
            fi
        else
            CURRENT="bind9 is installed and service bind9 is enabled ($SVC_ENABLED)."
            RESULT="FAIL"
        fi
    fi

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
