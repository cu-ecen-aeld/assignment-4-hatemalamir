
##############################################################
#
# LDD
#
##############################################################

LDD_VERSION = 6e6222ff169d4ea84a9f731755ae54a06eb8dc1a
LDD_SITE = git@github.com:cu-ecen-aeld/assignment-7-hatemalamir.git
LDD_SITE_METHOD = git
LDD_GIT_SUBMODULES = YES

LDD_LICENSE_FILES = COPYING
LDD_MODULE_SUBDIRS = misc-modules scull
LDD_MODULE_MAKE_OPTS = KVERSION=$(LINUX_VERSION_PROBED)

define LDD_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) ARCH=$(KERNEL_ARCH) CROSS_COMPILE=$(TARGET_CROSS) -C $(@D)/scull
	$(MAKE) $(TARGET_CONFIGURE_OPTS) ARCH=$(KERNEL_ARCH) CROSS_COMPILE=$(TARGET_CROSS) -C $(@D)/misc-modules
endef

define LDD_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0644 $(@D)/scull/*.ko $(TARGET_DIR)/usr/bin/
	$(MAKE) $(TARGET_CONFIGURE_OPTS) ARCH=$(KERNEL_ARCH) CROSS_COMPILE=$(TARGET_CROSS) -C $(@D)/misc-modules INSTALL_MOD_PATH=$(TARGET_DIR) modules_install
endef

$(eval $(kernel-module))
$(eval $(generic-package))
