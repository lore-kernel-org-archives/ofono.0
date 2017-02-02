Content-Type: multipart/mixed; boundary="===============6840400613154296395=="
MIME-Version: 1.0
From: Piotr Haber <gluedig@gmail.com>
Subject: [PATCH 2/2] udevng: unify telit and xe910
Date: Thu, 02 Feb 2017 15:09:27 +0100
Message-ID: <20170202140927.8152-3-gluedig@gmail.com>
In-Reply-To: <20170202140927.8152-1-gluedig@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6840400613154296395==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Unified setup for Telit devices using
usbserial and cdc_acm drivers.
---
 plugins/udevng.c | 44 ++++++--------------------------------------
 1 file changed, 6 insertions(+), 38 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 098e0651..b98d9d43 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -611,7 +611,7 @@ static gboolean setup_nokia(struct modem_info *modem)
 =

 static gboolean setup_telit(struct modem_info *modem)
 {
-	const char *mdm =3D NULL, *aux =3D NULL, *gps =3D NULL, *diag =3D NULL;
+	const char *mdm =3D NULL, *aux =3D NULL, *gps =3D NULL, *net =3D NULL;
 	GSList *list;
 =

 	DBG("%s", modem->syspath);
@@ -621,7 +621,6 @@ static gboolean setup_telit(struct modem_info *modem)
 =

 		DBG("%s %s %s %s", info->devnode, info->interface,
 						info->number, info->label);
-
 		if (g_strcmp0(info->label, "aux") =3D=3D 0) {
 			aux =3D info->devnode;
 			if (mdm !=3D NULL)
@@ -633,41 +632,11 @@ static gboolean setup_telit(struct modem_info *modem)
 		} else if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
 			if (g_strcmp0(info->number, "00") =3D=3D 0)
 				mdm =3D info->devnode;
-			else if (g_strcmp0(info->number, "01") =3D=3D 0)
-				diag =3D info->devnode;
 			else if (g_strcmp0(info->number, "02") =3D=3D 0)
 				gps =3D info->devnode;
 			else if (g_strcmp0(info->number, "03") =3D=3D 0)
 				aux =3D info->devnode;
-		}
-	}
-
-	if (aux =3D=3D NULL || mdm =3D=3D NULL)
-		return FALSE;
-
-	DBG("modem=3D%s aux=3D%s gps=3D%s diag=3D%s", mdm, aux, gps, diag);
-
-	ofono_modem_set_string(modem->modem, "Modem", mdm);
-	ofono_modem_set_string(modem->modem, "Aux", aux);
-	ofono_modem_set_string(modem->modem, "GPS", gps);
-
-	return TRUE;
-}
-
-static gboolean setup_xe910(struct modem_info *modem)
-{
-	const char *mdm =3D NULL, *aux =3D NULL, *gps =3D NULL, *net =3D NULL;
-	GSList *list;
-
-	DBG("%s", modem->syspath);
-
-	for (list =3D modem->devices; list; list =3D list->next) {
-		struct device_info *info =3D list->data;
-
-		DBG("%s %s %s %s", info->devnode, info->interface,
-						info->number, info->label);
-
-		if (g_strcmp0(info->interface, "2/2/1") =3D=3D 0) {
+		} else if (g_strcmp0(info->interface, "2/2/1") =3D=3D 0) {
 			if (g_strcmp0(info->number, "00") =3D=3D 0)
 				mdm =3D info->devnode;
 			else if (g_strcmp0(info->number, "06") =3D=3D 0)
@@ -981,8 +950,7 @@ static struct {
 	{ "alcatel",	setup_alcatel	},
 	{ "novatel",	setup_novatel	},
 	{ "nokia",	setup_nokia	},
-	{ "telit",	setup_telit	},
-	{ "xe910",	setup_xe910,	"device/interface"	},
+	{ "telit",	setup_telit,	"device/interface"	},
 	{ "simcom",	setup_simcom	},
 	{ "zte",	setup_zte	},
 	{ "icera",	setup_icera	},
@@ -1220,7 +1188,7 @@ static struct {
 	{ "simcom",	"option",	"05c6", "9000"	},
 	{ "telit",	"usbserial",	"1bc7"		},
 	{ "telit",	"option",	"1bc7"		},
-	{ "xe910",	"cdc_acm",	"1bc7", "0021"	},
+	{ "telit",	"cdc_acm",	"1bc7", "0021"	},
 	{ "nokia",	"option",	"0421", "060e"	},
 	{ "nokia",	"option",	"0421", "0623"	},
 	{ "samsung",	"option",	"04e8", "6889"	},
@@ -1232,8 +1200,8 @@ static struct {
 	{ "gemalto",	"option",	"1e2d",	"0053"	},
 	{ "gemalto",	"cdc_wdm",	"1e2d",	"0053"	},
 	{ "gemalto",	"qmi_wwan",	"1e2d",	"0053"	},
-	{ "xe910",	"cdc_ncm",	"1bc7", "0036"	},
-	{ "xe910",	"cdc_acm",	"1bc7", "0036"	},
+	{ "telit",	"cdc_ncm",	"1bc7", "0036"	},
+	{ "telit",	"cdc_acm",	"1bc7", "0036"	},
 	{ }
 };
 =

-- =

2.11.0


--===============6840400613154296395==--

