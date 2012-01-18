Content-Type: multipart/mixed; boundary="===============4815303380965849339=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v4 6/6] udevng: Add a default assignment for Huawei QCDM port
Date: Wed, 18 Jan 2012 18:05:17 +0100
Message-ID: <1326906317-11601-7-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1326906317-11601-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4815303380965849339==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udevng.c |   30 +++++++++++++++++++++---------
 1 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 2a9200d..7b0d60f 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -237,6 +237,7 @@ static gboolean setup_sierra(struct modem_info *modem)
 static gboolean setup_huawei(struct modem_info *modem)
 {
 	const char *mdm =3D NULL, *pcui =3D NULL, *diag =3D NULL;
+	const char *default_pcui =3D NULL;
 	GSList *list;
 =

 	DBG("%s", modem->syspath);
@@ -266,22 +267,33 @@ static gboolean setup_huawei(struct modem_info *modem)
 			if (mdm !=3D NULL && pcui !=3D NULL)
 				break;
 		} else if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
-			if (g_strcmp0(info->number, "00") =3D=3D 0)
+			if (mdm =3D=3D NULL && g_strcmp0(info->number, "00") =3D=3D 0)
 				mdm =3D info->devnode;
-			else if (g_strcmp0(info->number, "01") =3D=3D 0)
-				pcui =3D info->devnode;
-			else if (g_strcmp0(info->number, "02") =3D=3D 0)
-				pcui =3D info->devnode;
-			else if (g_strcmp0(info->number, "03") =3D=3D 0)
-				pcui =3D info->devnode;
-			else if (g_strcmp0(info->number, "04") =3D=3D 0)
-				pcui =3D info->devnode;
+			else if (diag =3D=3D NULL) {
+				if (g_strcmp0(info->number, "01") =3D=3D 0)
+					diag =3D info->devnode;
+			} else if (pcui =3D=3D NULL) {
+				if (g_strcmp0(info->number, "01") =3D=3D 0)
+					default_pcui =3D info->devnode;
+				else if (g_strcmp0(info->number, "02") =3D=3D 0)
+					default_pcui =3D info->devnode;
+				else if (g_strcmp0(info->number, "03") =3D=3D 0)
+					default_pcui =3D info->devnode;
+				else if (g_strcmp0(info->number, "04") =3D=3D 0)
+					default_pcui =3D info->devnode;
+			}
 		}
 	}
 =

+	if (pcui =3D=3D NULL && default_pcui !=3D NULL)
+		pcui =3D default_pcui;
+
 	if (mdm =3D=3D NULL || pcui =3D=3D NULL)
 		return FALSE;
 =

+	if (diag !=3D NULL && g_strcmp0(diag, pcui) =3D=3D 0)
+		diag =3D NULL;
+
 	DBG("modem=3D%s pcui=3D%s diag=3D%s", mdm, pcui, diag);
 =

 	ofono_modem_set_string(modem->modem, "Modem", mdm);
-- =

1.7.1


--===============4815303380965849339==--

