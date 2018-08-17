# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGO_PN="golang.org/x/time/..."
EGO_SRC="golang.org/x/time"

if [[ "${PV}" == *9999* ]]; then
	inherit golang-vcs
else
	KEYWORDS="~amd64 ~x86"
	EGIT_COMMIT="fbb02b2291d28baffd63558aa44b4b56f178d650"
	SRC_URI="https://github.com/golang/time/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="Go supplementary time packages"
HOMEPAGE="https://godoc.org/golang.org/x/time"
LICENSE="BSD"
SLOT="0/${PVR}"
IUSE=""
DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	# Create a writable GOROOT in order to avoid sandbox violations.
	cp -sR "$(go env GOROOT)" "${T}/goroot" || die
	rm -rf "${T}/goroot/src/${EGO_SRC}" || die
	rm -rf "${T}/goroot/pkg/$(go env GOOS)_$(go env GOARCH)/${EGO_SRC}" || die
	export GOROOT="${T}/goroot"
	golang-build_src_compile
}
