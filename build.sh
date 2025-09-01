#!/bin/bash
#Script to build buildroot configuration
#Author: Siddhant Jajoo

source shared.sh

EXTERNAL_REL_BUILDROOT=../base_external
git submodule init
git submodule sync
git submodule update

set -e 
cd `dirname $0`

if [ ! -e buildroot/.config ]
then
	echo "MISSING BUILDROOT CONFIGURATION FILE"

	if [ -e ${AESD_MODIFIED_DEFCONFIG} ]
	then
		echo "USING ${AESD_MODIFIED_DEFCONFIG}"
		make -C buildroot defconfig BR2_EXTERNAL=${EXTERNAL_REL_BUILDROOT} BR2_DEFCONFIG=${AESD_MODIFIED_DEFCONFIG_REL_BUILDROOT}
	else
		echo "Run ./save_config.sh to save this as the default configuration in ${AESD_MODIFIED_DEFCONFIG}"
		echo "Then add packages as needed to complete the installation, re-running ./save_config.sh as needed"
		make -C buildroot defconfig BR2_EXTERNAL=${EXTERNAL_REL_BUILDROOT} BR2_DEFCONFIG=${AESD_DEFAULT_DEFCONFIG}
	fi
else
	echo "USING EXISTING BUILDROOT CONFIG"
	echo "To force update, delete .config or make changes using make menuconfig and build again."
	SCRIPT_DIR="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"
	CONF_KERNEL_VER=$(awk -F= '$1=="BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE" {gsub(/"/, "", $2); print $2}' $SCRIPT_DIR/base_external/configs/aesd_qemu_defconfig)
	echo "Using Kernel version ${CONF_KERNEL_VER} for build."
	export KERNELDIR="${SCRIPT_DIR}/buildroot/output/build/linux-${CONF_KERNEL_VER}/"
	make -C buildroot BR2_EXTERNAL=${EXTERNAL_REL_BUILDROOT}
fi
