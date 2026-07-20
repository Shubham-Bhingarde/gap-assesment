#!/usr/bin/env bash
# controls/2.1.17_web_proxy_server_services_are_not_in_use.sh

execute_control() {
    local CONTROL_ID="2.1.17"
    local TITLE="Ensure web proxy server services are not in use ((Automated)"
    local EXPECTED="Run the following command to verify squid is not installed:
# dpkg-query -s squid &>/dev/null && echo \"squid is installed\"
Nothing should be returned.
- OR - IF - the package is required for dependencies:
Run the following command to verify squid.service is not enabled:
# systemctl is-enabled squid.service 2>/dev/null | grep 'enabled'
Nothing should be returned
Run the following command to verify the squid.service is not active:
# systemctl is-active squid.service 2>/dev/null | grep '^active'
Nothing should be returned
Note: If the package is required for a dependency
• Ensure the dependent package is approved by local site policy
• Ensure stopping and masking the service and/or socket meets local site policy"
    local RISK="Unknown"
    local DESC="Squid is a standard proxy server used in many distributions and environments.

Rationale:
Unless a system is specifically set up to act as a proxy server, it is recommended that
the squid package be removed to reduce the potential attack surface.
Note: Several HTTP proxy servers exist. These should be checked and removed unless
required."
    local ATTACK="There may be packages that are dependent on the squid package. If the squid
package is removed, these dependent packages will be removed as well. Before
removing the squid package, review any dependent packages to determine if they are
required on the system.
- IF - a dependent package is required: stop and mask the squid.service leaving the
squid package installed."
    local REMEDIATION="Run the following commands to stop squid.service and remove the squid package:
# systemctl stop squid.service
# apt purge squid
- OR - If the squid package is required as a dependency:
Run the following commands to stop and mask the squid.service:
# systemctl stop squid.service
# systemctl mask squid.service"

    local RESULT="PASS"
    local CURRENT=""

    # 1. Check if the package is installed
    local PKG_CHECK=$(dpkg-query -W -f='${Status}' "squid" 2>/dev/null | grep -c "install ok installed" || true)

    if [ "$PKG_CHECK" -eq 0 ]; then
        CURRENT="squid package is not installed."
        RESULT="PASS"
    else
        # 2. Package is installed, check if the service is enabled/active
        local SVC_ENABLED=$(systemctl is-enabled "squid" 2>/dev/null || echo "unknown")
        local SVC_ACTIVE=$(systemctl is-active "squid" 2>/dev/null || echo "unknown")

        if [ "$SVC_ENABLED" = "masked" ] || [ "$SVC_ENABLED" = "disabled" ] || [ "$SVC_ENABLED" = "unknown" ]; then
            if [ "$SVC_ACTIVE" != "active" ]; then
                CURRENT="squid is installed, but service squid is $SVC_ENABLED and $SVC_ACTIVE."
                RESULT="PASS"
            else
                CURRENT="Service squid is $SVC_ENABLED but actively running ($SVC_ACTIVE)."
                RESULT="FAIL"
            fi
        else
            CURRENT="squid is installed and service squid is enabled ($SVC_ENABLED)."
            RESULT="FAIL"
        fi
    fi

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
