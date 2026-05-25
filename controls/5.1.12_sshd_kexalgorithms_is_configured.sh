#!/usr/bin/env bash
# controls/5.1.12_sshd_kexalgorithms_is_configured.sh

execute_control() {
    local CONTROL_ID="5.1.12"
    local TITLE="Ensure sshd KexAlgorithms is configured ((Automated)"
    local EXPECTED="Run the following command to verify none of the \"weak\" Key Exchange algorithms are
being used:
# sshd -T | grep -Pi -- 'kexalgorithms\h+([^#\n\r]+,)?(diffie-hellman-group1sha1|diffie-hellman-group14-sha1|diffie-hellman-group-exchange-sha1)\b'
Nothing should be returned.
- IF - A line is returned, review the list of Key Exchange Algorithms. The following are
considered \"weak\" Key Exchange Algorithms, and should not be used:
diffie-hellman-group1-sha1
diffie-hellman-group14-sha1
diffie-hellman-group-exchange-sha1"
    local RISK="Unknown"
    local DESC="Key exchange is any method in cryptography by which cryptographic keys are
exchanged between two parties, allowing use of a cryptographic algorithm. If the sender
and receiver wish to exchange encrypted messages, each must be equipped to encrypt
messages to be sent and decrypt messages received
Notes:
•
•
•
•
Kex algorithms have a higher preference the earlier they appear in the list
Some organizations may have stricter requirements for approved Key exchange
algorithms
Ensure that Key exchange algorithms used are in compliance with site policy
The only Key Exchange Algorithms currently FIPS 140 approved are:
o ecdh-sha2-nistp256
o ecdh-sha2-nistp384
o ecdh-sha2-nistp521
o diffie-hellman-group-exchange-sha256
o diffie-hellman-group16-sha512
o diffie-hellman-group18-sha512
o diffie-hellman-group14-sha256

Rationale:
Key exchange methods that are considered weak should be removed. A key exchange
method may be weak because too few bits are used, or the hashing algorithm is
considered too weak. Using weak algorithms could expose connections to man-in-themiddle attacks"
    local ATTACK=""
    local REMEDIATION="Edit the /etc/ssh/sshd_config file and add/modify the KexAlgorithms line to contain
a comma separated list of the site unapproved (weak) KexAlgorithms preceded with a above any Include entries:
Example:
KexAlgorithms -diffie-hellman-group1-sha1,diffie-hellman-group14-sha1,diffiehellman-group-exchange-sha1
Note: First occurrence of an option takes precedence. If Include locations are enabled,
used, and order of precedence is understood in your environment, the entry may be
created in a file in Include location."

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
