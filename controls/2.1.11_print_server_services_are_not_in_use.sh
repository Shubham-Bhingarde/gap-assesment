#!/usr/bin/env bash
# controls/2.1.11_print_server_services_are_not_in_use.sh

execute_control() {
    local CONTROL_ID="2.1.11"
    local TITLE="Ensure print server services are not in use ((Automated)"
    local EXPECTED="Run the following command to verify cups is not Installed:
# dpkg-query -s cups &>/dev/null && echo \"cups is installed\"
Nothing should be returned.
- OR - IF - the cups package is required as a dependency:
Run the following command to verify the cups.socket and cups.service are not
enabled:
# systemctl is-enabled cups.socket cups.service 2>/dev/null | grep 'enabled'
Nothing should be returned
Run the following command to verify the cups.socket and cups.service are not
active:
# systemctl is-active cups.socket cups.service 2>/dev/null | grep '^active'
Nothing should be returned
Note: If the package is required for a dependency
•
•
Ensure the dependent package is approved by local site policy
Ensure stopping and masking the service and/or socket meets local site policy"
    local RISK="Unknown"
    local DESC="The Common Unix Print System (CUPS) provides the ability to print to both local and
network printers. A system running CUPS can also accept print jobs from remote
systems and print them to local printers. It also provides a web based remote
administration capability.

Rationale:
If the system does not need to print jobs or accept print jobs from other systems, it is
recommended that CUPS be removed to reduce the potential attack surface."
    local ATTACK="Removing the cups package, or disabling cups.socket and/or cups.service will
prevent printing from the system, a common task for workstation systems.
There may be packages that are dependent on the cups package. If the cups package
is removed, these dependent packages will be removed as well. Before removing the
cups package, review any dependent packages to determine if they are required on the
system.
- IF - a dependent package is required: stop and mask cups.socket and
cups.service leaving the cups package installed."
    local REMEDIATION="Run the following commands to stop cups.socket and cups.service, and remove the
cups package:
# systemctl stop cups.socket cups.service
# apt purge cups
- OR - IF - the cups package is required as a dependency:
Run the following commands to stop and mask the cups.socket and cups.service:
# systemctl stop cups.socket cups.service
# systemctl mask cups.socket cups.service"

    local RESULT="PASS"
    local CURRENT=""

    # 1. Check if the package is installed
    local PKG_CHECK=$(dpkg-query -W -f='${Status}' "cups" 2>/dev/null | grep -c "install ok installed" || true)

    if [ "$PKG_CHECK" -eq 0 ]; then
        CURRENT="cups package is not installed."
        RESULT="PASS"
    else
        # 2. Package is installed, check if the service is enabled/active
        local SVC_ENABLED=$(systemctl is-enabled "cups" 2>/dev/null || echo "unknown")
        local SVC_ACTIVE=$(systemctl is-active "cups" 2>/dev/null || echo "unknown")

        if [ "$SVC_ENABLED" = "masked" ] || [ "$SVC_ENABLED" = "disabled" ] || [ "$SVC_ENABLED" = "unknown" ]; then
            if [ "$SVC_ACTIVE" != "active" ]; then
                CURRENT="cups is installed, but service cups is $SVC_ENABLED and $SVC_ACTIVE."
                RESULT="PASS"
            else
                CURRENT="Service cups is $SVC_ENABLED but actively running ($SVC_ACTIVE)."
                RESULT="FAIL"
            fi
        else
            CURRENT="cups is installed and service cups is enabled ($SVC_ENABLED)."
            RESULT="FAIL"
        fi
    fi

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
