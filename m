Content-Type: multipart/mixed; boundary="===============2846947168477315139=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH 2/5] build: add lte atom support
Date: Tue, 15 Nov 2016 15:08:17 +0100
Message-ID: <1479218900-9870-3-git-send-email-dragos@endocode.com>
In-Reply-To: <1479218900-9870-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2846947168477315139==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 7caf05b..af0f1ab 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -22,7 +22,7 @@ pkginclude_HEADERS =3D include/log.h include/plugin.h inc=
lude/history.h \
 			include/private-network.h include/cdma-netreg.h \
 			include/cdma-provision.h include/handsfree.h \
 			include/handsfree-audio.h include/siri.h \
-			include/netmon.h
+			include/netmon.h include/lte.h
 =

 nodist_pkginclude_HEADERS =3D include/version.h
 =

@@ -605,7 +605,7 @@ src_ofonod_SOURCES =3D $(builtin_sources) $(gatchat_sou=
rces) src/ofono.ver \
 			src/cdma-provision.c src/handsfree.c \
 			src/handsfree-audio.c src/bluetooth.h \
 			src/hfp.h src/siri.c \
-			src/netmon.c
+			src/netmon.c src/lte.c
 =

 src_ofonod_LDADD =3D gdbus/libgdbus-internal.la $(builtin_libadd) \
 			@GLIB_LIBS@ @DBUS_LIBS@ -ldl
-- =

2.7.4


--===============2846947168477315139==--

