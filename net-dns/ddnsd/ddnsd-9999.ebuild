# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="DynDNS update client written in Go"
HOMEPAGE="https://github.com/g0dsCookie/ddnsd"
SRC="github.com/g0dsCookie/ddnsd"
S="${WORKDIR}/src/${SRC}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-lang/go-1.8"
RDEPEND="${DEPEND}"

src_unpack() {
	GOPATH="${WORKDIR}" go get -v -u ${SRC} || die
}

src_compile() {
	GOPATH="${WORKDIR}" go install -v ${SRC} || die
}

src_install() {
	dobin "${WORKDIR}/bin/ddnsd"
	newinitd "${FILESDIR}/${PN}.initd" ${PN}
	insinto "/etc/ddnsd"
	doins "${S}/ddnsd.xml.example"
}
