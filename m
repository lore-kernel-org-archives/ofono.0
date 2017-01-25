Content-Type: multipart/mixed; boundary="===============1459862970210527487=="
MIME-Version: 1.0
From: Piotr Haber <gluedig@gmail.com>
Subject: [PATCH 4/4] udevng: setup of Telit LE910V2
Date: Wed, 25 Jan 2017 11:41:28 +0100
Message-ID: <20170125104128.5254-5-gluedig@gmail.com>
In-Reply-To: <20170125104128.5254-1-gluedig@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1459862970210527487==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Setup LE910V2 in default USB composition
with 6 CDC-ACM serial ports and 1 CDC-NCM network adapter.
---
 plugins/udevng.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 50089129..90ddeeab 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -957,6 +957,41 @@ static gboolean setup_gemalto(struct modem_info* modem)
 	return TRUE;
 }
 =

+static gboolean setup_le910v2(struct modem_info *modem)
+{
+	const char *aux =3D NULL, *mdm =3D NULL, *network =3D NULL;
+	GSList *list;
+
+	DBG("%s", modem->syspath);
+
+	for (list =3D modem->devices; list; list =3D list->next) {
+		struct device_info *info =3D list->data;
+
+		DBG("%s %s %s %s %s", info->devnode, info->interface,
+					info->number, info->label, info->sysattr);
+
+		if (g_strcmp0(info->interface, "2/2/1") =3D=3D 0) {
+			if (g_strcmp0(info->number, "00") =3D=3D 0)
+				aux =3D info->devnode;
+			else if (g_strcmp0(info->number, "06") =3D=3D 0)
+				mdm =3D info->devnode;
+		} else if (info->sysattr && (g_str_has_suffix(info->sysattr,
+						"CDC NCM") =3D=3D TRUE)) {
+			network =3D info->devnode;
+		}
+	}
+	DBG("aux=3D%s modem=3D%s network=3D%s", aux, mdm, network);
+
+	if (aux =3D=3D NULL || mdm =3D=3D NULL || network =3D=3D NULL)
+		return FALSE;
+
+	ofono_modem_set_string(modem->modem, "Aux", aux);
+	ofono_modem_set_string(modem->modem, "Modem", mdm);
+	ofono_modem_set_string(modem->modem, "NetworkInterface", network);
+
+	return TRUE;
+}
+
 static struct {
 	const char *name;
 	gboolean (*setup)(struct modem_info *modem);
@@ -984,6 +1019,7 @@ static struct {
 	{ "quectel",	setup_quectel	},
 	{ "ublox",	setup_ublox	},
 	{ "gemalto",	setup_gemalto	},
+	{ "le910v2",	setup_le910v2,	"device/interface"	},
 	{ }
 };
 =

@@ -1226,6 +1262,8 @@ static struct {
 	{ "gemalto",	"option",	"1e2d",	"0053"	},
 	{ "gemalto",	"cdc_wdm",	"1e2d",	"0053"	},
 	{ "gemalto",	"qmi_wwan",	"1e2d",	"0053"	},
+	{ "le910v2",	"cdc_ncm",	"1bc7", "0036"	},
+	{ "le910v2",	"cdc_acm",	"1bc7", "0036"	},
 	{ }
 };
 =

-- =

2.11.0


--===============1459862970210527487==--

