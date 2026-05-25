#!/usr/bin/env bash
# controls/1.3.1.3_all_apparmor_profiles_are_not_disabled.sh

execute_control() {
    local CONTROL_ID="1.3.1.3"
    local TITLE="Ensure all AppArmor Profiles are not disabled ((Automated)"
    local EXPECTED="Run the following command and verify that profiles are loaded, and are in either enforce
or complain mode:
# apparmor_status | grep profiles
Review output and ensure that profiles are loaded, and in either enforce or complain
mode:
37 profiles are loaded.
35 profiles are in enforce mode.
2 profiles are in complain mode.
4 processes have profiles defined.
Run the following command and verify no processes are unconfined
# apparmor_status | grep processes
Review the output and ensure no processes are unconfined:
4 processes have profiles defined.
4 processes are in enforce mode.
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
- OR Run the following command to set all profiles to complain mode:
# aa-complain /etc/apparmor.d/*
Note: Any unconfined processes may need to have a profile created or activated for
them and then be restarted"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
