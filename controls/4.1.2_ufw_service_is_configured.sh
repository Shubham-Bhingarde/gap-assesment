#!/usr/bin/env bash
# controls/4.1.2_ufw_service_is_configured.sh

execute_control() {
    local CONTROL_ID="4.1.2"
    local TITLE="Ensure ufw service is configured ((Automated)"
    local EXPECTED="Run the following command to verify ufw.service is enabled:
# systemctl is-enabled ufw.service
enabled
Run the following command to verify ufw.service is active:
# systemctl is-active ufw.service
active
Run the following command to verify ufw is active
# ufw status
Status: active"
    local RISK="Unknown"
    local DESC="The service, ufw.service, manages UFW. This service is responsible for applying and
maintaining firewall rules, controlling which network traffic is allowed in and out of the
system.
Note:
•
•
•
When running ufw enable or starting ufw.service, ufw will flush its chains. This
is required so ufw can maintain a consistent state, but it may drop existing
connections, eg ssh. ufw does support adding rules before enabling the firewall.
Once ufw is 'enabled', ufw will not flush the chains when adding or removing
rules (but will when modifying a rule or changing the default policy)
By default ufw will prompt when enabling the firewall while running under ssh.
This can be disabled by using ufw --force enable
Warning: If a rule for openSSH server does not exist, and openSSH is used to
administer the host, the ability to administer and/or connect to the host may be lost.
Example command to create a rule to allow ssh:
# ufw allow proto tcp from any to any port 22
This rule will allow connection to the ssh server from any location. It is highly
recommended that this rule be modified to restrict ssh access to only required hosts and
to follow local site policy.
•
•
The rules will still be flushed, but the ssh port will be open after enabling the
firewall. Please note that once ufw is 'enabled', ufw will not flush the chains when
adding or removing rules (but will when modifying a rule or changing the default
policy)
By default, ufw will prompt when enabling the firewall while running under ssh.
This can be disabled by using ufw --force enable

Rationale:
The ufw service must be enabled and running in order for ufw to protect the system"
    local ATTACK="Changing firewall settings while connected over network can result in being locked out
of the system."
    local REMEDIATION="Run the following command to unmask the ufw.service:
# systemctl unmask ufw.service
Run the following command to enable and start the ufw.service:
# systemctl --now enable ufw.service
active
Run the following command to enable ufw:
# ufw enable"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
