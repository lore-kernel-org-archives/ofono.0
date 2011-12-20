Content-Type: multipart/mixed; boundary="===============0282401547572601703=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [RFC v4 15/16] dundee: Add PPP handling code to device
Date: Tue, 20 Dec 2011 15:47:18 +0100
Message-ID: <1324392439-26508-16-git-send-email-wagi@monom.org>
In-Reply-To: <1324392439-26508-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0282401547572601703==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 Makefile.am     |    2 +-
 dundee/device.c |  241 +++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 2 files changed, 240 insertions(+), 3 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 015f2d5..817fdc0 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -651,7 +651,7 @@ if DUNDEE
 =

 sbin_PROGRAMS +=3D dundee/dundee
 =

-dundee_dundee_SOURCES =3D $(gdbus_sources) \
+dundee_dundee_SOURCES =3D $(gdbus_sources) $(gatchat_sources) \
 			src/log.c src/dbus.c \
 			dundee/main.c dundee/dbus.c dundee/manager.c \
 			dundee/device.c
diff --git a/dundee/device.c b/dundee/device.c
index 696c9e2..9a5b498 100644
--- a/dundee/device.c
+++ b/dundee/device.c
@@ -30,12 +30,16 @@
 =

 #include <glib.h>
 #include <gdbus.h>
+#include <gatchat.h>
+#include <gatppp.h>
 =

 #include "dundee.h"
 =

 static int next_device_id =3D 0;
 static GHashTable *device_hash;
 =

+static const char *none_prefix[] =3D { NULL };
+
 struct ipv4_settings {
 	char *interface;
 	char *ip;
@@ -47,10 +51,14 @@ struct dundee_device {
 	struct dundee_device_driver *driver;
 	gboolean registered;
 =

+	GAtPPP *ppp;
+	GAtChat *chat;
+
 	char *name;
 	gboolean active;
 	struct ipv4_settings settings;
 =

+	DBusMessage *pending;
 	void *data;
 };
 =

@@ -146,6 +154,27 @@ void __dundee_device_foreach(dundee_device_foreach_fun=
c func, void *userdata)
 	}
 }
 =

