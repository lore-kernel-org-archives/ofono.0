Content-Type: multipart/mixed; boundary="===============4582782483174301801=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 1/1] Add support for Quectel EC21/25 modems
Date: Tue, 18 Apr 2017 14:56:29 +0200
Message-ID: <20170418125629.852-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4582782483174301801==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This follows the same pattern as the Telit QMI modems, routing the
setup through a QMI driver.  I think this can be cleaned up somehow,
but for now this at least provides support for these two modem models
so that others can aid in testing.
---
 plugins/udevng.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 3cca6b1..21f60de 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -847,6 +847,48 @@ static gboolean setup_quectel(struct modem_info *modem)
 	return TRUE;
 }
 =

+static gboolean setup_quectelqmi(struct modem_info *modem)
+{
+	const char *qmi =3D NULL, *net =3D NULL, *gps =3D NULL;
+	GSList *list;
+
+	DBG("%s", modem->syspath);
+
+	for (list =3D modem->devices; list; list =3D g_slist_next(list)) {
+		struct device_info *info =3D list->data;
+
+		DBG("%s %s %s %s %s", info->devnode, info->interface,
+				info->number, info->label, info->subsystem);
+
+		if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0 &&
+				g_strcmp0(info->number, "04") =3D=3D 0) {
+			if (g_strcmp0(info->subsystem, "net") =3D=3D 0)
+				net =3D info->devnode;
+			else if (g_strcmp0(info->subsystem, "usbmisc") =3D=3D 0)
+				qmi =3D info->devnode;
+		} else if (g_strcmp0(info->interface, "255/0/0") =3D=3D 0 &&
+				g_strcmp0(info->number, "02") =3D=3D 0) {
+			gps =3D info->devnode;
+		}
+	}
+
+	DBG("qmi=3D%s net=3D%s", qmi, net);
+
+	if (qmi =3D=3D NULL || net =3D=3D NULL)
+		return FALSE;
+
+	DBG("qmi=3D%s net=3D%s", qmi, net);
+
+	ofono_modem_set_string(modem->modem, "Device", qmi);
+	ofono_modem_set_string(modem->modem, "NetworkInterface", net);
+	if (gps)
+		ofono_modem_set_string(modem->modem, "GPS", gps);
+
+	ofono_modem_set_driver(modem->modem, "gobi");
+
+	return TRUE;
+}
+
 static gboolean setup_serial_modem(struct modem_info* modem)
 {
 	struct serial_device_info* info;
@@ -1068,6 +1110,7 @@ static struct {
 	{ "icera",	setup_icera	},
 	{ "samsung",	setup_samsung	},
 	{ "quectel",	setup_quectel	},
+	{ "quectelqmi",	setup_quectelqmi},
 	{ "ublox",	setup_ublox	},
 	{ "gemalto",	setup_gemalto	},
 	/* Following are non-USB modems */
@@ -1434,6 +1477,10 @@ static struct {
 	{ "samsung",	"option",	"04e8", "6889"	},
 	{ "samsung",	"kalmia"			},
 	{ "quectel",	"option",	"05c6", "9090"	},
+	{ "quectelqmi",	"qmi_wwan",	"2c7c", "0121"	},
+	{ "quectelqmi",	"qcserial",	"2c7c", "0121"	},
+	{ "quectelqmi",	"qmi_wwan",	"2c7c", "0125"	},
+	{ "quectelqmi",	"qcserial",	"2c7c", "0125"	},
 	{ "ublox",	"cdc_acm",	"1546", "1102"	},
 	{ "ublox",	"rndis_host",	"1546", "1146"	},
 	{ "ublox",	"cdc_acm",	"1546", "1146"	},
-- =

2.9.3


--===============4582782483174301801==--

