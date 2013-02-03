Content-Type: multipart/mixed; boundary="===============0974288150187387317=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Bj=C3=B8rn?= Mork <bjorn@mork.no>
Subject: [PATCH 4/4] udevng: support Sierra QMI devices
Date: Sun, 03 Feb 2013 22:39:47 +0100
Message-ID: <1359927587-24353-5-git-send-email-bjorn@mork.no>
In-Reply-To: <1359927587-24353-1-git-send-email-bjorn@mork.no>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0974288150187387317==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Bj=C3=B8rn Mork <bjorn@mork.no>
---
 plugins/udevng.c |   19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index d27dd67..774d7b4 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -218,7 +218,7 @@ static gboolean setup_gobi(struct modem_info *modem)
 =

 static gboolean setup_sierra(struct modem_info *modem)
 {
-	const char *mdm =3D NULL, *app =3D NULL, *net =3D NULL, *diag =3D NULL;
+	const char *mdm =3D NULL, *app =3D NULL, *net =3D NULL, *diag =3D NULL, *=
qmi =3D NULL;
 	GSList *list;
 =

 	DBG("%s", modem->syspath);
@@ -238,14 +238,27 @@ static gboolean setup_sierra(struct modem_info *modem)
 				app =3D info->devnode;
 			else if (g_strcmp0(info->number, "07") =3D=3D 0)
 				net =3D info->devnode;
+			else if (g_strcmp0(info->number, "08") =3D=3D 0) {
+				if (g_strcmp0(info->subsystem, "net") =3D=3D 0)
+					net =3D info->devnode;
+				else
+					qmi =3D info->devnode;
+			}
 		}
 	}
 =

+	if (qmi !=3D NULL && net !=3D NULL) {
+		ofono_modem_set_driver(modem->modem, "gobi");
+		goto done;
+	}
+
 	if (mdm =3D=3D NULL || net =3D=3D NULL)
 		return FALSE;
 =

-	DBG("modem=3D%s app=3D%s net=3D%s diag=3D%s", mdm, app, net, diag);
+done:
+	DBG("modem=3D%s app=3D%s net=3D%s diag=3D%s qmi=3D%s", mdm, app, net, dia=
g, qmi);
 =

+	ofono_modem_set_string(modem->modem, "Device", qmi);
 	ofono_modem_set_string(modem->modem, "Modem", mdm);
 	ofono_modem_set_string(modem->modem, "App", app);
 	ofono_modem_set_string(modem->modem, "Diag", diag);
@@ -978,6 +991,8 @@ static struct {
 	{ "hso",	"hso"				},
 	{ "gobi",	"qmi_wwan"			},
 	{ "gobi",	"qcserial"			},
+	{ "sierra",	"qcserial",	"1199", "68a2" 	},
+	{ "sierra",	"qmi_wwan",	"1199", "68a2" 	},
 	{ "sierra",	"sierra"			},
 	{ "sierra",	"sierra_net"			},
 	{ "option",	"option",	"0af0"		},
-- =

1.7.10.4


--===============0974288150187387317==--

