Content-Type: multipart/mixed; boundary="===============2519525090892825093=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [PATCH 4/5 v2] Cell-info: New files included in compilation
Date: Tue, 04 Jan 2011 16:36:58 +0200
Message-ID: <1294151819-3300-5-git-send-email-antti.paila@nokia.com>
In-Reply-To: <1294151819-3300-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2519525090892825093==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 8a8555d..1ede3e7 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -14,7 +14,8 @@ include_HEADERS =3D include/log.h include/plugin.h includ=
e/history.h \
 			include/gprs.h include/gprs-context.h \
 			include/radio-settings.h include/stk.h \
 			include/audio-settings.h include/nettime.h \
-			include/ctm.h include/cdma-voicecall.h
+			include/ctm.h include/cdma-voicecall.h \
+			include/cell-info.h
 =

 nodist_include_HEADERS =3D include/version.h
 =

@@ -328,7 +329,7 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) src/ofono.ver \
 			src/nettime.c src/stkagent.c src/stkagent.h \
 			src/simfs.c src/simfs.h src/audio-settings.c \
 			src/smsagent.c src/smsagent.h src/ctm.c \
-			src/cdma-voicecall.c
+			src/cdma-voicecall.c src/cell-info.c
 =

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ -ldl
 =

@@ -368,7 +369,8 @@ doc_files =3D doc/overview.txt doc/ofono-paper.txt doc/=
release-faq.txt \
 			doc/phonebook-api.txt doc/radio-settings-api.txt \
 			doc/sim-api.txt doc/stk-api.txt \
 			doc/audio-settings-api.txt doc/text-telephony-api.txt \
-			doc/calypso-modem.txt
+			doc/calypso-modem.txt \
+			doc/cell-info.txt
 =

 =

 test_scripts =3D test/backtrace \
-- =

1.7.1


--===============2519525090892825093==--

