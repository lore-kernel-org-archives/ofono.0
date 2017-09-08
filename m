Content-Type: multipart/mixed; boundary="===============4423057948734897552=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 6/7] udev: fix quectelqmi gps interface
Date: Fri, 08 Sep 2017 04:40:39 +0200
Message-ID: <20170908024040.31418-6-jonas@southpole.se>
In-Reply-To: <20170908024040.31418-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4423057948734897552==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Using location-reporting requires both the 'aux' and 'gps' interfaces;
the GPS interface is interface 1, not 2.
---
 plugins/udevng.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 4a11cd1..518eda8 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -876,7 +876,7 @@ static gboolean setup_quectel(struct modem_info *modem)
 =

 static gboolean setup_quectelqmi(struct modem_info *modem)
 {
-	const char *qmi =3D NULL, *net =3D NULL, *gps =3D NULL;
+	const char *qmi =3D NULL, *net =3D NULL, *gps =3D NULL, *aux =3D NULL;
 	GSList *list;
 =

 	DBG("%s", modem->syspath);
@@ -894,8 +894,11 @@ static gboolean setup_quectelqmi(struct modem_info *mo=
dem)
 			else if (g_strcmp0(info->subsystem, "usbmisc") =3D=3D 0)
 				qmi =3D info->devnode;
 		} else if (g_strcmp0(info->interface, "255/0/0") =3D=3D 0 &&
-				g_strcmp0(info->number, "02") =3D=3D 0) {
+				g_strcmp0(info->number, "01") =3D=3D 0) {
 			gps =3D info->devnode;
+		} else if (g_strcmp0(info->interface, "255/0/0") =3D=3D 0 &&
+				g_strcmp0(info->number, "02") =3D=3D 0) {
+			aux =3D info->devnode;
 		}
 	}
 =

@@ -909,8 +912,12 @@ static gboolean setup_quectelqmi(struct modem_info *mo=
dem)
 	ofono_modem_set_string(modem->modem, "Device", qmi);
 	ofono_modem_set_string(modem->modem, "NetworkInterface", net);
 =

+	DBG("gps=3D%s aux=3D%s", gps, aux);
+
 	if (gps)
 		ofono_modem_set_string(modem->modem, "GPS", gps);
+	if (aux)
+		ofono_modem_set_string(modem->modem, "Aux", aux);
 =

 	ofono_modem_set_driver(modem->modem, "gobi");
 =

-- =

2.9.3


--===============4423057948734897552==--

