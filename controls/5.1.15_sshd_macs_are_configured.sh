#!/usr/bin/env bash
# controls/5.1.15_sshd_macs_are_configured.sh

execute_control() {
    local CONTROL_ID="5.1.15"
    local TITLE="Ensure sshd MACs are configured ((Automated)"
    local EXPECTED="Run the following command to verify none of the \"weak\" MACs are being used:
# sshd -T | grep -Pi -- 'macs\h+([^#\n\r]+,)?(hmac-md5|hmac-md5-96|hmacripemd160|hmac-sha1-96|umac-64@openssh\.com|hmac-md5-etm@openssh\.com|hmacmd5-96-etm@openssh\.com|hmac-ripemd160-etm@openssh\.com|hmac-sha1-96etm@openssh\.com|umac-64-etm@openssh\.com|umac-128-etm@openssh\.com)\b'
Nothing should be returned
Note: Review CVE-2023-48795 and verify the system has been patched. If the system
has not been patched, review the use of the Encrypt Then Mac (etm) MACs.
The following are considered \"weak\" MACs, and should not be used:
hmac-md5
hmac-md5-96
hmac-ripemd160
hmac-sha1-96
umac-64@openssh.com
hmac-md5-etm@openssh.com
hmac-md5-96-etm@openssh.com
hmac-ripemd160-etm@openssh.com
hmac-sha1-96-etm@openssh.com
umac-64-etm@openssh.com
umac-128-etm@openssh.com"
    local RISK="Unknown"
    local DESC="This variable limits the types of MAC algorithms that SSH can use during
communication.
Notes:
•
•
•
Some organizations may have stricter requirements for approved MACs.
Ensure that MACs used are in compliance with site policy.
The only \"strong\" MACs currently FIPS 140 approved are:
o HMAC-SHA1
o HMAC-SHA2-256
o HMAC-SHA2-384
o HMAC-SHA2-512

Rationale:
MD5 and 96-bit MAC algorithms are considered weak and have been shown to increase
exploitability in SSH downgrade attacks. Weak algorithms continue to have a great deal
of attention as a weak spot that can be exploited with expanded computing power. An
attacker that breaks the algorithm could take advantage of a MiTM position to decrypt
the SSH tunnel and capture credentials and information."
    local ATTACK=""
    local REMEDIATION="Edit the /etc/ssh/sshd_config file and add/modify the MACs line to contain a comma
separated list of the site unapproved (weak) MACs preceded with a - above any
Include entries:
Example:
MACs -hmac-md5,hmac-md5-96,hmac-ripemd160,hmac-sha1-96,umac64@openssh.com,hmac-md5-etm@openssh.com,hmac-md5-96-etm@openssh.com,hmacripemd160-etm@openssh.com,hmac-sha1-96-etm@openssh.com,umac-64etm@openssh.com,umac-128-etm@openssh.com
- IF - CVE-2023-48795 has not been reviewed and addressed, the following etm MACs
should be added to the exclude list: hmac-sha1-etm@openssh.com,hmac-sha2-256etm@openssh.com,hmac-sha2-512-etm@openssh.com
Note: First occurrence of an option takes precedence. If Include locations are enabled,
used, and order of precedence is understood in your environment, the entry may be
created in a file in Include location."

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
