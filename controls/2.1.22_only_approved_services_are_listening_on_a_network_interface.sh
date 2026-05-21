#!/usr/bin/env bash
# controls/2.1.22_only_approved_services_are_listening_on_a_network_interface.sh

execute_control() {
    local CONTROL_ID="2.1.22"
    local TITLE="Ensure only approved services are listening on a network interface ((Manual)"
    local EXPECTED="Run the following command:
# ss -plntu
Review the output to ensure:
•
•
•
All services listed are required on the system and approved by local site policy.
Both the port and interface the service is listening on are approved by local site
policy.
If a listed service is not required:
o Remove the package containing the service
o - IF - the service's package is required for a dependency, stop and mask
the service and/or socket"
    local RISK="Unknown"
    local DESC="A network port is identified by its number, the associated IP address, and the type of the
communication protocol such as TCP or UDP.
A listening port is a network port on which an application or process listens on, acting as
a communication endpoint.
Each listening port can be open or closed (filtered) using a firewall. In general terms, an
open port is a network port that accepts incoming packets from remote locations.

Rationale:
Services listening on the system pose a potential risk as an attack vector. These
services should be reviewed, and if not required, the service should be stopped, and the
package containing the service should be removed. If required packages have a
dependency, the service should be stopped and masked to reduce the attack surface of
the system."
    local ATTACK="There may be packages that are dependent on the service's package. If the service's
package is removed, these dependent packages will be removed as well. Before
removing the service's package, review any dependent packages to determine if they
are required on the system.
- IF - a dependent package is required: stop and mask the <service_name>.socket
and <service_name>.service leaving the service's package installed."
    local REMEDIATION="Run the following commands to stop the service and remove the package containing
the service:
# systemctl stop <service_name>.socket <service_name>.service
# apt purge <package_name>
- OR - If required packages have a dependency:
Run the following commands to stop and mask the service and socket:
# systemctl stop <service_name>.socket <service_name>.service
# systemctl mask <service_name>.socket <service_name>.service
Note: replace <service_name> with the appropriate service name."

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
