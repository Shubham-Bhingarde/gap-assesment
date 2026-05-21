#!/usr/bin/env bash
# controls/5.3.1.2_latest_version_of_libpam_modules_is_installed.sh

execute_control() {
    local CONTROL_ID="5.3.1.2"
    local TITLE="Ensure latest version of libpam-modules is installed ((Automated)"
    local EXPECTED="Run the following command to verify libpam-modules is installed:
# dpkg-query -s libpam-modules &>/dev/null && echo \"libpam-modules is
installed\"
libpam-modules is installed
Run the following command to verify libpam-modules is the latest version:
# apt list --upgradable 2>&1 | grep -P '^libpam-modules\b'
Nothing should be returned"
    local RISK="Unknown"
    local DESC="libpam-modules is a package containing a set of Pluggable Authentication Modules
(PAM) which allows system administrators to configure different authentication methods
for user logins, providing flexibility in how users can access applications by using
various authentication modules to include password checks and other security
mechanisms.

Rationale:
Older versions of the libpam-modules package may not include the latest security and
feature patches and updates.
Note: This Benchmark was tested and written against libpam-modules Version:
1.4.0-11ubuntu2.6"
    local ATTACK=""
    local REMEDIATION="Run the following command to install the latest version of libpam-modules:
# apt install libpam-modules"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
