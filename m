Content-Type: multipart/mixed; boundary="===============3174679699055370407=="
MIME-Version: 1.0
From: dragos@endocode.com
Subject: [PATCH 02/19] plugins/udevng: support different interface strings to
 detect TOBY series
Date: Wed, 09 Mar 2016 17:05:49 +0100
Message-ID: <1457539549-8977-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3174679699055370407==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Dongsu Park <dongsu@endocode.com>

Each modem expresses their interfaces with its own interface string,
which is composed of 3 different USB attributes:
"bInterfaceClass/bInterfaceSubClass/bInterfaceProtocol".
While the old models like LISA support only "2/2/1" for modem
interfaces, TOBY-L2 also supports an unique string for NetworkInterface
for each profile.

* low-medium throughput profile : 2/6/0
* fairly backward-compatible profile : 10/0/0
* high throughput profile : 224/1/3

Besides the condition for checking NULL for mdm/aux/net should be relaxed
a little bit.
---
 plugins/udevng.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 52b667e..2170c90 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -838,7 +838,7 @@ static gboolean setup_quectel(struct modem_info *modem)
 =

 static gboolean setup_ublox(struct modem_info *modem)
 {
-	const char *aux =3D NULL, *mdm =3D NULL;
+	const char *aux =3D NULL, *mdm =3D NULL, *net =3D NULL;
 	GSList *list;
 =

 	DBG("%s", modem->syspath);
@@ -857,21 +857,37 @@ static gboolean setup_ublox(struct modem_info *modem)
 			mdm =3D info->devnode;
 			if (aux !=3D NULL)
 				break;
+		/*
+		 * "2/2/1"
+		 *  - a common modem interface both for older models like LISA,
+		 *    and for newer models like TOBY.
+		 * For TOBY-L2, NetworkInterface can be detected for each profile:
+		 *  - low-medium throughput profile : 2/6/0
+		 *  - fairly backward-compatible profile : 10/0/0
+		 *  - high throughput profile : 224/1/3
+		 * */
 		} else if (g_strcmp0(info->interface, "2/2/1") =3D=3D 0) {
 			if (g_strcmp0(info->number, "02") =3D=3D 0)
 				aux =3D info->devnode;
 			else if (g_strcmp0(info->number, "00") =3D=3D 0)
 				mdm =3D info->devnode;
+		} else if (g_strcmp0(info->interface, "2/6/0") =3D=3D 0 ||
+			   g_strcmp0(info->interface, "10/0/0") =3D=3D 0 ||
+			   g_strcmp0(info->interface, "224/1/3") =3D=3D 0) {
+			net =3D info->devnode;
 		}
 	}
 =

-	if (aux =3D=3D NULL || mdm =3D=3D NULL)
+	/* Abort only if both interfaces are NULL, as it's highly possible that
+	 * only one of 2 interfaces is available for U-blox modem. */
+	if (aux =3D=3D NULL && mdm =3D=3D NULL)
 		return FALSE;
 =

-	DBG("aux=3D%s modem=3D%s", aux, mdm);
+	DBG("aux=3D%s modem=3D%s net=3D%s", aux, mdm, net);
 =

 	ofono_modem_set_string(modem->modem, "Aux", aux);
 	ofono_modem_set_string(modem->modem, "Modem", mdm);
+	ofono_modem_set_string(modem->modem, "NetworkInterface", net);
 =

 	return TRUE;
 }
-- =

2.5.0


--===============3174679699055370407==--

