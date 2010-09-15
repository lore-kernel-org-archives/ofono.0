Content-Type: multipart/mixed; boundary="===============0829031542655482239=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [n900 PATCH 1/5] Include isimodem sources always in dist
Date: Wed, 15 Sep 2010 19:59:30 +0300
Message-ID: <1284569974-22505-2-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1284569974-22505-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0829031542655482239==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <ppessi@hamsa.research.nokia.com>

---
 Makefile.am |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 802e94b..79ef4e4 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -94,9 +94,7 @@ if DATAFILES
 conf_DATA +=3D plugins/modem.conf
 endif
 =

-if ISIMODEM
-builtin_modules +=3D isimodem
-builtin_sources +=3D $(gisi_sources) \
+isimodem_sources =3D $(gisi_sources) \
 				drivers/isimodem/isimodem.h \
 				drivers/isimodem/isimodem.c \
 				drivers/isimodem/mtc.h \
@@ -130,8 +128,14 @@ builtin_sources +=3D $(gisi_sources) \
 				drivers/isimodem/gprs-context.c \
 				drivers/isimodem/gpds.h
 =

+usbpn_sources =3D plugins/usbpnmodem.c
+
+if ISIMODEM
+builtin_modules +=3D isimodem
+builtin_sources +=3D $(isimodem_sources)
+
 builtin_modules +=3D usbpnmodem
-builtin_sources +=3D plugins/usbpnmodem.c
+builtin_sources +=3D $(usbpn_sources)
 endif
 =

 if ATMODEM
@@ -377,6 +381,8 @@ endif
 conf_files =3D src/ofono.conf plugins/modem.conf
 =

 EXTRA_DIST =3D src/genbuiltin plugins/example_history.c $(doc_files) \
+				$(isimodem_sources) \
+				$(usbpn_sources) \
 				$(test_scripts) $(conf_files) $(udev_files)
 =

 dist_man_MANS =3D doc/ofonod.8
-- =

1.7.0.4


--===============0829031542655482239==--

