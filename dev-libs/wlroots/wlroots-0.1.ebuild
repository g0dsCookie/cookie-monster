# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MESON_AUTO_DEPEND=no
inherit meson

DESCRIPTION="A modular Wayland compositor library"
HOMEPAGE="https://swaywm.org"
SRC_URI="https://github.com/swaywm/wlroots/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="caps logind elogind systemd xorg xwayland xkb icccm examples"

REQUIRED_USE="
	logind? ( ^^ ( elogind systemd ) )
	elogind? ( logind )
	systemd? ( logind )
	xorg? ( xwayland )
"

DEPEND="
	>=dev-libs/wayland-1.16
	>=dev-libs/wayland-protocols-1.15
	>=dev-libs/libinput-1.7
	caps? ( sys-libs/libcap )
	elogind? ( >=sys-auth/elogind-237 )
	systemd? ( sys-apps/systemd )
	media-libs/mesa[egl,gbm,gles2]
	x11-libs/libdrm
	x11-libs/libxkbcommon
	x11-libs/pixman
	virtual/libudev
	xwayland? ( x11-libs/libxcb[xkb?] )
	xorg? ( x11-libs/libX11 )
"
RDEPEND="${DEPEND}"
BDEPEND="
	>=dev-util/meson-0.47
	>=dev-util/ninja-1.7.2
"

src_configure() {
	local emesonargs=(
		-Dlibcap=$(usex caps enabled disabled)
		-Dlogind=$(usex logind enabled disabled)
		-Dxcb-icccm=$(usex icccm enabled disabled)
		-Dxcb-xkb=$(usex xkb enabled disabled)
		-Dxwayland=$(usex xwayland enabled disabled)
		-Dx11-backend=$(usex xorg enabled disabled)
		$(meson_use examples)
		$(meson_use examples rootston)
	)
	if use elogind; then
		emesonargs+=(-Dlogind-provider=elogind)
	elif use systemd; then
		emesonargs+=(-Dlogind-provider=systemd)
	fi
	meson_src_configure
}
