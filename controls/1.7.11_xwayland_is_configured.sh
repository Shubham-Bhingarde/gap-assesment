#!/usr/bin/env bash
# controls/1.7.11_xwayland_is_configured.sh

execute_control() {
    local CONTROL_ID="1.7.11"
    local TITLE="Ensure Xwayland is configured ((Automated)"
    local EXPECTED="Run the following command to verify Xwayland is not enabled:
# sed -n '/\[daemon\]/,/\[/p' /etc/gdm/custom.conf | grep -Psi
'^\h*waylandenable\b'
Verify output includes:
WaylandEnable=false"
    local RISK="Unknown"
    local DESC="Xwayland is a compatibility layer that allows legacy X11 applications to run within a
Wayland environment. It's effectively an X server that runs as a Wayland client,
enabling existing X11 software to be displayed on a Wayland compositor.

Rationale:
Wayland's security benefits from not relying on X11's network listener. Without X11,
there's no network listener, making it harder for malicious actors to exploit vulnerabilities
in X11. However, enabling Xwayland (running X11 applications on Wayland) introduces
X11's security concerns.
All X vulnerabilities apply to Xwayland, including keylogging, but they only affect X
windows and interactions with them.
Malware can potentially exploit Xwayland vulnerabilities to keylog or intercept other
input events"
    local ATTACK="Many applications haven't been ported to Wayland yet, and Xwayland makes it possible
to run these applications without requiring a full switch back to X11. Disabling Xwayland
functionality may cause these applications to fail."
    local REMEDIATION="Edit the file /etc/gdm/custom.conf and uncomment or add the following line in the
[daemon] block:
WaylandEnable=false
Example:
# GDM configuration storage
[daemon]
WaylandEnable=false
[security]
[xdmcp]
[chooser]
[debug]
# Uncomment the line below to turn on debugging
#Enable=true"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
