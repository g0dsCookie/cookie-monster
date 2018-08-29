# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit linux-info

DESCRIPTION="OSS implementation of the TCG TPM2 Software Stack (TSS2)"
HOMEPAGE="https://github.com/tpm2-software/tpm2-tss"
SRC_URI="https://github.com/tpm2-software/${PN}/releases/download/${PV}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-libs/libgcrypt:0
"
RDEPEND="${DEPEND}"

pkg_setup() {
	local tpm_kernel_version tpm_kernel_present
	kernel_is ge 4 && tpm_kernel_version="yes"
	if linux_config_exists; then
		linux_chkconfig_present TCG_TPM && tpm_kernel_present="yes"
	else
		ewarn "No kernel configuration could be found."
	fi
	if [[ -n "${tpm_kernel_present}" ]]; then
		einfo "Good, you seem to have in-kernel TPM support."
	elif [[ -n "${tpm_kernel_version}" ]]; then
		eerror
		eerror "To use this package, you will have to activate TPM support"
		eerror "in your kernel configuration. That's at least CONFIG_TCG_TPM,"
		eerror "plus probably a chip specific driver (like CONFIG_TCG_ATMEL)."
		eerror
	else
		eerror
		eerror "To use this package, you should install a TPM driver."
		eerror "You can have the following options:"
		eerror "  - switch to a >=4.0 kernel and compile the kernel module"
		eerror
	fi
}
