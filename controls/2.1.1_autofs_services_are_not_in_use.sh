#!/usr/bin/env bash
# controls/2.1.1_autofs_services_are_not_in_use.sh

execute_control() {
    local CONTROL_ID="2.1.1"
    local TITLE="Ensure autofs services are not in use ((Automated)"
    local EXPECTED="As a preference autofs should not be installed unless other packages depend on it.
Run the following command to verify autofs is not installed:
# dpkg-query -s autofs &>/dev/null && echo \"autofs is installed\"
Nothing should be returned.
- OR - IF - the package is required for dependencies:
Run the following command to verify autofs.service is not enabled:
# systemctl is-enabled autofs.service 2>/dev/null | grep 'enabled'
Nothing should be returned
Run the following command to verify the autofs.service is not active:
# systemctl is-active autofs.service 2>/dev/null | grep '^active'
Nothing should be returned
Note: If the package is required for a dependency
•
•
Ensure the dependent package is approved by local site policy
Ensure stopping and masking the service and/or socket meets local site policy"
    local RISK="Unknown"
    local DESC="autofs allows automatic mounting of devices, typically including CD/DVDs and USB
drives.

Rationale:
With automounting enabled anyone with physical access could attach a USB drive or
disc and have its contents available in the filesystem even if they lacked permissions to
mount it themselves."
    local ATTACK="The use of portable hard drives is very common for workstation users. If your
organization allows the use of portable storage or media on workstations and physical
access controls to workstations is considered adequate there is little value add in
turning off automounting.
There may be packages that are dependent on the autofs package. If the autofs
package is removed, these dependent packages will be removed as well. Before
removing the autofs package, review any dependent packages to determine if they are
required on the system.
- IF - a dependent package is required: stop and mask the autofs.service leaving the
autofs package installed."
    local REMEDIATION="Run the following commands to stop autofs.service and remove the autofs
package:
# systemctl stop autofs.service
# apt purge autofs
- OR - IF - the autofs package is required as a dependency:
Run the following commands to stop and mask autofs.service:
# systemctl stop autofs.service
# systemctl mask autofs.service"

    local RESULT="PASS"
    local CURRENT=""

    # 1. Check if the package is installed
    local PKG_CHECK=$(dpkg-query -W -f='${Status}' "autofs" 2>/dev/null | grep -c "install ok installed" || true)

    if [ "$PKG_CHECK" -eq 0 ]; then
        CURRENT="autofs package is not installed."
        RESULT="PASS"
    else
        # 2. Package is installed, check if the service is enabled/active
        local SVC_ENABLED=$(systemctl is-enabled "autofs" 2>/dev/null || echo "unknown")
        local SVC_ACTIVE=$(systemctl is-active "autofs" 2>/dev/null || echo "unknown")

        if [ "$SVC_ENABLED" = "masked" ] || [ "$SVC_ENABLED" = "disabled" ] || [ "$SVC_ENABLED" = "unknown" ]; then
            if [ "$SVC_ACTIVE" != "active" ]; then
                CURRENT="autofs is installed, but service autofs is $SVC_ENABLED and $SVC_ACTIVE."
                RESULT="PASS"
            else
                CURRENT="Service autofs is $SVC_ENABLED but actively running ($SVC_ACTIVE)."
                RESULT="FAIL"
            fi
        else
            CURRENT="autofs is installed and service autofs is enabled ($SVC_ENABLED)."
            RESULT="FAIL"
        fi
    fi

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
