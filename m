Content-Type: multipart/mixed; boundary="===============5063395816412207905=="
MIME-Version: 1.0
From: Philip Paeps <philip@paeps.cx>
Subject: [PATCH 2/4] udevng: add setup logic for Quectel UC15 modules
Date: Tue, 24 Jun 2014 12:08:40 +0200
Message-ID: <1403604522-22645-3-git-send-email-philip@paeps.cx>
In-Reply-To: <1403604522-22645-1-git-send-email-philip@paeps.cx>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5063395816412207905==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udevng.c |   37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index d41c6a8..de37a40 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -791,6 +791,41 @@ static gboolean setup_samsung(struct modem_info *modem)
 	return TRUE;
 }
 =

+static gboolean setup_quectel(struct modem_info *modem)
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
+						info->number, info->label);
+
+		if (g_strcmp0(info->label, "aux") =3D=3D 0) {
+			aux =3D info->devnode;
+			if (mdm !=3D NULL)
+				break;
+		} else if (g_strcmp0(info->label, "modem") =3D=3D 0) {
+			mdm =3D info->devnode;
+			if (aux !=3D NULL)
+				break;
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
@@ -815,6 +850,7 @@ static struct {
 	{ "zte",	setup_zte	},
 	{ "icera",	setup_icera	},
 	{ "samsung",	setup_samsung	},
+	{ "quectel",	setup_quectel	},
 	{ }
 };
 =

@@ -1026,6 +1062,7 @@ static struct {
 	{ "nokia",	"option",	"0421", "0623"	},
 	{ "samsung",	"option",	"04e8", "6889"	},
 	{ "samsung",	"kalmia"			},
+	{ "quectel",	"option",	"05c6", "9090"	},
 	{ }
 };
 =

-- =

1.7.10.4


--===============5063395816412207905==--

