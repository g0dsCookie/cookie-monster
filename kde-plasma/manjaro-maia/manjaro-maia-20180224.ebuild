# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 cmake-utils

EGIT_REPO_URI="https://github.com/manjaro/artwork-maia.git"
if [[ "${PV}" != "9999" ]]; then
	EGIT_COMMIT_DATE="${PV}"
fi

DESCRIPTION="Maia Theme for Manjaro Linux (Plasma 5)"
HOMEPAGE="https://github.com/manjaro/artwork-maia"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
