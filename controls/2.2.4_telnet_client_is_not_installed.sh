#!/usr/bin/env bash
# controls/2.2.4_telnet_client_is_not_installed.sh

execute_control() {
    local CONTROL_ID="2.2.4"
    local TITLE="Ensure telnet client is not installed ((Automated)"
    local EXPECTED="Verify telnet is not installed. Use the following command to provide the needed
information:
# dpkg-query -s telnet &>/dev/null && echo \"telnet is installed\"
Nothing should be returned."
    local RISK="Unknown"
    local DESC="The telnet package contains the telnet client, which allows users to start
connections to other systems via the telnet protocol.

Rationale:
The telnet protocol is insecure and unencrypted. The use of an unencrypted
transmission medium could allow an unauthorized user to steal credentials. The ssh
package provides an encrypted session and stronger security and is included in most
Linux distributions."
    local ATTACK="Many insecure service clients are used as troubleshooting tools and in testing
environments. Uninstalling them can inhibit capability to test and troubleshoot. If they
are required it is advisable to remove the clients after use to prevent accidental or
intentional misuse."
    local REMEDIATION="Uninstall telnet:
# apt purge telnet"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
