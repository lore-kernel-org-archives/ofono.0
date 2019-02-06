Content-Type: multipart/mixed; boundary="===============4171666584360796411=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH 1/2] xmm7modem: Change in xmm7mode plugin for multi PDP
 handling
Date: Wed, 06 Feb 2019 14:07:01 +0530
Message-ID: <1549442221-29806-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4171666584360796411==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Made changes in xmm7modem plugin to allow mutiple PDP context
activation and to assign correct network interface to the
activated PDP context.
---
 plugins/udevng.c  | 12 +++++++++++-
 plugins/xmm7xxx.c | 21 +++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index ff6e1fc..e00b6ac 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1179,7 +1179,7 @@ static gboolean setup_gemalto(struct modem_info* mode=
m)
 =

 static gboolean setup_xmm7xxx(struct modem_info *modem)
 {
-	const char *mdm =3D NULL, *net =3D NULL;
+	const char *mdm =3D NULL, *net =3D NULL, *net2 =3D NULL, *net3 =3D NULL;
 	GSList *list;
 =

 	DBG("%s %s\n", __DATE__, __TIME__);
@@ -1200,6 +1200,10 @@ static gboolean setup_xmm7xxx(struct modem_info *mod=
em)
 			} else if (g_strcmp0(info->subsystem, "net") =3D=3D 0) {
 				if (g_strcmp0(info->number, "06") =3D=3D 0)
 					net =3D info->devnode;
+				if (g_strcmp0(info->number, "08") =3D=3D 0)
+					net2 =3D info->devnode;
+				if (g_strcmp0(info->number, "0a") =3D=3D 0)
+					net3 =3D info->devnode;
 			}
 		} else {
 			if (g_strcmp0(info->subsystem, "tty") =3D=3D 0) {
@@ -1219,6 +1223,12 @@ static gboolean setup_xmm7xxx(struct modem_info *mod=
em)
 =

 	ofono_modem_set_string(modem->modem, "Modem", mdm);
 	ofono_modem_set_string(modem->modem, "NetworkInterface", net);
+	if (net2)
+		ofono_modem_set_string(modem->modem, "NetworkInterface2", net2);
+	if (net3)
+		ofono_modem_set_string(modem->modem, "NetworkInterface3", net3);
+	ofono_modem_set_string(modem->modem, "CtrlPath", "/USBCDC/0");
+	ofono_modem_set_string(modem->modem, "DataPath", "/USBHS/NCM/");
 =

 	return TRUE;
 }
diff --git a/plugins/xmm7xxx.c b/plugins/xmm7xxx.c
index 237c62c..eaae4ad 100644
--- a/plugins/xmm7xxx.c
+++ b/plugins/xmm7xxx.c
@@ -1269,6 +1269,7 @@ static void xmm7xxx_post_online(struct ofono_modem *m=
odem)
 	struct xmm7xxx_data *data =3D ofono_modem_get_data(modem);
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
+	const char *interface =3D NULL;
 =

 	DBG("%p", modem);
 =

@@ -1282,6 +1283,26 @@ static void xmm7xxx_post_online(struct ofono_modem *=
modem)
 	if (gprs && gc)
 		ofono_gprs_add_context(gprs, gc);
 =

+	interface =3D ofono_modem_get_string(modem, "NetworkInterface2");
+
+	if (interface) {
+		gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_XMM, "ifxmodem",
+					data->chat);
+
+		if (gprs && gc)
+			ofono_gprs_add_context(gprs, gc);
+	}
+
+	interface =3D ofono_modem_get_string(modem, "NetworkInterface3");
+
+	if (interface) {
+		gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_XMM, "ifxmodem",
+					data->chat);
+
+		if (gprs && gc)
+			ofono_gprs_add_context(gprs, gc);
+	}
+
 	ofono_ims_create(modem, "xmm7modem", data->chat);
 	ofono_netmon_create(modem, 0, "xmm7modem", data->chat);
 }
-- =

1.9.1


--===============4171666584360796411==--

