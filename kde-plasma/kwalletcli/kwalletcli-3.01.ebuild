# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Command-Line Interface for the KDE Wallet"
HOMEPAGE="https://www.mirbsd.org/kwalletcli.htm"
SRC_URI="https://www.mirbsd.org/MirOS/dist/hosted/kwalletcli/${P}.tar.gz"

LICENSE="MirOS"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtwidgets:5
	kde-frameworks/kcoreaddons:5
	kde-frameworks/kwallet:5
	kde-frameworks/ki18n:5
"
RDEPEND="
	${DEPEND}
	app-shells/mksh
"

S="${WORKDIR}/${PN}"

src_compile() {
	emake KDE_VER=5 CFLAGS="${CFLAGS} -fPIC" CXXFLAGS="${CXXFLAGS} -fPIC"
}

src_install() {
	dobin kwalletcli kwalletaskpass kwalletcli_getpin pinentry-kwallet
	doman kwalletcli.1 kwalletaskpass.1 kwalletcli_getpin.1 pinentry-kwallet.1
	doinfo LICENCE
}
