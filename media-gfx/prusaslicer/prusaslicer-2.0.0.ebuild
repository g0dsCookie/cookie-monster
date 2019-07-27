# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

MY_PN="PrusaSlicer"

DESCRIPTION="G-code generator for 3D printers (RepRap, Makerbot, Ultimaker etc.)"
HOMEPAGE="https://www.prusa3d.com/prusaslicer/"
SRC_URI="https://github.com/prusa3d/${MY_PN}/archive/version_${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+wxwidgets +gtk3 test"

DEPEND="
	wxwidgets? (
		!gtk3? ( x11-libs/wxGTK:3.0 )
		gtk3? ( x11-libs/wxGTK:3.0-gtk3 )
	)
	dev-cpp/tbb
	>=dev-libs/boost-1.64
	dev-cpp/eigen:3
	media-libs/glew:0
	dev-libs/expat
	dev-libs/openssl:0
	sci-libs/nlopt
	test? ( dev-cpp/gtest )
"
RDEPEND="${DEPEND}"
BDEPEND=""

DOCS=( README.md )

S="${WORKDIR}/${MY_PN}-version_${PV}"

PATCHES=( "${FILESDIR}/${PN}-2.0.0-add-conditional-gtest.patch" )

src_configure() {
	local mycmakeargs=(
		-DSLIC3R_FHS=1
		-DSLIC3R_STATIC=0
		-DSLIC3R_PERL_XS=0
		-DSLIC3R_BUILD_SANDBOX=0
		-DSLIC3R_WX_STABLE=1
		-DSLIC3R_GTK=$(usex gtk3 3 2)
		-DSLIC3R_GUI=$(usex wxwidgets 1 0)
		-DSLIC3R_BUILD_TESTS=$(usex test 1 0)
	)
	cmake-utils_src_configure
}
