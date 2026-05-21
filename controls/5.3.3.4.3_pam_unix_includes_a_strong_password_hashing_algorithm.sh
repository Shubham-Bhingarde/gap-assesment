#!/usr/bin/env bash
# controls/5.3.3.4.3_pam_unix_includes_a_strong_password_hashing_algorithm.sh

execute_control() {
    local CONTROL_ID="5.3.3.4.3"
    local TITLE="Ensure pam_unix includes a strong password hashing algorithm ((Automated)"
    local EXPECTED="Run the following command to verify that a strong password hashing algorithm is set on
the pam_unix.so module:
# grep -PH -'^\h*password\h+([^#\n\r]+)\h+pam_unix\.so\h+([^#\n\r]+\h+)?(sha512|yescrypt)
\b' /etc/pam.d/common-password
Output should be similar to:
/etc/pam.d/common-password:password
[success=1 default=ignore]
pam_unix.so obscure use_authtok try_first_pass yescrypt
Verify that the line(s) include either sha512 - OR - yescrypt"
    local RISK="Unknown"
    local DESC="A cryptographic hash function converts an arbitrary-length input into a fixed length
output. Password hashing performs a one-way transformation of a password, turning
the password into another string, called the hashed password.
The pam_unix module can be configured to use one of the following hashing algorithms
for user's passwords:
•
•
•
•
•
•
•
md5 - When a user changes their password next, encrypt it with the MD5
algorithm.
bigcrypt - When a user changes their password next, encrypt it with the DEC C2
algorithm.
sha256 - When a user changes their password next, encrypt it with the SHA256
algorithm. The SHA256 algorithm must be supported by the crypt(3) function.
sha512 - When a user changes their password next, encrypt it with the SHA512
algorithm. The SHA512 algorithm must be supported by the crypt(3) function.
blowfish - When a user changes their password next, encrypt it with the
blowfish algorithm. The blowfish algorithm must be supported by the crypt(3)
function.
gost_yescrypt - When a user changes their password next, encrypt it with the
gost-yescrypt algorithm. The gost-yescrypt algorithm must be supported by
the crypt(3) function.
yescrypt - When a user changes their password next, encrypt it with the
yescrypt algorithm. The yescrypt algorithm must be supported by the crypt(3)
function.

Rationale:
The SHA-512 and yescrypt algorithms provide a stronger hash than other algorithms
used by Linux for password hash generation. A stronger hash provides additional
protection to the system by increasing the level of effort needed for an attacker to
successfully determine local user passwords.
Note: These changes only apply to the local system."
    local ATTACK=""
    local REMEDIATION="Run the following command:
# awk '/Password-Type:/{ f = 1;next } /-Type:/{ f = 0 } f {if
(/pam_unix\.so/) print FILENAME}' /usr/share/pam-configs/*
Edit any returned files and edit or add a strong hashing algorithm, either sha512 or
yescrypt, that meets local site policy to the pam_unix lines in the Password section:
Example File:
Name: Unix authentication
Default: yes
Priority: 256
Auth-Type: Primary # <- Start of \"Auth\" section
Auth:
[success=end default=ignore]
pam_unix.so try_first_pass
Auth-Initial:
[success=end default=ignore]
pam_unix.so
Account-Type: Primary # <- Start of \"Account\" section
Account:
[success=end new_authtok_reqd=done default=ignore]
pam_unix.so
Account-Initial:
[success=end new_authtok_reqd=done default=ignore]
pam_unix.so
Session-Type: Additional # <- Start of \"Session\" section
Session:
required
pam_unix.so
Session-Initial:
required
pam_unix.so
Password-Type: Primary # <- Start of \"Password\" section
Password:
[success=end default=ignore]
pam_unix.so obscure use_authtok
try_first_pass yescrypt # <- **ensure hashing algorithm is either sha512 or
yescrypt**
Password-Initial:
[success=end default=ignore]
pam_unix.so obscure yescrypt # <**ensure hashing algorithm is either sha512 or yescrypt**
Run the following command to update the files in the /etc/pam.d/ directory:
# pam-auth-update --enable <MODIFIED_PROFILE_NAME>
Example:
# pam-auth-update --enable unix"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
