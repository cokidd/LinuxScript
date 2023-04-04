#!/bin/bash

# reboot Confirm Option
function RebootConfirm() {
    echo "This Operation need Reboot System, Are you confrim? (y/n)"
    read confirmOption
    if [ "$confirmOption" == "y" ];then
        reboot
    else
        echo "Do nothing but /etc/selinux/config is modify"
    fi
}

# check system selinux status 
function SelinuxStatus() {
    echo `getenforce`
}

# set Selinux Permissive
function SelinuxSetPermissive() {
    sed -ri 's/(^SELINUX=)[a-z]*/\1permissive/g' /etc/selinux/config
    RebootConfirm
}

# set Selinux Disabled
function SelinuxSetDisabled() {
    sed -ri 's/(^SELINUX=)[a-z]*/\1disabled/g' /etc/selinux/config
    RebootConfirm
}

# set Selinux Enabled
function SelinuxSetEnabled() {
    sed -ri 's/(^SELINUX=)[a-z]*/\1enforcing/g' /etc/selinux/config
    RebootConfirm
}

# main function
function SelinuxMain(){
if [ "$1" == "status" ];then
SelinuxStatus
elif [ "$1" == "disabled" ];then
SelinuxSetDisabled
elif [ "$1" == "permissive" ];then
SelinuxSetPermissive
elif [ "$1" == "enable" ];then
SelinuxSetEnabled
else
echo "status: Get Selinux status"
echo "enable: Enable Selinux"
echo "disabled: Disabled Selinux"
echo "permissive: Permissive Selinux"
fi
}

SelinuxMain $1