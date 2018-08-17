# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
EGO_PN="github.com/olekukonko/tablewriter/..."
EGO_SRC="github.com/olekukonko/tablewriter"

if [[ ${PV} == *9999* ]]; then
	inherit golang-vcs
else
	KEYWORDS="~amd64 ~x86"
	EGIT_COMMIT="d4647c9c7a84d847478d890b816b7d8b62b0b279"
	SRC_URI="https://${EGO_SRC}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="ASCII table in golang"
HOMEPAGE="https://github.com/olekukonko/tablewriter"
LICENSE="MIT"
SLOT="0"
IUSE=""
DEPEND="
	>=dev-go/mattn-runewidth-0.0.3
"
RDEPEND="${DEPEND}"
