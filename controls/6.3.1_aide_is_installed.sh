#!/usr/bin/env bash
# controls/6.3.1_aide_is_installed.sh

execute_control() {
    local CONTROL_ID="6.3.1"
    local TITLE="Ensure AIDE is installed ((Automated)"
    local EXPECTED="Run the following command to verify aide is installed:
# dpkg-query -s aide &>/dev/null && echo \"aide is installed\"
aide is installed
Run the following command to verify aide-common is installed:
# dpkg-query -s aide-common &>/dev/null && echo \"aide-common is installed\"
aide-common is installed"
    local RISK="Unknown"
    local DESC="AIDE takes a snapshot of filesystem state including modification times, permissions,
and file hashes which can then be used to compare against the current state of the
filesystem to detect modifications to the system.

Rationale:
By monitoring the filesystem state compromised files can be detected to prevent or limit
the exposure of accidental or malicious misconfigurations or modified binaries."
    local ATTACK=""
    local REMEDIATION="Install AIDE using the appropriate package manager or manual installation:
# apt install aide aide-common
Configure AIDE as appropriate for your environment. Consult the AIDE documentation
for options.
Run the following commands to initialize AIDE:
# aideinit
# mv /var/lib/aide/aide.db.new /var/lib/aide/aide.db"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
