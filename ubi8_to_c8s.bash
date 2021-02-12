#!/usr/bin/env bash

# set variable
CENTOS_GPG_KEY="http://mirror.centos.org/centos/8-stream/BaseOS/x86_64/os/Packages/centos-gpg-keys-8-2.el8.noarch.rpm"
CENTOS_STREAM_REPOS="http://mirror.centos.org/centos/8-stream/BaseOS/x86_64/os/Packages/centos-stream-repos-8-2.el8.noarch.rpm"
CENTOS_STREAM_RELEASE="http://mirror.centos.org/centos/8-stream/BaseOS/x86_64/os/Packages/centos-stream-release-8.4-1.el8.noarch.rpm"

# THIS SCRIPT MUST RUN AS ROOT IN UBI CONTIAINER

# Disable RHEL flavored configuration
/usr/bin/dnf remove -y dnf-plugin-subscription-manager python3-subscription-manager-rhsm subscription-manager subscription-manager-rhsm-certificates 
/usr/bin/dnf config-manager --set-disabled ubi-8-*

# Install CentOS Stream 8 repos
/usr/bin/dnf install --releasever=8 -y ${CENTOS_GPG_KEY} ${CENTOS_STREAM_REPOS}
/usr/bin/rpm -v --import  /etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial

# Remove RHEL 8 Release Data
/usr/bin/rpm -v --nodeps -e redhat-release

# Install CentOS Stream 8 Release Data
/usr/bin/dnf install --releasever=8 -y centos-stream-release

# Re-sync the distro pacakges
/usr/bin/dnf distro-sync --setopt=install_weak_deps=False  -y

# Clean packages
/usr/bin/dnf -y autoremove
/usr/bin/dnf clean all
rm -rf /var/cache/*
