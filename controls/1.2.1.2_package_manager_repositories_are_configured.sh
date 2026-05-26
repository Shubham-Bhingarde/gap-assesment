#!/usr/bin/env bash
# controls/1.2.1.2_package_manager_repositories_are_configured.sh

execute_control() {
    local CONTROL_ID="1.2.1.2"
    local TITLE="Ensure package manager repositories are configured ((Manual)"
    local EXPECTED="Run the following command and verify package repositories are configured correctly:
# apt-cache policy"
    local RISK="Unknown"
    local DESC="Systems need to have package manager repositories configured to ensure they receive
the latest patches and updates.

Rationale:
If a system's package repositories are misconfigured important patches may not be
identified or a rogue repository could introduce compromised software."
    local ATTACK=""
    local REMEDIATION="Configure your package manager repositories according to site policy."

    local RESULT="PASS"
    local CURRENT=""

    local REPOS=$(grep -E "^(deb|deb-src)" /etc/apt/sources.list /etc/apt/sources.list.d/* 2>/dev/null || true)

    if [ -n "$REPOS" ]; then
        CURRENT="Package manager repositories are configured. Verification requires manual review."
        RESULT="PASS"
    else
        CURRENT="No repositories configured."
        RESULT="FAIL"
    fi
    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
