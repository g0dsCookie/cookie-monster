# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="case insensitive on purpose file system"
HOMEPAGE="http://www.brain-dump.org/projects/ciopfs/"
SRC_URI="http://www.brain-dump.org/projects/ciopfs/ciopfs-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="icu"

DEPEND="
	sys-apps/attr
	sys-fs/fuse:*
	icu? ( dev-libs/icu )
"
RDEPEND="${DEPEND}"

src_compile() {
	if use icu; then
		emake unicode-icu
	else
		emake ciopfs
	fi
}

src_install() {
	dobin ciopfs
	dosym ciopfs /usr/bin/mount.ciopfs
}
