Content-Type: multipart/mixed; boundary="===============4866097181258624455=="
MIME-Version: 1.0
From: Bing Jupiter <jupiter.hce@gmail.com>
Subject: [PATCH v2 1/4] SARA R4 QMI support
Date: Wed, 24 Feb 2021 19:39:21 +1100
Message-ID: <20210224083924.3480-2-jupiter.hce@gmail.com>
In-Reply-To: <20210224083924.3480-1-jupiter.hce@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4866097181258624455==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udevng.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 34ac1cc0..9941145f 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1194,6 +1194,45 @@ static gboolean setup_ublox(struct modem_info *modem)
 	return TRUE;
 }
 =

+static gboolean setup_ubloxqmi(struct modem_info *modem) {
+	const char *qmi =3D NULL, *net =3D NULL, *gps =3D NULL, *aux =3D NULL;
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
+				g_strcmp0(info->number, "03") =3D=3D 0) {
+			if (g_strcmp0(info->subsystem, "net") =3D=3D 0)
+				net =3D info->devnode;
+			else if (g_strcmp0(info->subsystem, "usbmisc") =3D=3D 0)
+				qmi =3D info->devnode;
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
+	ofono_modem_set_string(modem->modem, "Quirk", "SARAR4");
+
+	DBG("gps=3D%s aux=3D%s", gps, aux);
+
+	ofono_modem_set_driver(modem->modem, "gobi");
+
+	return TRUE;
+}
+
 static gboolean setup_gemalto(struct modem_info* modem)
 {
 	const char *app =3D NULL, *gps =3D NULL, *mdm =3D NULL,
@@ -1441,6 +1480,7 @@ static struct {
 	{ "quectel",	setup_quectel	},
 	{ "quectelqmi",	setup_quectelqmi},
 	{ "ublox",	setup_ublox	},
+	{ "ubloxqmi",   setup_ubloxqmi  },
 	{ "gemalto",	setup_gemalto	},
 	{ "xmm7xxx",	setup_xmm7xxx	},
 	{ "mbim",	setup_mbim	},
@@ -1850,6 +1890,7 @@ static struct {
 	{ "ublox",	"cdc_ncm",	"1546", "110a"	},
 	{ "ublox",	"rndis_host",	"1546", "1146"	},
 	{ "ublox",	"cdc_acm",	"1546", "1146"	},
+	{ "ubloxqmi",   "qmi_wwan", "05c6", "90b2"  },
 	{ "gemalto",	"option",	"1e2d",	"0053"	},
 	{ "gemalto",	"cdc_wdm",	"1e2d",	"0053"	},
 	{ "gemalto",	"qmi_wwan",	"1e2d",	"0053"	},
-- =

2.25.1

--===============4866097181258624455==--

