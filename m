Content-Type: multipart/mixed; boundary="===============6497369504891546036=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH] hfp: Expose BT address using the serial number
Date: Thu, 13 Oct 2011 07:05:36 -0700
Message-ID: <1318514736-15369-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6497369504891546036==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>
---
 plugins/hfp_hf.c |  100 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 100 insertions(+), 0 deletions(-)

diff --git a/plugins/hfp_hf.c b/plugins/hfp_hf.c
index 1008696..d81cae9 100644
--- a/plugins/hfp_hf.c
+++ b/plugins/hfp_hf.c
@@ -38,6 +38,7 @@
 #include <ofono/plugin.h>
 #include <ofono/log.h>
 #include <ofono/modem.h>
+#include <ofono/devinfo.h>
 #include <ofono/netreg.h>
 #include <ofono/voicecall.h>
 #include <ofono/call-volume.h>
@@ -46,6 +47,7 @@
 #include <drivers/hfpmodem/slc.h>
 =

 #include "bluetooth.h"
+#include "drivers/atmodem/atutil.h"
 =

 #define	BLUEZ_GATEWAY_INTERFACE		BLUEZ_SERVICE ".HandsfreeGateway"
 =

@@ -62,10 +64,15 @@ static GHashTable *modem_hash =3D NULL;
 struct hfp_data {
 	struct hfp_slc_info info;
 	char *handsfree_path;
+	char *device_address;
 	DBusMessage *slc_msg;
 	gboolean agent_registered;
 };
 =

+struct devinfo_data {
+	char *device_address;
+};
+
 static void hfp_debug(const char *str, void *user_data)
 {
 	const char *prefix =3D user_data;
@@ -206,6 +213,7 @@ static int hfp_hf_probe(const char *device, const char =
*dev_addr,
 	struct ofono_modem *modem;
 	struct hfp_data *data;
 	char buf[256];
+	struct ofono_devinfo *info;
 =

 	/* We already have this device in our hash, ignore */
 	if (g_hash_table_lookup(modem_hash, device) !=3D NULL)
@@ -229,15 +237,27 @@ static int hfp_hf_probe(const char *device, const cha=
r *dev_addr,
 	if (data->handsfree_path =3D=3D NULL)
 		goto free;
 =

+	data->device_address =3D g_strdup(dev_addr);
+	if (data->device_address =3D=3D NULL)
+		goto free;
+
 	ofono_modem_set_data(modem, data);
 	ofono_modem_set_name(modem, alias);
 	ofono_modem_register(modem);
 =

 	g_hash_table_insert(modem_hash, g_strdup(device), modem);
 =

+	info =3D ofono_devinfo_create(modem, 0, "hfp", data);
+	ofono_devinfo_register(info);
+
 	return 0;
 =

 free:
+	if (data !=3D NULL) {
+		g_free(data->handsfree_path);
+		g_free(data->device_address);
+	}
+
 	g_free(data);
 	ofono_modem_remove(modem);
 =

@@ -354,6 +374,7 @@ static void hfp_remove(struct ofono_modem *modem)
 =

 	g_hash_table_remove(modem_hash, data->handsfree_path);
 =

+	g_free(data->device_address);
 	g_free(data->handsfree_path);
 	g_free(data);
 =

@@ -476,6 +497,67 @@ static void hfp_post_sim(struct ofono_modem *modem)
 	DBG("%p", modem);
 }
 =

+static void hfp_query_manufacturer(struct ofono_devinfo *info,
+					ofono_devinfo_query_cb_t cb,
+					void *data)
+{
+	CALLBACK_WITH_FAILURE(cb, "", data);
+}
+
+static void hfp_query_model(struct ofono_devinfo *info,
+				ofono_devinfo_query_cb_t cb,
+				void *data)
+{
+	CALLBACK_WITH_FAILURE(cb, "", data);
+}
+
+static void hfp_query_revision(struct ofono_devinfo *info,
+				ofono_devinfo_query_cb_t cb,
+				void *data)
+{
+	CALLBACK_WITH_FAILURE(cb, "", data);
+}
+
+static void hfp_query_serial(struct ofono_devinfo *info,
+				ofono_devinfo_query_cb_t cb,
+				void *data)
+{
+	struct devinfo_data *dev =3D ofono_devinfo_get_data(info);
+	CALLBACK_WITH_SUCCESS(cb, dev->device_address, data);
+}
+
+static int hfp_devinfo_probe(struct ofono_devinfo *info, unsigned int vend=
or,
+				void *user)
+{
+	struct hfp_data *hfp_data =3D user;
+
+	struct devinfo_data *devinfo_data =3D g_try_new0(struct devinfo_data, 1);
+	if (devinfo_data =3D=3D NULL)
+		return -ENOMEM;
+
+	devinfo_data->device_address =3D g_strdup(hfp_data->device_address);
+	if (devinfo_data->device_address =3D=3D NULL) {
+		g_free(devinfo_data);
+		return -ENOMEM;
+	}
+
+	ofono_devinfo_set_data(info, devinfo_data);
+
+	return 0;
+}
+
+static void hfp_devinfo_remove(struct ofono_devinfo *info)
+{
+	struct devinfo_data *data =3D ofono_devinfo_get_data(info);
+
+	ofono_devinfo_set_data(info, NULL);
+	if (data =3D=3D NULL)
+		return;
+
+	g_free(data->device_address);
+	g_free(data);
+}
+
 static struct ofono_modem_driver hfp_driver =3D {
 	.name		=3D "hfp",
 	.probe		=3D hfp_probe,
@@ -486,6 +568,16 @@ static struct ofono_modem_driver hfp_driver =3D {
 	.post_sim	=3D hfp_post_sim,
 };
 =

+static struct ofono_devinfo_driver hfp_devinfo_driver =3D {
+	.name			=3D "hfp",
+	.probe			=3D hfp_devinfo_probe,
+	.remove			=3D hfp_devinfo_remove,
+	.query_manufacturer	=3D hfp_query_manufacturer,
+	.query_model		=3D hfp_query_model,
+	.query_revision		=3D hfp_query_revision,
+	.query_serial		=3D hfp_query_serial
+};
+
 static struct bluetooth_profile hfp_hf =3D {
 	.name		=3D "hfp_hf",
 	.probe		=3D hfp_hf_probe,
@@ -506,8 +598,15 @@ static int hfp_init(void)
 	if (err < 0)
 		return err;
 =

+	err =3D ofono_devinfo_driver_register(&hfp_devinfo_driver);
+	if (err < 0) {
+		ofono_modem_driver_unregister(&hfp_driver);
+		return err;
+	}
+
 	err =3D bluetooth_register_uuid(HFP_AG_UUID, &hfp_hf);
 	if (err < 0) {
+		ofono_devinfo_driver_unregister(&hfp_devinfo_driver);
 		ofono_modem_driver_unregister(&hfp_driver);
 		return err;
 	}
@@ -521,6 +620,7 @@ static int hfp_init(void)
 static void hfp_exit(void)
 {
 	bluetooth_unregister_uuid(HFP_AG_UUID);
+	ofono_devinfo_driver_unregister(&hfp_devinfo_driver);
 	ofono_modem_driver_unregister(&hfp_driver);
 =

 	g_hash_table_destroy(modem_hash);
-- =

1.7.4.4


--===============6497369504891546036==--

