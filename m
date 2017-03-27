Content-Type: multipart/mixed; boundary="===============5470887969785695492=="
MIME-Version: 1.0
From: Lukasz Nowak <lnowak.tyco@gmail.com>
Subject: [PATCH v5 2/2] udevng: add Telit LE910 V1 support
Date: Mon, 27 Mar 2017 09:56:18 +0100
Message-ID: <1490604978-10639-3-git-send-email-lnowak.tyco@gmail.com>
In-Reply-To: <1490604978-10639-1-git-send-email-lnowak.tyco@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5470887969785695492==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lukasz Nowak <lnowak@tycoint.com>

Tested with LE910-SVG and Verizon.
---
 plugins/udevng.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index ce2bc28..5eb7da8 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -665,6 +665,44 @@ static gboolean setup_telit(struct modem_info *modem)
 	return TRUE;
 }
 =

+static gboolean setup_telitqmi(struct modem_info *modem)
+{
+	const char *qmi =3D NULL, *net =3D NULL;
+	GSList *list;
+	gboolean telit =3D FALSE;
+
+	DBG("%s", modem->syspath);
+
+	for (list =3D modem->devices; list; list =3D list->next) {
+		struct device_info *info =3D list->data;
+
+		DBG("%s %s %s %s %s", info->devnode, info->interface,
+				info->number, info->label, info->subsystem);
+
+		if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0 &&
+				g_strcmp0(info->number, "02") =3D=3D 0) {
+			if (g_strcmp0(info->subsystem, "net") =3D=3D 0)
+				net =3D info->devnode;
+			else if (g_strcmp0(info->subsystem, "usbmisc") =3D=3D 0)
+				qmi =3D info->devnode;
+		}
+	}
+
+	if (qmi =3D=3D NULL || net =3D=3D NULL)
+		return FALSE;
+
+	DBG("qmi=3D%s net=3D%s", qmi, net);
+
+	ofono_modem_set_string(modem->modem, "Device", qmi);
+	ofono_modem_set_string(modem->modem, "NetworkInterface", net);
+
+	ofono_modem_set_boolean(modem->modem, "ForceSimLegacy", TRUE);
+	ofono_modem_set_boolean(modem->modem, "AlwaysOnline", TRUE);
+	ofono_modem_set_driver(modem->modem, "gobi");
+
+	return TRUE;
+}
+
 static gboolean setup_simcom(struct modem_info *modem)
 {
 	const char *mdm =3D NULL, *aux =3D NULL, *gps =3D NULL, *diag =3D NULL;
@@ -952,6 +990,7 @@ static struct {
 	{ "novatel",	setup_novatel	},
 	{ "nokia",	setup_nokia	},
 	{ "telit",	setup_telit,	"device/interface"	},
+	{ "telitqmi",	setup_telitqmi	},
 	{ "simcom",	setup_simcom	},
 	{ "zte",	setup_zte	},
 	{ "icera",	setup_icera	},
@@ -1190,6 +1229,8 @@ static struct {
 	{ "telit",	"usbserial",	"1bc7"		},
 	{ "telit",	"option",	"1bc7"		},
 	{ "telit",	"cdc_acm",	"1bc7", "0021"	},
+	{ "telitqmi",	"qmi_wwan",	"1bc7", "1201"	},
+	{ "telitqmi",	"option",	"1bc7", "1201"	},
 	{ "nokia",	"option",	"0421", "060e"	},
 	{ "nokia",	"option",	"0421", "0623"	},
 	{ "samsung",	"option",	"04e8", "6889"	},
-- =

2.7.4


--===============5470887969785695492==--

