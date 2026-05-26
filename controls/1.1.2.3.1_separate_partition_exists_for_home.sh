#!/usr/bin/env bash
# controls/1.1.2.3.1_separate_partition_exists_for_home.sh

execute_control() {
    local CONTROL_ID="1.1.2.3.1"
    local TITLE="Ensure separate partition exists for /home ((Automated)"
    local EXPECTED="Run the following command and verify output shows /home is mounted:
# findmnt -kn /home
/home
/dev/sdb
ext4
rw,nosuid,nodev,relatime,seclabel"
    local RISK="Unknown"
    local DESC="The /home directory is used to support disk storage needs of local users.

Rationale:
The default installation only creates a single / partition. Since the /home directory
contains user generated data, there is a risk of resource exhaustion. It will essentially
have the whole disk available to fill up and impact the system as a whole. In addition,
other operations on the system could fill up the disk unrelated to /home and impact all
local users.
Configuring /home as its own file system allows an administrator to set additional mount
options such as noexec/nosuid/nodev. These options limit an attacker's ability to
create exploits on the system. In the case of /home options such as
usrquota/grpquota may be considered to limit the impact that users can have on each
other with regards to disk resource exhaustion. Other options allow for specific
behavior. See man mount for exact details regarding filesystem-independent and
filesystem-specific options.
As /home contains user data, care should be taken to ensure the security and integrity
of the data and mount point."
    local ATTACK="Resizing filesystems is a common activity in cloud-hosted servers. Separate filesystem
partitions may prevent successful resizing or may require the installation of additional
tools solely for the purpose of resizing operations. The use of these additional tools may
introduce their own security considerations."
    local REMEDIATION="For new installations, during installation create a custom partition setup and specify a
separate partition for /home.
For systems that were previously installed, create a new partition and configure
/etc/fstab as appropriate."

    local RESULT="PASS"
    local CURRENT=""

    local MOUNT_CHECK=$(findmnt -kn "/home" 2>/dev/null)
    local SYSTEMD_CHECK=$(systemctl is-enabled $(systemd-escape --suffix=mount "/home") 2>/dev/null || echo "")

    if [ -n "$MOUNT_CHECK" ]; then
        CURRENT="/home is mounted. Systemd status: ${SYSTEMD_CHECK:-unknown}"
        RESULT="PASS"
    else
        CURRENT="/home is not mounted as a separate partition or tmpfs."
        RESULT="FAIL"
    fi
    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
