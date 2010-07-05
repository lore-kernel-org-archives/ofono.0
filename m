Content-Type: multipart/mixed; boundary="===============2298741909155258126=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 4/6] emulator: Add Enable/Disable for oFono emulator
Date: Mon, 05 Jul 2010 13:45:07 +0800
Message-ID: <1278308709-13908-5-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1278308709-13908-4-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2298741909155258126==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use tty descriptor passed from BlueZ agent to enable emulator. It uses
gatserver to handle incoming AT commands.

In disable or remove emulator stage, we shutdown the gatserver.
---
 include/emulator.h |    3 +
 plugins/dun_gw.c   |   15 ++++++
 src/emulator.c     |  127 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 145 insertions(+), 0 deletions(-)

diff --git a/include/emulator.h b/include/emulator.h
index 0c87b13..9d96d67 100644
--- a/include/emulator.h
+++ b/include/emulator.h
@@ -52,6 +52,9 @@ struct ofono_emulator *ofono_emulator_create(struct ofono=
_modem *modem,
 					struct ofono_emulator_driver *driver);
 void ofono_emulator_remove(struct ofono_emulator *e);
 =

+ofono_bool_t ofono_emulator_enable(struct ofono_emulator *e, int fd);
+void ofono_emulator_disable(struct ofono_emulator *e);
+
 int ofono_emulator_driver_register(const struct ofono_emulator_driver *dri=
ver);
 void ofono_emulator_driver_unregister(
 				const struct ofono_emulator_driver *driver);
