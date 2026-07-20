#!/usr/bin/env bash
# controls/1.5.4_core_file_size_is_configured.sh

execute_control() {
    local CONTROL_ID="1.5.4"
    local TITLE="Ensure core file size is configured ((Automated)"
    local EXPECTED="Run the following command to verify a hard limit for core is set to 0 for all users *:
# grep -Psi -- '^\h*\*\h+hard\h+core\b' /etc/security/limits.conf
/etc/security/limits.d/*
Example output:
/etc/security/limits.d/60-limits.conf:* hard core 0
Verify no line are returned with a value greater than 0."
    local RISK="Unknown"
    local DESC="core - limits the core file size
hard - for enforcing hard resource limits. These limits are set by the superuser and
enforced by the Kernel. The user cannot raise their requirement of system resources
above such values.

Rationale:
Setting a hard limit on core dumps prevents users from overriding the soft variable.
A core dump includes a memory image taken at the time the operating system
terminates an application. The memory image could contain sensitive data and is
generally useful only for developers trying to debug problems."
    local ATTACK=""
    local REMEDIATION="1. Run the following command to comment out any entries that include a hard
value for core greater than 0 in /etc/security/limits.conf and and file in
the /etc/security/limits.d/ directory.
Example:
# sed -ri '/^\s*[#\n\r]+\s+hard\s+core\h+([1-9][0-9]*)/s/^/# /'
/etc/security/limits.conf /etc/security/limits.d/*
2. Create or edit a file in /etc/security/limits.d/ and add the following line:
* hard core 0
Example:
# printf '%s\n' \"\" \"* hard core 0\" >> /etc/security/limits.d/60-limits.conf"

    local RESULT="PASS"
    local CURRENT=""

    local LIMIT=$(grep -E "^\\s*\\*\\s+hard\\s+core" /etc/security/limits.conf /etc/security/limits.d/* 2>/dev/null || true)
    local SYSCTL=$(sysctl fs.suid_dumpable 2>/dev/null | awk '{print $3}')
    local SYSTEMD_CONF=$(grep -E "^\\s*DumpCore=no" /etc/systemd/system.conf 2>/dev/null || grep -E "^\\s*DumpCore=no" /etc/systemd/coredump.conf 2>/dev/null || true)

    if echo "$LIMIT" | grep -q "0" && [ "$SYSCTL" = "0" ] && [ -n "$SYSTEMD_CONF" ]; then
        CURRENT="Core dumps are disabled."
        RESULT="PASS"
    else
        CURRENT="Core dumps are not fully disabled. Limit: $LIMIT, Sysctl: $SYSCTL."
        RESULT="FAIL"
    fi
    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
