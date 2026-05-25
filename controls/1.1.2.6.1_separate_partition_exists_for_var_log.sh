#!/usr/bin/env bash
# controls/1.1.2.6.1_separate_partition_exists_for_var_log.sh

execute_control() {
    local CONTROL_ID="1.1.2.6.1"
    local TITLE="Ensure separate partition exists for /var/log ((Automated)"
    local EXPECTED="Run the following command and verify output shows /var/log is mounted:
# findmnt -kn /var/log
/var/log /dev/sdb ext4
rw,nosuid,nodev,noexec,relatime,seclabel"
    local RISK="Unknown"
    local DESC="The /var/log directory is used by system services to store log data.

Rationale:
The default installation only creates a single / partition. Since the /var/log directory
contains log files which can grow quite large, there is a risk of resource exhaustion. It
will essentially have the whole disk available to fill up and impact the system as a whole.
Configuring /var/log as its own file system allows an administrator to set additional
mount options such as noexec/nosuid/nodev. These options limit an attackers ability
to create exploits on the system. Other options allow for specific behavior. See man
mount for exact details regarding filesystem-independent and filesystem-specific
options.
As /var/log contains log files, care should be taken to ensure the security and integrity
of the data and mount point."
    local ATTACK="Resizing filesystems is a common activity in cloud-hosted servers. Separate filesystem
partitions may prevent successful resizing, or may require the installation of additional
tools solely for the purpose of resizing operations. The use of these additional tools may
introduce their own security considerations."
    local REMEDIATION="For new installations, during installation create a custom partition setup and specify a
separate partition for /var/log .
For systems that were previously installed, create a new partition and configure
/etc/fstab as appropriate."

    local RESULT="FAIL"
    local CURRENT="Manual audit required. Please verify against the expected configuration."

    # NOTE: This is an auto-generated stub.
    # Add real bash logic to evaluate compliance status.

    save_result "$CONTROL_ID" "$TITLE" "$EXPECTED" "$CURRENT" "$RESULT" "$RISK" "$REMEDIATION" "$DESC" "$ATTACK"
}
