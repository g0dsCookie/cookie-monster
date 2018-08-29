# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="The source repository for the TPM (Trusted Platform Module) 2 tools"
HOMEPAGE="https://github.com/tpm2-software/tpm2-tools"
SRC_URI="https://github.com/tpm2-software/${PN}/releases/download/${PV}/${P}.tar.gz"

LICENSE="Intel-SDP"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-libs/tpm2-tss
"
RDEPEND="${DEPEND}"
