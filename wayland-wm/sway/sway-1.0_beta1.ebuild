# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="i3-compatible Wayland compositor"
HOMEPAGE="https://swaywm.org"
MY_VER="1.0-beta.1"
SRC_URI="https://github.com/swaywm/sway/archive/${MY_VER}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+xwayland logind elogind systemd wallpaper zsh-completions bash-completions fish-completions"
REQUIRED_USE="
	logind? ( ^^ ( elogind systemd ) )
	elogind? ( logind )
	systemd? ( logind )
"

DEPEND="
	>=dev-libs/json-c-0.13
	dev-libs/libpcre
	dev-libs/wlroots[logind?,elogind?,systemd?,xwayland?]
	dev-libs/wayland
	>=dev-libs/wayland-protocols-1.14
	>=dev-libs/libinput-1.6
	sys-libs/libcap
	>=sys-apps/dbus-1.10
	x11-libs/pango
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	virtual/pam
	xwayland? ( x11-libs/libxcb )
"
RDEPEND="${DEPEND}"
BDEPEND="
	app-text/scdoc
"

S="${WORKDIR}/sway-${MY_VER}"

src_configure() {
	local emesonargs=(
		-Dsway-version=${MY_VER}
		-Ddefault-wallpaper=$(usex wallpaper true false)
		-Dzsh-completions=$(usex zsh-completions true false)
		-Dbash-completions=$(usex bash-completions true false)
		-Dfish-completions=$(usex fish-completions true false)
		-Denable-xwayland=$(usex xwayland true false)
	)
	meson_src_configure
}

src_install() {
	meson_src_install

	if ! use logind; then
		ewarn "Sway has been installed without logind support (elogind/systemd)"
		ewarn "The sway binary will be setuid."
		fperms 4711 /usr/bin/sway
	fi
}
