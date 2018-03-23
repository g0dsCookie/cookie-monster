# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 font

EGIT_REPO_URI="https://github.com/stark/siji.git"
if [[ "${PV}" != "9999" ]]; then
	EGIT_COMMIT_DATE="${PV}"
	KEYWORDS="amd64 x86"
fi

DESCRIPTION="An iconic bitmap font based on Stlarch with additional glyphs."
HOMEPAGE="https://github.com/stark/siji"

LICENSE="GPL-2"
SLOT="0"
IUSE="plugins"

DEPEND="plugins? ( x11-apps/xfd )"
RDEPEND="${DEPEND}"

FONT_S="${S}/pcf/"
FONT_SUFFIX="pcf"

src_install() {
	if use plugins; then
		mv "${S}/view.sh" "${PN}_view"
		dobin "${PN}_view"
	fi

	font_src_install
}
