#!/usr/bin/env bash
# controls/2.1.20_x_window_server_services_are_not_in_use.sh

execute_control() {
    local CONTROL_ID="2.1.20"
    local TITLE="Ensure X window server services are not in use ((Automated)"
    local EXPECTED="- IF - a Graphical Desktop Manager or X-Windows server is not required and approved
by local site policy:
Run the following command to Verify X Windows Server is not installed.
dpkg-query -s xserver-common &>/dev/null && echo \"xserver-common is
installed\"
Nothing should be returned"
    local RISK="Unknown"
    local DESC="The X Window System provides a Graphical User Interface (GUI) where users can have
multiple windows in which to run programs and various add on. The X Windows system
is typically used on workstations where users login, but not on servers where users
typically do not login.

Rationale:
Unless your organization specifically requires graphical login access via X Windows,
remove it to reduce the potential attack surface."
    local ATTACK="If a Graphical Desktop Manager (GDM) is in use on the system, there may be a
dependency on the xorg-x11-server-common package. If the GDM is required and
approved by local site policy, the package should not be removed.
Many Linux systems run applications which require a Java runtime. Some Linux Java
packages have a dependency on specific X Windows xorg-x11-fonts. One workaround
to avoid this dependency is to use the \"headless\" Java packages for your specific Java
runtime."
    local REMEDIATION="- IF - a Graphical Desktop Manager or X-Windows server is not required and approved
by local site policy:
Run the following command to remove the X Windows Server package:
# apt purge xserver-common"

    local RESULT="PASS"
    local CURRENT=""

    # 1. Check if the package is installed
    local PKG_CHECK=$(dpkg-query -W -f='${Status}' "xserver-xorg" 2>/dev/null | grep -c "install ok installed" || true)

    if [ "$PKG_CHECK" -eq 0 ]; then
        CURRENT="xserver-xorg package is not installed."
        RESULT="PASS"
    else
        # 2. Package is installed, check if the service is enabled/active
        local SVC_ENABLED=$(systemctl is-enabled "xserver-xorg" 2>/dev/null || echo "unknown")
        local SVC_ACTIVE=$(systemctl is-active "xserver-xorg" 2>/dev/null || echo "unknown")

        if [ "$SVC_ENABLED" = "masked" ] || [ "$SVC_ENABLED" = "disabled" ] || [ "$SVC_ENABLED" = "unknown" ]; then
            if [ "$SVC_ACTIVE" != "active" ]; then
                CURRENT="xserver-xorg is installed, but service xserver-xorg is $SVC_ENABLED and $SVC_ACTIVE."
                RESULT="PASS"
            else
                CURRENT="Service xserver-xorg is $SVC_ENABLED but actively running ($SVC_ACTIVE)."
                RESULT="FAIL"
            fi
        else
            CURRENT="xserver-xorg is installed and service xserver-xorg is enabled ($SVC_ENABLED)."
            RESULT="FAIL"
        fi
    fi

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
