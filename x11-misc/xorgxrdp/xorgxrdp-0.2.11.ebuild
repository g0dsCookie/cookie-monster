# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Xorg drivers for xrdp"
HOMEPAGE="https://github.com/neutrinolabs/xorgxrdp"
SRC_URI="https://github.com/neutrinolabs/${PN}/releases/download/v${PV}/${P}.tar.gz"

LICENSE="X11"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
	x11-base/xorg-server
	net-misc/xrdp
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-lang/nasm
"

DOCS=( "${S}/README.md" )

src_configure() {
	./bootstrap || die
	econf
}
