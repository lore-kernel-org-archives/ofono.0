Content-Type: multipart/mixed; boundary="===============2889491458865872109=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 1/2] bluetooth: Rename DUN GW plugin
Date: Tue, 12 Mar 2013 10:38:43 +0100
Message-ID: <1363081124-5264-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2889491458865872109==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

As BlueZ 5 introduced backwards incompatible API changes, and we want to
keep support for BlueZ 4 based DUN GW plugin for some time, we need to
separate DUN GW plugin which is based on BlueZ 4 from the one based on
BlueZ 5.

The dun_gw.c plugin is renamed to dun_gw_bluez4. This will make it easy
to add a DUN GW plugin for BlueZ 5.
---
 Makefile.am                           |    4 ++--
 plugins/{dun_gw.c =3D> dun_gw_bluez4.c} |    5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)
 rename plugins/{dun_gw.c =3D> dun_gw_bluez4.c} (96%)

diff --git a/Makefile.am b/Makefile.am
index 3b998af..bf4806b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -425,8 +425,8 @@ builtin_sources +=3D plugins/hfp_hf_bluez4.c plugins/bl=
uez4.h
 builtin_modules +=3D hfp_ag_bluez4
 builtin_sources +=3D plugins/hfp_ag_bluez4.c plugins/bluez4.h
 =

-builtin_modules +=3D dun_gw
-builtin_sources +=3D plugins/dun_gw.c plugins/bluez4.h
+builtin_modules +=3D dun_gw_bluez4
+builtin_sources +=3D plugins/dun_gw_bluez4.c plugins/bluez4.h
 =

 builtin_modules +=3D connman
 builtin_sources +=3D plugins/connman.c
diff --git a/plugins/dun_gw.c b/plugins/dun_gw_bluez4.c
similarity index 96%
rename from plugins/dun_gw.c
rename to plugins/dun_gw_bluez4.c
index fc8bde4..a1de7a4 100644
--- a/plugins/dun_gw.c
+++ b/plugins/dun_gw_bluez4.c
@@ -167,5 +167,6 @@ static void dun_gw_exit(void)
 	}
 }
 =

-OFONO_PLUGIN_DEFINE(dun_gw, "Dial-up Networking Profile Plugins", VERSION,
-			OFONO_PLUGIN_PRIORITY_DEFAULT, dun_gw_init, dun_gw_exit)
+OFONO_PLUGIN_DEFINE(dun_gw_bluez4, "Dial-up Networking Profile Plugins",
+				VERSION, OFONO_PLUGIN_PRIORITY_DEFAULT,
+				dun_gw_init, dun_gw_exit)
-- =

1.7.9.5


--===============2889491458865872109==--

