# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

EGIT_REPO_URI="https://github.com/nareshv/kde-konsole-colorschemes.git"
if [[ "${PV}" != "9999" ]]; then
	EGIT_COMMIT_DATE="${PV}"
fi

DESCRIPTION="KDE4/5 Konsole Colorschemes"
HOMEPAGE="https://github.com/nareshv/kde-konsole-colorschemes"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="kde-apps/konsole"
RDEPEND="${DEPEND}"

RESTRICT="strip test"

INCLUDE=(
	"FlatUI"
	"Monokai"
	"Oxygen"
	"Solarized Dark"
	"Solarized Light"
	"Tango"
	"bl1nk"
	"srcery"
)

src_install() {
	insinto /usr/share/konsole

	for ((i = 0; i < ${#INCLUDE[@]}; i++))
	do
		doins "${INCLUDE[${i}]}.colorscheme" || die
	done
}
