# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
EGO_PN="github.com/davidscholberg/go-durationfmt"

if [[ ${PV} == *9999* ]]; then
	inherit golang-vcs
else
	KEYWORDS="amd64"
	EGIT_COMMIT="64843a2"
	SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="Go library that allows you to format durations according to a format string"
HOMEPAGE="https://github.com/davidscholberg/go-durationfmt"
LICENSE="BSD-2"
SLOT="0"
IUSE=""
DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""
DOCS=(
	src/${EGO_PN}/README.md
)

src_install() {
	golang-build_src_install
	einstalldocs
}
