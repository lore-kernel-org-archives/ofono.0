Content-Type: multipart/mixed; boundary="===============0817821741277905798=="
MIME-Version: 1.0
From: sjur.brandeland@stericsson.com
Subject: [RFC v2 1/7] STE-plugin: Add --disable-stemodem to makefiles.
Date: Tue, 19 Jan 2010 17:11:47 +0100
Message-ID: <1263917513-6756-2-git-send-email-sjur.brandeland@stericsson.com>
In-Reply-To: <1263917513-6756-1-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0817821741277905798==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Added STE to makefiles with option to remove STE support by using --disable=
-stemodem.
---
 Makefile.am  |   18 ++++++++++++++++++
 configure.ac |    5 +++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 276b478..353eb01 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -53,6 +53,8 @@ gatchat_sources =3D gatchat/gatchat.h gatchat/gatchat.c \
 				gatchat/gsm0710.h gatchat/gsm0710.c \
 				gatchat/gattty.h gatchat/gattty.c
 =

+gcaif_sources =3D gcaif/caif_socket.h gcaif/if_caif.h
+
 udev_files =3D plugins/ofono.rules
 =

 if UDEV
@@ -152,6 +154,16 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 builtin_modules +=3D modemconf
 builtin_sources +=3D plugins/modemconf.c
 =

+if STEMODEM
+builtin_modules +=3D stemodem
+builtin_sources +=3D  $(gcaif_sources) \
+                       drivers/atmodem/atutil.h \
+                       drivers/stemodem/stemodem.h \
+                       drivers/stemodem/stemodem.c \
+                       drivers/stemodem/voicecall.c \
+                       drivers/stemodem/gprs-context.c
+endif
+
 if DATAFILES
 conf_DATA +=3D plugins/modem.conf
 endif
@@ -185,6 +197,12 @@ builtin_sources +=3D plugins/hfp.c
 =

 builtin_modules +=3D palmpre
 builtin_sources +=3D plugins/palmpre.c
+
+if STEMODEM
+builtin_modules +=3D ste
+builtin_sources +=3D $(gcaif_sources) plugins/ste.c
+endif
+
 endif
 =

 if MAINTAINER_MODE
diff --git a/configure.ac b/configure.ac
index c1770d9..105a405 100644
--- a/configure.ac
+++ b/configure.ac
@@ -131,6 +131,11 @@ AC_ARG_ENABLE(atmodem, AC_HELP_STRING([--disable-atmod=
em],
 					[enable_atmodem=3D${enableval}])
 AM_CONDITIONAL(ATMODEM, test "${enable_atmodem}" !=3D "no")
 =

+AC_ARG_ENABLE(stemodem, AC_HELP_STRING([--disable-stemodem],
+				[disable STE (CAIF) AT modem support]),
+					[enable_stemodem=3D${enableval}])
+AM_CONDITIONAL(STEMODEM, test "${enable_stemodem}" !=3D "no")
+
 AC_ARG_ENABLE(datafiles, AC_HELP_STRING([--disable-datafiles],
 			[don't install configuration and data files]),
 					[enable_datafiles=3D${enableval}])
-- =

1.6.0.4


--===============0817821741277905798==--

