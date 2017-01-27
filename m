Content-Type: multipart/mixed; boundary="===============7601693093240695400=="
MIME-Version: 1.0
From: Piotr Haber <gluedig@gmail.com>
Subject: [PATCH 2/3] udevng: setup of Telit LE910V2
Date: Fri, 27 Jan 2017 10:54:23 +0100
Message-ID: <20170127095424.19685-3-gluedig@gmail.com>
In-Reply-To: <20170127095424.19685-1-gluedig@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7601693093240695400==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Setup LE910V2 in default USB composition (1bc7:0036)
with 6 CDC-ACM serial ports and 1 CDC-NCM network adapter.
---
 plugins/udevng.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 2f1da62b..098e0651 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -656,7 +656,7 @@ static gboolean setup_telit(struct modem_info *modem)
 =

 static gboolean setup_xe910(struct modem_info *modem)
 {
-	const char *mdm =3D NULL, *aux =3D NULL, *gps =3D NULL;
+	const char *mdm =3D NULL, *aux =3D NULL, *gps =3D NULL, *net =3D NULL;
 	GSList *list;
 =

 	DBG("%s", modem->syspath);
@@ -674,18 +674,24 @@ static gboolean setup_xe910(struct modem_info *modem)
 				aux =3D info->devnode;
 			else if (g_strcmp0(info->number, "0a") =3D=3D 0)
 				gps =3D info->devnode;
+		} else if (info->sysattr && (g_str_has_suffix(info->sysattr,
+						"CDC NCM") =3D=3D TRUE)) {
+			net =3D info->devnode;
 		}
 	}
 =

 	if (aux =3D=3D NULL || mdm =3D=3D NULL)
 		return FALSE;
 =

-	DBG("modem=3D%s aux=3D%s gps=3D%s", mdm, aux, gps);
+	DBG("modem=3D%s aux=3D%s gps=3D%s net=3D%s", mdm, aux, gps, net);
 =

 	ofono_modem_set_string(modem->modem, "Modem", mdm);
 	ofono_modem_set_string(modem->modem, "Aux", aux);
 	ofono_modem_set_string(modem->modem, "GPS", gps);
 =

+	if (net !=3D NULL)
+		ofono_modem_set_string(modem->modem, "NetworkInterface", net);
+
 	return TRUE;
 }
 =

@@ -976,7 +982,7 @@ static struct {
 	{ "novatel",	setup_novatel	},
 	{ "nokia",	setup_nokia	},
 	{ "telit",	setup_telit	},
-	{ "xe910",	setup_xe910	},
+	{ "xe910",	setup_xe910,	"device/interface"	},
 	{ "simcom",	setup_simcom	},
 	{ "zte",	setup_zte	},
 	{ "icera",	setup_icera	},
@@ -1226,6 +1232,8 @@ static struct {
 	{ "gemalto",	"option",	"1e2d",	"0053"	},
 	{ "gemalto",	"cdc_wdm",	"1e2d",	"0053"	},
 	{ "gemalto",	"qmi_wwan",	"1e2d",	"0053"	},
+	{ "xe910",	"cdc_ncm",	"1bc7", "0036"	},
+	{ "xe910",	"cdc_acm",	"1bc7", "0036"	},
 	{ }
 };
 =

-- =

2.11.0


--===============7601693093240695400==--

