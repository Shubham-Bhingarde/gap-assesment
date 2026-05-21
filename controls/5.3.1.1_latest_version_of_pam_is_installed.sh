#!/usr/bin/env bash
# controls/5.3.1.1_latest_version_of_pam_is_installed.sh

execute_control() {
    local CONTROL_ID="5.3.1.1"
    local TITLE="Ensure latest version of pam is installed ((Automated)"
    local EXPECTED="Run the following command to verify libpam-runtime is installed:
# dpkg-query -s libpam-runtime &>/dev/null && echo \"libpam-runtime is
installed\"
libpam-runtime is installed
Run the following command to verify libpam-runtime is the latest version:
# apt list --upgradable 2>&1 | grep -P '^libpam-runtime\b'
Nothing should be returned"
    local RISK="Unknown"
    local DESC="Linux Pluggable Authentication Modules (PAM) is a suite of libraries that allow a Linux
system administrator to configure methods to authenticate users. It provides a flexible
and centralized way to switch authentication methods for secured applications by using
configuration files instead of changing application code
The libpam-runtime provides the runtime support for the PAM library

Rationale:
Older versions of the libpam-runtime package may not include the latest security and
feature patches and updates.
Note: This Benchmark was tested against libpam-runtime Version: 1.4.011ubuntu2.6"
    local ATTACK=""
    local REMEDIATION="Run the following command to install the latest version of libpam-runtime:
# apt install libpam-runtime"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
