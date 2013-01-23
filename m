Content-Type: multipart/mixed; boundary="===============4566305831232408372=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v1 10/10] hfp_hf_bluez5: Add SLC establishment procedure
Date: Wed, 23 Jan 2013 15:28:01 -0300
Message-ID: <1358965681-7420-11-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1358965681-7420-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4566305831232408372==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When receiving a NewConnection call from BlueZ, initiates the Service
Level Connection using the received file descriptor. The HFP modem
sub-components (devinfo, voicecall, netreg, handsfree and callvolume)
are created at this point.
---
 plugins/hfp_hf_bluez5.c | 176 ++++++++++++++++++++++++++++++++++++++++++++=
++--
 1 file changed, 170 insertions(+), 6 deletions(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index d4f158e..cec924c 100644
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

@@ -44,12 +55,115 @@
 =

 #define HFP_EXT_PROFILE_PATH   "/bluetooth/profile/hfp_hf"
 =

+struct hfp {
+	struct hfp_slc_info *info;
+	DBusMessage *msg;
+};
+
 static GHashTable *modem_hash =3D NULL;
 static GHashTable *devices_proxies =3D NULL;
 static GDBusClient *bluez =3D NULL;
 =

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
+static int service_level_connection(struct ofono_modem *modem,
+						int fd, guint16 version)
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
+		return -EIO;
+	}
+
+	syntax =3D g_at_syntax_new_gsm_permissive();
+	chat =3D g_at_chat_new(io, syntax);
+	g_at_syntax_unref(syntax);
+
+	g_io_channel_set_close_on_unref(io, TRUE);
+	g_io_channel_unref(io);
+
+	if (chat =3D=3D NULL)
+		return -ENOMEM;
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
+	return -EINPROGRESS;
+}
+
 static struct ofono_modem *modem_register(const char *device,
-						const char *alias)
+				const char *device_address, const char *alias)
 {
 	struct ofono_modem *modem;
 	char *path;
@@ -67,6 +181,8 @@ static struct ofono_modem *modem_register(const char *de=
vice,
 	if (modem =3D=3D NULL)
 		return NULL;
 =

+	ofono_modem_set_string(modem, "Address", device_address);
+
 	ofono_modem_set_name(modem, alias);
 	ofono_modem_register(modem);
 =

@@ -77,14 +193,32 @@ static struct ofono_modem *modem_register(const char *=
device,
 =

 static int hfp_probe(struct ofono_modem *modem)
 {
+	struct hfp *hfp;
+
 	DBG("modem: %p", modem);
 =

+	hfp =3D g_new0(struct hfp, 1);
+
+	ofono_modem_set_data(modem, hfp);
+
 	return 0;
 }
 =

 static void hfp_remove(struct ofono_modem *modem)
 {
+	struct hfp *hfp =3D ofono_modem_get_data(modem);
+
 	DBG("modem: %p", modem);
+
+	if (hfp->msg)
+		dbus_message_unref(hfp->msg);
+
+	if (hfp->info)
+		hfp_slc_info_free(hfp->info);
+
+	g_free(hfp);
+
+	ofono_modem_set_data(modem, NULL);
 }
 =

 /* power up hardware */
@@ -104,7 +238,16 @@ static int hfp_disable(struct ofono_modem *modem)
 =

 static void hfp_pre_sim(struct ofono_modem *modem)
 {
+	struct hfp *hfp =3D ofono_modem_get_data(modem);
+	char *address =3D (char *) ofono_modem_get_string(modem, "Address");
+
 	DBG("%p", modem);
+
+	ofono_devinfo_create(modem, 0, "hfpmodem", address);
+	ofono_voicecall_create(modem, 0, "hfpmodem", hfp->info);
+	ofono_netreg_create(modem, 0, "hfpmodem", hfp->info);
+	ofono_handsfree_create(modem, 0, "hfpmodem", hfp->info);
+	ofono_call_volume_create(modem, 0, "hfpmodem", hfp->info);
 }
 =

 static void hfp_post_sim(struct ofono_modem *modem)
@@ -126,12 +269,13 @@ static struct ofono_modem_driver hfp_driver =3D {
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

@@ -153,6 +297,11 @@ static DBusMessage *profile_new_connection(DBusConnect=
ion *conn,
 =

 	dbus_message_iter_get_basic(&iter, &alias);
 =

+	if (g_dbus_proxy_get_property(proxy, "Address", &iter) =3D=3D FALSE)
+		goto invalid;
+
+	dbus_message_iter_get_basic(&iter, &address);
+
 	dbus_message_iter_next(&entry);
 	if (dbus_message_iter_get_arg_type(&entry) !=3D DBUS_TYPE_UNIX_FD)
 		goto invalid;
@@ -161,7 +310,7 @@ static DBusMessage *profile_new_connection(DBusConnecti=
on *conn,
 	if (fd < 0)
 		goto invalid;
 =

-	modem =3D modem_register(device, alias);
+	modem =3D modem_register(device, address, alias);
 	if (modem =3D=3D NULL) {
 		close(fd);
 		return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
@@ -169,6 +318,15 @@ static DBusMessage *profile_new_connection(DBusConnect=
ion *conn,
 					"Could not register HFP modem");
 	}
 =

+	err =3D service_level_connection(modem, fd, HFP_VERSION_LATEST);
+	if (err < 0 && err !=3D -EINPROGRESS)
+		return g_dbus_create_error(msg, BLUEZ_ERROR_INTERFACE
+					".Rejected",
+					"Not enough resources");
+
+	hfp =3D ofono_modem_get_data(modem);
+	hfp->msg =3D dbus_message_ref(msg);
+
 	return NULL;
 =

 invalid:
@@ -252,7 +410,7 @@ static gboolean has_hfp_ag_uuid(DBusMessageIter *array)
 =

 static void proxy_added(GDBusProxy *proxy, void *user_data)
 {
-	const char *interface, *path, *alias;
+	const char *interface, *path, *alias, *address;
 	DBusMessageIter iter;
 =

 	interface =3D g_dbus_proxy_get_interface(proxy);
@@ -276,7 +434,13 @@ static void proxy_added(GDBusProxy *proxy, void *user_=
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
-- =

1.8.1.1


--===============4566305831232408372==--

