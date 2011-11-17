Content-Type: multipart/mixed; boundary="===============4390518550503965440=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH] udevng: Add support of SU-7300
Date: Thu, 17 Nov 2011 14:59:43 +0100
Message-ID: <1321538383-21015-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4390518550503965440==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add setup_speedupcdma in order to support the specificities of cdma modems

---
 plugins/udevng.c |   44 +++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 43 insertions(+), 1 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index e0f5fd8..35f8c1e 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -289,6 +289,48 @@ static gboolean setup_huawei(struct modem_info *modem)
 	return TRUE;
 }
 =

+static gboolean setup_speedupcdma(struct modem_info *modem)
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
+		} else if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
+			if (g_strcmp0(info->number, "00") =3D=3D 0)
+				mdm =3D info->devnode;
+			else if (g_strcmp0(info->number, "02") =3D=3D 0)
+				aux =3D info->devnode;
+			else if (g_strcmp0(info->number, "03") =3D=3D 0)
+				aux =3D info->devnode;
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
 static gboolean setup_speedup(struct modem_info *modem)
 {
 	const char *aux =3D NULL, *mdm =3D NULL;
@@ -614,7 +656,7 @@ static struct {
 	{ "sierra",	setup_sierra	},
 	{ "huawei",	setup_huawei	},
 	{ "huaweicdma",	setup_huawei	},
-	{ "speedupcdma",setup_speedup	},
+	{ "speedupcdma",setup_speedupcdma},
 	{ "speedup",	setup_speedup	},
 	{ "linktop",	setup_linktop	},
 	{ "alcatel",	setup_alcatel	},
-- =

1.7.4.1


--===============4390518550503965440==--

