# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Open source RDP server"
HOMEPAGE="https://github.com/neutrinolabs/xrdp"
SRC_URI="https://github.com/neutrinolabs/${PN}/releases/download/v${PV}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"
IUSE="pam ipv6 fuse jpeg aac opus lame pixman debug kerberos"

DEPEND="
	dev-libs/openssl:0=
	x11-base/xorg-server
	pam? ( sys-libs/pam )
	fuse? ( sys-fs/fuse:0= )
	jpeg? ( virtual/jpeg )
	aac? ( media-libs/fdk-aac )
	opus? ( media-libs/opus )
	lame? ( media-sound/lame )
	pixman? ( x11-libs/pixman )
	kerberos? ( virtual/krb5 )
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	default
	./bootstrap
}

src_configure() {
	local myconf=(
		--enable-vsock=yes
		$(use_enable pam)
		$(use_enable ipv6)
		$(use_enable fuse)
		$(use_enable jpeg)
		$(use_enable aac fdkaac)
		$(use_enable opus)
		$(use_enable lame mp3lame)
		$(use_enable pixman)
		$(use_enable debug)
		$(use_enable kerberos)
	)
	econf "${myconf[@]}"
}

src_install() {
	default

	insinto /etc/xrdp
	doins "${FILESDIR}/startwm.sh"

	newinitd "${FILESDIR}/xrdp-initd" xrdp
	newinitd "${FILESDIR}/xrdp-sesman-initd" xrdp-sesman
}
