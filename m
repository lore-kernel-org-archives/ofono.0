Content-Type: multipart/mixed; boundary="===============7216294652734633225=="
MIME-Version: 1.0
From: sjur.brandeland@stericsson.com
Subject: [PATCH 6/6] STE-plugin: Add STE to Makefile
Date: Mon, 25 Jan 2010 20:25:33 +0100
Message-ID: <1264447534-2386-7-git-send-email-sjur.brandeland@stericsson.com>
In-Reply-To: <1264447534-2386-6-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7216294652734633225==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index b6776bd..5e5ccfc 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -55,6 +55,7 @@ gatchat_sources =3D gatchat/gatchat.h gatchat/gatchat.c \
 				gatchat/gatutil.h gatchat/gatutil.c \
 				gatchat/gat.h
 =

+
 udev_files =3D plugins/ofono.rules
 =

 if UDEV
@@ -154,6 +155,11 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 builtin_modules +=3D modemconf
 builtin_sources +=3D plugins/modemconf.c
 =

+builtin_modules +=3D stemodem
+builtin_sources +=3D drivers/atmodem/atutil.h \
+                   drivers/stemodem/stemodem.h \
+                   drivers/stemodem/stemodem.c
+
 if DATAFILES
 conf_DATA +=3D plugins/modem.conf
 endif
@@ -187,6 +193,10 @@ builtin_sources +=3D plugins/hfp.c
 =

 builtin_modules +=3D palmpre
 builtin_sources +=3D plugins/palmpre.c
+
+builtin_modules +=3D ste
+builtin_sources +=3D plugins/ste.c
+
 endif
 =

 if MAINTAINER_MODE
-- =

1.6.0.4


--===============7216294652734633225==--

