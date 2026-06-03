#!/usr/bin/env bash
# controls/2.1.13_rsync_services_are_not_in_use.sh

execute_control() {
    local CONTROL_ID="2.1.13"
    local TITLE="Ensure rsync services are not in use ((Automated)"
    local EXPECTED="Run the following command to verify rsync is not installed:
# dpkg-query -s rsync &>/dev/null && echo \"rsync is installed\"
Nothing should be returned.
- OR - IF - the rsync package is required as a dependency:
Run the following command to verify rsync.service is not enabled:
# systemctl is-enabled rsync.service 2>/dev/null | grep 'enabled'
Nothing should be returned
Run the following command to verify rsync.service is not active:
# systemctl is-active rsync.service 2>/dev/null | grep '^active'
Nothing should be returned
Note: If the package is required for a dependency
•
•
Ensure the dependent package is approved by local site policy
Ensure stopping and masking the service and/or socket meets local site policy"
    local RISK="Unknown"
    local DESC="The rsync service can be used to synchronize files between systems over network
links.

Rationale:
rsync.service presents a security risk as the rsync protocol is unencrypted.
The rsync package should be removed to reduce the attack area of the system."
    local ATTACK="There may be packages that are dependent on the rsync package. If the rsync
package is removed, these dependent packages will be removed as well. Before
removing the rsync package, review any dependent packages to determine if they are
required on the system.
- IF - a dependent package is required: stop and mask rsync.service leaving the
rsync package installed."
    local REMEDIATION="Run the following commands to stop rsync.service, and remove the rsync package:
# systemctl stop rsync.service
# apt purge rsync
- OR - IF - the rsync package is required as a dependency:
Run the following commands to stop and mask rsync.service:
# systemctl stop rsync.service
# systemctl mask rsync.service"

    local RESULT="PASS"
    local CURRENT=""

    # 1. Check if the package is installed
    local PKG_CHECK=$(dpkg-query -W -f='${Status}' "rsync" 2>/dev/null | grep -c "install ok installed" || true)

    if [ "$PKG_CHECK" -eq 0 ]; then
        CURRENT="rsync package is not installed."
        RESULT="PASS"
    else
        # 2. Package is installed, check if the service is enabled/active
        local SVC_ENABLED=$(systemctl is-enabled "rsync" 2>/dev/null || echo "unknown")
        local SVC_ACTIVE=$(systemctl is-active "rsync" 2>/dev/null || echo "unknown")

        if [ "$SVC_ENABLED" = "masked" ] || [ "$SVC_ENABLED" = "disabled" ] || [ "$SVC_ENABLED" = "unknown" ]; then
            if [ "$SVC_ACTIVE" != "active" ]; then
                CURRENT="rsync is installed, but service rsync is $SVC_ENABLED and $SVC_ACTIVE."
                RESULT="PASS"
            else
                CURRENT="Service rsync is $SVC_ENABLED but actively running ($SVC_ACTIVE)."
                RESULT="FAIL"
            fi
        else
            CURRENT="rsync is installed and service rsync is enabled ($SVC_ENABLED)."
            RESULT="FAIL"
        fi
    fi

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
