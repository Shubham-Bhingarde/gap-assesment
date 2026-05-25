#!/usr/bin/env bash
# controls/5.1.8_sshd_disableforwarding_is_enabled.sh

execute_control() {
    local CONTROL_ID="5.1.8"
    local TITLE="Ensure sshd DisableForwarding is enabled ((Automated)"
    local EXPECTED="Run the following command to verify DisableForwarding is set to yes:
# sshd -T | grep disableforwarding
disableforwarding yes
- IF - Match set statements are used in your environment, specify the connection
parameters to use for the -T extended test mode and run the audit to verify the setting
is not incorrectly configured in a match block
Example additional audit needed for a match block for the user sshuser:
# sshd -T -C user=sshuser | grep disableforwarding
Note: If provided, any Match directives in the configuration file that would apply are
applied before the configuration is written to standard output. The connection
parameters are supplied as keyword=value pairs and may be supplied in any order,
either with multiple -C options or as a comma-separated list. The keywords are addr
(source address), user (user), host (resolved source host name), laddr (local
address), lport (local port number), and rdomain (routing domain)"
    local RISK="Unknown"
    local DESC="The DisableForwarding parameter disables all forwarding features, including X11,
ssh-agent(1), TCP and StreamLocal. This option overrides all other forwarding-related
options and may simplify restricted configurations.
•
•
•
X11Forwarding provides the ability to tunnel X11 traffic through the connection to
enable remote graphic connections.
ssh-agent is a program to hold private keys used for public key authentication.
Through use of environment variables the agent can be located and
automatically used for authentication when logging in to other machines using
ssh.
SSH port forwarding is a mechanism in SSH for tunneling application ports from
the client to the server, or servers to clients. It can be used for adding encryption
to legacy applications, going through firewalls, and some system administrators
and IT professionals use it for opening backdoors into the internal network from
their home machines.

Rationale:
Disable X11 forwarding unless there is an operational requirement to use X11
applications directly. There is a small risk that the remote X11 servers of users who are
logged in via SSH with X11 forwarding could be compromised by other users on the
X11 server. Note that even if X11 forwarding is disabled, users can always install their
own forwarders.
anyone with root privilege on the the intermediate server can make free use of sshagent to authenticate them to other servers
Leaving port forwarding enabled can expose the organization to security risks and
backdoors. SSH connections are protected with strong encryption. This makes their
contents invisible to most deployed network monitoring and traffic filtering solutions.
This invisibility carries considerable risk potential if it is used for malicious purposes
such as data exfiltration. Cybercriminals or malware could exploit SSH to hide their
unauthorized communications, or to exfiltrate stolen data from the target network."
    local ATTACK="SSH tunnels are widely used in many corporate environments. In some environments
the applications themselves may have very limited native support for security. By
utilizing tunneling, compliance with SOX, HIPAA, PCI-DSS, and other standards can be
achieved without having to modify the applications."
    local REMEDIATION="Edit the /etc/ssh/sshd_config file to set the DisableForwarding parameter to yes
above any Include and Match entries as follows:
DisableForwarding yes
Note: First occurrence of an option takes precedence, Match set statements
withstanding. If Include locations are enabled, used, and order of precedence is
understood in your environment, the entry may be created in a file in Include location."

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
