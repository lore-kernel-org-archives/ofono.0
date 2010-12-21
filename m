Content-Type: multipart/mixed; boundary="===============3185025790777001927=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [RFC PATCH 4/4] cell-info: New files included for compilation
Date: Tue, 21 Dec 2010 16:00:24 +0200
Message-ID: <1292940024-24363-5-git-send-email-antti.paila@nokia.com>
In-Reply-To: <1292940024-24363-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3185025790777001927==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 12b3c33..86f1ab5 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -14,7 +14,7 @@ include_HEADERS =3D include/log.h include/plugin.h includ=
e/history.h \
 			include/gprs.h include/gprs-context.h \
 			include/radio-settings.h include/stk.h \
 			include/audio-settings.h include/nettime.h \
-			include/ctm.h
+			include/ctm.h include/cell-info.h
 =

 nodist_include_HEADERS =3D include/version.h
 =

@@ -319,7 +319,7 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) src/ofono.ver \
 			src/radio-settings.c src/stkutil.h src/stkutil.c \
 			src/nettime.c src/stkagent.c src/stkagent.h \
 			src/simfs.c src/simfs.h src/audio-settings.c \
-			src/smsagent.c src/smsagent.h src/ctm.c
+			src/smsagent.c src/smsagent.h src/ctm.c src/cell-info.c
 =

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ -ldl
 =

-- =

1.7.1


--===============3185025790777001927==--

