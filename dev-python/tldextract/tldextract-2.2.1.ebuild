# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_6 )
inherit distutils-r1

DESCRIPTION="Accurately separate the TLD from the registered domain and subdomains"
HOMEPAGE="https://github.com/john-kurkowski/tldextract"
SRC_URI="https://github.com/john-kurkowski/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="tldextract"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-python/idna[${PYTHON_USEDEP}]
	>=dev-python/requests-2.1[${PYTHON_USEDEP}]
	dev-python/requests-file
"
RDEPEND="${DEPEND}"
BDEPEND=""
