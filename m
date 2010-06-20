Content-Type: multipart/mixed; boundary="===============2117682539439761521=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: [PATCH 6/6] bluetooth: make bluetooth.c not a plugin
Date: Sun, 20 Jun 2010 05:51:24 -0300
Message-ID: <1277023884-27143-6-git-send-email-gustavo@padovan.org>
In-Reply-To: <1277023884-27143-5-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2117682539439761521==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am         |    7 ++++---
 plugins/bluetooth.c |    2 --
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 96116a5..d51d6db 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -71,6 +71,9 @@ gatchat_sources =3D gatchat/gatchat.h gatchat/gatchat.c \
 				gatchat/ppp_auth.c gatchat/ppp_net.c \
 				gatchat/ppp_ipcp.c
 =

+bluetooth_sources =3D plugins/bluetooth.c plugins/bluetooth.h
+
+
 udev_files =3D plugins/ofono.rules
 =

 if UDEV
@@ -133,6 +136,7 @@ endif
 if ATMODEM
 builtin_modules +=3D atmodem
 builtin_sources +=3D $(gatchat_sources) \
+				$(bluetooth_sources) \
 				drivers/atmodem/atmodem.h \
 				drivers/atmodem/atmodem.c \
 				drivers/atmodem/call-settings.c \
@@ -238,9 +242,6 @@ builtin_sources +=3D plugins/em770.c
 builtin_modules +=3D novatel
 builtin_sources +=3D plugins/novatel.c
 =

-builtin_modules +=3D bluetooth
-builtin_sources +=3D plugins/bluetooth.c plugins/bluetooth.h
-
 builtin_modules +=3D hfp
 builtin_sources +=3D plugins/hfp.c plugins/bluetooth.h
 =

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index cb45b3f..12446f7 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -571,5 +571,3 @@ void bluetooth_unregister_uuid(const char *uuid)
 	uuid_hash =3D NULL;
 }
 =

-OFONO_PLUGIN_DEFINE(bluetooth, "Bluetooth Utils Plugins", VERSION,
-			OFONO_PLUGIN_PRIORITY_DEFAULT, NULL, NULL)
-- =

1.7.1


--===============2117682539439761521==--

