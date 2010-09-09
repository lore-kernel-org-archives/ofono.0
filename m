Content-Type: multipart/mixed; boundary="===============5672493243808502868=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH 4/5] Add message agent implementation to build
Date: Thu, 09 Sep 2010 11:08:27 +0300
Message-ID: <1284019708-11747-5-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1284019708-11747-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5672493243808502868==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index f31180e..fddcaad 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -282,7 +282,8 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) \
 			src/storage.c src/cbs.c src/watch.c src/call-volume.c \
 			src/gprs.c src/idmap.h src/idmap.c \
 			src/radio-settings.c src/stkutil.h src/stkutil.c \
-			src/nettime.c src/stkagent.c src/stkagent.h
+			src/nettime.c src/stkagent.c src/stkagent.h \
+			src/smsagent.c src/smsagent.h
 =

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ -ldl
 =

-- =

1.7.0.4


--===============5672493243808502868==--

