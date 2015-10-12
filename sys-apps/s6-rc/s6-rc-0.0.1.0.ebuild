# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit multilib

DESCRIPTION="s6-rc is a service manager for s6-based systems"
HOMEPAGE="http://www.skarnet.org/software/s6-rc/"
SRC_URI="http://www.skarnet.org/software/${PN}/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="static"

V_SKALIBS="2.3.7.0"
V_EXECLINE="2.1.4.0"
V_S6="2.2.1.0"
DEPEND="
	>=sys-devel/make-4.0
	static? (
		>=dev-libs/skalibs-${V_SKALIBS}[static-libs]
		>=dev-lang/execline-${V_EXECLINE}[static-libs]
		>=sys-apps/s6-${V_S6}[static]
	)
	!static? (
		>=dev-libs/skalibs-${V_SKALIBS}
		>=dev-lang/execline-${V_EXECLINE}
		>=sys-apps/s6-${V_S6}
	)
"
RDEPEND="
	!static? (
		>=dev-libs/skalibs-${V_SKALIBS}
		>=dev-lang/execline-${V_EXECLINE}
		>=sys-apps/s6-${V_S6}
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
	dodoc -r examples/
	dohtml -r doc/*
}
