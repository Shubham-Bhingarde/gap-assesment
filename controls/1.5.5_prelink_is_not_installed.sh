#!/usr/bin/env bash
# controls/1.5.5_prelink_is_not_installed.sh

execute_control() {
    local CONTROL_ID="1.5.5"
    local TITLE="Ensure prelink is not installed ((Automated)"
    local EXPECTED="Verify prelink is not installed:
# dpkg-query -s prelink &>/dev/null && echo \"prelink is installed\"
Nothing should be returned."
    local RISK="Unknown"
    local DESC="prelink is a program that modifies ELF shared libraries and ELF dynamically linked
binaries in such a way that the time needed for the dynamic linker to perform relocations
at startup significantly decreases.

Rationale:
The prelinking feature can interfere with the operation of AIDE, because it changes
binaries. Prelinking can also increase the vulnerability of the system if a malicious user
is able to compromise a common library such as libc."
    local ATTACK=""
    local REMEDIATION="Run the following command to restore binaries to normal:
# prelink -ua
Uninstall prelink using the appropriate package manager or manual installation:
# apt purge prelink"

    local RESULT="PASS"
    local CURRENT=""

    local HAS_PRELINK=$(dpkg-query -W -f='${Status}' prelink 2>/dev/null | grep -c "install ok installed" || true)

    if [ "$HAS_PRELINK" -eq 0 ]; then
        CURRENT="prelink is not installed."
        RESULT="PASS"
    else
        CURRENT="prelink is installed."
        RESULT="FAIL"
    fi
    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
