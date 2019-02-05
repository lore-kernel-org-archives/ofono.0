Content-Type: multipart/mixed; boundary="===============7919958764600516716=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH 1/2] xmm7modem: Change in xmm7mode plugin for multi PDP
 handling
Date: Tue, 05 Feb 2019 18:27:18 +0530
Message-ID: <1549371438-27766-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7919958764600516716==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Made changes in xmm7modem plugin to allow mutiple PDP context
activation and to assign correct network interface to the
activated PDP context.
---
 plugins/udevng.c  | 14 ++++++++++++--
 plugins/xmm7xxx.c | 21 +++++++++++++++++++++
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index ff6e1fc..b14369c 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1,4 +1,4 @@
-/*
+
  *
  *  oFono - Open Source Telephony
  *
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


--===============7919958764600516716==--