+static void settings_changed(struct dundee_device *device)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	DBusMessage *signal;
+	DBusMessageIter iter;
+	const char *key =3D "Settings";
+
+	signal =3D dbus_message_new_signal(device->path,
+					DUNDEE_DEVICE_INTERFACE,
+					"PropertyChanged");
+
+	if (signal =3D=3D NULL)
+		return;
+	dbus_message_iter_init_append(signal, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &key);
+
+	settings_append(device, &iter);
+
+	g_dbus_send_message(conn, signal);
+}
+
 static DBusMessage *device_get_properties(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -171,6 +200,200 @@ static DBusMessage *device_get_properties(DBusConnect=
ion *conn,
 	return reply;
 }
 =

+
+static void debug(const char *str, void *data)
+{
+	DBG("%s: %s\n", (const char *) data, str);
+}
+
+static void ppp_connect(const char *iface, const char *local, const char *=
peer,
+			const char *dns1, const char *dns2,
+			gpointer user_data)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct dundee_device *device =3D user_data;
+	const char *dns[3] =3D { dns1, dns2, 0 };
+
+	DBG("%p", device);
+	DBG("Network Device: %s\n", iface);
+	DBG("IP Address: %s\n", local);
+	DBG("Peer IP Address: %s\n", peer);
+	DBG("Primary DNS Server: %s\n", dns1);
+	DBG("Secondary DNS Server: %s\n", dns2);
+
+	g_free(device->settings.interface);
+	device->settings.interface =3D g_strdup(iface);
+	if (device->settings.interface =3D=3D NULL)
+		goto err;
+
+	g_free(device->settings.ip);
+	device->settings.ip =3D g_strdup(local);
+	if (device->settings.ip =3D=3D NULL)
+		goto err;
+
+	g_strfreev(device->settings.nameservers);
+	device->settings.nameservers =3D g_strdupv((gchar **)dns);
+	if (device->settings.nameservers =3D=3D NULL)
+		goto err;
+
+	device->active =3D TRUE;
+
+	settings_changed(device);
+	ofono_dbus_signal_property_changed(conn, device->path,
+					DUNDEE_DEVICE_INTERFACE, "Active",
+					DBUS_TYPE_BOOLEAN, &device->active);
+
+	return;
+
+err:
+	g_free(device->settings.interface);
+	g_free(device->settings.ip);
+	g_strfreev(device->settings.nameservers);
+	device->settings.interface =3D NULL;
+	device->settings.ip =3D NULL;
+	device->settings.nameservers =3D NULL;
+}
+
+static void disconnect_callback(const struct dundee_error *error, void *da=
ta)
+{
+	struct dundee_device *device =3D data;
+
+	DBG("%p", device);
+
+	g_at_chat_unref(device->chat);
+	device->chat =3D NULL;
+
+	if (error->type !=3D DUNDEE_ERROR_TYPE_NO_ERROR) {
+		__ofono_dbus_pending_reply(&device->pending,
+					__dundee_error_failed(device->pending));
+		goto out;
+	}
+
+	__ofono_dbus_pending_reply(&device->pending,
+		dbus_message_new_method_return(device->pending));
+
+out:
+	device->pending =3D NULL;
+}
+
+static void ppp_disconnect(GAtPPPDisconnectReason reason, gpointer user_da=
ta)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct dundee_device *device =3D user_data;
+
+	DBG("%p", device);
+	DBG("PPP Link down: %d\n", reason);
+
+	g_at_ppp_unref(device->ppp);
+	device->ppp =3D NULL;
+
+	g_at_chat_resume(device->chat);
+
+	g_free(device->settings.interface);
+	g_free(device->settings.ip);
+	g_strfreev(device->settings.nameservers);
+	device->settings.interface =3D NULL;
+	device->settings.ip =3D NULL;
+	device->settings.nameservers =3D NULL;
+
+	device->active =3D FALSE;
+
+	settings_changed(device);
+	ofono_dbus_signal_property_changed(conn, device->path,
+					DUNDEE_DEVICE_INTERFACE, "Active",
+					DBUS_TYPE_BOOLEAN, &device->active);
+
+	device->driver->disconnect(device, disconnect_callback, device);
+}
+
+static void dial_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct dundee_device *device =3D user_data;
+	GAtIO *io;
+
+	if (!ok) {
+		DBG("Unable to define context\n");
+		return;
+	}
+
+	/* get the data IO channel */
+	io =3D g_at_chat_get_io(device->chat);
+
+	/*
+	 * shutdown gatchat or else it tries to take all the input
+	 * from the modem and does not let PPP get it.
+	 */
+	g_at_chat_suspend(device->chat);
+
+	/* open ppp */
+	device->ppp =3D g_at_ppp_new();
+	if (device->ppp =3D=3D NULL) {
+		DBG("Unable to create PPP object\n");
+		return;
+	}
+	g_at_ppp_set_debug(device->ppp, debug, "PPP");
+
+	/* set connect and disconnect callbacks */
+	g_at_ppp_set_connect_function(device->ppp, ppp_connect, device);
+	g_at_ppp_set_disconnect_function(device->ppp, ppp_disconnect, device);
+
+	/* open the ppp connection */
+	g_at_ppp_open(device->ppp, io);
+}
+
+static int device_dial_setup(struct dundee_device *device, int fd)
+{
+	GAtSyntax *syntax;
+	GIOChannel *io;
+
+	io =3D g_io_channel_unix_new(fd);
+	if (io =3D=3D NULL)
+		return -EIO;
+
+	syntax =3D g_at_syntax_new_gsm_permissive();
+	device->chat =3D g_at_chat_new(io, syntax);
+	g_io_channel_unref(io);
+	g_at_syntax_unref(syntax);
+
+	if (device->chat =3D=3D NULL)
+		return -EIO;
+
+	g_at_chat_set_debug(device->chat, debug, "Control");
+
+	g_at_chat_send(device->chat, "ATD*99#", none_prefix, dial_cb,
+			device, NULL);
+
+	return 0;
+}
+
+static void connect_callback(const struct dundee_error *error,
+				int fd, void *data)
+{
+	struct dundee_device *device =3D data;
+	int err;
+
+	DBG("%p", device);
+
+	if (error->type !=3D DUNDEE_ERROR_TYPE_NO_ERROR) {
+		__ofono_dbus_pending_reply(&device->pending,
+				__dundee_error_failed(device->pending));
+		goto out;
+	}
+
+	err =3D device_dial_setup(device, fd);
+	if (err < 0) {
+		__ofono_dbus_pending_reply(&device->pending,
+				__dundee_error_failed(device->pending));
+		goto out;
+	}
+
+	__ofono_dbus_pending_reply(&device->pending,
+			dbus_message_new_method_return(device->pending));
+
+out:
+	device->pending =3D NULL;
+}
+
 static DBusMessage *set_property_active(struct dundee_device *device,
 					DBusMessage *msg,
 					DBusMessageIter *var)
@@ -184,9 +407,14 @@ static DBusMessage *set_property_active(struct dundee_=
device *device,
 =

 	dbus_message_iter_get_basic(var, &active);
 =

-	device->active =3D active;
+	device->pending =3D dbus_message_ref(msg);
+
+	if (active)
+		device->driver->connect(device, connect_callback, device);
+	else
+		g_at_ppp_suspend(device->ppp);
 =

-	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+	return NULL;
 }
 =

 static DBusMessage *device_set_property(DBusConnection *conn,
@@ -288,6 +516,15 @@ static void destroy_device(gpointer user)
 {
 	struct dundee_device *device =3D user;
 =

+	if (device->chat !=3D NULL)
+		g_at_chat_unref(device->chat);
+
+	if (device->ppp !=3D NULL)
+		g_at_ppp_unref(device->ppp);
+
+	if (device->pending)
+		dbus_message_unref(device->pending);
+
 	g_free(device->settings.interface);
 	g_free(device->settings.ip);
 	g_strfreev(device->settings.nameservers);
-- =

1.7.8.110.g4cb5d1


--===============0282401547572601703==--

