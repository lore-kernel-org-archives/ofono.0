Content-Type: multipart/mixed; boundary="===============0481592483544197575=="
MIME-Version: 1.0
From: Forest Bond <forest@alittletooquiet.net>
Subject: [PATCH 8/8] udevng: Support single-interface sierra devices
Date: Fri, 28 Dec 2012 14:36:23 -0500
Message-ID: <20121228193623.GN18339@alittletooquiet.net>
In-Reply-To: <20121228193141.GF18339@alittletooquiet.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0481592483544197575==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Forest Bond <forest.bond@rapidrollout.com>

Sierra Wireless CDMA devices have a single interface with multiple
ports.
---
 plugins/udevng.c |   43 +++++++++++++++++++++++++++++++++----------
 1 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index afb02ca..feef4cc 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -218,10 +218,28 @@ static gboolean setup_gobi(struct modem_info *modem)
 static gboolean setup_sierra(struct modem_info *modem)
 {
 	const char *mdm =3D NULL, *app =3D NULL, *net =3D NULL, *diag =3D NULL;
+	gboolean multi_iface =3D FALSE;
+	char *last_iface =3D NULL;
 	GSList *list;
 =

 	DBG("%s", modem->syspath);
 =

+	/*
+	 * DirectIP devices use multiple interfaces, but non-DirectIP
+	 * (e.g. CDMA) devices have a single interface with multiple
+	 * ports distinguished by the "port_number" sysfs attribute.
+	 */
+
+	for (list =3D modem->devices; list; list =3D list->next) {
+		struct device_info *info =3D list->data;
+
+		if (last_iface !=3D NULL && g_strcmp0(info->number, last_iface) !=3D 0) {
+			multi_iface =3D TRUE;
+			break;
+		}
+		last_iface =3D info->number;
+	}
+
 	for (list =3D modem->devices; list; list =3D list->next) {
 		struct device_info *info =3D list->data;
 =

@@ -229,18 +247,23 @@ static gboolean setup_sierra(struct modem_info *modem)
 						info->number, info->label);
 =

 		if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
-			if (g_strcmp0(info->number, "01") =3D=3D 0)
-				diag =3D info->devnode;
-			if (g_strcmp0(info->number, "03") =3D=3D 0)
-				mdm =3D info->devnode;
-			else if (g_strcmp0(info->number, "04") =3D=3D 0)
-				app =3D info->devnode;
-			else if (g_strcmp0(info->number, "07") =3D=3D 0)
-				net =3D info->devnode;
+			if (multi_iface) {
+				if (g_strcmp0(info->number, "01") =3D=3D 0)
+					diag =3D info->devnode;
+				else if (g_strcmp0(info->number, "03") =3D=3D 0)
+					mdm =3D info->devnode;
+				else if (g_strcmp0(info->number, "04") =3D=3D 0)
+					app =3D info->devnode;
+				else if (g_strcmp0(info->number, "07") =3D=3D 0)
+					net =3D info->devnode;
+			} else {
+				if (g_strcmp0(info->sysattr, "0") =3D=3D 0)
+					mdm =3D info->devnode;
+			}
 		}
 	}
 =

-	if (mdm =3D=3D NULL || net =3D=3D NULL)
+	if (mdm =3D=3D NULL || (multi_iface && net =3D=3D NULL))
 		return FALSE;
 =

 	DBG("modem=3D%s app=3D%s net=3D%s diag=3D%s", mdm, app, net, diag);
@@ -768,7 +791,7 @@ static struct {
 	{ "mbm",	setup_mbm,	"device/interface"	},
 	{ "hso",	setup_hso,	"hsotype"		},
 	{ "gobi",	setup_gobi	},
-	{ "sierra",	setup_sierra	},
+	{ "sierra",	setup_sierra,	"device/port_number"	},
 	{ "option",	setup_option	},
 	{ "huawei",	setup_huawei	},
 	{ "speedupcdma",setup_speedup	},
-- =

1.7.0.4

--===============0481592483544197575==--

