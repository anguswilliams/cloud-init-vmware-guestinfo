ROOT_BUILD_DIR=target

PIP_CMD=pip3
PYTHON_REQUIREMENTS_DIR=$(ROOT_BUILD_DIR)/python_requirements

PKG_VERSION=1.3.1
PKG_ITERATION=1
PKG_NAME=cloud-init-vmware-guestinfo
PKG_DESCRIPTION="A cloud-init datasource that uses VMware GuestInfo"
PKG_MAINTAINER="Andrew Kutz <akutz@vmware.com>"
PKG_ARCH=all
PKG_ARCH_RPM=noarch

all: clean build
rpm: rpm-el7
deb: deb-bionic deb-focal
build: clean rpm deb

clean:
	@rm -rf "$(ROOT_BUILD_DIR)"

deb-bionic: build_dir=$(ROOT_BUILD_DIR)/deb-bionic
deb-bionic:
	@mkdir -p $(build_dir)/BUILD/usr/lib/python3/dist-packages/cloudinit/sources/
	@mkdir -p $(build_dir)/BUILD/etc/cloud/cloud.cfg.d/
	@mkdir -p $(build_dir)/BUILD/usr/bin
	@cp DataSourceVMwareGuestInfo.py $(build_dir)/BUILD/usr/lib/python3/dist-packages/cloudinit/sources/
	@cp 99-DataSourceVMwareGuestInfo.cfg $(build_dir)/BUILD/etc/cloud/cloud.cfg.d/
	@cp dscheck_VMwareGuestInfo.sh $(build_dir)/BUILD/usr/bin/dscheck_VMwareGuestInfo
	@chmod 0755 $(build_dir)/BUILD/usr/bin/dscheck_VMwareGuestInfo
	fpm --output-type deb \
		--input-type dir \
		--package $(build_dir)/ \
		--depends python3-netifaces \
		--depends python3-distutils \
		--depends cloud-init \
		--version $(PKG_VERSION) \
		--iteration $(PKG_ITERATION) \
		--name $(PKG_NAME) \
		--chdir $(build_dir)/BUILD \
		--maintainer $(PKG_MAINTAINER) \
		--description $(PKG_DESCRIPTION) \
		--architecture $(PKG_ARCH) \
		--verbose \
		etc usr

deb-focal: build_dir=$(ROOT_BUILD_DIR)/deb-focal
deb-focal:
	@mkdir -p $(build_dir)/BUILD/usr/lib/python3/dist-packages/cloudinit/sources/
	@mkdir -p $(build_dir)/BUILD/etc/cloud/cloud.cfg.d/
	@mkdir -p $(build_dir)/BUILD/usr/bin
	@cp DataSourceVMwareGuestInfo.py $(build_dir)/BUILD/usr/lib/python3/dist-packages/cloudinit/sources/
	@cp 99-DataSourceVMwareGuestInfo.cfg $(build_dir)/BUILD/etc/cloud/cloud.cfg.d/
	@cp dscheck_VMwareGuestInfo.sh $(build_dir)/BUILD/usr/bin/dscheck_VMwareGuestInfo
	@chmod 0755 $(build_dir)/BUILD/usr/bin/dscheck_VMwareGuestInfo
	fpm --output-type deb \
		--input-type dir \
		--package $(build_dir)/ \
		--depends python3-netifaces \
		--depends python3-distutils \
		--depends cloud-init \
		--version $(PKG_VERSION) \
		--iteration $(PKG_ITERATION) \
		--name $(PKG_NAME) \
		--chdir $(build_dir)/BUILD \
		--maintainer $(PKG_MAINTAINER) \
		--description $(PKG_DESCRIPTION) \
		--architecture $(PKG_ARCH) \
		--verbose \
		etc usr

rpm-el8: build_dir=$(ROOT_BUILD_DIR)/rpm-el8
rpm-el8:
	@mkdir -p $(build_dir)/BUILD/usr/lib/python3.6/site-packages/cloudinit/sources/
	@mkdir -p $(build_dir)/BUILD/etc/cloud/cloud.cfg.d/
	@mkdir -p $(build_dir)/BUILD/usr/bin
	@cp DataSourceVMwareGuestInfo.py $(build_dir)/BUILD/usr/lib/python3.6/site-packages/cloudinit/sources/
	@cp 99-DataSourceVMwareGuestInfo.cfg $(build_dir)/BUILD/etc/cloud/cloud.cfg.d/
	@cp dscheck_VMwareGuestInfo.sh $(build_dir)/BUILD/usr/bin/dscheck_VMwareGuestInfo
	@chmod 0755 $(build_dir)/BUILD/usr/bin/dscheck_VMwareGuestInfo
	fpm --output-type rpm \
		--input-type dir \
		--package $(build_dir)/ \
		--depends python3-netifaces \
		--depends cloud-init \
		--version $(PKG_VERSION) \
		--iteration $(PKG_ITERATION) \
		--name $(PKG_NAME) \
		--chdir $(build_dir)/BUILD \
		--maintainer $(PKG_MAINTAINER) \
		--description $(PKG_DESCRIPTION) \
		--architecture $(PKG_ARCH) \
		--verbose \
		etc usr

rpm-el7: build_dir=$(ROOT_BUILD_DIR)/rpm-el7
rpm-el7:
	@mkdir -p $(build_dir)/BUILD/usr/lib/python2.7/site-packages/cloudinit/sources/
	@mkdir -p $(build_dir)/BUILD/etc/cloud/cloud.cfg.d/
	@mkdir -p $(build_dir)/BUILD/usr/bin
	@cp DataSourceVMwareGuestInfo.py $(build_dir)/BUILD/usr/lib/python2.7/site-packages/cloudinit/sources/
	@cp 99-DataSourceVMwareGuestInfo.cfg $(build_dir)/BUILD/etc/cloud/cloud.cfg.d/
	@cp dscheck_VMwareGuestInfo.sh $(build_dir)/BUILD/usr/bin/dscheck_VMwareGuestInfo
	@chmod 0755 $(build_dir)/BUILD/usr/bin/dscheck_VMwareGuestInfo
	fpm --output-type rpm \
		--input-type dir \
		--package $(build_dir)/ \
		--depends python-netifaces \
		--depends cloud-init \
		--version $(PKG_VERSION) \
		--iteration $(PKG_ITERATION) \
		--name $(PKG_NAME) \
		--chdir $(build_dir)/BUILD \
		--maintainer $(PKG_MAINTAINER) \
		--description $(PKG_DESCRIPTION) \
		--architecture $(PKG_ARCH) \
		--verbose \
		etc usr
