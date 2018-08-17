# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGO_PN="github.com/cloudflare/cloudflare-go"

if [[ "${PV}" == *9999* ]]; then
	inherit golang-vcs
else
	KEYWORDS="~amd64 ~x86"
	EGIT_COMMIT=v${PV}
	SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="Go library for the Cloudflare v4 API"
HOMEPAGE="https://github.com/cloudflare/cloudflare-go"
LICENSE="BSD-2"
SLOT="0"
IUSE="flarectl"
DEPEND="
	>=dev-go/pkg-errors-0.8
	>=dev-go/go-time-20180412
	flarectl? (
		>=dev-go/olekukonko-tablewriter-20180506
	)
"
RDEPEND="${DEPEND}"

src_compile-flarectl() {
	debug-print-function ${FUNCNAME} "$@"

	ego_pn_check
	set -- env GOPATH="${WORKDIR}/${P}:$(get_golibdir_gopath)" \
		go build -v -work -x ${EGO_BUILD_FLAGS} "${EGO_PN}/cmd/flarectl"
	echo "$@"
	"$@" || die
}

src_install-flarectl() {
	debug-print-function ${FUNCNAME} "$@"

	ego_pn_check
	set -- env GOPATH="${WORKDIR}/${P}:$(get_golibdir_gopath)" \
		go install -v -work -x ${EGO_BUILD_FLAGS} "${EGO_PN}/cmd/flarectl"
	echo "$@"
	"$@" || die
}

src_compile() {
	golang-build_src_compile

	# only continue if user want's flarectl
	use flarectl || return
	src_compile-flarectl
}

src_install() {
	golang-build_src_install

	# only continue if user want's flarectl
	use flarectl || return
	src_install-flarectl
	dobin bin/flarectl
}
