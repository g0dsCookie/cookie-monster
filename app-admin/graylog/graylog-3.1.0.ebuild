# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Free and open source log management"
HOMEPAGE="https://graylog.org"
SRC_URI="
	https://downloads.graylog.org/releases/${PN}/${P}.tgz
	enterprise? ( https://downloads.graylog.org/releases/graylog-enterprise/graylog-enterprise-plugins-${PV}.tgz )
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="enterprise"

RDEPEND="
	virtual/jdk:1.8
	acct-user/graylog
	acct-group/graylog
"

DOCS=(
	COPYING README.markdown UPGRADING.rst
)

GRAYLOG_DATA_DIR="/var/lib/graylog"
GRAYLOG_INSTALL_DIR="/usr/share/graylog"
QA_PREBUILT="${GRAYLOG_INSTALL_DIR}/lib/sigar/libsigar*"

src_prepare() {
	default

	# Stick to architecture of build host
	if ! use amd64; then
		rm -r lib/sigar/libsigar-amd64-*.so || die "Failed in removing AMD64 support libraries"
	fi
	if ! use ppc64; then
		rm -r lib/sigar/libsigar-ppc64-*.so || die "Failed in removing PPC64 support libraries"
	fi
	if ! use x86; then
		rm -r lib/sigar/libsigar-x86-*.so || die "Failed in removing X86 support libraries"
	fi
	# Currently unsupported platforms
	# QA warning galore but testing/patches welcome
	rm lib/sigar/libsigar-*freebsd*so \
		lib/sigar/libsigar-*solaris*so \
		lib/sigar/libsigar-*hpux*.sl \
		lib/sigar/libsigar-*macosx*.dylib \
		lib/sigar/libsigar-ia64-*.so \
		lib/sigar/libsigar-ppc-*.so \
		lib/sigar/libsigar-s390x*.so \
		lib/sigar/*winnt* || die "Failed in removing unsupported platform libraries"

	# gentoo specific paths
	sed -i "s@\(node_id_file = \).*@\1${GRAYLOG_DATA_DIR}/node-id@g; \
		s@\(message_journal_dir = \).*@\1${GRAYLOG_DATA_DIR}/data/journal@g; \
		s@#\(content_packs_dir = \).*@\1${GRAYLOG_DATA_DIR}/data/contentpacks@g" \
		graylog.conf.example || die
}

src_install() {
	default

	insinto /etc/graylog
	doins graylog.conf.example

	#insinto "${GRAYLOG_DATA_DIR}/data/contentpacks"
	#doins data/contentpacks/grok-patterns.json

	insinto "${GRAYLOG_INSTALL_DIR}"
	doins graylog.jar
	doins -r bin lib plugin

	if use enterprise; then
		pushd "${WORKDIR}/graylog-enterprise-plugins-${PV}" || die
		doins -r bin plugin
		popd || die
	fi

	newconfd "${FILESDIR}/confd-r2" graylog
	newinitd "${FILESDIR}/initd-r2" graylog
}
