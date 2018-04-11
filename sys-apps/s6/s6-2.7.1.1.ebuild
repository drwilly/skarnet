# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="skarnet.org's small and secure supervision software suite"
HOMEPAGE="http://www.skarnet.org/software/s6/"
SRC_URI="http://www.skarnet.org/software/${PN}/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="static static-libs"

V_SKALIBS="2.6.4.0"
V_EXECLINE="2.3.0.4"
DEPEND="
	>=sys-devel/make-3.81
	static? (
		>=dev-libs/skalibs-${V_SKALIBS}[static-libs]
		>=dev-lang/execline-${V_EXECLINE}[static-libs]
	)
	!static? (
		>=dev-libs/skalibs-${V_SKALIBS}
		>=dev-lang/execline-${V_EXECLINE}[static=]
	)
"
RDEPEND="
	!static? (
		>=dev-libs/skalibs-${V_SKALIBS}
		>=dev-lang/execline-${V_EXECLINE}
	)
"

DOCS="AUTHORS examples README*"
HTML_DOCS="doc/*"

src_configure() {
	econf \
		$(use_enable !static shared) \
		$(use_enable static allstatic) \
		$(use_enable static static-libc) \
		$(use_enable static-libs static) \
		--dynlibdir=/$(get_libdir) \
		--bindir=/bin \
		--sbindir=/sbin \
		--libdir=/usr/$(get_libdir)/${PN} \
		--datadir=/etc \
		--with-sysdeps=/usr/$(get_libdir)/skalibs \
		--with-dynlib=/$(get_libdir)
}
