# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit multilib

DESCRIPTION="skarnet.org's small and secure supervision software suite"
HOMEPAGE="http://www.skarnet.org/software/s6/"
SRC_URI="http://www.skarnet.org/software/${PN}/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="static"

V_SKALIBS="2.3.7.0"
V_EXECLINE="2.1.4.0"
DEPEND="
	>=sys-devel/make-4.0
	static? (
		>=dev-libs/skalibs-${V_SKALIBS}[static-libs]
		>=dev-lang/execline-${V_EXECLINE}[static-libs]
	)
	!static? (
		>=dev-libs/skalibs-${V_SKALIBS}
		>=dev-lang/execline-${V_EXECLINE}
	)
"
RDEPEND="
	!static? (
		>=dev-libs/skalibs-${V_SKALIBS}
		>=dev-lang/execline-${V_EXECLINE}
	)
"

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

src_install() {
	default
# FIXME the examples/ subdirectory breaks all kinds of stuff when trying to install with pkgcore or paludis
#	dodoc -r examples/
	dohtml -r doc/*
}
