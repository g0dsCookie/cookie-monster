# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/davidscholberg/goblocks/..."

if [[ ${PV} == *9999* ]]; then
	inherit golang-vcs
else
	SRC_URI="https://github.com/davidscholberg/goblocks/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="Fast, lightweight i3status replacement written in Go"
HOMEPAGE="https://github.com/davidscholberg/goblocks"

LICENSE="BSD-2"
SLOT="0"
IUSE=""

DEPEND="
	>=dev-lang/go-1.7
	dev-go/go-durationfmt
	dev-go/go-i3barjson
	dev-go/go-yaml
"
RDEPEND="${DEPEND}"
BDEPEND=""

DOCS=(
	src/github.com/davidscholberg/goblocks/README.md
	src/github.com/davidscholberg/goblocks/config/goblocks-full.yml
	src/github.com/davidscholberg/goblocks/config/goblocks-screenshot.yml
)

PATCHES=(
	"${FILESDIR}/go-yaml.patch"
)

src_install() {
	golang-build_src_install
	einstalldocs
	dobin bin/*
}
