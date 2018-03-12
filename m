Content-Type: multipart/mixed; boundary="===============4936616433041201227=="
MIME-Version: 1.0
From: Gabriel Lucas <gabriel.lucas@smile.fr>
Subject: [PATCH 1/6] gemalto: add detection of ALS3 modem
Date: Mon, 12 Mar 2018 13:57:08 +0100
Message-ID: <1520859433-14112-2-git-send-email-gabriel.lucas@smile.fr>
In-Reply-To: <1520859433-14112-1-git-send-email-gabriel.lucas@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4936616433041201227==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The product ID is added to the list of
modems to be detected by Ofono.
The gemalto plugin is used to handle the
ALS3 modem.
---
 plugins/udevng.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 3c7d99e..d398c6e 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1132,6 +1132,7 @@ static gboolean setup_gemalto(struct modem_info* mode=
m)
 		DBG("%s %s %s %s %s", info->devnode, info->interface,
 				info->number, info->label, info->subsystem);
 =

+		// PHS8-P
 		if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
 			if (g_strcmp0(info->number, "01") =3D=3D 0)
 				gps =3D info->devnode;
@@ -1144,6 +1145,20 @@ static gboolean setup_gemalto(struct modem_info* mod=
em)
 			else if (g_strcmp0(info->subsystem, "usbmisc") =3D=3D 0)
 				qmi =3D info->devnode;
 		}
+
+		// ALS3
+		if (g_strcmp0(info->interface, "2/2/1") =3D=3D 0) {
+			if (g_strcmp0(info->number, "00") =3D=3D 0)
+				mdm =3D info->devnode;
+			else if (g_strcmp0(info->number, "02") =3D=3D 0)
+				app =3D info->devnode;
+			else if (g_strcmp0(info->number, "04") =3D=3D 0)
+				gps =3D info->devnode;
+		}
+		if (g_strcmp0(info->interface, "2/6/0") =3D=3D 0) {
+			if (g_strcmp0(info->subsystem, "net") =3D=3D 0)
+				net =3D info->devnode;
+		}
 	}
 =

 	DBG("application=3D%s gps=3D%s modem=3D%s network=3D%s qmi=3D%s",
@@ -1156,6 +1171,7 @@ static gboolean setup_gemalto(struct modem_info* mode=
m)
 	ofono_modem_set_string(modem->modem, "GPS", gps);
 	ofono_modem_set_string(modem->modem, "Modem", mdm);
 	ofono_modem_set_string(modem->modem, "Device", qmi);
+	ofono_modem_set_string(modem->modem, "Model", modem->model);
 	ofono_modem_set_string(modem->modem, "NetworkInterface", net);
 =

 	return TRUE;
@@ -1601,6 +1617,8 @@ static struct {
 	{ "gemalto",	"option",	"1e2d",	"0053"	},
 	{ "gemalto",	"cdc_wdm",	"1e2d",	"0053"	},
 	{ "gemalto",	"qmi_wwan",	"1e2d",	"0053"	},
+	{ "gemalto",	"cdc_acm",	"1e2d",	"0061"	},
+	{ "gemalto",	"cdc_ether",	"1e2d",	"0061"	},
 	{ "telit",	"cdc_ncm",	"1bc7", "0036"	},
 	{ "telit",	"cdc_acm",	"1bc7", "0036"	},
 	{ "xmm7xxx",	"cdc_acm",	"8087", "0930"	},
-- =

1.9.1


--===============4936616433041201227==--

