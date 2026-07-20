#!/usr/bin/env bash
# controls/1.1.1.6_overlay_kernel_module_is_not_available.sh

execute_control() {
    local CONTROL_ID="1.1.1.6"
    local TITLE="Ensure overlay kernel module is not available ((Automated)"
    local EXPECTED="Verify the overlay kernel module is not available on the system or has been disabled.
1. Run the following script to determine if the overlay kernel module is available on
the system:
#!/usr/bin/env bash
{
l_mod_name=\"overlayfs\" l_mod_type=\"fs\"
while IFS= read -r l_mod_path; do
if [ -d \"\$l_mod_path/\${l_mod_name//-/\/}\" ] && \
[ -n \"\$(ls -A \"\$l_mod_path/\${l_mod_name//-/\/}\")\" ]; then
printf '%s\n' \"\$l_mod_name exists in \$l_mod_path\"
fi
done < <(readlink -e /usr/lib/modules/**/kernel/\$l_mod_type \
|| readlink -e /lib/modules/**/kernel/\$l_mod_type)
}
If nothing is returned, the overlay kernel module is not available on the system and no
further audit steps are required.
Note: Some systems may include the overlay kernel module as part of the kernel
opposed to being available as a kernel module. In this case, the above audit will not
return anything. This is also considered a passing state.
If anything is returned by the above script:
2. Verify the overlay kernel module is not loaded and not loadable by performing
the following:
Run the following command to verify the overlay kernel module is not loaded:
# lsmod | grep 'overlay'
Nothing should be returned
Run the following command to verify the overlay kernel module is not loadable:
# modprobe --showconfig | grep -P -- '\b(install|blacklist)\h+overlay\b'
Verify the output includes:
blacklist overlay
-ANDinstall overlay /bin/false
-ORinstall overlay /bin/true
Example output:
blacklist overlay
install overlay /bin/false"
    local RISK="Unknown"
    local DESC="The Linux overlay kernel module, commonly referred to as Overlayfs, is a union mount
filesystem. It allows the user to overlay one file system on top of another, and creates a
single, unified view.

Rationale:
The overlay kernel module has known CVE's: CVE-2023-32629, CVE-2023-2640, and
CVE-2023-0386. Disabling the overlay kernel module reduces the local attack surface
by removing support for unnecessary filesystem types and mitigates potential risks
associated with unauthorized execution of setuid files, enhancing the overall system
security."
    local ATTACK="WARNING: If Container applications such as Docker, Kubernetes, Podman, Linux
Containers (LXC), etc. are in use proceed with caution and consider the impact on
containerized workloads, as disabling the overlay may severely disrupt
containerization."
    local REMEDIATION="Unload and disable the overlay kernel module.
1. Run the following commands to unload the overlay kernel module:
# modprobe -r overlay 2>/dev/null
# rmmod overlay 2>/dev/null
2. Perform the following to disable the overlay kernel module:
Create a file ending in .conf with install overlay /bin/false in the
/etc/modprobe.d/ directory
Example:
# printf '%s\n' \"\" \"install overlay /bin/false\" >> /etc/modprobe.d/60overlay.conf
Create a file ending in .conf with blacklist overlay in the /etc/modprobe.d/
directory
Example:
# printf '%s\n' \"\" \"blacklist overlay\" >> /etc/modprobe.d/60-overlay.conf"

    local RESULT="PASS"
    local CURRENT=""

    # 1. Check if the module is available on the system
    local MOD_CHECK=$(
        l_mod_name="overlay" l_mod_type="fs"
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
        CURRENT="overlay module is not available on the system."
        RESULT="PASS"
    else
        # Module is available, verify it is not loaded
        local LOAD_CHECK=$(lsmod | grep -P -- 'overlay' || true)

        # Verify it is not loadable
        local CONFIG_CHECK=$(modprobe --showconfig 2>/dev/null | grep -P -- '\b(install|blacklist)\h+overlay\b' || true)

        local HAS_BLACKLIST=false
        local HAS_INSTALL=false

        if echo "$CONFIG_CHECK" | grep -q "blacklist overlay"; then
            HAS_BLACKLIST=true
        fi

        if echo "$CONFIG_CHECK" | grep -qE "install overlay /bin/(false|true)"; then
            HAS_INSTALL=true
        fi

        CURRENT="Module exists. Loaded: [${LOAD_CHECK:-None}]. Config: [${CONFIG_CHECK:-None}]"

        if [ -n "$LOAD_CHECK" ]; then
            RESULT="FAIL"
            CURRENT="overlay module is currently loaded."
        elif [[ "$HAS_BLACKLIST" == "true" && "$HAS_INSTALL" == "true" ]]; then
            RESULT="PASS"
        else
            RESULT="FAIL"
            CURRENT="overlay module exists, is not loaded, but is not properly blacklisted and disabled."
        fi
    fi

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
