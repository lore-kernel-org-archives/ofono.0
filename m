Content-Type: multipart/mixed; boundary="===============4628060903155106193=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 9/9] build: Add rilmodem to the build
Date: Tue, 13 Oct 2015 18:07:58 +0200
Message-ID: <1444752478-18198-10-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1444752478-18198-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4628060903155106193==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Build gril, the rilmodem and infineon drivers, and the corresponding
plugins.
---
 Makefile.am  | 44 +++++++++++++++++++++++++++++++++++++++++++-
 configure.ac |  5 +++++
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 113a2d5..3ad1302 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -95,6 +95,15 @@ gisi_sources =3D gisi/client.c gisi/client.h gisi/common=
.h \
 				gisi/server.c gisi/server.h \
 				gisi/socket.c gisi/socket.h
 =

+gril_sources =3D gril/gril.h gril/gril.c gril/grilio.h \
+				gril/grilio.c gril/grilutil.h \
+				gril/grilutil.c gril/ringbuffer.h \
+				gril/gfunc.h gril/ril.h \
+				gril/parcel.c gril/parcel.h \
+				gril/grilreply.c gril/grilreply.h \
+				gril/grilrequest.c gril/grilrequest.h \
+				gril/grilunsol.c gril/grilunsol.h
+
 btio_sources =3D btio/btio.h btio/btio.c
 =

 if UDEV
@@ -107,6 +116,39 @@ builtin_modules +=3D udevng
 builtin_sources +=3D plugins/udevng.c
 endif
 =

+if RILMODEM
+builtin_sources +=3D $(gril_sources)
+
+builtin_modules +=3D rildev
+builtin_sources +=3D plugins/rildev.c
+
+builtin_modules +=3D ril
+builtin_sources +=3D plugins/ril.c
+
+builtin_modules +=3D infineon
+builtin_sources +=3D plugins/infineon.c
+
+builtin_modules +=3D rilmodem
+builtin_sources +=3D drivers/rilmodem/rilmodem.h \
+			drivers/rilmodem/vendor.h \
+			drivers/rilmodem/rilmodem.c \
+			drivers/rilmodem/devinfo.c \
+			drivers/rilmodem/network-registration.c \
+			drivers/rilmodem/voicecall.c \
+			drivers/rilmodem/call-volume.c \
+			drivers/rilmodem/gprs.c \
+			drivers/rilmodem/gprs-context.c \
+			drivers/rilmodem/sim.c \
+			drivers/rilmodem/sms.c \
+			drivers/rilmodem/rilutil.c \
+			drivers/rilmodem/rilutil.h \
+			drivers/rilmodem/ussd.c \
+			drivers/rilmodem/call-settings.c \
+			drivers/rilmodem/call-forwarding.c \
+			drivers/rilmodem/radio-settings.c \
+			drivers/rilmodem/call-barring.c
+endif
+
 if ISIMODEM
 builtin_modules +=3D isimodem
 builtin_sources +=3D $(gisi_sources) \
@@ -563,7 +605,7 @@ AM_CFLAGS =3D @DBUS_CFLAGS@ @GLIB_CFLAGS@ $(builtin_cfl=
ags) \
 =

 AM_CPPFLAGS =3D -I$(builddir)/include -I$(builddir)/src -I$(srcdir)/src \
 			-I$(srcdir)/gdbus -I$(srcdir)/gisi -I$(srcdir)/gatchat \
-			-I$(srcdir)/btio
+			-I$(srcdir)/btio -I$(srcdir)/gril
 =

 doc_files =3D doc/overview.txt doc/ofono-paper.txt doc/release-faq.txt \
 		doc/manager-api.txt doc/modem-api.txt doc/network-api.txt \
diff --git a/configure.ac b/configure.ac
index 130e8cf..b8d42c8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -161,6 +161,11 @@ AC_ARG_ENABLE(isimodem, AC_HELP_STRING([--disable-isim=
odem],
 					[enable_isimodem=3D${enableval}])
 AM_CONDITIONAL(ISIMODEM, test "${enable_isimodem}" !=3D "no")
 =

+AC_ARG_ENABLE(rilmodem, AC_HELP_STRING([--disable-rilmodem],
+				[disable RIL modem support]),
+					[enable_rilmodem=3D${enableval}])
+AM_CONDITIONAL(RILMODEM, test "${enable_rilmodem}" !=3D "no")
+
 AC_ARG_ENABLE(qmimodem, AC_HELP_STRING([--disable-qmimodem],
 				[disable Qualcomm QMI modem support]),
 					[enable_qmimodem=3D${enableval}])
-- =

2.1.4


--===============4628060903155106193==--

