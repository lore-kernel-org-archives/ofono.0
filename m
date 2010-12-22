Content-Type: multipart/mixed; boundary="===============7687282021800304617=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [RFC PATCH 4/5 v2] cell-info: New files included for compilation
Date: Wed, 22 Dec 2010 11:35:38 +0200
Message-ID: <1293010539-9524-5-git-send-email-antti.paila@nokia.com>
In-Reply-To: <1293010539-9524-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7687282021800304617==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 4a919ab..e433861 100644
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

@@ -320,7 +320,7 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
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


--===============7687282021800304617==--

