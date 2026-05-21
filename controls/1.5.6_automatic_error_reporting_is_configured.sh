#!/usr/bin/env bash
# controls/1.5.6_automatic_error_reporting_is_configured.sh

execute_control() {
    local CONTROL_ID="1.5.6"
    local TITLE="Ensure Automatic Error Reporting is configured ((Automated)"
    local EXPECTED="Run the following command to verify that the Apport Error Reporting Service is not
enabled:
# dpkg-query -s apport &> /dev/null && grep -Psi -'^\h*enabled\h*=\h*[^0]\b' /etc/default/apport
Nothing should be returned
Run the following command to verify that the apport service is not active:
# systemctl is-active apport.service | grep '^active'
Nothing should be returned"
    local RISK="Unknown"
    local DESC="The Apport Error Reporting Service automatically generates crash reports for
debugging

Rationale:
Apport collects potentially sensitive data, such as core dumps, stack traces, and log
files. They can contain passwords, credit card numbers, serial numbers, and other
private material."
    local ATTACK=""
    local REMEDIATION="Edit /etc/default/apport and add or edit the enabled parameter to equal 0:
enabled=0
Run the following commands to stop and mask the apport service
# systemctl stop apport.service
# systemctl mask apport.service
- OR Run the following command to remove the apport package:
# apt purge apport"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
