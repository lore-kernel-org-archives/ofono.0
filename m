Content-Type: multipart/mixed; boundary="===============7411838727437929331=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2 3/5] udevng.c: tty assignment according OFONO_LABEL should
 take precedence
Date: Mon, 29 Aug 2011 18:41:49 +0200
Message-ID: <1314636111-16146-4-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1314636111-16146-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7411838727437929331==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udevng.c |   52 ++++++++++++++++++++++++++++++--------------------=
--
 1 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 1365bd1..40cc1ff 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -264,16 +264,18 @@ static gboolean setup_huawei(struct modem_info *modem)
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
+					pcui =3D info->devnode;
+				else if (g_strcmp0(info->number, "02") =3D=3D 0)
+					pcui =3D info->devnode;
+				else if (g_strcmp0(info->number, "03") =3D=3D 0)
+					pcui =3D info->devnode;
+				else if (g_strcmp0(info->number, "04") =3D=3D 0)
+					pcui =3D info->devnode;
+			}
 		}
 	}
 =

@@ -311,12 +313,14 @@ static gboolean setup_speedup(struct modem_info *mode=
m)
 			if (aux !=3D NULL)
 				break;
 		} else if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
-			if (g_strcmp0(info->number, "01") =3D=3D 0)
+			if ( aux =3D=3D NULL && g_strcmp0(info->number, "01") =3D=3D 0)
 				aux =3D info->devnode;
-			else if (g_strcmp0(info->number, "02") =3D=3D 0)
-				mdm =3D info->devnode;
-			else if (g_strcmp0(info->number, "03") =3D=3D 0)
-				mdm =3D info->devnode;
+			else if (mdm =3D=3D NULL) {
+				if (g_strcmp0(info->number, "02") =3D=3D 0)
+					mdm =3D info->devnode;
+				else if (g_strcmp0(info->number, "03") =3D=3D 0)
+					mdm =3D info->devnode;
+			}
 		}
 	}
 =

@@ -385,9 +389,10 @@ static gboolean setup_alcatel(struct modem_info *modem)
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
@@ -425,9 +430,10 @@ static gboolean setup_novatel(struct modem_info *modem)
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
@@ -465,9 +471,10 @@ static gboolean setup_nokia(struct modem_info *modem)
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
@@ -505,13 +512,14 @@ static gboolean setup_telit(struct modem_info *modem)
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


--===============7411838727437929331==--

