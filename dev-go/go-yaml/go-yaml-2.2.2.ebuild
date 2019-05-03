# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
EGO_PN=github.com/go-yaml/yaml

if [[ ${PV} == *9999* ]]; then
	inherit golang-vcs
else
	KEYWORDS="amd64"
	SRC_URI="https://github.com/go-yaml/yaml/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="YAML support for the Go language."
HOMEPAGE="https://github.com/go-yaml/yaml"
LICENSE="Apache-2.0"
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
