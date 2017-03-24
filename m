Content-Type: multipart/mixed; boundary="===============7324190834742980307=="
MIME-Version: 1.0
From: Lukasz Nowak <lnowak.tyco@gmail.com>
Subject: [PATCH v3 2/2] udevng: add Telit LE910 V1 support
Date: Fri, 24 Mar 2017 14:51:46 +0000
Message-ID: <1490367106-8401-3-git-send-email-lnowak.tyco@gmail.com>
In-Reply-To: <1490367106-8401-1-git-send-email-lnowak.tyco@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7324190834742980307==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lukasz Nowak <lnowak@tycoint.com>

Tested with LE910-SVG and Verizon.
---
 plugins/udevng.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 2279bbe..3b15064 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -182,14 +182,15 @@ static gboolean setup_gobi(struct modem_info *modem)
 	const char *qmi =3D NULL, *mdm =3D NULL, *net =3D NULL;
 	const char *gps =3D NULL, *diag =3D NULL;
 	GSList *list;
+	gboolean telit =3D FALSE;
 =

 	DBG("%s", modem->syspath);
 =

 	for (list =3D modem->devices; list; list =3D list->next) {
 		struct device_info *info =3D list->data;
 =

-		DBG("%s %s %s %s", info->devnode, info->interface,
-						info->number, info->label);
+		DBG("%s %s %s %s %s", info->devnode, info->interface,
+					info->number, info->label, info->subsystem);
 =

 		if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
 			if (info->number =3D=3D NULL)
@@ -199,10 +200,18 @@ static gboolean setup_gobi(struct modem_info *modem)
 			else if (g_strcmp0(info->number, "01") =3D=3D 0)
 				diag =3D info->devnode;
 			else if (g_strcmp0(info->number, "02") =3D=3D 0)
-				mdm =3D info->devnode;
+				if (g_strcmp0(info->subsystem, "net") =3D=3D 0)
+					net =3D info->devnode;
+				else if (g_strcmp0(info->subsystem, "usbmisc") =3D=3D 0) {
+					telit =3D TRUE;
+					qmi =3D info->devnode;
+				} else
+					mdm =3D info->devnode;
 			else if (g_strcmp0(info->number, "03") =3D=3D 0)
 				gps =3D info->devnode;
-		}
+		} else if (g_strcmp0(info->interface, "255/0/0") =3D=3D 0)
+			if (g_strcmp0(info->number, "04") =3D=3D 0)
+				mdm =3D info->devnode;
 	}
 =

 	if (qmi =3D=3D NULL || mdm =3D=3D NULL || net =3D=3D NULL)
@@ -215,6 +224,12 @@ static gboolean setup_gobi(struct modem_info *modem)
 	ofono_modem_set_string(modem->modem, "Diag", diag);
 	ofono_modem_set_string(modem->modem, "NetworkInterface", net);
 =

+	if (telit) {
+		/* Telit LE910 V1 modems */
+		ofono_modem_set_boolean(modem->modem, "ForceSimLegacy", TRUE);
+		ofono_modem_set_boolean(modem->modem, "AlwaysOnline", TRUE);
+	}
+
 	return TRUE;
 }
 =

@@ -1168,6 +1183,7 @@ static struct {
 	{ "mbm",	"cdc_ether",	"0930"		},
 	{ "mbm",	"cdc_ncm",	"0930"		},
 	{ "hso",	"hso"				},
+	{ "gobi",	"option",	"1bc7", "1201"	},
 	{ "gobi",	"qmi_wwan"			},
 	{ "gobi",	"qcserial"			},
 	{ "sierra",	"qmi_wwan",	"1199"		},
-- =

2.7.4


--===============7324190834742980307==--

