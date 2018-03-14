# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit golang-base git-r3

EGIT_REPO_URI="https://github.com/Cutehacks/qpm.git"
if [[ "${PV}" != "9999" ]]; then
	EGIT_COMMIT_DATE="${PV}"
fi

DESCRIPTION="A package manager for Qt."
HOMEPAGE="https://www.qpm.io"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/src/qpm.io"
EGIT_CHECKOUT_DIR="${S}"

src_compile() {
	GOPATH="${WORKDIR}" go install -v -work -x -ldflags="-s" "qpm.io/qpm"
}

src_install() {
	dobin "${WORKDIR}/bin/qpm"
	dodoc "${WORKDIR}/src/qpm.io/README.md"
}