diff --git a/plugins/dun_gw.c b/plugins/dun_gw.c
index 95b176c..43a0b0a 100644
--- a/plugins/dun_gw.c
+++ b/plugins/dun_gw.c
@@ -111,6 +111,8 @@ static DBusMessage *dun_agent_new_connection(DBusConnec=
tion *conn,
 						DBusMessage *msg,
 						void *user_data)
 {
+	struct dun_data *data =3D user_data;
+	struct ofono_emulator *e =3D data->e;
 	DBusMessage *reply;
 	int fd;
 =

@@ -121,6 +123,14 @@ static DBusMessage *dun_agent_new_connection(DBusConne=
ction *conn,
 		goto error;
 	}
 =

+	if (!ofono_emulator_enable(e, fd)) {
+		reply =3D g_dbus_create_error(msg, DUN_AGENT_INTERFACE, ".Failed",
+						"Failed to enable DUN Server");
+		goto error;
+	}
+
+	DBG("Accept new DUN connection");
+
 	return dbus_message_new_method_return(msg);
 =

 error:
@@ -211,6 +221,9 @@ static int dun_gw_enable(struct ofono_emulator *e, int =
fd)
 {
 	DBG("%p", e);
 =

+	if (!ofono_emulator_enable(e, fd))
+		return -EINVAL;
+
 	return 0;
 }
 =

@@ -218,6 +231,8 @@ static int dun_gw_disable(struct ofono_emulator *e)
 {
 	DBG("%p", e);
 =

+	ofono_emulator_disable(e);
+
 	return 0;
 }
 =

diff --git a/src/emulator.c b/src/emulator.c
index 6b63398..1155769 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -30,6 +30,7 @@
 #include <gdbus.h>
 =

 #include "ofono.h"
+#include "gatserver.h"
 #include "common.h"
 =

 struct ofono_emulator {
@@ -38,12 +39,19 @@ struct ofono_emulator {
 	struct ofono_atom *atom;
 	unsigned int id;
 	void *user_data;
+	GAtServer *server;
+	ofono_bool_t powered;
 };
 =

 static GSList *emulator_list;
 static GSList *ofono_emulator_drivers;
 static unsigned int ofono_emulator_ids;
 =

+static void ofono_emulator_debug(const char *str, void *data)
+{
+	g_print("%s: %s\n", (char *)data, str);
+}
+
 static unsigned int ofono_emulator_next_id()
 {
 	unsigned int i;
@@ -121,6 +129,9 @@ static void emulator_remove(struct ofono_atom *atom)
 =

 	emulator_list =3D g_slist_remove(emulator_list, e);
 =

+	if (e->powered)
+		e->driver->disable(e);
+
 	if (e->driver->remove)
 		e->driver->remove(e);
 =

@@ -129,6 +140,78 @@ static void emulator_remove(struct ofono_atom *atom)
 	e =3D NULL;
 }
 =

+void ofono_emulator_disable(struct ofono_emulator *e)
+{
+	if (e->server =3D=3D NULL)
+		return;
+
+	g_at_server_shutdown(e->server);
+	g_at_server_unref(e->server);
+	e->server =3D NULL;
+
+	e->powered =3D FALSE;
+}
+
+static int set_powered(struct ofono_emulator *e, ofono_bool_t powered, int=
 fd)
+{
+	int val;
+
+	if (powered =3D=3D TRUE && e->driver->enable)
+		val =3D e->driver->enable(e, fd);
+	else if (powered =3D=3D FALSE && e->driver->disable)
+		val =3D e->driver->disable(e);
+	else
+		return -EINVAL;
+
+	e->powered =3D powered;
+
+	return val;
+}
+
+static void emulator_disconnect(gpointer data)
+{
+	struct ofono_emulator *e =3D data;
+
+	set_powered(e, FALSE, 0);
+}
+
+ofono_bool_t ofono_emulator_enable(struct ofono_emulator *e, int fd)
+{
+	GAtServer *server;
+	GIOChannel *channel;
+
+	if (fd <=3D 0 || e->server !=3D NULL)
+		return FALSE;
+
+	channel =3D g_io_channel_unix_new(fd);
+	server =3D g_at_server_new(channel);
+	if (!server)
+		goto error;
+
+	e->server =3D server;
+	g_at_server_set_debug(e->server, ofono_emulator_debug, "Server");
+	g_at_server_set_disconnect_function(e->server, emulator_disconnect, e);
+
+	g_io_channel_unref(channel);
+
+	e->powered =3D TRUE;
+
+	return TRUE;
+
+error:
+	if (channel) {
+		g_io_channel_shutdown(channel, FALSE, NULL);
+		g_io_channel_unref(channel);
+	}
+
+	if (server) {
+		g_at_server_shutdown(server);
+		g_at_server_unref(server);
+	}
+
+	return FALSE;
+}
+
 static struct ofono_emulator *create_emulator(struct ofono_modem *modem,
 					struct ofono_emulator_driver *driver)
 {
@@ -156,8 +239,52 @@ static DBusMessage *emulator_get_properties(DBusConnec=
tion *conn,
 	return dbus_message_new_method_return(msg);
 }
 =

+static DBusMessage *emulator_enable(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	DBusMessage *reply;
+	struct ofono_emulator *e =3D data;
+	const char *path;
+	int fd;
+	ofono_bool_t powered =3D TRUE;
+
+	if (!e)
+		return FALSE;
+
+	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_UNIX_FD, &fd,
+					DBUS_TYPE_INVALID) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	if (set_powered(e, TRUE, fd) < 0)
+		return __ofono_error_failed(msg);
+
+	reply =3D dbus_message_new_method_return(msg);
+	path =3D ofono_emulator_get_path(e);
+	dbus_message_append_args(reply, DBUS_TYPE_OBJECT_PATH, &path,
+					DBUS_TYPE_INVALID);
+
+	ofono_dbus_signal_property_changed(conn, path,
+					OFONO_EMULATOR_INTERFACE,
+					"Powered", DBUS_TYPE_BOOLEAN,
+					&powered);
+	return reply;
+}
+
+static DBusMessage *emulator_disable(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	struct ofono_emulator *e =3D data;
+
+	set_powered(e, FALSE, 0);
+
+	return dbus_message_new_method_return(msg);
+}
+
 static GDBusMethodTable ofono_emulator_methods[] =3D {
 	{ "GetProperties",	"",	"a{sv}", emulator_get_properties },
+	{ "Enable", 	"h", 	"", 		emulator_enable,
+						G_DBUS_METHOD_FLAG_ASYNC },
+	{ "Disable", 	"", 	"", 		emulator_disable },
 	{ }
 };
 =

-- =

1.6.3.3


--===============2298741909155258126==--

