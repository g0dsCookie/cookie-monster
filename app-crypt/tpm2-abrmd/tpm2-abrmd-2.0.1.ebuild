# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="TPM2 Access Broker & Resource Management Daemon implementing the TCG spec."
HOMEPAGE="https://github.com/tpm2-software/tpm2-abrmd"
SRC_URI="https://github.com/tpm2-software/${PN}/releases/download/${PV}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	sys-apps/dbus
	dev-libs/tpm2-tss
"
RDEPEND="${DEPEND}"

pkg_setup() {
	enewgroup tss
	enewuser tss -1 -1 /var/lib/tpm tss
}

src_install() {
	newinitd "${FILESDIR}/${PN}.initd" "${PN}"
	fowners tss:tss /var/lib/tpm
	default
}
