
##############################################################
#
# AESDCHAR
#
##############################################################

AESDCHAR_VERSION = 48f8af60c64c963b8d00f29f146311b0041d5362
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
