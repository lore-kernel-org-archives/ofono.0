Content-Type: multipart/mixed; boundary="===============8272345990392628692=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 6/8] hfp_hf: Register the HFP modem
Date: Thu, 17 Jan 2013 12:13:09 -0300
Message-ID: <1358435591-14757-7-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1358435591-14757-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8272345990392628692==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch registers the HFP modem when Bluetooth link is established.
---
 plugins/hfp_hf_bluez5.c | 105 ++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 104 insertions(+), 1 deletion(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 636b1b3..f4c59d7 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -24,15 +24,26 @@
 #endif
 =

 #include <errno.h>
+#include <string.h>
+
 #include <glib.h>
 =

 #include <gdbus.h>
+#include <gatchat.h>
+#include <gattty.h>
 =

 #define OFONO_API_SUBJECT_TO_CHANGE
 #include <ofono/modem.h>
 #include <ofono/dbus.h>
 #include <ofono/plugin.h>
 #include <ofono/log.h>
+#include <ofono/devinfo.h>
+#include <ofono/netreg.h>
+#include <ofono/voicecall.h>
+#include <ofono/call-volume.h>
+#include <ofono/handsfree.h>
+
+#include <drivers/hfpmodem/slc.h>
 =

 #include "bluez5.h"
 #include "media.h"
@@ -43,6 +54,62 @@
 =

 #define HFP_EXT_PROFILE_PATH   "/bluetooth/profile/hfp_hf"
 =

+struct hfp {
+	char *device_address;
+	char *device_path;
+	struct hfp_slc_info info;
+	DBusMessage *msg;
+	GSList *endpoints;
+};
+
+static GHashTable *modem_hash =3D NULL;
+
+static void hfp_free(gpointer user_data)
+{
+	struct hfp *hfp =3D user_data;
+
+	if (hfp->msg)
+		dbus_message_unref(hfp->msg);
+
+	g_slist_free_full(hfp->endpoints, media_endpoint_free);
+	g_free(hfp->device_address);
+	g_free(hfp->device_path);
+	g_free(hfp);
+}
+
+static void modem_data_free(gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct hfp *hfp =3D ofono_modem_get_data(modem);
+
+	hfp_free(hfp);
+}
+
+static int modem_register(struct hfp *hfp, const char *alias, int fd,
+							guint16 version)
+{
+	struct ofono_modem *modem;
+	int err =3D 0;
+	char *path;
+
+	path =3D g_strconcat("hfp", hfp->device_path, NULL);
+
+	modem =3D ofono_modem_create(path, "hfp");
+
+	g_free(path);
+
+	if (modem =3D=3D NULL)
+		return -ENOMEM;
+
+	ofono_modem_set_data(modem, hfp);
+	ofono_modem_set_name(modem, alias);
+	ofono_modem_register(modem);
+
+	g_hash_table_insert(modem_hash, g_strdup(hfp->device_path), modem);
+
+	return err;
+}
+
 static void parse_guint16(DBusMessageIter *iter, gpointer user_data)
 {
 	guint16 *value =3D user_data;
@@ -160,6 +227,11 @@ static int hfp_enable(struct ofono_modem *modem)
 {
 	DBG("%p", modem);
 =

+	if (ofono_modem_get_powered(modem))
+		return 0;
+
+	ofono_modem_set_powered(modem, TRUE);
+
 	return 0;
 }
 =

@@ -167,12 +239,22 @@ static int hfp_disable(struct ofono_modem *modem)
 {
 	DBG("%p", modem);
 =

+	ofono_modem_set_powered(modem, FALSE);
+
 	return 0;
 }
 =

 static void hfp_pre_sim(struct ofono_modem *modem)
 {
+	struct hfp *hfp =3D ofono_modem_get_data(modem);
+
 	DBG("%p", modem);
+
+	ofono_devinfo_create(modem, 0, "hfpmodem", hfp->device_address);
+	ofono_voicecall_create(modem, 0, "hfpmodem", &hfp->info);
+	ofono_netreg_create(modem, 0, "hfpmodem", &hfp->info);
+	ofono_call_volume_create(modem, 0, "hfpmodem", &hfp->info);
+	ofono_handsfree_create(modem, 0, "hfpmodem", &hfp->info);
 }
 =

 static void hfp_post_sim(struct ofono_modem *modem)
@@ -194,11 +276,12 @@ static struct ofono_modem_driver hfp_driver =3D {
 static DBusMessage *profile_new_connection(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
+	struct hfp *hfp;
 	DBusMessageIter entry;
 	const char *device;
 	GSList *endpoints =3D NULL;
 	guint16 version, features;
-	int fd;
+	int fd, err;
 =

 	DBG("Profile handler NewConnection");
 =

@@ -231,6 +314,21 @@ static DBusMessage *profile_new_connection(DBusConnect=
ion *conn,
 		ofono_error("Media Endpoint missing");
 		goto error;
 	}
+
+	hfp =3D g_new0(struct hfp, 1);
+	hfp->device_address =3D g_strdup("unknown");
+	hfp->device_path =3D g_strdup(device);
+	hfp->endpoints =3D endpoints;
+	hfp->msg =3D dbus_message_ref(msg);
+
+	err =3D modem_register(hfp, "unknown", fd, version);
+	if (err < 0 && err !=3D -EINPROGRESS) {
+		hfp_free(hfp);
+		return g_dbus_create_error(msg,
+				BLUEZ_ERROR_INTERFACE ".Rejected",
+				"%s", strerror(-err));
+	}
+
 	return NULL;
 =

 error:
@@ -315,6 +413,9 @@ static int hfp_init(void)
 		return err;
 	}
 =

+	modem_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal, g_free,
+								modem_data_free);
+
 	return 0;
 }
 =

@@ -326,6 +427,8 @@ static void hfp_exit(void)
 	g_dbus_unregister_interface(conn, HFP_EXT_PROFILE_PATH,
 						BLUEZ_PROFILE_INTERFACE);
 	ofono_modem_driver_unregister(&hfp_driver);
+
+	g_hash_table_destroy(modem_hash);
 }
 =

 OFONO_PLUGIN_DEFINE(hfp_bluez5, "External Hands-Free Profile Plugin", VERS=
ION,
-- =

1.7.11.7


--===============8272345990392628692==--

