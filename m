Content-Type: multipart/mixed; boundary="===============2723095789637068543=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 3/5] udevng.c: tty assignment according OFONO_LABEL should
 take precedence
Date: Tue, 29 Nov 2011 13:21:19 +0100
Message-ID: <1322569281-10908-4-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1322569281-10908-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2723095789637068543==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udevng.c |   61 +++++++++++++++++++++++++++++++++-----------------=
---
 1 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index be87320..6a3c970 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -235,6 +235,7 @@ static gboolean setup_sierra(struct modem_info *modem)
 static gboolean setup_huawei(struct modem_info *modem)
 {
 	const char *mdm =3D NULL, *pcui =3D NULL, *diag =3D NULL;
+	const char *default_pcui =3D NULL;
 	GSList *list;
 =

 	DBG("%s", modem->syspath);
@@ -264,19 +265,24 @@ static gboolean setup_huawei(struct modem_info *modem)
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
+			else if (pcui =3D=3D NULL) {
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

@@ -291,7 +297,7 @@ static gboolean setup_huawei(struct modem_info *modem)
 =

 static gboolean setup_speedup(struct modem_info *modem)
 {
-	const char *aux =3D NULL, *mdm =3D NULL;
+	const char *aux =3D NULL, *mdm =3D NULL, *default_mdm =3D NULL;
 	GSList *list;
 =

 	DBG("%s", modem->syspath);
@@ -311,15 +317,20 @@ static gboolean setup_speedup(struct modem_info *mode=
m)
 			if (aux !=3D NULL)
 				break;
 		} else if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
-			if (g_strcmp0(info->number, "01") =3D=3D 0)
+			if (aux =3D=3D NULL && g_strcmp0(info->number, "01") =3D=3D 0)
 				aux =3D info->devnode;
-			else if (g_strcmp0(info->number, "02") =3D=3D 0)
-				mdm =3D info->devnode;
-			else if (g_strcmp0(info->number, "03") =3D=3D 0)
-				mdm =3D info->devnode;
+			else if (mdm =3D=3D NULL) {
+				if (g_strcmp0(info->number, "02") =3D=3D 0)
+					default_mdm =3D info->devnode;
+				else if (g_strcmp0(info->number, "03") =3D=3D 0)
+					default_mdm =3D info->devnode;
+			}
 		}
 	}
 =

+	if (mdm =3D=3D NULL && default_mdm !=3D NULL)
+		mdm =3D default_mdm;
+
 	if (aux =3D=3D NULL || mdm =3D=3D NULL)
 		return FALSE;
 =

@@ -385,9 +396,10 @@ static gboolean setup_alcatel(struct modem_info *modem)
 			if (aux !=3D NULL)
 				break;
 		} else if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
-			if (g_strcmp0(info->number, "03") =3D=3D 0)
+			if (aux =3D=3D NULL && g_strcmp0(info->number, "03") =3D=3D 0)
 				aux =3D info->devnode;
-			else if (g_strcmp0(info->number, "05") =3D=3D 0)
+			else if (mdm =3D=3D NULL &&
+					g_strcmp0(info->number, "05") =3D=3D 0)
 				mdm =3D info->devnode;
 		}
 	}
@@ -425,9 +437,10 @@ static gboolean setup_novatel(struct modem_info *modem)
 			if (aux !=3D NULL)
 				break;
 		} else if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
-			if (g_strcmp0(info->number, "00") =3D=3D 0)
+			if (aux =3D=3D NULL && g_strcmp0(info->number, "00") =3D=3D 0)
 				aux =3D info->devnode;
-			else if (g_strcmp0(info->number, "01") =3D=3D 0)
+			else if (mdm =3D=3D NULL &&
+					g_strcmp0(info->number, "01") =3D=3D 0)
 				mdm =3D info->devnode;
 		}
 	}
@@ -465,9 +478,10 @@ static gboolean setup_nokia(struct modem_info *modem)
 			if (aux !=3D NULL)
 				break;
 		} else if (g_strcmp0(info->interface, "10/0/0") =3D=3D 0) {
-			if (g_strcmp0(info->number, "02") =3D=3D 0)
+			if (mdm =3D=3D NULL && g_strcmp0(info->number, "02") =3D=3D 0)
 				mdm =3D info->devnode;
-			else if (g_strcmp0(info->number, "04") =3D=3D 0)
+			else if (aux =3D=3D NULL &&
+					g_strcmp0(info->number, "04") =3D=3D 0)
 				aux =3D info->devnode;
 		}
 	}
@@ -505,13 +519,14 @@ static gboolean setup_telit(struct modem_info *modem)
 			if (aux !=3D NULL)
 				break;
 		} else if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
-			if (g_strcmp0(info->number, "00") =3D=3D 0)
+			if (mdm =3D=3D NULL && g_strcmp0(info->number, "00") =3D=3D 0)
 				mdm =3D info->devnode;
 			else if (g_strcmp0(info->number, "01") =3D=3D 0)
 				diag =3D info->devnode;
 			else if (g_strcmp0(info->number, "02") =3D=3D 0)
 				gps =3D info->devnode;
-			else if (g_strcmp0(info->number, "03") =3D=3D 0)
+			else if (aux =3D=3D NULL
+					&& g_strcmp0(info->number, "03") =3D=3D 0)
 				aux =3D info->devnode;
 		}
 	}
-- =

1.7.1


--===============2723095789637068543==--

