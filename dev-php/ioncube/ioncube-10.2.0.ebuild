# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PHP_EXT_NAME="ioncube_loader"
PHP_EXT_ZENDEXT="yes"
PHP_EXT_INI="yes"
DOCS="README.txt LICENSE.txt"

USE_PHP="php5-6 php7-0 php7-1 php7-2"

inherit php-ext-source-r3

DESCRIPTION="PHP extension for running PHP scripts encoded with ionCube's encoder"
HOMEPAGE="http://www.ioncube.com/"

if [[ "${ARCH}" == "amd64" ]]; then
	MY_ARCH="x86-64"
elif [[ "${ARCH}" == "x86" ]]; then
	MY_ARCH="x86"
fi

SRC_URI="http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_${MY_ARCH}_${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

S="${WORKDIR}/ioncube"
PHP_EXT_S="${S}"

RESTRICT="mirror strip"

DEPEND="
	!dev-php/eaccelerator
	!dev-php/PECL-apc
"
RDEPEND="${DEPEND}"

PHP_LIB_DIR="/usr/share/php/${PN}"

src_unpack() {
	unpack ${A}

	local slot orig_s="${PHP_EXT_S}"
	for slot in $(php_get_slots); do
		ln -s "${S}" "$(dirname "${S}")/${slot}"
	done
}

src_install() {
	local slot version major minor
	for slot in $(php_get_slots); do
		php_init_slot_env ${slot}

		version=( $(qatom "${PHP_PKG}") )
		version=( ${version[2]//./ } )

		for major in ${version[0]}; do
			for minor in ${version[2]}; do
				ioncube="${S}/${PHP_EXT_NAME}_lin_${version[0]}.${version[1]}.so"
				[[ -e "${ioncube}" ]] || die "Unable to find a matching ioncube for ${PHP_PKG}."
				insinto "${EXT_DIR}"
				newins "${ioncube}" "${PHP_EXT_NAME}.so" || die "Unable to install extension"
				break
			done
		done

		local doc
		for doc in ${DOCS}; do
			[[ -s "${doc}" ]] && dodoc "${doc}"
		done
	done
	php-ext-source-r3_createinifiles
}

pkg_config() {
	einfo "Please refer to the installation instructions"
	einfo "in /usr/share/doc/${CATEGORY}/${P}/README"
}

pkg_postinst() {
	if has_version "dev-lang/php[apache2]"; then
		elog
		elog "You need to restart apache2 to activate the ${PN}."
		elog
	fi
}

src_prepare() {
	eapply_user
}

src_configure() {
	:
}

src_compile() {
	:
}
