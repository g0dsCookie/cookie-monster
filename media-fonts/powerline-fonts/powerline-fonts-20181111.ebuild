# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 font

EGIT_REPO_URI="https://github.com/powerline/fonts.git"
if [[ "${PV}" != "9999" ]]; then
	EGIT_COMMIT_DATE="${PV}"
	KEYWORDS="amd64 x86"
fi

DESCRIPTION="Patched fonts for Powerline users."
HOMEPAGE="https://github.com/powerline/fonts"

LICENSE="powerline-fonts"
SLOT="0"

declare -A ttffonts otffonts
ttffonts=( ["3270"]="/3270" ["anonymouspro"]="/AnonymousPro" ["arimo"]="/Arimo" ["cousine"]="/Cousine"
	["dejavu"]="/DejaVuSansMono"
	["droiddotted"]="/DroidSansMonoDotted" ["droidslashed"]="/DroidSansMonoSlashed" ["go"]="/GoMono"
	["hack"]="/Hack" ["inconsolata"]="/Inconsolata" ["liberation"]="/LiberationMono"
	["meslodotted"]="/Meslo Dotted" ["mesloslashed"]="/Meslo Slashed" ["monofur"]="/Monofur"
	["noto"]="/NotoMono" ["nova"]="/NovaMono" ["profont"]="/ProFont" ["roboto"]="/RobotoMono"
	["space"]="/SpaceMono" ["symbolneu"]="/SymbolNeu" ["tinos"]="/Tinos"
	["ubuntu"]="/UbuntuMono" )
otffonts=( ["sourcecode"]="/SourceCodePro" ["fira"]="/FiraMono" ["droid"]="/DroidSansMono" )

for i in ${!ttffonts[@]}; do IUSE="${IUSE} +$i"; done
for i in ${!otffonts[@]}; do IUSE="${IUSE} +$i"; done

IUSE="${IUSE} +terminus"

DEPEND="terminus? ( app-arch/gzip )"
RDEPEND=""

RESTRICT="strip test"

src_compile() {
	if use terminus; then
		cd "${S}/Terminus/PCF" || die
		gunzip *.gz || die
	fi
}

src_install() {
	FONT_SUFFIX="ttf"
	FONT_S=""
	for i in ${!ttffonts[@]}; do
		if use $i; then
			local font="${ttffonts[${i}]}"
			if [ "${font}" != "${font/ /}" ]; then
				mv "${WORKDIR}/${P}${font}" "${WORKDIR}/${P}${font// /}"
				font="${font// /}"
			fi
			FONT_S="${FONT_S} ${WORKDIR}/${P}${font}"
		fi
	done
	[ "${FONT_S}" != "" ] && font_src_install

	FONT_SUFFIX="otf"
	FONT_S=""
	for i in ${!otffonts[@]}; do
		if use $i; then
			local font="${otffonts[${i}]}"
			if [ "${font}" != "${font/ /}" ]; then
				mv "${WORKDIR}/${P}${font}" "${WORKDIR}/${P}${font// /}"
				font="${font// /}"
			fi
			FONT_S="${FONT_S} ${WORKDIR}/${P}${font}"
		fi
	done
	[ "${FONT_S}" != "" ] && font_src_install

	if use terminus; then
		FONT_S="${WORKDIR}/${P}/Terminus/PCF"
		FONT_SUFFIX="pcf"
		FONTDIR="${FONTDIR}/Terminus"
		font_src_install
	fi
}
