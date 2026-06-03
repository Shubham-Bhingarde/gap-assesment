#!/usr/bin/env bash
# controls/2.1.19_xinetd_services_are_not_in_use.sh

execute_control() {
    local CONTROL_ID="2.1.19"
    local TITLE="Ensure xinetd services are not in use ((Automated)"
    local EXPECTED="Run the following command to verify the xinetd package is not installed:
# dpkg-query -s xinetd &>/dev/null && echo \"xinetd is installed\"
Nothing should be returned.
-OR-IF- the xinetd package is required as a dependency:
Run the following command to verify xinetd.service is not enabled:
# systemctl is-enabled xinetd.service 2>/dev/null | grep 'enabled'
Nothing should be returned
Run the following command to verify xinetd.service is not active:
# systemctl is-active xinetd.service 2>/dev/null | grep '^active'
Nothing should be returned
Note: If the package is required for a dependency
•
•
Ensure the dependent package is approved by local site policy
Ensure stopping and masking the service and/or socket meets local site policy"
    local RISK="Unknown"
    local DESC="The eXtended InterNET Daemon (xinetd) is an open source super daemon that
replaced the original inetd daemon. The xinetd daemon listens for well known
services and dispatches the appropriate daemon to properly respond to service
requests.

Rationale:
If there are no xinetd services required, it is recommended that the package be
removed to reduce the attack surface are of the system.
Note: If an xinetd service or services are required, ensure that any xinetd service not
required is stopped and masked"
    local ATTACK="There may be packages that are dependent on the xinetd package. If the xinetd
package is removed, these dependent packages will be removed as well. Before
removing the xinetd package, review any dependent packages to determine if they are
required on the system.
-IF- a dependent package is required: stop and mask xinetd.service leaving the xinetd
package installed."
    local REMEDIATION="Run the following commands to stop xinetd.service, and remove the xinetd
package:
# systemctl stop xinetd.service
# apt purge xinetd
-OR-IF- the xinetd package is required as a dependency:
Run the following commands to stop and mask the xinetd.service:
# systemctl stop xinetd.service
# systemctl mask xinetd.service"

    local RESULT="PASS"
    local CURRENT=""

    # 1. Check if the package is installed
    local PKG_CHECK=$(dpkg-query -W -f='${Status}' "xinetd" 2>/dev/null | grep -c "install ok installed" || true)

    if [ "$PKG_CHECK" -eq 0 ]; then
        CURRENT="xinetd package is not installed."
        RESULT="PASS"
    else
        # 2. Package is installed, check if the service is enabled/active
        local SVC_ENABLED=$(systemctl is-enabled "xinetd" 2>/dev/null || echo "unknown")
        local SVC_ACTIVE=$(systemctl is-active "xinetd" 2>/dev/null || echo "unknown")

        if [ "$SVC_ENABLED" = "masked" ] || [ "$SVC_ENABLED" = "disabled" ] || [ "$SVC_ENABLED" = "unknown" ]; then
            if [ "$SVC_ACTIVE" != "active" ]; then
                CURRENT="xinetd is installed, but service xinetd is $SVC_ENABLED and $SVC_ACTIVE."
                RESULT="PASS"
            else
                CURRENT="Service xinetd is $SVC_ENABLED but actively running ($SVC_ACTIVE)."
                RESULT="FAIL"
            fi
        else
            CURRENT="xinetd is installed and service xinetd is enabled ($SVC_ENABLED)."
            RESULT="FAIL"
        fi
    fi

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
