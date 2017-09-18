# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 font

DESCRIPTION="An iconic bitmap font based on Stlarch with additional glyphs."
HOMEPAGE="https://github.com/stark/siji"
EGIT_REPO_URI="https://github.com/stark/siji.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="plugins"

DEPEND="plugins? ( x11-apps/xfd )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-9999/pcf/"
FONT_S="${PN}"
FONT_SUFFIX="pcf"

pkg_preinst() {
	if use plugins; then
		mv "${WORKDIR}/${PN}-9999/view.sh" "${PN}_view"
		dobin "${PN}_view"
	fi
}
