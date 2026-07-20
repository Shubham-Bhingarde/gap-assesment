#!/usr/bin/env bash
# controls/1.2.2.1_updates_patches_and_additional_security_software_are_installed.sh

execute_control() {
    local CONTROL_ID="1.2.2.1"
    local TITLE="Ensure updates, patches, and additional security software are installed ((Manual)"
    local EXPECTED="Verify there are no updates or patches to install:
# apt update
# apt -s upgrade"
    local RISK="Unknown"
    local DESC="Periodically patches are released for included software either due to security flaws or to
include additional functionality.

Rationale:
Newer patches may contain security enhancements that would not be available through
the latest full update. As a result, it is recommended that the latest software patches be
used to take advantage of the latest functionality. As with any software installation,
organizations need to determine if a given update meets their requirements and verify
the compatibility and supportability of any additional software against the update
revision that is selected."
    local ATTACK=""
    local REMEDIATION="Run the following commands to update all packages following local site policy guidance
on applying updates and patches:
Run the following command to update the system with the available patches and
updates:
# apt update
Run one of the following commands to apply the updates and patches:
# apt upgrade
- OR # apt dist-upgrade
Note: When running the command apt dist-upgrade that apt has a \"smart\" conflict
resolution system, and it will attempt to upgrade the most important packages at the
expense of less important ones if necessary. So, dist-upgrade command may remove
some packages."

    local RESULT="PASS"
    local CURRENT=""

    local PENDING=$(apt-get -s upgrade 2>/dev/null | grep -E "^Inst" || true)

    if [ -z "$PENDING" ]; then
        CURRENT="No updates are pending."
        RESULT="PASS"
    else
        CURRENT="Updates are pending installation."
        RESULT="FAIL"
    fi
    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
