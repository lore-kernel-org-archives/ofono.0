Content-Type: multipart/mixed; boundary="===============2059659134680557879=="
MIME-Version: 1.0
From: Joey Hewitt <joey@joeyhewitt.com>
Subject: [PATCH 1/2] gobi: support rpmsg device node (SMD channel)
Date: Fri, 13 Apr 2018 11:42:02 -0600
Message-ID: <4c2a3b50c6e07db7d66bef9056d1dda42e0afe9e.1523728975.git.joey@joeyhewitt.com>
In-Reply-To: <cover.1523728975.git.joey@joeyhewitt.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2059659134680557879==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udevng.c | 61 ++++++++++++++++++++++++++++++----------------------=
----
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index ff5d41a..c85128a 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -202,39 +202,43 @@ static gboolean setup_gobi(struct modem_info *modem)
 =

 	DBG("%s", modem->syspath);
 =

-	for (list =3D modem->devices; list; list =3D list->next) {
-		struct device_info *info =3D list->data;
+	if (modem->type =3D=3D MODEM_TYPE_USB) {
+		for (list =3D modem->devices; list; list =3D list->next) {
+			struct device_info *info =3D list->data;
 =

-		DBG("%s %s %s %s %s %s", info->devnode, info->interface,
-						info->number, info->label,
-						info->sysattr, info->subsystem);
+			DBG("%s %s %s %s %s %s", info->devnode, info->interface,
+							info->number, info->label,
+							info->sysattr, info->subsystem);
 =

-		if (g_strcmp0(info->subsystem, "usbmisc") =3D=3D 0) /* cdc-wdm */
-			qmi =3D info->devnode;
-		else if (g_strcmp0(info->subsystem, "net") =3D=3D 0) /* wwan */
-			net =3D info->devnode;
-		else if (g_strcmp0(info->subsystem, "tty") =3D=3D 0) {
-			if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
-				if (g_strcmp0(info->number, "00") =3D=3D 0)
-					diag =3D info->devnode; /* ec20 */
-				else if (g_strcmp0(info->number, "01") =3D=3D 0)
-					diag =3D info->devnode; /* gobi */
-				else if (g_strcmp0(info->number, "02") =3D=3D 0)
-					mdm =3D info->devnode; /* gobi */
-				else if (g_strcmp0(info->number, "03") =3D=3D 0)
-					gps =3D info->devnode; /* gobi */
-			} else if (g_strcmp0(info->interface, "255/0/0") =3D=3D 0) {
-				if (g_strcmp0(info->number, "01") =3D=3D 0)
-					gps =3D info->devnode; /* ec20 */
-				if (g_strcmp0(info->number, "02") =3D=3D 0)
-					mdm =3D info->devnode; /* ec20 */
-				/* ignore the 3rd device second AT/mdm iface */
+			if (g_strcmp0(info->subsystem, "usbmisc") =3D=3D 0) /* cdc-wdm */
+				qmi =3D info->devnode;
+			else if (g_strcmp0(info->subsystem, "net") =3D=3D 0) /* wwan */
+				net =3D info->devnode;
+			else if (g_strcmp0(info->subsystem, "tty") =3D=3D 0) {
+				if (g_strcmp0(info->interface, "255/255/255") =3D=3D 0) {
+					if (g_strcmp0(info->number, "00") =3D=3D 0)
+						diag =3D info->devnode; /* ec20 */
+					else if (g_strcmp0(info->number, "01") =3D=3D 0)
+						diag =3D info->devnode; /* gobi */
+					else if (g_strcmp0(info->number, "02") =3D=3D 0)
+						mdm =3D info->devnode; /* gobi */
+					else if (g_strcmp0(info->number, "03") =3D=3D 0)
+						gps =3D info->devnode; /* gobi */
+				} else if (g_strcmp0(info->interface, "255/0/0") =3D=3D 0) {
+					if (g_strcmp0(info->number, "01") =3D=3D 0)
+						gps =3D info->devnode; /* ec20 */
+					if (g_strcmp0(info->number, "02") =3D=3D 0)
+						mdm =3D info->devnode; /* ec20 */
+					/* ignore the 3rd device second AT/mdm iface */
+				}
 			}
 		}
-	}
 =

-	if (qmi =3D=3D NULL || mdm =3D=3D NULL || net =3D=3D NULL)
-		return FALSE;
+		if (qmi =3D=3D NULL || mdm =3D=3D NULL || net =3D=3D NULL)
+			return FALSE;
+	} else if (modem->type =3D=3D MODEM_TYPE_SERIAL) {
+		qmi =3D modem->serial->devnode;
+	}
 =

 	DBG("qmi=3D%s net=3D%s mdm=3D%s gps=3D%s diag=3D%s", qmi, net, mdm, gps, =
diag);
 =

@@ -1772,6 +1776,7 @@ static void enumerate_devices(struct udev *context)
 		return;
 =

 	udev_enumerate_add_match_subsystem(enumerate, "tty");
+	udev_enumerate_add_match_subsystem(enumerate, "rpmsg");
 	udev_enumerate_add_match_subsystem(enumerate, "usb");
 	udev_enumerate_add_match_subsystem(enumerate, "usbmisc");
 	udev_enumerate_add_match_subsystem(enumerate, "net");
-- =

2.7.4


--===============2059659134680557879==--

