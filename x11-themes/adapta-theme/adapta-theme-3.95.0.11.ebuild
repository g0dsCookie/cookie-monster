# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="An adaptive Gtk+ theme based on Material Design Guidelines"
HOMEPAGE="https://github.com/adapta-project/adapta-gtk-theme"
SRC_URI="https://github.com/adapta-project/adapta-gtk-theme/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="adapta-theme"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome cinnamon flashback xfce mate openbox chrome-legacy"

DEPEND="
	>=media-gfx/inkscape-0.91
	>=x11-libs/gdk-pixbuf-2.32.2
	>=dev-libs/glib-2.56.4
	dev-libs/libxml2
	>=dev-lang/sassc-3.3
"
RDEPEND="${DEPEND}"
BDEPEND="
	sys-process/parallel
"

S="${WORKDIR}/adapta-gtk-theme-${PV}"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		--enable-parallel \
		$(use_enable gnome) \
		$(use_enable cinnamon) \
		$(use_enable flashback) \
		$(use_enable xfce) \
		$(use_enable mate) \
		$(use_enable openbox) \
		$(use_enable chrome-legacy)
}
