#!/usr/bin/env bash
# controls/4.1.1_ufw_is_installed.sh

execute_control() {
    local CONTROL_ID="4.1.1"
    local TITLE="Ensure ufw is installed ((Automated)"
    local EXPECTED="Run the following command to verify that Uncomplicated Firewall (UFW) is installed:
# dpkg-query -s ufw &>/dev/null && echo \"ufw is installed\"
ufw is installed"
    local RISK="Unknown"
    local DESC="The Uncomplicated Firewall (ufw) is a frontend for iptables and is particularly well-suited
for host-based firewalls. ufw provides a framework for managing netfilter, as well as a
command-line interface for manipulating the firewall

Rationale:
UFW acts as a frontend for both iptables and nftables and can use either as its
backend, though the specific backend depends on the Linux distribution and system
configuration.
You can enable the firewall, view its status, and manage rules using simple commandline tools to secure your system."
    local ATTACK="Changing firewall settings while connected over the network can result in being locked
out of the system."
    local REMEDIATION="Run the following command to install Uncomplicated Firewall (UFW):
# apt install ufw"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
