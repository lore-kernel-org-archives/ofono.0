Content-Type: multipart/mixed; boundary="===============7750563583816953190=="
MIME-Version: 1.0
From: Vincent Cesson <vincent.cesson@smile.fr>
Subject: [PATCH] udevng: complete gemalto setup
Date: Wed, 18 Jan 2017 14:12:42 +0100
Message-ID: <1484745162-8162-1-git-send-email-vincent.cesson@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7750563583816953190==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Complete the Gemalto setup with cdc_wdm and qmi so all enumerated devices a=
re associated with gemalto.
---
 plugins/udevng.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 5c10794..7f1c300 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -915,7 +915,7 @@ static gboolean setup_ublox(struct modem_info *modem)
 =

 static gboolean setup_gemalto(struct modem_info* modem)
 {
-	const char *app =3D NULL, *gps =3D NULL, *mdm =3D NULL;
+	const char *app =3D NULL, *gps =3D NULL, *mdm =3D NULL, *net =3D NULL, *q=
mi =3D NULL;
 =

 	GSList *list;
 =

@@ -934,10 +934,15 @@ static gboolean setup_gemalto(struct modem_info* mode=
m)
 				app =3D info->devnode;
 			else if (g_strcmp0(info->number, "03") =3D=3D 0)
 				mdm =3D info->devnode;
+			else if (g_strcmp0(info->subsystem, "net") =3D=3D 0)
+				net =3D info->devnode;
+			else if (g_strcmp0(info->subsystem, "usbmisc") =3D=3D 0)
+				qmi =3D info->devnode;
 		}
 	}
 =

-	DBG("application=3D%s gps=3D%s modem=3D%s", app, gps, mdm);
+	DBG("application=3D%s gps=3D%s modem=3D%s network=3D%s qmi=3D%s",
+            app, gps, mdm, net, qmi);
 =

 	if (app =3D=3D NULL || mdm =3D=3D NULL)
 		return FALSE;
@@ -945,6 +950,8 @@ static gboolean setup_gemalto(struct modem_info* modem)
 	ofono_modem_set_string(modem->modem, "Application", app);
 	ofono_modem_set_string(modem->modem, "GPS", gps);
 	ofono_modem_set_string(modem->modem, "Modem", mdm);
+	ofono_modem_set_string(modem->modem, "Device", qmi);
+	ofono_modem_set_string(modem->modem, "NetworkInterface", net);
 =

 	return TRUE;
 }
@@ -1216,6 +1223,8 @@ static struct {
 	{ "ublox",	"rndis_host",	"1546", "1146"	},
 	{ "ublox",	"cdc_acm",	"1546", "1146"	},
 	{ "gemalto",	"option",	"1e2d",	"0053"	},
+	{ "gemalto",	"cdc_wdm",	"1e2d",	"0053"	},
+	{ "gemalto",	"qmi_wwan",	"1e2d",	"0053"	},
 	{ }
 };
 =

-- =

1.9.1


--===============7750563583816953190==--

