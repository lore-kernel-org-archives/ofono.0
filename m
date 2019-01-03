Content-Type: multipart/mixed; boundary="===============9187368052444117272=="
MIME-Version: 1.0
From: BOUBAKER Bassem <bassem.boubaker@actia.fr>
Subject: [PATCH] Add support for cinterion AHS3-W enumeration in
 plugins/udevng.c
Date: Thu, 03 Jan 2019 09:22:53 +0000
Message-ID: <1546510967-1011-1-git-send-email-bassem.boubaker@actia.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9187368052444117272==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This commit will add the vid/pid of this module. Also, probe correclty the
different ports (app,mdm,gps,wwan).

PS: unlike other cinterion modules, AHS3-W enumerate application port on in=
fo->number=3D0 and not info->number=3D2
---
 plugins/udevng.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index ff6e1fc..56531ea 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1132,11 +1132,18 @@ static gboolean setup_gemalto(struct modem_info* mo=
dem)
 		DBG("%s %s %s %s %s", info->devnode, info->interface,
 				info->number, info->label, info->subsystem);
 =

-		/* PHS8-P */
+		/* PHS8-P, PXS8, AHS3-W */
 		if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
+
 			if (g_strcmp0(info->number, "01") =3D=3D 0)
 				gps =3D info->devnode;
-			else if (g_strcmp0(info->number, "02") =3D=3D 0)
+			/* For AHS3-W module, the app is on number 00; for the other modules,
+			the app is on number 02 */
+			else if ((g_strcmp0(info->number, "00") =3D=3D 0) &&
+				(g_strcmp0(modem->model, "0055") =3D=3D 0))
+				app =3D info->devnode;
+			else if ((g_strcmp0(info->number, "02") =3D=3D 0) &&
+				(g_strcmp0(modem->model, "0055") !=3D 0))
 				app =3D info->devnode;
 			else if (g_strcmp0(info->number, "03") =3D=3D 0)
 				mdm =3D info->devnode;
@@ -1146,7 +1153,7 @@ static gboolean setup_gemalto(struct modem_info* mode=
m)
 				qmi =3D info->devnode;
 		}
 =

-		/* Cinterion ALS3, PLS8-E, PLS8-X */
+		/* Cinterion ALS3, PLS8-E, PLS8-X, PXS8-ACM mode */
 		if (g_strcmp0(info->interface, "2/2/1") =3D=3D 0) {
 			if (g_strcmp0(info->number, "00") =3D=3D 0)
 				mdm =3D info->devnode;
@@ -1687,6 +1694,8 @@ static struct {
 	{ "gemalto",	"qmi_wwan",	"1e2d",	"0053"	},
 	{ "gemalto",	"cdc_acm",	"1e2d",	"0061"	},
 	{ "gemalto",	"cdc_ether",	"1e2d",	"0061"	},
+	{ "gemalto",	"option",	"1e2d",	"0055"	},
+	{ "gemalto",	"cdc_ether",	"1e2d",	"0055"	},
 	{ "telit",	"cdc_ncm",	"1bc7", "0036"	},
 	{ "telit",	"cdc_acm",	"1bc7", "0036"	},
 	{ "xmm7xxx",	"cdc_acm",	"8087"		},
-- =

2.7.4


--===============9187368052444117272==--

