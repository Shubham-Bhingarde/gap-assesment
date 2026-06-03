#!/usr/bin/env bash
# controls/2.1.2_avahi_daemon_services_are_not_in_use.sh

execute_control() {
    local CONTROL_ID="2.1.2"
    local TITLE="Ensure avahi daemon services are not in use ((Automated)"
    local EXPECTED="Run the following command to verify avahi-daemon is not installed:
# dpkg-query -s avahi-daemon &>/dev/null && echo \"avahi-daemon is installed\"
Nothing should be returned.
- OR - IF - the avahi package is required as a dependency:
Run the following command to verify avahi-daemon.socket and avahidaemon.service are not enabled:
# systemctl is-enabled avahi-daemon.socket avahi-daemon.service 2>/dev/null |
grep 'enabled'
Nothing should be returned
Run the following command to verify avahi-daemon.socket and avahidaemon.service are not active:
# systemctl is-active avahi-daemon.socket avahi-daemon.service 2>/dev/null |
grep '^active'
Nothing should be returned
Note: If the package is required for a dependency
•
•
Ensure the dependent package is approved by local site policy
Ensure stopping and masking the service and/or socket meets local site policy"
    local RISK="Unknown"
    local DESC="Avahi is a free zeroconf implementation, including a system for multicast DNS/DNS-SD
service discovery. Avahi allows programs to publish and discover services and hosts
running on a local network with no specific configuration. For example, a user can plug
a computer into a network and Avahi automatically finds printers to print to, files to look
at and people to talk to, as well as network services running on the machine.

Rationale:
Automatic discovery of network services is not normally required for system
functionality. It is recommended to remove this package to reduce the potential attack
surface."
    local ATTACK="There may be packages that are dependent on the avahi package. If the avahi
package is removed, these dependent packages will be removed as well. Before
removing the avahi package, review any dependent packages to determine if they are
required on the system.
- IF - a dependent package is required: stop and mask the avahi-daemon.socket and
avahi-daemon.service leaving the avahi package installed."
    local REMEDIATION="Run the following commands to stop avahi-daemon.socket and avahidaemon.service, and remove the avahi-daemon package:
# systemctl stop avahi-daemon.socket avahi-daemon.service
# apt purge avahi-daemon
- OR - IF - the avahi-daemon package is required as a dependency:
Run the following commands to stop and mask the avahi-daemon.socket and avahidaemon.service:
# systemctl stop avahi-daemon.socket avahi-daemon.service
# systemctl mask avahi-daemon.socket avahi-daemon.service"

    local RESULT="PASS"
    local CURRENT=""

    # 1. Check if the package is installed
    local PKG_CHECK=$(dpkg-query -W -f='${Status}' "avahi-daemon" 2>/dev/null | grep -c "install ok installed" || true)

    if [ "$PKG_CHECK" -eq 0 ]; then
        CURRENT="avahi-daemon package is not installed."
        RESULT="PASS"
    else
        # 2. Package is installed, check if the service is enabled/active
        local SVC_ENABLED=$(systemctl is-enabled "avahi-daemon" 2>/dev/null || echo "unknown")
        local SVC_ACTIVE=$(systemctl is-active "avahi-daemon" 2>/dev/null || echo "unknown")

        if [ "$SVC_ENABLED" = "masked" ] || [ "$SVC_ENABLED" = "disabled" ] || [ "$SVC_ENABLED" = "unknown" ]; then
            if [ "$SVC_ACTIVE" != "active" ]; then
                CURRENT="avahi-daemon is installed, but service avahi-daemon is $SVC_ENABLED and $SVC_ACTIVE."
                RESULT="PASS"
            else
                CURRENT="Service avahi-daemon is $SVC_ENABLED but actively running ($SVC_ACTIVE)."
                RESULT="FAIL"
            fi
        else
            CURRENT="avahi-daemon is installed and service avahi-daemon is enabled ($SVC_ENABLED)."
            RESULT="FAIL"
        fi
    fi

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
