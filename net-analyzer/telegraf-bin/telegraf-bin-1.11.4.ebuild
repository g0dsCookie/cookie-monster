# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd user

DESCRIPTION="The plugin-driven server agent for collecting & reporting metrics."
HOMEPAGE="https://github.com/influxdata/telegraf"
SRC_URI="
	amd64?	( https://dl.influxdata.com/telegraf/releases/telegraf-${PV}_linux_amd64.tar.gz )
	x86?	( https://dl.influxdata.com/telegraf/releases/telegraf-${PV}_linux_i386.tar.gz )
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/telegraf"

RESTRICT="strip"

pkg_setup() {
	enewgroup telegraf
	enewuser telegraf -1 -1 -1 telegraf
}

src_compile() { :; }

src_install() {
	insinto /etc/telegraf
	doins -r etc/telegraf/*
	keepdir /etc/telegraf/telegraf.d

	dobin usr/bin/telegraf

	systemd_dounit usr/lib/telegraf/scripts/telegraf.service
	newconfd "${FILESDIR}"/telegraf.confd telegraf
	newinitd "${FILESDIR}"/telegraf.rc telegraf

	dodir /var/log/telegraf
	fowners telegraf:telegraf /var/log/telegraf
	keepdir /var/log/telegraf
}
