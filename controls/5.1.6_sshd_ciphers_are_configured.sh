#!/usr/bin/env bash
# controls/5.1.6_sshd_ciphers_are_configured.sh

execute_control() {
    local CONTROL_ID="5.1.6"
    local TITLE="Ensure sshd Ciphers are configured ((Automated)"
    local EXPECTED="Run the following command to verify none of the \"weak\" ciphers are being used:
# sshd -T | grep -Pi -'^ciphers\h+\\\"?([^#\n\r]+,)?((3des|blowfish|cast128|aes(128|192|256))cbc|arcfour(128|256)?|rijndael-cbc@lysator\.liu\.se|chacha20poly1305@openssh\.com)\b'
- IF - a line is returned, review the list of ciphers. If the line includes chacha20poly1305@openssh.com, review CVE-2023-48795 and verify the system has been
patched. No ciphers in the list below should be returned as they're considered \"weak\":
3des-cbc
aes128-cbc
aes192-cbc
aes256-cbc"
    local RISK="Unknown"
    local DESC="This variable limits the ciphers that SSH can use during communication.
Notes:
•
•
•
Some organizations may have stricter requirements for approved ciphers.
Ensure that ciphers used are in compliance with site policy.
The only \"strong\" ciphers currently FIPS 140 compliant are:
o aes256-gcm@openssh.com
o aes128-gcm@openssh.com
o aes256-ctr
o aes192-ctr
o aes128-ctr

Rationale:
Weak ciphers that are used for authentication to the cryptographic module cannot be
relied upon to provide confidentiality or integrity, and system data may be compromised.
•
•
The Triple DES ciphers, as used in SSH, have a birthday bound of approximately
four billion blocks, which makes it easier for remote attackers to obtain clear text
data via a birthday attack against a long-duration encrypted session, aka a
\"Sweet32\" attack.
Error handling in the SSH protocol; Client and Server, when using a block cipher
algorithm in Cipher Block Chaining (CBC) mode, makes it easier for remote
attackers to recover certain plain text data from an arbitrary block of cipher text in
an SSH session via unknown vectors."
    local ATTACK=""
    local REMEDIATION="Edit the /etc/ssh/sshd_config file and add/modify the Ciphers line to contain a comma
separated list of the site unapproved (weak) Ciphers preceded with a - above any
Include entries:
Example:
Ciphers -3des-cbc,aes128-cbc,aes192-cbc,aes256-cbc,chacha20poly1305@openssh.com
- IF - CVE-2023-48795 has been addressed, and it meets local site policy, chacha20poly1305@openssh.com may be removed from the list of excluded ciphers.
Note: First occurrence of an option takes precedence. If Include locations are enabled,
used, and order of precedence is understood in your environment, the entry may be
created in a file in Include location."

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
