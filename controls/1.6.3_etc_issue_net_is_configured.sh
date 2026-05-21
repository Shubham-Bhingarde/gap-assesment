#!/usr/bin/env bash
# controls/1.6.3_etc_issue_net_is_configured.sh

execute_control() {
    local CONTROL_ID="1.6.3"
    local TITLE="Ensure /etc/issue.net is configured ((Automated)"
    local EXPECTED="Run the following command and verify that the contents match site policy:
# cat /etc/issue.net
Run the following command and verify no results are returned:
# grep -Psi \"(\\\v|\\\r|\\\m|\\\s|\b\$(grep '^ID=' /etc/os-release | cut -d= f2 | sed -e 's/\"//g')\b)\" /etc/issue.net"
    local RISK="Unknown"
    local DESC="The contents of the /etc/issue.net file are displayed to users prior to login for remote
connections from configured services.
Unix-based systems have typically displayed information about the OS release and
patch level upon logging in to the system. This information can be useful to developers
who are developing software for a particular OS platform. If mingetty(8) supports the
following options, they display operating system information: \m - machine architecture
\r - operating system release \s - operating system name \v - operating system
version

Rationale:
Warning messages inform users who are attempting to login to the system of their legal
status regarding the system and must include the name of the organization that owns
the system and any monitoring policies that are in place. Displaying OS and patch level
information in login banners also has the side effect of providing detailed system
information to attackers attempting to target specific exploits of a system. Authorized
users can easily get this information by running the \" uname -a \" command once they
have logged in."
    local ATTACK=""
    local REMEDIATION="Edit the /etc/issue.net file with the appropriate contents according to your site policy,
remove any instances of \m , \r , \s , \v or references to the OS platform
Example:
# echo \"Authorized users only. All activity may be monitored and reported.\" >
/etc/issue.net"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
