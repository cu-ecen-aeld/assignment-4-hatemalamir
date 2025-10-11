
##############################################################
#
# AESDCHAR
#
##############################################################

AESDCHAR_VERSION = cbd4a2ef638d7d5a0eb5ba6ad75c32d66b020fcb
AESDCHAR_SITE = git@github.com:cu-ecen-aeld/assignments-3-and-later-hatemalamir.git
AESDCHAR_SITE_METHOD = git
AESDCHAR_GIT_SUBMODULES = YES

AESDCHAR_LICENSE_FILES = COPYING
AESDCHAR_MODULE_SUBDIRS = aesd-char-driver
AESDCHAR_MODULE_MAKE_OPTS = KVERSION=$(LINUX_VERSION_PROBED)

define AESDCHAR_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) ARCH=$(KERNEL_ARCH) CROSS_COMPILE=$(TARGET_CROSS) -C $(@D)/aesd-char-driver
endef

define AESDCHAR_INSTALL_TARGET_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) ARCH=$(KERNEL_ARCH) CROSS_COMPILE=$(TARGET_CROSS) -C $(@D)/aesd-char-driver INSTALL_MOD_PATH=$(TARGET_DIR) modules_install
	$(INSTALL) -m 0755 $(@D)/aesd-char-driver/aesdchar_load $(TARGET_DIR)/usr/sbin/
	$(INSTALL) -m 0755 $(@D)/aesd-char-driver/aesdchar_unload $(TARGET_DIR)/usr/sbin/
	$(INSTALL) -m 0755 $(@D)/aesd-char-driver/S97aesdchar $(TARGET_DIR)/etc/init.d/
endef

$(eval $(kernel-module))
$(eval $(generic-package))
