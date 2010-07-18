Content-Type: multipart/mixed; boundary="===============5729097334279016516=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: [PATCH 4/4] make bluetooth.{c,h} a static library
Date: Sun, 18 Jul 2010 19:57:29 -0300
Message-ID: <1279493849-22930-4-git-send-email-gustavo@padovan.org>
In-Reply-To: <1279493849-22930-3-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5729097334279016516==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am         |    7 +++----
 plugins/bluetooth.c |    3 ---
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index e256841..3c69b4e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -71,6 +71,8 @@ gatchat_sources =3D gatchat/gatchat.h gatchat/gatchat.c \
 				gatchat/ppp_auth.c gatchat/ppp_net.c \
 				gatchat/ppp_ipcp.c
 =

+bluetooth_sources =3D plugins/bluetooth.c plugins/bluetooth.h
+
 udev_files =3D plugins/ofono.rules
 =

 if UDEV
@@ -236,11 +238,8 @@ builtin_sources +=3D plugins/huawei.c
 builtin_modules +=3D novatel
 builtin_sources +=3D plugins/novatel.c
 =

-builtin_modules +=3D bluetooth
-builtin_sources +=3D plugins/bluetooth.c plugins/bluetooth.h
-
 builtin_modules +=3D hfp
-builtin_sources +=3D plugins/hfp.c plugins/bluetooth.h
+builtin_sources +=3D plugins/hfp.c $(bluetooth_sources)
 =

 builtin_modules +=3D palmpre
 builtin_sources +=3D plugins/palmpre.c
diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 9335607..9aca650 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -555,6 +555,3 @@ void bluetooth_unregister_uuid(const char *uuid)
 	g_hash_table_destroy(adapter_address_hash);
 	uuid_hash =3D NULL;
 }
-
-OFONO_PLUGIN_DEFINE(bluetooth, "Bluetooth Utils Plugins", VERSION,
-			OFONO_PLUGIN_PRIORITY_DEFAULT, NULL, NULL)
-- =

1.7.1.1


--===============5729097334279016516==--

