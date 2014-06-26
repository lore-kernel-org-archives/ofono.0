Content-Type: multipart/mixed; boundary="===============1810456098485012055=="
MIME-Version: 1.0
From: Philip Paeps <philip@paeps.cx>
Subject: [PATCH 2/6] udevng: add detection logic for u-blox modems
Date: Thu, 26 Jun 2014 20:28:14 +0200
Message-ID: <1403807298-14588-3-git-send-email-philip@paeps.cx>
In-Reply-To: <1403807298-14588-1-git-send-email-philip@paeps.cx>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1810456098485012055==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udevng.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index d41c6a8..42ee989 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -791,6 +791,46 @@ static gboolean setup_samsung(struct modem_info *modem)
 	return TRUE;
 }
 =

+static gboolean setup_ublox(struct modem_info *modem)
+{
+	const char *aux =3D NULL, *mdm =3D NULL;
+	GSList *list;
+
+	DBG("%s", modem->syspath);
+
+	for (list =3D modem->devices; list; list =3D list->next) {
+		struct device_info *info =3D list->data;
+
+		DBG("%s %s %s %s", info->devnode, info->interface,
+					info->number, info->label);
+
+		if (g_strcmp0(info->label, "aux") =3D=3D 0) {
+			aux =3D info->devnode;
+			if (mdm !=3D NULL)
+				break;
+		} else if (g_strcmp0(info->label, "modem") =3D=3D 0) {
+			mdm =3D info->devnode;
+			if (aux !=3D NULL)
+				break;
+		} else if (g_strcmp0(info->interface, "2/2/1") =3D=3D 0) {
+			if (g_strcmp0(info->number, "02") =3D=3D 0)
+				aux =3D info->devnode;
+			else if (g_strcmp0(info->number, "00") =3D=3D 0)
+				mdm =3D info->devnode;
+		}
+	}
+
+	if (aux =3D=3D NULL || mdm =3D=3D NULL)
+		return FALSE;
+
+	DBG("aux=3D%s modem=3D%s", aux, mdm);
+
+	ofono_modem_set_string(modem->modem, "Aux", aux);
+	ofono_modem_set_string(modem->modem, "Modem", mdm);
+
+	return TRUE;
+}
+
 static struct {
 	const char *name;
 	gboolean (*setup)(struct modem_info *modem);
@@ -815,6 +855,7 @@ static struct {
 	{ "zte",	setup_zte	},
 	{ "icera",	setup_icera	},
 	{ "samsung",	setup_samsung	},
+	{ "ublox",	setup_ublox	},
 	{ }
 };
 =

@@ -1026,6 +1067,7 @@ static struct {
 	{ "nokia",	"option",	"0421", "0623"	},
 	{ "samsung",	"option",	"04e8", "6889"	},
 	{ "samsung",	"kalmia"			},
+	{ "ublox",	"cdc_acm",	"1546", "1102"	},
 	{ }
 };
 =

-- =

1.7.10.4


--===============1810456098485012055==--

