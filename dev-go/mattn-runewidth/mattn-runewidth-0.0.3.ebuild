# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
EGO_PN="github.com/mattn/go-runewidth"

if [[ ${PV} == *9999* ]]; then
	inherit golang-vcs
else
	KEYWORDS="~amd64 ~x86"
	EGIT_COMMIT="v${PV}"
	SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="Provides functions to get fixed width of the character or string."
HOMEPAGE="https://github.com/mattn/go-runewidth"
LICENSE="MIT"
SLOT="0"
IUSE=""
DEPEND=""
RDEPEND="${DEPEND}"
