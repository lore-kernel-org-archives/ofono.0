Content-Type: multipart/mixed; boundary="===============8588545890220669453=="
MIME-Version: 1.0
From: Jonah =?unknown-8bit?q?Br=C3=BCchert?= <jbb.prv@gmx.de>
Subject: [PATCH phonesim 3/7] Remove autotools build system
Date: Mon, 18 Jan 2021 17:46:17 +0100
Message-ID: <20210118164621.52831-4-jbb.prv@gmx.de>
In-Reply-To: <20210118164621.52831-1-jbb.prv@gmx.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8588545890220669453==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 INSTALL             | 236 --------------------------------------------
 Makefile.am         |  79 ---------------
 bootstrap           |   3 -
 bootstrap-configure |   9 --
 configure.ac        |  49 ---------
 5 files changed, 376 deletions(-)
 delete mode 100644 INSTALL
 delete mode 100644 Makefile.am
 delete mode 100755 bootstrap
 delete mode 100755 bootstrap-configure
 delete mode 100644 configure.ac

diff --git a/INSTALL b/INSTALL
deleted file mode 100644
index 56b077d..0000000
--- a/INSTALL
+++ /dev/null
@@ -1,236 +0,0 @@
-Installation Instructions
-*************************
-
-Copyright (C) 1994, 1995, 1996, 1999, 2000, 2001, 2002, 2004, 2005 Free
-Software Foundation, Inc.
-
-This file is free documentation; the Free Software Foundation gives
-unlimited permission to copy, distribute and modify it.
-
-Basic Installation
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-These are generic installation instructions.
-
-   The `configure' shell script attempts to guess correct values for
-various system-dependent variables used during compilation.  It uses
-those values to create a `Makefile' in each directory of the package.
-It may also create one or more `.h' files containing system-dependent
-definitions.  Finally, it creates a shell script `config.status' that
-you can run in the future to recreate the current configuration, and a
-file `config.log' containing compiler output (useful mainly for
-debugging `configure').
-
-   It can also use an optional file (typically called `config.cache'
-and enabled with `--cache-file=3Dconfig.cache' or simply `-C') that saves
-the results of its tests to speed up reconfiguring.  (Caching is
-disabled by default to prevent problems with accidental use of stale
-cache files.)
-
-   If you need to do unusual things to compile the package, please try
-to figure out how `configure' could check whether to do them, and mail
-diffs or instructions to the address given in the `README' so they can
-be considered for the next release.  If you are using the cache, and at
-some point `config.cache' contains results you don't want to keep, you
-may remove or edit it.
-
-   The file `configure.ac' (or `configure.in') is used to create
-`configure' by a program called `autoconf'.  You only need
-`configure.ac' if you want to change it or regenerate `configure' using
-a newer version of `autoconf'.
-
-The simplest way to compile this package is:
-
-  1. `cd' to the directory containing the package's source code and type
-     `./configure' to configure the package for your system.  If you're
-     using `csh' on an old version of System V, you might need to type
-     `sh ./configure' instead to prevent `csh' from trying to execute
-     `configure' itself.
-
-     Running `configure' takes awhile.  While running, it prints some
-     messages telling which features it is checking for.
-
-  2. Type `make' to compile the package.
-
-  3. Optionally, type `make check' to run any self-tests that come with
-     the package.
-
-  4. Type `make install' to install the programs and any data files and
-     documentation.
-
-  5. You can remove the program binaries and object files from the
-     source code directory by typing `make clean'.  To also remove the
-     files that `configure' created (so you can compile the package for
-     a different kind of computer), type `make distclean'.  There is
-     also a `make maintainer-clean' target, but that is intended mainly
-     for the package's developers.  If you use it, you may have to get
-     all sorts of other programs in order to regenerate files that came
-     with the distribution.
-
-Compilers and Options
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-Some systems require unusual options for compilation or linking that the
-`configure' script does not know about.  Run `./configure --help' for
-details on some of the pertinent environment variables.
-
-   You can give `configure' initial values for configuration parameters
-by setting variables in the command line or in the environment.  Here
-is an example:
-
-     ./configure CC=3Dc89 CFLAGS=3D-O2 LIBS=3D-lposix
-
-   *Note Defining Variables::, for more details.
-
-Compiling For Multiple Architectures
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-You can compile the package for more than one kind of computer at the
-same time, by placing the object files for each architecture in their
-own directory.  To do this, you must use a version of `make' that
-supports the `VPATH' variable, such as GNU `make'.  `cd' to the
-directory where you want the object files and executables to go and run
-the `configure' script.  `configure' automatically checks for the
-source code in the directory that `configure' is in and in `..'.
-
-   If you have to use a `make' that does not support the `VPATH'
-variable, you have to compile the package for one architecture at a
-time in the source code directory.  After you have installed the
-package for one architecture, use `make distclean' before reconfiguring
-for another architecture.
-
-Installation Names
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-By default, `make install' will install the package's files in
-`/usr/local/bin', `/usr/local/man', etc.  You can specify an
-installation prefix other than `/usr/local' by giving `configure' the
-option `--prefix=3DPREFIX'.
-
-   You can specify separate installation prefixes for
-architecture-specific files and architecture-independent files.  If you
-give `configure' the option `--exec-prefix=3DPREFIX', the package will
-use PREFIX as the prefix for installing programs and libraries.
-Documentation and other data files will still use the regular prefix.
-
-   In addition, if you use an unusual directory layout you can give
-options like `--bindir=3DDIR' to specify different values for particular
-kinds of files.  Run `configure --help' for a list of the directories
-you can set and what kinds of files go in them.
-
-   If the package supports it, you can cause programs to be installed
-with an extra prefix or suffix on their names by giving `configure' the
-option `--program-prefix=3DPREFIX' or `--program-suffix=3DSUFFIX'.
-
-Optional Features
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-Some packages pay attention to `--enable-FEATURE' options to
-`configure', where FEATURE indicates an optional part of the package.
-They may also pay attention to `--with-PACKAGE' options, where PACKAGE
-is something like `gnu-as' or `x' (for the X Window System).  The
-`README' should mention any `--enable-' and `--with-' options that the
-package recognizes.
-
-   For packages that use the X Window System, `configure' can usually
-find the X include and library files automatically, but if it doesn't,
-you can use the `configure' options `--x-includes=3DDIR' and
-`--x-libraries=3DDIR' to specify their locations.
-
-Specifying the System Type
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
-
-There may be some features `configure' cannot figure out automatically,
-but needs to determine by the type of machine the package will run on.
-Usually, assuming the package is built to be run on the _same_
-architectures, `configure' can figure that out, but if it prints a
-message saying it cannot guess the machine type, give it the
-`--build=3DTYPE' option.  TYPE can either be a short name for the system
-type, such as `sun4', or a canonical name which has the form:
-
-     CPU-COMPANY-SYSTEM
-
-where SYSTEM can have one of these forms:
-
-     OS KERNEL-OS
-
-   See the file `config.sub' for the possible values of each field.  If
-`config.sub' isn't included in this package, then this package doesn't
-need to know the machine type.
-
-   If you are _building_ compiler tools for cross-compiling, you should
-use the `--target=3DTYPE' option to select the type of system they will
-produce code for.
-
-   If you want to _use_ a cross compiler, that generates code for a
-platform different from the build platform, you should specify the
-"host" platform (i.e., that on which the generated programs will
-eventually be run) with `--host=3DTYPE'.
-
-Sharing Defaults
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-If you want to set default values for `configure' scripts to share, you
-can create a site shell script called `config.site' that gives default
-values for variables like `CC', `cache_file', and `prefix'.
-`configure' looks for `PREFIX/share/config.site' if it exists, then
-`PREFIX/etc/config.site' if it exists.  Or, you can set the
-`CONFIG_SITE' environment variable to the location of the site script.
-A warning: not all `configure' scripts look for a site script.
-
-Defining Variables
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-Variables not defined in a site shell script can be set in the
-environment passed to `configure'.  However, some packages may run
-configure again during the build, and the customized values of these
-variables may be lost.  In order to avoid this problem, you should set
-them in the `configure' command line, using `VAR=3Dvalue'.  For example:
-
-     ./configure CC=3D/usr/local2/bin/gcc
-
-causes the specified `gcc' to be used as the C compiler (unless it is
-overridden in the site shell script).  Here is a another example:
-
-     /bin/bash ./configure CONFIG_SHELL=3D/bin/bash
-
-Here the `CONFIG_SHELL=3D/bin/bash' operand causes subsequent
-configuration-related scripts to be executed by `/bin/bash'.
-
-`configure' Invocation
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-`configure' recognizes the following options to control how it operates.
-
-`--help'
-`-h'
-     Print a summary of the options to `configure', and exit.
-
-`--version'
-`-V'
-     Print the version of Autoconf used to generate the `configure'
-     script, and exit.
-
-`--cache-file=3DFILE'
-     Enable the cache: use and save the results of the tests in FILE,
-     traditionally `config.cache'.  FILE defaults to `/dev/null' to
-     disable caching.
-
-`--config-cache'
-`-C'
-     Alias for `--cache-file=3Dconfig.cache'.
-
-`--quiet'
-`--silent'
-`-q'
-     Do not print messages saying which checks are being made.  To
-     suppress all normal output, redirect it to `/dev/null' (any error
-     messages will still be shown).
-
-`--srcdir=3DDIR'
-     Look for the package's source code in directory DIR.  Usually
-     `configure' can determine that directory automatically.
-
-`configure' also accepts some other, not widely useful, options.  Run
-`configure --help' for more details.
-
diff --git a/Makefile.am b/Makefile.am
deleted file mode 100644
index 74cf657..0000000
--- a/Makefile.am
+++ /dev/null
@@ -1,79 +0,0 @@
-
-AM_MAKEFLAGS =3D --no-print-directory
-
-bin_PROGRAMS =3D src/phonesim
-
-src_phonesim_SOURCES =3D src/main.cpp \
-			src/control.h src/control.cpp \
-			src/attranslator.h src/attranslator.cpp \
-			src/gsmspec.h src/gsmspec.cpp \
-			src/gsmitem.h src/gsmitem.cpp \
-			src/phonesim.h src/phonesim.cpp \
-			src/server.h src/server.cpp \
-			src/hardwaremanipulator.h src/hardwaremanipulator.cpp \
-			src/qsmsmessagelist.h src/qsmsmessagelist.cpp \
-			src/qsmsmessage_p.h \
-			src/qsmsmessage.h src/qsmsmessage.cpp \
-			src/qcbsmessage.h src/qcbsmessage.cpp \
-			src/callmanager.h src/callmanager.cpp \
-			src/simauth.h src/simauth.cpp \
-			src/aidapplication.h src/aidapplication.cpp \
-			src/comp128.h src/comp128.c \
-			src/aes.h src/aes.c \
-			src/simfilesystem.h src/simfilesystem.cpp \
-			src/simapplication.h src/simapplication.cpp \
-			src/qgsmcodec.h src/qgsmcodec.cpp \
-			src/qatutils.h src/qatutils.cpp \
-			src/qatresultparser.h src/qatresultparser.cpp \
-			src/qatresult.h src/qatresult.cpp \
-			src/qwsppdu.h src/qwsppdu.cpp \
-			src/qsimcommand.h src/qsimcommand.cpp \
-			src/qsimenvelope.h src/qsimenvelope.cpp \
-			src/qsimterminalresponse.h src/qsimterminalresponse.cpp \
-			src/qsimcontrolevent.h src/qsimcontrolevent.cpp \
-			src/conformancesimapplication.cpp
-
-nodist_src_phonesim_SOURCES =3D src/ui_controlbase.h \
-				src/moc_control.cpp \
-				src/moc_phonesim.cpp \
-				src/moc_hardwaremanipulator.cpp \
-				src/moc_callmanager.cpp \
-				src/moc_simauth.cpp \
-				src/moc_aidapplication.cpp \
-				src/moc_simfilesystem.cpp \
-				src/moc_simapplication.cpp \
-				src/moc_qwsppdu.cpp
-
-src_phonesim_LDADD =3D $(QT_LIBS)
-
-AM_CXXFLAGS =3D -Wall $(QT_CFLAGS) -fPIC
-
-AM_CPPFLAGS =3D -I$(top_srcdir)/src -I$(top_builddir)/src
-
-CLEANFILES =3D src/control.moc $(nodist_src_phonesim_SOURCES)
-
-dist_pkgdata_DATA =3D src/default.xml
-
-EXTRA_DIST =3D src/controlbase.ui src/GSMSpecification.xml
-
-MAINTAINERCLEANFILES =3D Makefile.in \
-	aclocal.m4 configure depcomp missing compile install-sh
-
-
-$(src_phonesim_OBJECTS): src/ui_controlbase.h
-
-QT_V_MOC   =3D $(QT_V_MOC_$(V))
-QT_V_MOC_  =3D $(QT_V_MOC_$(AM_DEFAULT_VERBOSITY))
-QT_V_MOC_0 =3D @echo "  MOC     " $@;
-
-src/moc_%.cpp: src/%.h
-	$(MKDIR_P) src
-	$(QT_V_MOC)$(MOC) $< -o $@
-
-QT_V_UIC   =3D $(QT_V_UIC_$(V))
-QT_V_UIC_  =3D $(QT_V_UIC_$(AM_DEFAULT_VERBOSITY))
-QT_V_UIC_0 =3D @echo "  UIC     " $@;
-
-src/ui_%.h: src/%.ui
-	$(MKDIR_P) src
-	$(QT_V_UIC)$(UIC) $< -o $@
diff --git a/bootstrap b/bootstrap
deleted file mode 100755
index 562c115..0000000
--- a/bootstrap
+++ /dev/null
@@ -1,3 +0,0 @@
-#!/bin/sh
-
-aclocal && automake --add-missing --copy && autoconf
diff --git a/bootstrap-configure b/bootstrap-configure
deleted file mode 100755
index 808a6be..0000000
--- a/bootstrap-configure
+++ /dev/null
@@ -1,9 +0,0 @@
-#!/bin/sh
-
-if [ -f config.status ]; then
-	make maintainer-clean
-fi
-
-./bootstrap && \
-    ./configure --enable-maintainer-mode \
-		--prefix=3D/usr
diff --git a/configure.ac b/configure.ac
deleted file mode 100644
index da87afe..0000000
--- a/configure.ac
+++ /dev/null
@@ -1,49 +0,0 @@
-AC_PREREQ(2.60)
-AC_INIT(phonesim, 1.21)
-
-AM_INIT_AUTOMAKE([foreign subdir-objects])
-
-m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])
-
-AM_MAINTAINER_MODE
-
-AC_PREFIX_DEFAULT(/usr/local)
-
-PKG_PROG_PKG_CONFIG
-
-AC_PROG_CC
-AC_PROG_CXX
-AC_PROG_INSTALL
-
-AC_ARG_ENABLE(optimization, AC_HELP_STRING([--disable-optimization],
-			[disable code optimization through compiler]), [
-	if (test "${enableval}" =3D "no"); then
-		CXXFLAGS=3D"$CXXFLAGS -O0"
-	fi
-])
-
-PKG_CHECK_MODULES(QT, Qt5Core Qt5Gui Qt5Xml Qt5Network Qt5Qml Qt5DBus [Qt5=
Widgets >=3D 5.10], dummy=3Dyes,
-						AC_MSG_ERROR(Qt is required))
-
-# Needed for qOverload
-CXXFLAGS=3D"$CXXFLAGS --std=3Dgnu++14"
-
-AC_SUBST(QT_CFLAGS)
-AC_SUBST(QT_LIBS)
-
-AC_MSG_CHECKING(for Qt5 host_bins)
-PKG_CHECK_VAR(QMAKE_PATH_HOST_BINS, Qt5Core, host_bins)
-AC_SUBST(QMAKE_PATH_HOST_BINS)
-AC_MSG_RESULT($QMAKE_PATH_HOST_BINS)
-
-AC_MSG_CHECKING(for moc)
-MOC=3D"$QMAKE_PATH_HOST_BINS/moc"
-AC_SUBST(MOC)
-AC_MSG_RESULT($MOC)
-
-AC_MSG_CHECKING(for uic)
-UIC=3D"$QMAKE_PATH_HOST_BINS/uic"
-AC_SUBST(UIC)
-AC_MSG_RESULT($UIC)
-
-AC_OUTPUT(Makefile)
--
2.29.2

--===============8588545890220669453==--

