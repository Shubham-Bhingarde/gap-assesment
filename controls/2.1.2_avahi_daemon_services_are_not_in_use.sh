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

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
