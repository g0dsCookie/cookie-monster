# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker

MY_PV="$(ver_rs 3 '-')"
MY_COMMIT="gd20421e03128"
MY_URI="https://github.com/ayufan-rock64/linux-kernel/releases/download"

DESCRIPTION="Precompiled kernel by ayufan for rockchip boards."
HOMEPAGE="https://github.com/ayufan-rock64/linux-kernel"
SRC_URI="
	${MY_URI}/${MY_PV}-${PN}/linux-firmware-image-${MY_PV}-${PN}-${MY_COMMIT}_${MY_PV}-${PN}_arm64.deb
	${MY_URI}/${MY_PV}-${PN}/linux-headers-${MY_PV}-${PN}-${MY_COMMIT}_${MY_PV}-${PN}_arm64.deb
	debug? ( ${MY_URI}/${MY_PV}-${PN}/linux-image-${MY_PV}-${PN}-${MY_COMMIT}-dbg_${MY_PV}-${PN}_arm64.deb )
	!debug? ( ${MY_URI}/${MY_PV}-${PN}/linux-image-${MY_PV}-${PN}-${MY_COMMIT}_${MY_PV}-${PN}_arm64.deb )
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="arm64"
IUSE="debug symlink"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}"

src_install() {
	local appendix="${MY_PV}-${PN}-${MY_COMMIT}"

	insinto /boot
	doins boot/{config,System.map,vmlinuz}-${appendix}

	insinto /lib/firmware
	doins -r lib/firmware/${appendix}

	insinto /lib/modules
	doins -r lib/modules/${appendix}

	insinto /usr/src
	doins -r usr/src/linux-headers-${appendix}

	insinto /usr/lib
	doins -r usr/lib/linux-image-${appendix}

	dodoc -r usr/share/doc/linux-{firmware-image,headers,image}-${appendix}
}

pkg_postinst() {
	if use symlink; then
		[[ -L ${EROOT}/usr/src/linux ]] && { rm "${EROOT}"/usr/src/linux || die; }
		ln -sf linux-headers-${MY_PV}-${PN}-${MY_COMMIT} "${EROOT}"/usr/src/linux || die
	fi
}
