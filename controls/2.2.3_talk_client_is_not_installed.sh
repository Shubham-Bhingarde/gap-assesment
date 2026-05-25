#!/usr/bin/env bash
# controls/2.2.3_talk_client_is_not_installed.sh

execute_control() {
    local CONTROL_ID="2.2.3"
    local TITLE="Ensure talk client is not installed ((Automated)"
    local EXPECTED="Verify talk is not installed. The following command may provide the needed
information:
# dpkg-query -s talk &>/dev/null && echo \"talk is installed\"
Nothing should be returned."
    local RISK="Unknown"
    local DESC="The talk software makes it possible for users to send and receive messages across
systems through a terminal session. The talk client, which allows initialization of talk
sessions, is installed by default.

Rationale:
The software presents a security risk as it uses unencrypted protocols for
communication."
    local ATTACK="Many insecure service clients are used as troubleshooting tools and in testing
environments. Uninstalling them can inhibit capability to test and troubleshoot. If they
are required it is advisable to remove the clients after use to prevent accidental or
intentional misuse."
    local REMEDIATION="Uninstall talk:
# apt purge talk"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
