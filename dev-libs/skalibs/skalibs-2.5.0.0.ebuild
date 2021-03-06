# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="general-purpose libraries used by software at skarnet.org"
HOMEPAGE="http://www.skarnet.org/software/skalibs/index.html"
SRC_URI="http://www.skarnet.org/software/${PN}/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc ipv6 static-libs"

DEPEND=">=sys-devel/make-3.81"
RDEPEND=""

DOCS=""
HTML_DOCS="doc/*"

src_configure() {
	econf \
		$(use_enable ipv6) \
		$(use_enable static-libs static) \
		--dynlibdir=/$(get_libdir) \
		--libdir=/usr/$(get_libdir)/${PN} \
		--datadir=/etc \
		--sysdepdir=/usr/$(get_libdir)/${PN}
}

src_install() {
	default
	dodir /etc/ld.so.conf.d/
	echo "/$(get_libdir)/${PN}" > ${ED}/etc/ld.so.conf.d/10${PN}.conf || die
}
