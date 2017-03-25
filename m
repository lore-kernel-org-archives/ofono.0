Content-Type: multipart/mixed; boundary="===============8464340194342730313=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH qmi 5/5] udevng: add qmiwwan modem driver
Date: Sat, 25 Mar 2017 17:57:55 +0100
Message-ID: <20170325165755.28114-6-jonas@southpole.se>
In-Reply-To: <20170325165755.28114-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8464340194342730313==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This can hopefully be a generic QMI modem setup function.  The channels
need to be labelled by udev.
---
 plugins/udevng.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 2279bbe..0b9c341 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -177,6 +177,46 @@ static gboolean setup_hso(struct modem_info *modem)
 	return TRUE;
 }
 =

+static gboolean setup_qmiwwan(struct modem_info *modem)
+{
+	const char *qmi =3D NULL, *net =3D NULL;
+	const char *gps =3D NULL;
+	GSList *list;
+
+	DBG("%s", modem->syspath);
+
+	for (list =3D modem->devices; list; list =3D list->next) {
+		struct device_info *info =3D list->data;
+
+		DBG("%s %s %s %s %s", info->devnode, info->interface,
+				info->number, info->label, info->subsystem);
+
+		if (!g_strcmp0(info->label, "qmi")) {
+			if (!g_strcmp0(info->subsystem, "usbmisc"))
+					qmi =3D info->devnode;
+			else if (!g_strcmp0(info->subsystem, "net"))
+					net =3D info->devnode;
+		} else if (!g_strcmp0(info->label, "gps")) {
+			gps =3D info->devnode;
+		}
+	}
+
+	if (qmi =3D=3D NULL || net =3D=3D NULL)
+		return FALSE;
+
+	DBG("qmi=3D%s net=3D%s gps=3D%s", qmi, net, gps);
+
+	ofono_modem_set_driver(modem->modem, "gobi");
+
+	ofono_modem_set_string(modem->modem, "Device", qmi);
+	ofono_modem_set_string(modem->modem, "NetworkInterface", net);
+	if (gps)
+		ofono_modem_set_string(modem->modem, "GPS", gps);
+
+	return TRUE;
+}
+
+
 static gboolean setup_gobi(struct modem_info *modem)
 {
 	const char *qmi =3D NULL, *mdm =3D NULL, *net =3D NULL;
@@ -941,6 +981,7 @@ static struct {
 	{ "isiusb",	setup_isi,	"type"			},
 	{ "mbm",	setup_mbm,	"device/interface"	},
 	{ "hso",	setup_hso,	"hsotype"		},
+	{ "qmiwwan",	setup_qmiwwan	},
 	{ "gobi",	setup_gobi	},
 	{ "sierra",	setup_sierra	},
 	{ "option",	setup_option	},
-- =

2.9.3


--===============8464340194342730313==--

