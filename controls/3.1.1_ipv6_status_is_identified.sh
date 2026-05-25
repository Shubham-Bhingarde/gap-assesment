#!/usr/bin/env bash
# controls/3.1.1_ipv6_status_is_identified.sh

execute_control() {
    local CONTROL_ID="3.1.1"
    local TITLE="Ensure IPv6 status is identified ((Manual)"
    local EXPECTED="Run the following script to identify if IPv6 is enabled on the system:
#!/usr/bin/env bash
{
l_output=\"\"
! grep -Pqs -- '^\h*0\b' /sys/module/ipv6/parameters/disable &&
l_output=\"- IPv6 is not enabled\"
if sysctl net.ipv6.conf.all.disable_ipv6 | grep -Pqs -\"^\h*net\.ipv6\.conf\.all\.disable_ipv6\h*=\h*1\b\" && \
sysctl net.ipv6.conf.default.disable_ipv6 | grep -Pqs -\"^\h*net\.ipv6\.conf\.default\.disable_ipv6\h*=\h*1\b\"; then
l_output=\"- IPv6 is not enabled\"
fi
[ -z \"\$l_output\" ] && l_output=\"- IPv6 is enabled\"
echo -e \"\n\$l_output\n\"
}"
    local RISK="Unknown"
    local DESC="Internet Protocol Version 6 (IPv6) is the most recent version of Internet Protocol (IP). It's
designed to supply IP addressing and additional security to support the predicted
growth of connected devices. IPv6 is based on 128-bit addressing and can support 340
undecillion, which is 340,282,366,920,938,463,463,374,607,431,768,211,456 unique
addresses.
Features of IPv6
•
•
•
•
Hierarchical addressing and routing infrastructure
Statefull and Stateless configuration
Support for quality of service (QoS)
An ideal protocol for neighboring node interaction

Rationale:
IETF RFC 4038 recommends that applications are built with an assumption of dual
stack. It is recommended that IPv6 be enabled and configured in accordance with
Benchmark recommendations.
- IF - dual stack and IPv6 are not used in your environment, IPv6 may be disabled to
reduce the attack surface of the system, and recommendations pertaining to IPv6 can
be skipped.
Note: It is recommended that IPv6 be enabled and configured unless this is against
local site policy"
    local ATTACK="IETF RFC 4038 recommends that applications are built with an assumption of dual
stack.
When enabled, IPv6 will require additional configuration to reduce risk to the system."
    local REMEDIATION="Enable or disable IPv6 in accordance with system requirements and local site policy"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
