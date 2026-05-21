#!/usr/bin/env bash
# controls/3.1.3_bluetooth_services_are_not_in_use.sh

execute_control() {
    local CONTROL_ID="3.1.3"
    local TITLE="Ensure bluetooth services are not in use ((Automated)"
    local EXPECTED="Run the following command to verify the bluez package is not installed:
# dpkg-query -s bluez &>/dev/null && echo \"bluez is installed\"
Nothing should be returned.
- OR - IF - the bluez package is required as a dependency:
Run the following command to verify bluetooth.service is not enabled:
# systemctl is-enabled bluetooth.service 2>/dev/null | grep 'enabled'
Nothing should be returned.
Run the following command to verify bluetooth.service is not active:
# systemctl is-active bluetooth.service 2>/dev/null | grep '^active'
Nothing should be returned.
Note: If the package is required for a dependency
•
•
Ensure the dependent package is approved by local site policy
Ensure stopping and masking the service and/or socket meets local site policy"
    local RISK="Unknown"
    local DESC="Bluetooth is a short-range wireless technology standard that is used for exchanging
data between devices over short distances. It employs UHF radio waves in the ISM
bands, from 2.402 GHz to 2.48 GHz. It is mainly used as an alternative to wire
connections.

Rationale:
An attacker may be able to find a way to access or corrupt your data. One example of
this type of activity is bluesnarfing, which refers to attackers using a Bluetooth
connection to steal information off of your Bluetooth device. Also, viruses or other
malicious code can take advantage of Bluetooth technology to infect other devices. If
you are infected, your data may be corrupted, compromised, stolen, or lost."
    local ATTACK="Many personal electronic devices (PEDs) use Bluetooth technology. For example, you
may be able to operate your computer with a wireless keyboard. Disabling Bluetooth will
prevent these devices from connecting to the system.
There may be packages that are dependent on the bluez package. If the bluez
package is removed, these dependent packages will be removed as well. Before
removing the bluez package, review any dependent packages to determine if they are
required on the system.
-IF- a dependent package is required: stop and mask bluetooth.service leaving the
bluez package installed."
    local REMEDIATION="Run the following commands to stop bluetooth.service, and remove the bluez
package:
# systemctl stop bluetooth.service
# apt purge bluez
- OR - IF - the bluez package is required as a dependency:
Run the following commands to stop and mask bluetooth.service:
# systemctl stop bluetooth.service
# systemctl mask bluetooth.service
Note: A reboot may be required"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
