Content-Type: multipart/mixed; boundary="===============8174166609565583890=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [PATCH 4/5] cell-info: New files included for compilation
Date: Tue, 28 Dec 2010 15:27:26 +0200
Message-ID: <1293542847-24248-5-git-send-email-antti.paila@nokia.com>
In-Reply-To: <1293542847-24248-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8174166609565583890==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index dfdb7bd..d9b0ad3 100644
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

@@ -367,7 +368,8 @@ doc_files =3D doc/overview.txt doc/ofono-paper.txt doc/=
release-faq.txt \
 			doc/message-api.txt doc/message-waiting-api.txt \
 			doc/phonebook-api.txt doc/radio-settings-api.txt \
 			doc/sim-api.txt doc/stk-api.txt \
-			doc/audio-settings-api.txt doc/text-telephony-api.txt
+			doc/audio-settings-api.txt doc/text-telephony-api.txt \
+			doc/cell-info.txt
 =

 =

 test_scripts =3D test/backtrace \
-- =

1.7.1


--===============8174166609565583890==--

