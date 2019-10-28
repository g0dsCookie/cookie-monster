# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_6 )
inherit distutils-r1

DESCRIPTION="Manipulate DNS records on various DNS providers in a standardized way"
HOMEPAGE="https://github.com/AnalogJ/lexicon"
SRC_URI="https://github.com/AnalogJ/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="route53 subreg plesk"

DEPEND="
	dev-python/requests[${PYTHON_USEDEP},ssl]
	dev-python/future[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/tldextract[${PYTHON_USEDEP}]
	route53? ( dev-python/boto3[${PYTHON_USEDEP}] )
	subreg? ( dev-python/zeep[${PYTHON_USEDEP}] )
	plesk? ( dev-python/xmltodict[${PYTHON_USEDEP}] )
"
RDEPEND="${DEPEND}"
BDEPEND=""
