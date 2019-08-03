# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

EGIT_REPO_URI="https://github.com/shvchk/fallout-grub-theme.git"
if [[ "${PV}" != "9999" ]]; then
	EGIT_COMMIT_DATE="${PV}"
	KEYWORDS="amd64 x86"
fi

DESCRIPTION="Fallout theme for grub bootloader."
HOMEPAGE="https://github.com/shvchk/fallout-grub-theme"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	rm -f install.sh
}

src_install() {
	insinto /usr/share/grub/themes/fallout
	doins -r *.png *.pf2 theme.txt icons

	default_src_install
}
