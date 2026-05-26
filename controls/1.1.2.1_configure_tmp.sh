#!/usr/bin/env bash
# controls/1.1.2.1_configure_tmp.sh

execute_control() {
    local CONTROL_ID="1.1.2.1"
    local TITLE="Configure /tmp"
    local EXPECTED=""
    local RISK="Unknown"
    local DESC=""
    local ATTACK=""
    local REMEDIATION=""

    local RESULT="PASS"
    local CURRENT="This is a category header. Please refer to the specific sub-controls."

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
