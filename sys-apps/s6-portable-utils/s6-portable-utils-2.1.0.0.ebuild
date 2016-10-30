# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="s6-portable-utils is a set of Unix utilities, designed for embedded systems"
HOMEPAGE="http://www.skarnet.org/software/s6/"
SRC_URI="http://www.skarnet.org/software/${PN}/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="static"

V_SKALIBS="2.4.0.0"
DEPEND="
	>=sys-devel/make-3.81
	static? ( >=dev-libs/skalibs-${V_SKALIBS}[static-libs] )
	!static? ( >=dev-libs/skalibs-${V_SKALIBS} )
"
RDEPEND="
	!static? ( >=dev-libs/skalibs-${V_SKALIBS} )
"

HTML_DOCS="doc/*"

src_configure() {
	econf \
		$(use_enable !static shared) \
		$(use_enable static allstatic) \
		$(use_enable static) \
		--dynlibdir=/$(get_libdir) \
		--bindir=/bin \
		--sbindir=/sbin \
		--libdir=/usr/$(get_libdir)/${PN} \
		--datadir=/etc \
		--with-sysdeps=/usr/$(get_libdir)/skalibs \
		--with-dynlib=/$(get_libdir)
}
