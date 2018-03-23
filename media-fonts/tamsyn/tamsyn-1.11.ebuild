# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit font

DESCRIPTION="Monospaced programming font for Linux and Windows"
HOMEPAGE="http://www.fial.com/~scott/tamsyn-font/"
SRC_URI="http://www.fial.com/~scott/tamsyn-font/download/tamsyn-font-${PV}.tar.gz"

LICENSE="tamsyn"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/tamsyn-font-${PV}"
FONT_S="${PN}"
FONT_SUFFIX="pcf"
