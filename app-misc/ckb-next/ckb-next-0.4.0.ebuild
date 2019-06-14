# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils xdg-utils

DESCRIPTION="RGB Driver for Linux and macOS"
HOMEPAGE="https://github.com/ckb-next/ckb-next"
SRC_URI="https://github.com/ckb-next/ckb-next/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="pulseaudio portaudio +qt5"

DEPEND="
	!!app-misc/ckb
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtnetwork:5
		dev-qt/qtwidgets:5
		x11-libs/libX11
	)
	portaudio? ( media-libs/portaudio )
	pulseaudio? ( media-sound/pulseaudio )
	dev-libs/quazip
	virtual/libudev:=
"
RDEPEND="${DEPEND}"
BDEPEND=""

DOCS=(README.md CHANGELOG.md LICENSE)
PATCHES=("${FILESDIR}/fix-udev-path.patch")

src_configure() {
	local mycmakeargs=(
		-DDISABLE_UPDATER=1
		-DWITH_GUI=$(usex qt5 ON OFF)
		-DWITH_PORTAUDIO=$(usex portaudio ON OFF)
	)
	cmake-utils_src_configure
}

pkg_postrm() {
	xdg_icon_cache_update
}

pkg_postinst() {
	xdg_icon_cache_update
}
