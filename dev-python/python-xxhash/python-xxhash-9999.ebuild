# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ifduyue/python-xxhash.git"
	EGIT_SUBMODULES=()
	EGIT_COMMIT_DATE="${PV}"
else
	SRC_URI="https://github.com/ifduyue/${PN}/archive/v${PV}.tar.gz"
	KEYWORDS="amd64 x86"
fi

PYTHON_COMPAT=( python2_7 python3_6 )
inherit distutils-r1

DESCRIPTION="Python Binding for xxHash"
HOMEPAGE="https://github.com/ifduyue/python-xxhash"

LICENSE="BSD-2"
SLOT="0"
IUSE=""

DEPEND="dev-libs/xxhash"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	export XXHASH_LINK_SO=1
	distutils-r1_src_configure "$@"
}

src_compile() {
	export XXHASH_LINK_SO=1
	distutils-r1_src_compile "$@"
}
