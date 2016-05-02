Content-Type: multipart/mixed; boundary="===============7238600702837587533=="
MIME-Version: 1.0
From: Martin Chaplet <m.chaplet@kerlink.fr>
Subject: [PATCH 3/3] Add support for Sierra MC73xx QMI modems
Date: Mon, 02 May 2016 18:33:14 +0200
Message-ID: <1462206794-14322-3-git-send-email-m.chaplet@kerlink.fr>
In-Reply-To: <1462206794-14322-1-git-send-email-m.chaplet@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7238600702837587533==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Udevng layer is changed in order to support Sierra QMI modems like
MC73cxx.
Identically to Huawei modems, these modems are parsed by setup_sierra.
If QMI interface is detected, the Gobi modem driver is selected.

Unfortunately, MC73xx chips seem to have a broken QMI UIM interface.
The qmimodem-legacy is so forced in setup function.

Signed-off-by: Martin Chaplet <m.chaplet@kerlink.fr>
---
 plugins/udevng.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 8ca4471..d95ac98 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -220,7 +220,7 @@ static gboolean setup_gobi(struct modem_info *modem)
 =

 static gboolean setup_sierra(struct modem_info *modem)
 {
-	const char *mdm =3D NULL, *app =3D NULL, *net =3D NULL, *diag =3D NULL;
+	const char *mdm =3D NULL, *app =3D NULL, *net =3D NULL, *diag =3D NULL, *=
qmi =3D NULL;
 	GSList *list;
 =

 	DBG("%s", modem->syspath);
@@ -228,8 +228,8 @@ static gboolean setup_sierra(struct modem_info *modem)
 	for (list =3D modem->devices; list; list =3D list->next) {
 		struct device_info *info =3D list->data;
 =

-		DBG("%s %s %s %s", info->devnode, info->interface,
-						info->number, info->label);
+		DBG("%s %s %s %s %s", info->devnode, info->interface,
+						info->number, info->label, info->subsystem);
 =

 		if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
 			if (g_strcmp0(info->number, "01") =3D=3D 0)
@@ -240,14 +240,30 @@ static gboolean setup_sierra(struct modem_info *modem)
 				app =3D info->devnode;
 			else if (g_strcmp0(info->number, "07") =3D=3D 0)
 				net =3D info->devnode;
+			else if (g_strcmp0(info->number, "0a") =3D=3D 0)
+			{
+				if (g_strcmp0(info->subsystem, "net") =3D=3D 0)
+					net =3D info->devnode;
+				else if (g_strcmp0(info->subsystem, "usbmisc") =3D=3D 0)
+					qmi =3D info->devnode;
+			}
 		}
 	}
 =

+	if (qmi !=3D NULL && net !=3D NULL) {
+		ofono_modem_set_driver(modem->modem, "gobi");
+		/* Fixup SIM interface for Sierra QMI devices */
+		ofono_modem_set_boolean(modem->modem, "ForceSimLegacy", TRUE);
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
@@ -1112,6 +1128,8 @@ static struct {
 	{ "hso",	"hso"				},
 	{ "gobi",	"qmi_wwan"			},
 	{ "gobi",	"qcserial"			},
+	{ "sierra",	"qmi_wwan",	"1199"		},
+	{ "sierra",	"qcserial",	"1199"		},
 	{ "sierra",	"sierra"			},
 	{ "sierra",	"sierra_net"			},
 	{ "option",	"option",	"0af0"		},
-- =

1.9.1


--===============7238600702837587533==--

