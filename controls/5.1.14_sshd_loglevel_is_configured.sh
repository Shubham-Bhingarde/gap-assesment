#!/usr/bin/env bash
# controls/5.1.14_sshd_loglevel_is_configured.sh

execute_control() {
    local CONTROL_ID="5.1.14"
    local TITLE="Ensure sshd LogLevel is configured ((Automated)"
    local EXPECTED="Run the following command and verify that output matches loglevel VERBOSE or
loglevel INFO:
# sshd -T | grep loglevel
loglevel VERBOSE
- OR loglevel INFO
- IF - Match set statements are used in your environment, specify the connection
parameters to use for the -T extended test mode and run the audit to verify the setting
is not incorrectly configured in a match block
Example additional audit needed for a match block for the user sshuser:
# sshd -T -C user=sshuser | grep loglevel
Note: If provided, any Match directives in the configuration file that would apply are
applied before the configuration is written to standard output. The connection
parameters are supplied as keyword=value pairs and may be supplied in any order,
either with multiple -C options or as a comma-separated list. The keywords are addr
(source address), user (user), host (resolved source host name), laddr (local
address), lport (local port number), and rdomain (routing domain)"
    local RISK="Unknown"
    local DESC="SSH provides several logging levels with varying amounts of verbosity. The DEBUG
options are specifically not recommended other than strictly for debugging SSH
communications. These levels provide so much data that it is difficult to identify
important security information, and may violate the privacy of users.

Rationale:
The INFO level is the basic level that only records login activity of SSH users. In many
situations, such as Incident Response, it is important to determine when a particular
user was active on a system. The logout record can eliminate those users who
disconnected, which helps narrow the field.
The VERBOSE level specifies that login and logout activity as well as the key fingerprint
for any SSH key used for login will be logged. This information is important for SSH key
management, especially in legacy environments."
    local ATTACK=""
    local REMEDIATION="Edit the /etc/ssh/sshd_config file to set the LogLevel parameter to VERBOSE or
INFO above any Include and Match entries as follows:
LogLevel VERBOSE
- OR LogLevel INFO
Note: First occurrence of an option takes precedence, Match set statements
withstanding. If Include locations are enabled, used, and order of precedence is
understood in your environment, the entry may be created in a file in Include location."

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
