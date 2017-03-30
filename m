Content-Type: multipart/mixed; boundary="===============8299275132551325852=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC hwdb v1 26/28] udevng: remove 'option' driver setup
Date: Thu, 30 Mar 2017 22:53:07 +0200
Message-ID: <20170330205309.25850-27-jonas@southpole.se>
In-Reply-To: <20170330205309.25850-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8299275132551325852==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

No driver named 'option' exists so this device can never be instantiated.
---
 plugins/udevng.c | 34 ----------------------------------
 1 file changed, 34 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 36c36b7..4f94546 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -279,39 +279,6 @@ done:
 	return TRUE;
 }
 =

-static gboolean setup_option(struct modem_info *modem)
-{
-	const char *aux =3D NULL, *mdm =3D NULL, *diag =3D NULL;
-	GSList *list;
-
-	DBG("%s", modem->syspath);
-
-	for (list =3D modem->devices; list; list =3D list->next) {
-		struct device_info *info =3D list->data;
-
-		DBG("%s %s %s %s", info->devnode, info->interface,
-						info->number, info->label);
-
-		if (g_strcmp0(info->label, "modem") =3D=3D 0)
-			mdm =3D info->devnode;
-		else if (g_strcmp0(info->label, "aux") =3D=3D 0)
-			aux =3D info->devnode;
-		else if (g_strcmp0(info->label, "diag") =3D=3D 0)
-			diag =3D info->devnode;
-	}
-
-	if (aux =3D=3D NULL || mdm =3D=3D NULL)
-		return FALSE;
-
-	DBG("aux=3D%s modem=3D%s diag=3D%s", aux, mdm, diag);
-
-	ofono_modem_set_string(modem->modem, "Aux", aux);
-	ofono_modem_set_string(modem->modem, "Modem", mdm);
-	ofono_modem_set_string(modem->modem, "Diag", diag);
-
-	return TRUE;
-}
-
 static gboolean setup_huawei(struct modem_info *modem)
 {
 	const char *qmi =3D NULL, *mdm =3D NULL, *net =3D NULL;
@@ -933,7 +900,6 @@ static struct {
 	{ "hso",	setup_hso,	"hsotype"		},
 	{ "gobi",	setup_gobi	},
 	{ "sierra",	setup_sierra	},
-	{ "option",	setup_option	},
 	{ "huawei",	setup_huawei	},
 	{ "speedupcdma",setup_speedup	},
 	{ "speedup",	setup_speedup	},
-- =

2.9.3


--===============8299275132551325852==--

