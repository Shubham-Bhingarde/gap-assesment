#!/usr/bin/env bash
# controls/1.7.10_xdmcp_is_not_enabled.sh

execute_control() {
    local CONTROL_ID="1.7.10"
    local TITLE="Ensure XDMCP is not enabled ((Automated)"
    local EXPECTED="Run the following script and verify the output:
#!/usr/bin/env bash
{
while IFS= read -r l_file; do
awk '/\[xdmcp\]/{ f = 1;next } /\[/{ f = 0 } f {if
(/^\s*Enable\s*=\s*true/) print \"The file: \\"'\"\$l_file\"'\\" includes: \\"\" \$0
\"\\" in the \\"[xdmcp]\\" block\"}' \"\$l_file\"
done < <(grep -Psil -- '^\h*\[xdmcp\]'
/etc/{gdm3,gdm}/{custom,daemon}.conf)
}
Nothing should be returned"
    local RISK="Unknown"
    local DESC="X Display Manager Control Protocol (XDMCP) is designed to provide authenticated
access to display management services for remote displays

Rationale:
XDMCP is inherently insecure.
•
•
XDMCP is not a ciphered protocol. This may allow an attacker to capture
keystrokes entered by a user
XDMCP is vulnerable to man-in-the-middle attacks. This may allow an attacker to
steal the credentials of legitimate users by impersonating the XDMCP server."
    local ATTACK=""
    local REMEDIATION="Edit all files returned by the audit and remove or comment out the Enable=true line in
the [xdmcp] block:
Example file:
# GDM configuration storage
#
# See /usr/share/gdm/gdm.schemas for a list of available options.
[daemon]
# Uncomment the line below to force the login screen to use Xorg
#WaylandEnable=false
#
#
#
Enabling automatic login
AutomaticLoginEnable = true
AutomaticLogin = user1
# Enabling timed login
# TimedLoginEnable = true
# TimedLogin = user1
# TimedLoginDelay = 10
[security]
[xdmcp]
# Enable=true <- **This line should be removed or commented out**
[chooser]
[debug]
# Uncomment the line below to turn on debugging
# More verbose logs
# Additionally lets the X server dump core if it crashes
# Enable=true"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
