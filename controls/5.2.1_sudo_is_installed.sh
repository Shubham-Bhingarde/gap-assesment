#!/usr/bin/env bash
# controls/5.2.1_sudo_is_installed.sh

execute_control() {
    local CONTROL_ID="5.2.1"
    local TITLE="Ensure sudo is installed ((Automated)"
    local EXPECTED="Run the following command to verify that either sudo is installed:
# dpkg-query -s sudo &>/dev/null && echo \"sudo is installed\"
sudo is installed
- OR Run the following command to verify that either sudo-ldap is installed:
# dpkg-query -s sudo-ldap &>/dev/null && echo \"sudo-ldap is installed\"
sudo-ldap is installed"
    local RISK="Unknown"
    local DESC="sudo allows a permitted user to execute a command as the superuser or another user,
as specified by the security policy. The invoking user's real (not effective) user ID is
used to determine the user name with which to query the security policy.

Rationale:
sudo supports a plug-in architecture for security policies and input/output logging. Third
parties can develop and distribute their own policy and I/O logging plug-ins to work
seamlessly with the sudo front end. The default security policy is sudoers, which is
configured via the file /etc/sudoers and any entries in /etc/sudoers.d.
The security policy determines what privileges, if any, a user has to run sudo. The policy
may require that users authenticate themselves with a password or another
authentication mechanism. If authentication is required, sudo will exit if the user's
password is not entered within a configurable time limit. This limit is policy-specific."
    local ATTACK=""
    local REMEDIATION="First determine is LDAP functionality is required. If so, then install sudo-ldap, else
install sudo.
Example:
# apt install sudo"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
