#
# Copyright (C) 2007-2018 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=coova-chilli
PKG_VERSION:=1.7
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/coova/coova-chilli
PKG_SOURCE_VERSION:=$(PKG_VERSION)
PKG_MIRROR_HASH:=adf30c6c61d803770d2f9bcc225e85465edd816396bcf409cc503832cd45c2a3

PKG_MAINTAINER:=Jaehoon You <teslamint@gmail.com>
PKG_LICENSE:=GPL-2.0-or-later
PKG_LICENSE_FILES:=COPYING

include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/package.mk

define Package/coova-chilli
  SUBMENU:=Captive Portals
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Wireless LAN HotSpot controller (Coova Chilli Version)
  URL:=https://coova.github.io/
  MENU:=1
endef

define KernelPackage/ipt-coova
  URL:=http://www.coova.org/CoovaChilli
  SUBMENU:=Netfilter Extensions
  DEPENDS:=+kmod-ipt-core +libxtables
  TITLE:=Coova netfilter module
  FILES:=$(PKG_BUILD_DIR)/src/linux/xt_*.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoProbe,xt_coova)
endef

define KernelPackage/ipt-coova/description
	Netfilter kernel module for CoovaChilli
endef

define Build/Compile
	$(MAKE) $(PKG_JOBS) \
		-C "$(LINUX_DIR)" \
		$(PKG_MAKE_FLAGS) \
		M="$(PKG_BUILD_DIR)/src/linux"
endef

define Package/coova-chilli/install
endef

$(eval $(call BuildPackage,coova-chilli))
$(eval $(call KernelPackage,ipt-coova))
