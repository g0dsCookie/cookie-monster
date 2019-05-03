# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

EGIT_REPO_URI="https://github.com/robbyrussell/oh-my-zsh.git"
if [[ "${PV}" != "9999" ]]; then
	EGIT_COMMIT_DATE="${PV}"
	KEYWORDS="amd64 x86"
fi

DESCRIPTION="Oh My Zsh is an community-driven framework for managing your zsh configuration."
HOMEPAGE="https://ohmyz.sh/"

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND="app-shells/zsh"
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	insinto /usr/share/zsh/oh-my-zsh
	doins -r "${S}"/{lib,oh-my-zsh.sh,plugins,templates,themes,tools}

	insinto /usr/share/zsh
	doins "${FILESDIR}"/oh-my-zsh.sh

	dodoc "${S}"/{CODE_OF_CONDUCT.md,CONTRIBUTING.md,LICENSE.txt,README.md,templates/zshrc.zsh-template}
}

pkg_postinst() {
	einfo "To enable oh-my-zsh you have to source /usr/share/zsh/oh-my-zsh.sh"
	einfo "within your ~/.zshrc"
	einfo
	einfo "  plugins=(git)"
	einfo "  source /usr/share/zsh/oh-my-zsh.sh"
}
