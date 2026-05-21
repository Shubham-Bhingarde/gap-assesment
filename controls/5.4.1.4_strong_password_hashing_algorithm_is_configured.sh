#!/usr/bin/env bash
# controls/5.4.1.4_strong_password_hashing_algorithm_is_configured.sh

execute_control() {
    local CONTROL_ID="5.4.1.4"
    local TITLE="Ensure strong password hashing algorithm is configured ((Automated)"
    local EXPECTED="Run the following command to verify the hashing algorithm is sha512 or yescrypt in
/etc/login.defs:
# grep -Pi -- '^\h*ENCRYPT_METHOD\h+(SHA512|YESCRYPT)\b' /etc/login.defs
Example output:
ENCRYPT_METHOD SHA512
- OR ENCRYPT_METHOD YESCRYPT"
    local RISK="Unknown"
    local DESC="A cryptographic hash function converts an arbitrary-length input into a fixed length
output. Password hashing performs a one-way transformation of a password, turning
the password into another string, called the hashed password.
ENCRYPT_METHOD (string) - This defines the system default encryption algorithm for
encrypting passwords (if no algorithm are specified on the command line). It can take
one of these values:
•
•
•
•
•
•
MD5 - MD5-based algorithm will be used for encrypting password
SHA256 - SHA256-based algorithm will be used for encrypting password
SHA512 - SHA512-based algorithm will be used for encrypting password
BCRYPT - BCRYPT-based algorithm will be used for encrypting password
YESCRYPT - YESCRYPT-based algorithm will be used for encrypting password
DES - DES-based algorithm will be used for encrypting password (default)
Note:
•
•
•
•
This parameter overrides the deprecated MD5_CRYPT_ENAB variable.
This parameter will only affect the generation of group passwords.
The generation of user passwords is done by PAM and subject to the PAM
configuration.
It is recommended to set this variable consistently with the PAM configuration.

Rationale:
The SHA-512 and yescrypt algorithms provide a stronger hash than other algorithms
used by Linux for password hash generation. A stronger hash provides additional
protection to the system by increasing the level of effort needed for an attacker to
successfully determine local group passwords."
    local ATTACK=""
    local REMEDIATION="Edit /etc/login.defs and set the ENCRYPT_METHOD to SHA512 or YESCRYPT:
ENCRYPT_METHOD <HASHING_ALGORITHM>
Example:
ENCRYPT_METHOD YESCRYPT
Note:
This only effects local groups' passwords created after updating the file to use
sha512 or yescrypt.
If it is determined that the password algorithm being used is not sha512 or
yescrypt, once it is changed, it is recommended that all group passwords be
updated to use the stronger hashing algorithm.
It is recommended that the chosen hashing algorithm is consistent across
/etc/login.defs and the PAM configuration
•
•
•"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
