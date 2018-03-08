# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
EGO_PN="github.com/g0dsCookie/gopbo"

EGO_VENDOR=(
	"github.com/google/subcommands ce3d4cfc062faac7115d44e5befec8b5a08c3faa"
	"github.com/dustin/go-humanize bb3d318650d48840a39aa21a027c6630e198e626"
)

if [[ ${PV} == *9999 ]]; then
	inherit golang-vcs
else
	EGIT_COMMIT="v${PV}"
	inherit golang-vcs-snapshot
	SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"
	KEYWORDS="~amd64 ~x86"
fi
inherit golang-build

DESCRIPTION="gopbo is used to (un)pack/validate PBO files."
HOMEPAGE="https://github.com/g0dsCookie/gopbo"

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	dobin gopbo
}
