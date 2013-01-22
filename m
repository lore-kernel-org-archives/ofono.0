Content-Type: multipart/mixed; boundary="===============5752889512690225928=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 10/10] hfp_hf_bluez5: Add SLC establishment procedure
Date: Tue, 22 Jan 2013 18:43:25 -0300
Message-ID: <1358891005-24688-11-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1358891005-24688-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5752889512690225928==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When receiving a NewConnection call from BlueZ, initiates the Service
Level Connection using the received file descriptor. The HFP modem
sub-components (devinfo, voicecall, netreg, handsfree and callvolume)
are created at this point.
---
 plugins/hfp_hf_bluez5.c | 199 ++++++++++++++++++++++++++++++++++++++++++++=
++--
 1 file changed, 192 insertions(+), 7 deletions(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 39853e3..79c78e5 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -24,17 +24,28 @@
 #endif
 =

 #include <errno.h>
+#include <stdint.h>
+#include <stdlib.h>
 #include <unistd.h>
+#include <string.h>
 =

 #include <glib.h>
 =

 #include <gdbus.h>
+#include <gatchat.h>
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
 =

@@ -44,14 +55,153 @@
 =

 #define HFP_EXT_PROFILE_PATH   "/bluetooth/profile/hfp_hf"
 =

+struct hfp {
+	char *device_address;
+	struct hfp_slc_info *info;
+	DBusMessage *msg;
+	GIOChannel *slcio;
+};
+
 static GHashTable *modem_hash =3D NULL;
 static GHashTable *devices_proxies =3D NULL;
 static GDBusClient *bluez =3D NULL;
 =

+static void hfp_free(gpointer user_data)
+{
+	struct hfp *hfp =3D user_data;
+
+	if (hfp->msg)
+		dbus_message_unref(hfp->msg);
+
+	if (hfp->slcio)
+		g_io_channel_unref(hfp->slcio);
+
+	if (hfp->info)
+		hfp_slc_info_free(hfp->info);
+
+	g_free(hfp->device_address);
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
+static void hfp_debug(const char *str, void *user_data)
+{
+	const char *prefix =3D user_data;
+
+	ofono_info("%s%s", prefix, str);
+}
+
+static void slc_established(gpointer userdata)
+{
+	struct ofono_modem *modem =3D userdata;
+	struct hfp *hfp =3D ofono_modem_get_data(modem);
+	DBusMessage *msg;
+
+	ofono_modem_set_powered(modem, TRUE);
+
+	msg =3D dbus_message_new_method_return(hfp->msg);
+	g_dbus_send_message(ofono_dbus_get_connection(), msg);
+	dbus_message_unref(hfp->msg);
+	hfp->msg =3D NULL;
+
+	ofono_info("Service level connection established");
+}
+
+static void slc_failed(gpointer userdata)
+{
+	struct ofono_modem *modem =3D userdata;
+	struct hfp *hfp =3D ofono_modem_get_data(modem);
+	DBusMessage *msg;
+
+	msg =3D g_dbus_create_error(hfp->msg, BLUEZ_ERROR_INTERFACE
+						".Failed",
+						"HFP Handshake failed");
+
+	g_dbus_send_message(ofono_dbus_get_connection(), msg);
+	dbus_message_unref(hfp->msg);
+	hfp->msg =3D NULL;
+
+	ofono_error("Service level connection failed");
+	ofono_modem_set_powered(modem, FALSE);
+
+	if (hfp->info) {
+		hfp_slc_info_free(hfp->info);
+		hfp->info =3D NULL;
+	}
+}
+
+static void hfp_disconnected_cb(gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct hfp *hfp =3D ofono_modem_get_data(modem);
+
+	DBG("HFP disconnected");
+
+	if (hfp->info) {
+		hfp_slc_info_free(hfp->info);
+		hfp->info =3D NULL;
+	}
+
+	ofono_modem_set_powered(modem, FALSE);
+}
+
+static GIOChannel *service_level_connection(struct ofono_modem *modem,
+					int fd, uint16_t version, int *err)
+{
+	struct hfp *hfp =3D ofono_modem_get_data(modem);
+	GIOChannel *io;
+	GAtSyntax *syntax;
+	GAtChat *chat;
+
+	io =3D g_io_channel_unix_new(fd);
+	if (io =3D=3D NULL) {
+		ofono_error("Service level connection failed: %s (%d)",
+						strerror(errno), errno);
+		*err =3D -EIO;
+		return NULL;
+	}
+
+	syntax =3D g_at_syntax_new_gsm_permissive();
+	chat =3D g_at_chat_new(io, syntax);
+	g_at_syntax_unref(syntax);
+	g_io_channel_set_close_on_unref(io, TRUE);
+
+	if (chat =3D=3D NULL) {
+		*err =3D -ENOMEM;
+		goto fail;
+	}
+
+	g_at_chat_set_disconnect_function(chat, hfp_disconnected_cb, modem);
+
+	if (getenv("OFONO_AT_DEBUG"))
+		g_at_chat_set_debug(chat, hfp_debug, "");
+
+	hfp->info =3D hfp_slc_info_init(chat, version);
+	g_at_chat_unref(chat);
+	hfp_slc_establish(hfp->info, slc_established, slc_failed, modem);
+
+	*err =3D -EINPROGRESS;
+
+	return io;
+
+fail:
+	g_at_chat_unref(chat);
+	g_io_channel_unref(io);
+	return NULL;
+}
+
 static struct ofono_modem *modem_register(const char *device,
-						const char *alias)
+				const char *device_address, const char *alias)
 {
 	struct ofono_modem *modem;
+	struct hfp *hfp;
 	char *path;
 =

 	modem =3D g_hash_table_lookup(modem_hash, device);
@@ -70,6 +220,11 @@ static struct ofono_modem *modem_register(const char *d=
evice,
 	ofono_modem_set_name(modem, alias);
 	ofono_modem_register(modem);
 =

+	hfp =3D g_new0(struct hfp, 1);
+	hfp->device_address =3D g_strdup(device_address);
+
+	ofono_modem_set_data(modem, hfp);
+
 	g_hash_table_insert(modem_hash, g_strdup(device), modem);
 =

 	return modem;
@@ -104,7 +259,15 @@ static int hfp_disable(struct ofono_modem *modem)
 =

 static void hfp_pre_sim(struct ofono_modem *modem)
 {
+	struct hfp *hfp =3D ofono_modem_get_data(modem);
+
 	DBG("%p", modem);
+
+	ofono_devinfo_create(modem, 0, "hfpmodem", hfp->device_address);
+	ofono_voicecall_create(modem, 0, "hfpmodem", hfp->info);
+	ofono_netreg_create(modem, 0, "hfpmodem", hfp->info);
+	ofono_handsfree_create(modem, 0, "hfpmodem", hfp->info);
+	ofono_call_volume_create(modem, 0, "hfpmodem", hfp->info);
 }
 =

 static void hfp_post_sim(struct ofono_modem *modem)
@@ -126,12 +289,13 @@ static struct ofono_modem_driver hfp_driver =3D {
 static DBusMessage *profile_new_connection(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
+	struct hfp *hfp;
 	struct ofono_modem *modem;
 	DBusMessageIter iter;
 	GDBusProxy *proxy;
 	DBusMessageIter entry;
-	const char *device, *alias;
-	int fd;
+	const char *device, *alias, *address;
+	int fd, err;
 =

 	DBG("Profile handler NewConnection");
 =

@@ -152,6 +316,11 @@ static DBusMessage *profile_new_connection(DBusConnect=
ion *conn,
 	else
 		dbus_message_iter_get_basic(&iter, &alias);
 =

+	if (g_dbus_proxy_get_property(proxy, "Address", &iter) =3D=3D FALSE)
+		goto error;
+
+	dbus_message_iter_get_basic(&iter, &address);
+
 	dbus_message_iter_next(&entry);
 	if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_UNIX_FD)
 		goto error;
@@ -160,10 +329,20 @@ static DBusMessage *profile_new_connection(DBusConnec=
tion *conn,
 	if (fd < 0)
 		goto error;
 =

-	modem =3D modem_register(device, alias);
+	modem =3D modem_register(device, address, alias);
 	if (modem =3D=3D NULL)
 		goto error;
 =

+	hfp =3D ofono_modem_get_data(modem);
+
+	hfp->msg =3D dbus_message_ref(msg);
+	hfp->slcio =3D service_level_connection(modem, fd,
+					HFP_VERSION_LATEST, &err);
+	if (err < 0 && err !=3D -EINPROGRESS) {
+		hfp_free(hfp);
+		goto error;
+	}
+
 	return NULL;
 =

 error:
@@ -263,7 +442,7 @@ static void parse_uuids(DBusMessageIter *array, gpointe=
r user_data)
 =

 static void proxy_added(GDBusProxy *proxy, void *user_data)
 {
-	const char *interface, *path, *alias;
+	const char *interface, *path, *alias, *address;
 	DBusMessageIter iter;
 	GSList *l, *uuids =3D NULL;
 =

@@ -299,7 +478,13 @@ static void proxy_added(GDBusProxy *proxy, void *user_=
data)
 =

 	dbus_message_iter_get_basic(&iter, &alias);
 =

-	modem_register(path, alias);
+
+	if (g_dbus_proxy_get_property(proxy, "Address", &iter) =3D=3D FALSE)
+		return;
+
+	dbus_message_iter_get_basic(&iter, &address);
+
+	modem_register(path, address, alias);
 }
 =

 static void proxy_removed(GDBusProxy *proxy, void *user_data)
@@ -382,7 +567,7 @@ static int hfp_init(void)
 	}
 =

 	modem_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal, g_free,
-								NULL);
+							modem_data_free);
 =

 	devices_proxies =3D g_hash_table_new_full(g_str_hash, g_str_equal,
 				g_free, (GDestroyNotify) g_dbus_proxy_unref);
-- =

1.8.1.1


--===============5752889512690225928==--

