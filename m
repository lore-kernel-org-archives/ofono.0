Content-Type: multipart/mixed; boundary="===============2684621811510476847=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [PATCH 5/5] isimodem: Makefile modifications
Date: Mon, 07 Mar 2011 12:24:34 +0200
Message-ID: <1299493474-12982-6-git-send-email-antti.paila@nokia.com>
In-Reply-To: <1299493474-12982-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2684621811510476847==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 3f20717..0f9f201 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -15,7 +15,8 @@ pkginclude_HEADERS =3D include/log.h include/plugin.h inc=
lude/history.h \
 			include/ctm.h include/cdma-voicecall.h \
 			include/cdma-sms.h include/sim-auth.h \
 			include/gprs-provision.h include/emulator.h \
-			include/location-reporting.h
+			include/location-reporting.h \
+			include/cell-info.h
 =

 nodist_pkginclude_HEADERS =3D include/version.h
 =

@@ -139,8 +140,8 @@ builtin_sources +=3D $(gisi_sources) \
 				drivers/isimodem/gprs-context.c \
 				drivers/isimodem/gpds.h \
 				drivers/isimodem/audio-settings.c \
-				drivers/isimodem/uicc.h
-
+				drivers/isimodem/uicc.h \
+				drivers/isimodem/cell-info.c
 =

 builtin_modules +=3D isiusb
 builtin_sources +=3D plugins/isiusb.c
@@ -383,7 +384,8 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) src/ofono.ver \
 			src/smsagent.c src/smsagent.h src/ctm.c \
 			src/cdma-voicecall.c src/sim-auth.c \
 			src/message.h src/message.c src/gprs-provision.c \
-			src/emulator.c src/location-reporting.c
+			src/emulator.c src/location-reporting.c \
+			src/cell-info.c
 =

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ -ldl
 =

@@ -426,7 +428,8 @@ doc_files =3D doc/overview.txt doc/ofono-paper.txt doc/=
release-faq.txt \
 			doc/sim-api.txt doc/stk-api.txt \
 			doc/audio-settings-api.txt doc/text-telephony-api.txt \
 			doc/calypso-modem.txt doc/message-api.txt \
-			doc/location-reporting-api.txt
+			doc/location-reporting-api.txt \
+			doc/cell-info.txt
 =

 =

 test_scripts =3D test/backtrace \
-- =

1.7.1


--===============2684621811510476847==--

