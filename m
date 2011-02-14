Content-Type: multipart/mixed; boundary="===============0556416970334572814=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [PATCH 4/5] cell-info: New files included in compilation
Date: Mon, 14 Feb 2011 16:56:51 +0200
Message-ID: <1297695412-22259-5-git-send-email-antti.paila@nokia.com>
In-Reply-To: <1297695412-22259-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0556416970334572814==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 42ad86f..785640b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -14,7 +14,8 @@ pkginclude_HEADERS =3D include/log.h include/plugin.h inc=
lude/history.h \
 			include/audio-settings.h include/nettime.h \
 			include/ctm.h include/cdma-voicecall.h \
 			include/cdma-sms.h include/sim-auth.h \
-			include/gprs-provision.h include/emulator.h
+			include/gprs-provision.h include/emulator.h \
+			include/cell-info.h
 =

 nodist_pkginclude_HEADERS =3D include/version.h
 =

@@ -367,7 +368,8 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) src/ofono.ver \
 			src/smsagent.c src/smsagent.h src/ctm.c \
 			src/cdma-voicecall.c src/sim-auth.c \
 			src/message.h src/message.c src/gprs-provision.c \
-			src/emulator.c
+			src/emulator.c \
+			src/cell-info.c
 =

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ -ldl
 =

@@ -409,7 +411,8 @@ doc_files =3D doc/overview.txt doc/ofono-paper.txt doc/=
release-faq.txt \
 			doc/phonebook-api.txt doc/radio-settings-api.txt \
 			doc/sim-api.txt doc/stk-api.txt \
 			doc/audio-settings-api.txt doc/text-telephony-api.txt \
-			doc/calypso-modem.txt doc/message-api.txt
+			doc/calypso-modem.txt doc/message-api.txt \
+			doc/cell-info.txt
 =

 =

 test_scripts =3D test/backtrace \
-- =

1.7.1


--===============0556416970334572814==--

