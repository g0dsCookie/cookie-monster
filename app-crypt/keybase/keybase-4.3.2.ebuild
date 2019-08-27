# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/keybase/client"
EGO_PN_KEYBASE="${EGO_PN}/go/keybase"
EGO_PN_KBFS="${EGO_PN}/go/kbfs/kbfsfuse"
EGO_BUILD_FLAGS="-tags production"

if [[ ${PV} == *9999* ]]; then
	inherit golang-vcs
else
	SRC_URI="https://github.com/keybase/client/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	inherit golang-vcs-snapshot
fi

inherit golang-build

DESCRIPTION="Client for keybase.io"
HOMEPAGE="https://keybase.io/"

LICENSE="BSD"
SLOT="0"
IUSE="+fuse"

DEPEND="app-crypt/gnupg"
RDEPEND="${DEPEND}"

src_compile() {
	EGO_PN="${EGO_PN_KEYBASE}" golang-build_src_compile
	EGO_PN="${EGO_PN_KBFS}" golang-build_src_compile
}

src_install() {
	dobin keybase
	dobin kbfsfuse
}
