Content-Type: multipart/mixed; boundary="===============1674969871942825113=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Cl=C3=A9mentViel?= <vielclement@gmail.com>
Subject: [PATCH 2/3] sim800: add udev detection
Date: Tue, 18 Sep 2018 22:36:26 +0200
Message-ID: <1537302987-12592-2-git-send-email-vielclement@gmail.com>
In-Reply-To: <1537302987-12592-1-git-send-email-vielclement@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1674969871942825113==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: clem <vielclement@gmail.com>

---
 plugins/udevng.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 02d049e..9a1be6a 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -710,6 +710,53 @@ static gboolean setup_telitqmi(struct modem_info *mode=
m)
 	return TRUE;
 }
 =

+static gboolean setup_sim800(struct modem_info *modem)
+{
+	const char *mdm =3D NULL, *aux =3D NULL, *gps =3D NULL, *diag =3D NULL;
+	GSList *list;
+
+	DBG("%s", modem->syspath);
+
+	for (list =3D modem->devices; list; list =3D list->next) {
+		struct device_info *info =3D list->data;
+
+		DBG("%s %s %s %s", info->devnode, info->interface,
+			info->number, info->label);
+
+		if (g_strcmp0(info->label, "aux") =3D=3D 0) {
+			DBG("setting aux as info->devnode");
+			aux =3D info->devnode;
+			if (mdm !=3D NULL)
+			break;
+		} else if (g_strcmp0(info->label, "modem") =3D=3D 0) {
+			mdm =3D info->devnode;
+			if (aux !=3D NULL)
+			break;
+		} else if (g_strcmp0(info->interface, "255/0/0") =3D=3D 0) {
+			if (g_strcmp0(info->number, "00") =3D=3D 0)
+				mdm =3D info->devnode;
+			else if (g_strcmp0(info->number, "01") =3D=3D 0)
+				gps =3D info->devnode;
+			else if (g_strcmp0(info->number, "02") =3D=3D 0)
+				aux =3D info->devnode;
+			else if (g_strcmp0(info->number, "03") =3D=3D 0)
+				mdm =3D info->devnode;
+		}
+	}
+
+	DBG("modem=3D%s aux=3D%s gps=3D%s diag=3D%s", mdm, aux, gps, diag);
+
+	if (mdm =3D=3D NULL) {
+		DBG("modem did not set up");
+		return FALSE;
+	}
+
+	ofono_modem_set_string(modem->modem, "Device", mdm);
+	ofono_modem_set_string(modem->modem, "Modem", mdm);
+
+	return TRUE;
+}
+
 /* TODO: Not used as we have no simcom driver */
 static gboolean setup_simcom(struct modem_info *modem)
 {
@@ -1282,6 +1329,7 @@ static struct {
 	{ "telit",	setup_telit,	"device/interface"	},
 	{ "telitqmi",	setup_telitqmi	},
 	{ "simcom",	setup_simcom	},
+	{ "sim800",     setup_sim800    },
 	{ "sim7100",	setup_sim7100	},
 	{ "zte",	setup_zte	},
 	{ "icera",	setup_icera	},
@@ -1654,6 +1702,7 @@ static struct {
 	{ "alcatel",	"option",	"1bbb", "0017"	},
 	{ "novatel",	"option",	"1410"		},
 	{ "zte",	"option",	"19d2"		},
+	{ "sim800",     "option",       "05c6", "9000"  },
 	{ "simcom",	"option",	"05c6", "9000"	},
 	{ "sim7100",	"option",	"1e0e", "9001"	},
 	{ "telit",	"usbserial",	"1bc7"		},
-- =

2.7.4


--===============1674969871942825113==--

