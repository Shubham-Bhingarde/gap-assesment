#!/usr/bin/env bash
# controls/5.3.2.1_pam_unix_module_is_enabled.sh

execute_control() {
    local CONTROL_ID="5.3.2.1"
    local TITLE="Ensure pam_unix module is enabled ((Automated)"
    local EXPECTED="Run the following command to verify that pam_unix is enabled:
# grep -PH -- '\bpam_unix\.so\b' /etc/pam.d/common{account,auth,password,session,session-noninteractive}
Output should be simular to:
/etc/pam.d/common-account:account
[success=1 new_authtok_reqd=done
default=ignore]
pam_unix.so
/etc/pam.d/common-auth:auth
[success=2 default=ignore]
pam_unix.so
try_first_pass
/etc/pam.d/common-password:password
[success=1 default=ignore]
pam_unix.so obscure use_authtok try_first_pass yescrypt
/etc/pam.d/common-session:session
required
pam_unix.so
/etc/pam.d/common-session-noninteractive:session
required
pam_unix.so"
    local RISK="Unknown"
    local DESC="pam_unix is the standard Unix authentication module. It uses standard calls from the
system's libraries to retrieve and set account information as well as authentication.
Usually this is obtained from the /etc/passwd and if shadow is enabled, the
/etc/shadow file as well.
The account component performs the task of establishing the status of the user's
account and password based on the following shadow elements: expire,
last_change, max_change, min_change, warn_change. In the case of the latter, it may
offer advice to the user on changing their password or, through the
PAM_AUTHTOKEN_REQD return, delay giving service to the user until they have
established a new password. The entries listed above are documented in the shadow(5)
manual page. Should the user's record not contain one or more of these entries, the
corresponding shadow check is not performed.
The authentication component performs the task of checking the users credentials
(password). The default action of this module is to not permit the user access to a
service if their official password is blank.

Rationale:
The system should only provide access after performing authentication of a user."
    local ATTACK=""
    local REMEDIATION="Run the following command to enable the pam_unix module:
# pam-auth-update --enable unix
Note: If a site specific custom profile is being used in your environment to configure
PAM that includes the configuration for the pam_unix module, enable that module
instead"

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
