# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGIT_REPO_URI="https://github.com/g0dsCookie/zfssnap.git"
if [[ "${PV}" != "9999" ]]; then
	EGIT_COMMIT_DATE="${PV}"
	KEYWORDS="~amd64"
fi

inherit git-r3

DESCRIPTION="Small and simple zfs snapshot manager"
HOMEPAGE="https://github.com/g0dsCookie/zfssnap"

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="
	${DEPEND}
	sys-fs/zfs
"

src_install() {
	newsbin zfssnap.sh zfssnap
	dodoc README.md
}
