Content-Type: multipart/mixed; boundary="===============1274007885673510914=="
MIME-Version: 1.0
From: Vincent Cesson <vincent.cesson@smile.fr>
Subject: [PATCH 2/2] udevng: Add Gemalto P-family detection
Date: Mon, 16 Jan 2017 10:07:53 +0100
Message-ID: <1484557673-15666-2-git-send-email-vincent.cesson@smile.fr>
In-Reply-To: <1484557673-15666-1-git-send-email-vincent.cesson@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1274007885673510914==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a new function setup, based on telit, to handle Gemalto P-family
discovery. The setup looks for USB interfaces:
application=3D/dev/ttyUSB2
gps=3D/dev/ttyUSB1
modem=3D/dev/ttyUSB3
---
 plugins/udevng.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index a2866b6..f86f467 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -913,6 +913,42 @@ static gboolean setup_ublox(struct modem_info *modem)
 	return TRUE;
 }
 =

+static gboolean setup_gemalto(struct modem_info* modem)
+{
+	const char *app =3D NULL, *gps =3D NULL, *mdm =3D NULL;
+
+	GSList *list;
+
+	DBG("%s", modem->syspath);
+
+	for (list =3D modem->devices; list; list =3D list->next) {
+		struct device_info *info =3D list->data;
+
+		DBG("%s %s %s %s %s", info->devnode, info->interface,
+						info->number, info->label, info->subsystem);
+
+		if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
+			if (g_strcmp0(info->number, "01") =3D=3D 0)
+				gps =3D info->devnode;
+			else if (g_strcmp0(info->number, "02") =3D=3D 0)
+				app =3D info->devnode;
+			else if (g_strcmp0(info->number, "03") =3D=3D 0)
+				mdm =3D info->devnode;
+		}
+	}
+
+	DBG("application=3D%s gps=3D%s modem=3D%s", app, gps, mdm);
+
+	if (app =3D=3D NULL || mdm =3D=3D NULL)
+		return FALSE;
+
+	ofono_modem_set_string(modem->modem, "Application", app);
+	ofono_modem_set_string(modem->modem, "GPS", gps);
+	ofono_modem_set_string(modem->modem, "Modem", mdm);
+
+	return TRUE;
+}
+
 static struct {
 	const char *name;
 	gboolean (*setup)(struct modem_info *modem);
@@ -939,6 +975,7 @@ static struct {
 	{ "samsung",	setup_samsung	},
 	{ "quectel",	setup_quectel	},
 	{ "ublox",	setup_ublox	},
+	{ "gemalto",	setup_gemalto	},
 	{ }
 };
 =

@@ -1178,6 +1215,7 @@ static struct {
 	{ "ublox",	"cdc_acm",	"1546", "1102"	},
 	{ "ublox",	"rndis_host",	"1546", "1146"	},
 	{ "ublox",	"cdc_acm",	"1546", "1146"	},
+	{ "gemalto",	"option",	"1e2d",	"0053"	},
 	{ }
 };
 =

-- =

1.9.1


--===============1274007885673510914==--

