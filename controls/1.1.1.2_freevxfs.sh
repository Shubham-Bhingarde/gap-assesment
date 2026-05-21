#!/usr/bin/env bash
# controls/1.1.1.2_freevxfs.sh

execute_control() {
    local CONTROL_ID="1.1.1.2"
    local TITLE="Ensure freevxfs kernel module is not available (Automated)"
    local EXPECTED="Module is either not available, not loaded, and blacklisted/disabled."
    local RISK="Medium"
    local DESC="The freevxfs filesystem type is a free version of the Veritas type filesystem. This is the primary filesystem type for HP-UX operating systems."
    local ATTACK="Unneeded filesystems expand the local attack surface. Vulnerabilities in the freevxfs implementation could be exploited for privilege escalation."
    local REMEDIATION="Run: printf 'install freevxfs /bin/false\nblacklist freevxfs\n' > /etc/modprobe.d/freevxfs.conf && rmmod freevxfs"

    local RESULT="PASS"
    local CURRENT=""

    # 1. Check if the module is available on the system
    local MOD_CHECK=$(
        l_mod_name="freevxfs" l_mod_type="fs"
        while IFS= read -r l_mod_path; do
            if [ -d "$l_mod_path/${l_mod_name//-/\/}" ] && \
               [ -n "$(ls -A "$l_mod_path/${l_mod_name//-/\/}" 2>/dev/null)" ]; then
                printf '%s\n' "$l_mod_name exists in $l_mod_path"
            fi
        done < <(readlink -e /usr/lib/modules/**/kernel/$l_mod_type 2>/dev/null || readlink -e /lib/modules/**/kernel/$l_mod_type 2>/dev/null || echo "")
    )

    if [ -z "$MOD_CHECK" ]; then
        CURRENT="freevxfs module is not available on the system."
        RESULT="PASS"
    else
        # Module is available, verify it is not loaded
        local LOAD_CHECK=$(lsmod | grep 'freevxfs' || true)

        # Verify it is not loadable
        local CONFIG_CHECK=$(modprobe --showconfig 2>/dev/null | grep -P -- '\b(install|blacklist)\h+freevxfs\b' || true)

        local HAS_BLACKLIST=false
        local HAS_INSTALL=false

        if echo "$CONFIG_CHECK" | grep -q "blacklist freevxfs"; then
            HAS_BLACKLIST=true
        fi

        if echo "$CONFIG_CHECK" | grep -qE "install freevxfs /bin/(false|true)"; then
            HAS_INSTALL=true
        fi

        CURRENT="Module exists. Loaded: [${LOAD_CHECK:-None}]. Config: [${CONFIG_CHECK:-None}]"

        if [ -n "$LOAD_CHECK" ]; then
            RESULT="FAIL"
            CURRENT="freevxfs module is currently loaded."
        elif [[ "$HAS_BLACKLIST" == "true" && "$HAS_INSTALL" == "true" ]]; then
            RESULT="PASS"
        else
            RESULT="FAIL"
            CURRENT="freevxfs module exists, is not loaded, but is not properly blacklisted and disabled."
        fi
    fi

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
