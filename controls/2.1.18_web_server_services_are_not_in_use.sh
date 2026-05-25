#!/usr/bin/env bash
# controls/2.1.18_web_server_services_are_not_in_use.sh

execute_control() {
    local CONTROL_ID="2.1.18"
    local TITLE="Ensure web server services are not in use ((Automated)"
    local EXPECTED="Run the following command to verify apache2 is not installed:
# dpkg-query -s apache2 &>/dev/null && echo \"apache2 is installed\"
Nothing should be returned.
Run the following command to verify nginx is not installed:
# dpkg-query -s nginx &>/dev/null && echo \"nginx is installed\"
Nothing should be returned.
- OR - IF - a package is installed and is required for dependencies:
- IF - the httpd package is required for dependencies:
Run the following command to verify httpd.socket and httpd.service
UnitFileState is not enabled and ActiveState is not active:
# systemctl show httpd.socket httpd.service -p UnitFileState,ActiveState |
grep -Pi '=(enabled|active)'
Nothing should be returned
- IF - the nginx package is required for dependencies:
Run the following command to verify nginx.service UnitFileState is not enabled
and ActiveState is not active:
# systemctl show nginx.service -p UnitFileState,ActiveState | grep -Pi
'=(enabled|active)'
Nothing should be returned
Note:
•
•
Other web server packages may exist. They should also be audited, if not
required and authorized by local site policy
If the package is required for a dependency:
o Ensure the dependent package is approved by local site policy
o Ensure stopping and masking the service and/or socket meets local site
policy"
    local RISK="Unknown"
    local DESC="Web servers provide the ability to host web site content.

Rationale:
Unless there is a local site approved requirement to run a web server service on the
system, web server packages should be removed to reduce the potential attack surface."
    local ATTACK="Removal of a web server's package, or changing the state of its service and/or socket,
will prevent the server from hosting web services.
- IF - a web server package is required for a dependency, any related service or socket
should be stopped and masked.
Note: If the remediation steps to mask a service are followed and that package is not
installed on the system, the service and/or socket will still be masked. If the package is
installed due to an approved requirement to host a web server, the associated service
and/or socket would need to be unmasked before it could be enabled and/or started."
    local REMEDIATION="Run the following commands to stop httpd.socket, httpd.service and remove the
apache2 package:
# systemctl stop apache2.socket apache2.service
# apt purge apache2
Run the following commands to stop nginx.service and remove the nginx package:
# systemctl stop nginx.service
# apt purge nginx
- OR - IF - a package is installed and is required for dependencies:
- IF - the httpd package is required for dependencies:
Run the following commands to stop and mask httpd.socket and httpd.service:
# systemctl stop httpd.socket httpd.service
# systemctl mask httpd.socket httpd.service
- IF - the nginx package is required for dependencies:
Run the following commands to stop and mask nginx.service:
# systemctl stop nginx.service
# systemctl mask nginx.service
Note: Other web server packages may exist. If not required and authorized by local site
policy, they should also be removed. If the package is required for a dependency, the
service and socket should be stopped and masked."

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
