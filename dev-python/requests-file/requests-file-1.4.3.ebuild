# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_6 )
inherit distutils-r1

DESCRIPTION="Transport adapter for fetching file:// URLs with the requests python library"
HOMEPAGE="https://github.com/dashea/requests-file"
SRC_URI="https://github.com/dashea/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="requests-file"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	>=dev-python/requests-1.0[${PYTHON_USEDEP}]
	dev-python/six
"
RDEPEND="${DEPEND}"
BDEPEND=""
