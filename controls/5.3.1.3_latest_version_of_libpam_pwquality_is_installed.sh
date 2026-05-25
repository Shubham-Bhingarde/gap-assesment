#!/usr/bin/env bash
# controls/5.3.1.3_latest_version_of_libpam_pwquality_is_installed.sh

execute_control() {
    local CONTROL_ID="5.3.1.3"
    local TITLE="Ensure latest version of libpam-pwquality is installed ((Automated)"
    local EXPECTED="Run the following command to verify libpam-pwquality is installed:
# dpkg-query -s libpam-pwquality &>/dev/null && echo \"libpam-pwquality is
installed\"
libpam-pwquality is installed
Run the following command to verify libpam-pwquality is the latest version:
# apt list --upgradable 2>&1 | grep -P '^libpam-pwquality\b'
Nothing should be returned"
    local RISK="Unknown"
    local DESC="libpwquality provides common functions for password quality checking and scoring
them based on their apparent randomness. The library also provides a function for
generating random passwords with good pronounceability.
This module can be plugged into the password stack of a given service to provide some
plug-in strength-checking for passwords. The code was originally based on
pam_cracklib module and the module is backwards compatible with its options.

Rationale:
Strong passwords reduce the risk of systems being hacked through brute force
methods.
Older versions of the libpam-pwquality package may not include the latest security
and feature patches and updates.
Note: This Benchmark was tested and written against libpam-pwquality Version:
1.4.4-1build2"
    local ATTACK=""
    local REMEDIATION="Run the following command to install the latest version of libpam-pwquality:
# apt install libpam-pwquality"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
