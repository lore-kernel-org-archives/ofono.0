Content-Type: multipart/mixed; boundary="===============1841687101784267172=="
MIME-Version: 1.0
From: Funktionspostfach Herbrechtsmeier OSS <stefan.herbrechtsmeier-oss@weidmueller.com>
Subject: [PATCH] udevng: add SIMCom SIM7600 modem support
Date: Wed, 08 May 2019 14:01:12 +0000
Message-ID: <20190508140058.190372-1-stefan.herbrechtsmeier-oss@weidmueller.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1841687101784267172==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

The SIMCom SIM7100 and SIM7600 modem use the same vendor and product id
but require different drivers (sim7100 vs gobi).
---
 plugins/udevng.c | 70 ++++++++++++++++++++++++++++++++++++++--------------=
----
 1 file changed, 48 insertions(+), 22 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index f689b756..2b6f6701 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1241,9 +1241,11 @@ static gboolean setup_xmm7xxx(struct modem_info *mod=
em)
 	return TRUE;
 }
 =

-static gboolean setup_sim7100(struct modem_info *modem)
+static gboolean setup_sim7x00(struct modem_info *modem)
 {
-	const char *at =3D NULL, *ppp =3D NULL, *gps =3D NULL, *diag =3D NULL, *a=
udio =3D NULL;
+	const char *audio =3D NULL, *diag =3D NULL, *gps =3D NULL;
+	const char *mdm =3D NULL, *net =3D NULL, *ppp =3D NULL;
+	const char *qmi =3D NULL;
 	GSList *list;
 =

 	DBG("%s", modem->syspath);
@@ -1251,10 +1253,12 @@ static gboolean setup_sim7100(struct modem_info *mo=
dem)
 	for (list =3D modem->devices; list; list =3D list->next) {
 		struct device_info *info =3D list->data;
 =

-		DBG("%s %s", info->devnode, info->number);
+		DBG("%s %s %s %s %s %s", info->devnode, info->interface,
+						info->number, info->label,
+						info->sysattr, info->subsystem);
 =

 		/*
-		 * Serial port layout:
+		 * SIM7100 serial port layout:
 		 * 0: QCDM/DIAG
 		 * 1: NMEA
 		 * 2: AT
@@ -1263,29 +1267,50 @@ static gboolean setup_sim7100(struct modem_info *mo=
dem)
 		 *
 		 * -- https://www.spinics.net/lists/linux-usb/msg135728.html
 		 */
-		if (g_strcmp0(info->number, "00") =3D=3D 0)
-			diag =3D info->devnode;
-		else if (g_strcmp0(info->number, "01") =3D=3D 0)
-			gps =3D info->devnode;
-		else if (g_strcmp0(info->number, "02") =3D=3D 0)
-			at =3D info->devnode;
-		else if (g_strcmp0(info->number, "03") =3D=3D 0)
-			ppp =3D info->devnode;
-		else if (g_strcmp0(info->number, "04") =3D=3D 0)
-			audio =3D info->devnode;
+		if (g_strcmp0(info->subsystem, "usbmisc") =3D=3D 0) /* cdc-wdm */
+			qmi =3D info->devnode; /* SIM7600 */
+		else if (g_strcmp0(info->subsystem, "net") =3D=3D 0) /* wwan */
+			net =3D info->devnode; /* SIM7600 */
+		else if (g_strcmp0(info->subsystem, "tty") =3D=3D 0) {
+			if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
+				if (g_strcmp0(info->number, "00") =3D=3D 0)
+					diag =3D info->devnode; /* SIM7x00 */
+			} else if (g_strcmp0(info->interface, "255/0/0") =3D=3D 0) {
+				if (g_strcmp0(info->number, "01") =3D=3D 0)
+					gps =3D info->devnode; /* SIM7x00 */
+				else if (g_strcmp0(info->number, "02") =3D=3D 0)
+					mdm =3D info->devnode; /* SIM7x00 */
+				else if (g_strcmp0(info->number, "03") =3D=3D 0)
+					ppp =3D info->devnode; /* SIM7100 */
+				else if (g_strcmp0(info->number, "04") =3D=3D 0)
+					audio =3D info->devnode; /* SIM7100 */
+			}
+		}
 	}
 =

-	if (at =3D=3D NULL)
+	if (mdm =3D=3D NULL)
 		return FALSE;
 =

-	DBG("at=3D%s ppp=3D%s gps=3D%s diag=3D%s, audio=3D%s", at, ppp, gps, diag=
, audio);
+	if (qmi !=3D NULL && net !=3D NULL) {
+		DBG("qmi=3D%s net=3D%s mdm=3D%s gps=3D%s diag=3D%s", qmi, net, mdm, gps,=
 diag);
+
+		ofono_modem_set_driver(modem->modem, "gobi");
+
+		ofono_modem_set_string(modem->modem, "Device", qmi);
+		ofono_modem_set_string(modem->modem, "Modem", mdm);
+		ofono_modem_set_string(modem->modem, "NetworkInterface", net);
+	} else {
+		DBG("at=3D%s ppp=3D%s gps=3D%s diag=3D%s, audio=3D%s", mdm, ppp, gps, di=
ag, audio);
+
+		ofono_modem_set_driver(modem->modem, "sim7100");
+
+		ofono_modem_set_string(modem->modem, "AT", mdm);
+		ofono_modem_set_string(modem->modem, "PPP", ppp);
+		ofono_modem_set_string(modem->modem, "Audio", audio);
+	}
 =

-	ofono_modem_set_string(modem->modem, "AT", at);
-	ofono_modem_set_string(modem->modem, "PPP", ppp);
 	ofono_modem_set_string(modem->modem, "GPS", gps);
 	ofono_modem_set_string(modem->modem, "Diag", diag);
-	ofono_modem_set_string(modem->modem, "Audio", audio);
-
 	return TRUE;
 }
 =

@@ -1309,7 +1334,7 @@ static struct {
 	{ "telit",	setup_telit,	"device/interface"	},
 	{ "telitqmi",	setup_telitqmi	},
 	{ "simcom",	setup_simcom	},
-	{ "sim7100",	setup_sim7100	},
+	{ "sim7x00",	setup_sim7x00	},
 	{ "zte",	setup_zte	},
 	{ "icera",	setup_icera	},
 	{ "samsung",	setup_samsung	},
@@ -1682,7 +1707,8 @@ static struct {
 	{ "novatel",	"option",	"1410"		},
 	{ "zte",	"option",	"19d2"		},
 	{ "simcom",	"option",	"05c6", "9000"	},
-	{ "sim7100",	"option",	"1e0e", "9001"	},
+	{ "sim7x00",	"option",	"1e0e", "9001"	},
+	{ "sim7x00",	"qmi_wwan",	"1e0e",	"9001"	},
 	{ "telit",	"usbserial",	"1bc7"		},
 	{ "telit",	"option",	"1bc7"		},
 	{ "telit",	"cdc_acm",	"1bc7", "0021"	},
-- =

2.16.2.windows.1


--===============1841687101784267172==--

