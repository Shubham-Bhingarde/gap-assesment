#!/usr/bin/env bash
# controls/1.1.1.11_firewire_core_kernel_module_is_not_available.sh

execute_control() {
    local CONTROL_ID="1.1.1.11"
    local TITLE="Ensure firewire-core kernel module is not available ((Automated)"
    local EXPECTED="Verify the firewire-core kernel module is not available on the system or has been
disabled.
1. Run the following script to determine if the firewire-core kernel module is
available on the system:
#!/usr/bin/env bash
{
l_mod_name=\"firewire\" l_mod_type=\"drivers\"
while IFS= read -r l_mod_path; do
if [ -d \"\$l_mod_path/\${l_mod_name//-/\/}\" ] && \
[ -n \"\$(ls -A \"\$l_mod_path/\${l_mod_name//-/\/}\")\" ]; then
printf '%s\n' \"\$l_mod_name exists in \$l_mod_path\"
fi
done < <(readlink -e /usr/lib/modules/**/kernel/\$l_mod_type \
|| readlink -e /lib/modules/**/kernel/\$l_mod_type)
}
If nothing is returned, the firewire-core kernel module is not available on the system
and no further audit steps are required.
Note: Some systems may include the firewire-core filesystem as part of the kernel
opposed to being available as a kernel module. In this case, the above audit will not
return anything. This is also considered a passing state.
If anything is returned by the above script:
2. Verify the firewire-core kernel module is not loaded and not loadable by
performing the following:
Run the following command to verify the firewire-core kernel module is not loaded:
# lsmod | grep -P -- 'firewire(_|-)core'
Nothing should be returned
Run the following command to verify the firewire-core kernel module is not loadable:
# modprobe --showconfig | grep -P -- '\b(install|blacklist)\h+firewire(_|)core\b'
Verify the output includes:
blacklist firewire_core
-ANDinstall firewire_core /bin/false
-ORinstall firewire_core /bin/true
Example output:
blacklist firewire_core
install firewire_core /bin/false"
    local RISK="Unknown"
    local DESC="The IEEE 1394 (FireWire) is a serial bus standard for high-speed real-time
communication.

Rationale:
Disabling FireWire protects the system against exploitation of any flaws in its
implementation."
    local ATTACK=""
    local REMEDIATION="Unload and disable the firewire-core kernel module.
1. Run the following commands to unload the firewire-core kernel module:
# modprobe -r firewire-core 2>/dev/null
# rmmod firewire-core 2>/dev/null
2. Perform the following to disable the firewire-core kernel module:
Create a file ending in .conf with install firewire-core /bin/false in the
/etc/modprobe.d/ directory
Example:
# printf '%s\n' \"\" \"install firewire-core /bin/false\" >> /etc/modprobe.d/60firewire-core.conf
Create a file ending in .conf with blacklist firewire-core in the
/etc/modprobe.d/ directory
Example:
# printf '%s\n' \"\" \"blacklist firewire-core\" >> /etc/modprobe.d/60-firewirecore.conf"

    local RESULT="PASS"
    local CURRENT=""

    # 1. Check if the module is available on the system
    local MOD_CHECK=$(
        l_mod_name="firewire-core" l_mod_type="fs"
        if [ "$l_mod_name" = "usb-storage" ] || [ "$l_mod_name" = "firewire-core" ]; then
            l_mod_type="drivers"
        fi
        while IFS= read -r l_mod_path; do
            if [ -d "$l_mod_path/${l_mod_name//-/\/}" ] && \
               [ -n "$(ls -A "$l_mod_path/${l_mod_name//-/\/}" 2>/dev/null)" ]; then
                printf '%s\n' "$l_mod_name exists in $l_mod_path"
            fi
        done < <(readlink -e /usr/lib/modules/**/kernel/$l_mod_type 2>/dev/null || readlink -e /lib/modules/**/kernel/$l_mod_type 2>/dev/null || echo "")
    )

    if [ -z "$MOD_CHECK" ]; then
        CURRENT="firewire-core module is not available on the system."
        RESULT="PASS"
    else
        # Module is available, verify it is not loaded
        local LOAD_CHECK=$(lsmod | grep -P -- 'firewire(_|-)core' || true)

        # Verify it is not loadable
        local CONFIG_CHECK=$(modprobe --showconfig 2>/dev/null | grep -P -- '\b(install|blacklist)\h+firewire_core\b' || true)

        local HAS_BLACKLIST=false
        local HAS_INSTALL=false

        if echo "$CONFIG_CHECK" | grep -q "blacklist firewire_core"; then
            HAS_BLACKLIST=true
        fi

        if echo "$CONFIG_CHECK" | grep -qE "install firewire_core /bin/(false|true)"; then
            HAS_INSTALL=true
        fi

        CURRENT="Module exists. Loaded: [${LOAD_CHECK:-None}]. Config: [${CONFIG_CHECK:-None}]"

        if [ -n "$LOAD_CHECK" ]; then
            RESULT="FAIL"
            CURRENT="firewire-core module is currently loaded."
        elif [[ "$HAS_BLACKLIST" == "true" && "$HAS_INSTALL" == "true" ]]; then
            RESULT="PASS"
        else
            RESULT="FAIL"
            CURRENT="firewire-core module exists, is not loaded, but is not properly blacklisted and disabled."
        fi
    fi

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
