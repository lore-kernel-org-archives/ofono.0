Content-Type: multipart/mixed; boundary="===============1764635441234197991=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 1/2] bluetooth: Rename HFP AG plugin
Date: Tue, 29 Jan 2013 11:42:39 +0100
Message-ID: <1359456160-9514-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1764635441234197991==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

As BlueZ 5 introduced backwards incompatible API changes, and we want to
keep support for BlueZ 4 based HFP AG plugin for some time, we need to
separate HFP AG plugin which is based on BlueZ 4 from the one based on
BlueZ 5.

The hfp_ag.c plugin is renamed to hfp_ag_bluez4. This will make it easy
to add an HFP AG plugin for BlueZ 5.
---
 Makefile.am                           |    4 ++--
 plugins/{hfp_ag.c =3D> hfp_ag_bluez4.c} |    5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)
 rename plugins/{hfp_ag.c =3D> hfp_ag_bluez4.c} (97%)

diff --git a/Makefile.am b/Makefile.am
index f24cac7..ee6d24c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -421,8 +421,8 @@ builtin_sources +=3D plugins/sap.c plugins/bluez4.h
 builtin_modules +=3D hfp_bluez4
 builtin_sources +=3D plugins/hfp_hf_bluez4.c plugins/bluez4.h
 =

-builtin_modules +=3D hfp_ag
-builtin_sources +=3D plugins/hfp_ag.c plugins/bluez4.h
+builtin_modules +=3D hfp_ag_bluez4
+builtin_sources +=3D plugins/hfp_ag_bluez4.c plugins/bluez4.h
 =

 builtin_modules +=3D dun_gw
 builtin_sources +=3D plugins/dun_gw.c plugins/bluez4.h
diff --git a/plugins/hfp_ag.c b/plugins/hfp_ag_bluez4.c
similarity index 97%
rename from plugins/hfp_ag.c
rename to plugins/hfp_ag_bluez4.c
index 12374ad..039b665 100644
--- a/plugins/hfp_ag.c
+++ b/plugins/hfp_ag_bluez4.c
@@ -213,5 +213,6 @@ static void hfp_ag_exit(void)
 	}
 }
 =

-OFONO_PLUGIN_DEFINE(hfp_ag, "Hands-Free Audio Gateway Profile Plugins", VE=
RSION,
-			OFONO_PLUGIN_PRIORITY_DEFAULT, hfp_ag_init, hfp_ag_exit)
+OFONO_PLUGIN_DEFINE(hfp_ag_bluez4, "Hands-Free Audio Gateway Profile Plugi=
ns",
+				VERSION, OFONO_PLUGIN_PRIORITY_DEFAULT,
+				hfp_ag_init, hfp_ag_exit)
-- =

1.7.9.5


--===============1764635441234197991==--

