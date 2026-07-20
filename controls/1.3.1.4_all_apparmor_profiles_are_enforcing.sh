#!/usr/bin/env bash
# controls/1.3.1.4_all_apparmor_profiles_are_enforcing.sh

execute_control() {
    local CONTROL_ID="1.3.1.4"
    local TITLE="Ensure all AppArmor Profiles are enforcing ((Automated)"
    local EXPECTED="Run the following commands and verify that profiles are loaded and are not in complain
mode:
# apparmor_status | grep profiles
Review output and ensure that profiles are loaded, and in enforce mode:
34 profiles are loaded.
34 profiles are in enforce mode.
0 profiles are in complain mode.
2 processes have profiles defined.
Run the following command and verify that no processes are unconfined:
apparmor_status | grep processes
Review the output and ensure no processes are unconfined:
2 processes have profiles defined.
2 processes are in enforce mode.
0 processes are in complain mode.
0 processes are unconfined but have a profile defined."
    local RISK="Unknown"
    local DESC="AppArmor profiles define what resources applications are able to access.

Rationale:
Security configuration requirements vary from site to site. Some sites may mandate a
policy that is stricter than the default policy, which is perfectly acceptable. This item is
intended to ensure that any policies that exist on the system are activated."
    local ATTACK=""
    local REMEDIATION="Run the following command to set all profiles to enforce mode:
# aa-enforce /etc/apparmor.d/*
Note: Any unconfined processes may need to have a profile created or activated for
them and then be restarted"

    local RESULT="PASS"
    local CURRENT=""

    local COMPLAINING=$(apparmor_status --complaining 2>/dev/null || true)

    if [ "$COMPLAINING" = "0" ]; then
        CURRENT="All profiles are in enforcing mode."
        RESULT="PASS"
    else
        CURRENT="Some profiles are in complaining mode ($COMPLAINING)."
        RESULT="FAIL"
    fi
    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
