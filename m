Content-Type: multipart/mixed; boundary="===============3003561626504661678=="
MIME-Version: 1.0
From: Nishanth V <nishanth.v@intel.com>
Subject: [PATCH 4/7] netmon: core changes for network monitor agent
Date: Thu, 07 Sep 2017 09:53:17 +0530
Message-ID: <1504758200-18624-4-git-send-email-nishanth.v@intel.com>
In-Reply-To: <1504758200-18624-1-git-send-email-nishanth.v@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3003561626504661678==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Added implementation for RegisterAgent and UnregisterAgent in
NetworkMonitor interface and added netmonagent source file for agent
implemention.
---
 Makefile.am       |   3 +-
 src/netmon.c      | 126 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++--
 src/netmonagent.c | 122 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++
 src/netmonagent.h |  23 ++++++++++
 src/ofono.conf    |   1 +
 5 files changed, 270 insertions(+), 5 deletions(-)
 create mode 100644 src/netmonagent.c
 create mode 100644 src/netmonagent.h

diff --git a/Makefile.am b/Makefile.am
index 658e152..fbc4d6d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -626,7 +626,8 @@ src_ofonod_SOURCES =3D $(builtin_sources) $(gatchat_sou=
rces) src/ofono.ver \
 			src/cdma-provision.c src/handsfree.c \
 			src/handsfree-audio.c src/bluetooth.h \
 			src/hfp.h src/siri.c \
-			src/netmon.c src/lte.c
+			src/netmon.c src/lte.c \
+			src/netmonagent.c src/netmonagent.h
 =

 src_ofonod_LDADD =3D gdbus/libgdbus-internal.la $(builtin_libadd) \
 			@GLIB_LIBS@ @DBUS_LIBS@ -ldl
diff --git a/src/netmon.c b/src/netmon.c
index 6476783..3a49587 100644
--- a/src/netmon.c
+++ b/src/netmon.c
@@ -34,6 +34,7 @@
 #include <gdbus.h>
 =

 #include "ofono.h"
+#include "netmonagent.h"
 =

 #define CELL_INFO_DICT_APPEND(p_dict, key, info, type, dbus_type)	do { \
 	type value; \
@@ -51,6 +52,7 @@ struct ofono_netmon {
 	DBusMessage *reply;
 	void *driver_data;
 	struct ofono_atom *atom;
+	struct netmon_agent *agent;
 };
 =

 static const char *cell_type_to_tech_name(enum ofono_netmon_cell_type type)
@@ -72,6 +74,7 @@ void ofono_netmon_serving_cell_notify(struct ofono_netmon=
 *netmon,
 					int info_type, ...)
 {
 	va_list arglist;
+	DBusMessage *agent_notify =3D NULL;
 	DBusMessageIter iter;
 	DBusMessageIter dict;
 	enum ofono_netmon_info next_info_type =3D info_type;
@@ -79,12 +82,17 @@ void ofono_netmon_serving_cell_notify(struct ofono_netm=
on *netmon,
 	char *mcc;
 	char *mnc;
 	int intval;
-	netmon->reply =3D dbus_message_new_method_return(netmon->pending);
 =

-	if (netmon->reply =3D=3D NULL)
-		return;
+	if (netmon->pending !=3D NULL) {
+		netmon->reply =3D dbus_message_new_method_return(netmon->pending);
+		dbus_message_iter_init_append(netmon->reply, &iter);
+	} else if (netmon->agent !=3D NULL) {
+		agent_notify =3D netmon_agent_new_method_call(netmon->agent,
+					"ServingCellInformationChanged");
 =

-	dbus_message_iter_init_append(netmon->reply, &iter);
+		dbus_message_iter_init_append(agent_notify, &iter);
+	} else
+		return;
 =

 	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
 					OFONO_PROPERTIES_ARRAY_SIGNATURE,
@@ -243,6 +251,9 @@ done:
 	va_end(arglist);
 =

 	dbus_message_iter_close_container(&iter, &dict);
+
+	if (agent_notify)
+		netmon_agent_send_no_reply(netmon->agent, agent_notify);
 }
 =

 static void serving_cell_info_callback(const struct ofono_error *error,
@@ -291,10 +302,117 @@ static DBusMessage *netmon_get_serving_cell_info(DBu=
sConnection *conn,
 	return NULL;
 }
 =

+static void periodic_updates_enabled_cb(const struct ofono_error *error,
+					void *data)
+{
+	struct ofono_netmon *netmon =3D data;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		ofono_error("Error enabling periodic updates");
+
+		netmon_agent_free(netmon->agent);
+		return;
+	}
+}
+
+static void periodic_updates_disabled_cb(const struct ofono_error *error,
+					void *data)
+{
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
+		ofono_error("Error disabling periodic updates");
+}
+
+static void agent_removed_cb(gpointer user_data)
+{
+	struct ofono_netmon *netmon =3D user_data;
+
+	netmon->agent =3D NULL;
+
+	netmon->driver->enable_periodic_update(netmon, 0, 0,
+						periodic_updates_disabled_cb,
+						NULL);
+}
+
+static DBusMessage *netmon_register_agent(DBusConnection *conn,
+				DBusMessage *msg, void *data)
+{
+	struct ofono_netmon *netmon =3D data;
+	const char *agent_path;
+	const unsigned int enable =3D 1;
+	unsigned int period;
+
+	if (netmon->agent)
+		return __ofono_error_busy(msg);
+
+	if (!netmon->driver->enable_periodic_update)
+		return __ofono_error_not_implemented(msg);
+
+	if (dbus_message_get_args(msg, NULL,
+				DBUS_TYPE_OBJECT_PATH, &agent_path,
+				DBUS_TYPE_UINT32, &period,
+				DBUS_TYPE_INVALID) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	if (!__ofono_dbus_valid_object_path(agent_path))
+		return __ofono_error_invalid_format(msg);
+
+	if (!period)
+		return __ofono_error_invalid_args(msg);
+
+	/* minimum period is 5 seconds, to avoid frequent updates*/
+	if (period < 5)
+		period =3D 5;
+
+	netmon->agent =3D netmon_agent_new(agent_path,
+					dbus_message_get_sender(msg));
+
+	if (netmon->agent =3D=3D NULL)
+		return __ofono_error_failed(msg);
+
+	netmon_agent_set_removed_notify(netmon->agent, agent_removed_cb, netmon);
+
+	netmon->driver->enable_periodic_update(netmon, enable, period,
+					periodic_updates_enabled_cb, netmon);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *netmon_unregister_agent(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct ofono_netmon *netmon =3D data;
+	const char *agent_path;
+	const char *agent_bus =3D dbus_message_get_sender(msg);
+
+	if (!netmon->driver->enable_periodic_update)
+		return __ofono_error_not_implemented(msg);
+
+	if (dbus_message_get_args(msg, NULL,
+					DBUS_TYPE_OBJECT_PATH, &agent_path,
+					DBUS_TYPE_INVALID) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	if (netmon->agent =3D=3D NULL)
+		return __ofono_error_failed(msg);
+
+	if (!netmon_agent_matches(netmon->agent, agent_path, agent_bus))
+		return __ofono_error_access_denied(msg);
+
+	netmon_agent_free(netmon->agent);
+
+	return dbus_message_new_method_return(msg);
+}
+
 static const GDBusMethodTable netmon_methods[] =3D {
 	{ GDBUS_ASYNC_METHOD("GetServingCellInformation",
 			NULL, GDBUS_ARGS({ "cellinfo", "a{sv}" }),
 			netmon_get_serving_cell_info) },
+	{ GDBUS_METHOD("RegisterAgent",
+			GDBUS_ARGS({ "path", "o"}, { "period", "u"}), NULL,
+			netmon_register_agent) },
+	{ GDBUS_METHOD("UnregisterAgent",
+			GDBUS_ARGS({ "agent", "o" }), NULL,
+			netmon_unregister_agent) },
 	{ }
 };
 =

diff --git a/src/netmonagent.c b/src/netmonagent.c
new file mode 100644
index 0000000..ab6f050
--- /dev/null
+++ b/src/netmonagent.c
@@ -0,0 +1,122 @@
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <stdint.h>
+#include <string.h>
+#include <errno.h>
+
+#include <glib.h>
+#include <gdbus.h>
+
+#include "ofono.h"
+#include "netmonagent.h"
+
+struct netmon_agent {
+	char *path;
+	char *bus;
+	guint disconnect_watch;
+	ofono_destroy_func removed_cb;
+	void *removed_data;
+};
+
+DBusMessage *netmon_agent_new_method_call(struct netmon_agent *agent,
+				const char *method)
+{
+	DBusMessage *msg =3D dbus_message_new_method_call(agent->bus,
+					agent->path,
+					OFONO_NETMON_AGENT_INTERFACE,
+					method);
+
+	return msg;
+}
+
+void netmon_agent_send_no_reply(struct netmon_agent *agent,
+				DBusMessage *message)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	dbus_message_set_no_reply(message, TRUE);
+
+	g_dbus_send_message(conn, message);
+}
+
+static inline void netmon_agent_send_release(struct netmon_agent *agent)
+{
+	DBusMessage *msg =3D netmon_agent_new_method_call(agent, "Release");
+
+	netmon_agent_send_no_reply(agent, msg);
+}
+
+ofono_bool_t netmon_agent_matches(struct netmon_agent *agent,
+				const char *path, const char *sender)
+{
+	return g_str_equal(agent->path, path) &&
+			g_str_equal(agent->bus, sender);
+}
+
+ofono_bool_t netmon_agent_sender_matches(struct netmon_agent *agent,
+					const char *sender)
+{
+	return g_str_equal(agent->bus, sender);
+}
+
+void netmon_agent_set_removed_notify(struct netmon_agent *agent,
+					ofono_destroy_func destroy,
+					void *user_data)
+{
+	agent->removed_cb =3D destroy;
+	agent->removed_data =3D user_data;
+}
+
+void netmon_agent_free(struct netmon_agent *agent)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	if (agent =3D=3D NULL)
+		return;
+
+	if (agent->disconnect_watch) {
+		netmon_agent_send_release(agent);
+		g_dbus_remove_watch(conn, agent->disconnect_watch);
+		agent->disconnect_watch =3D 0;
+	}
+
+	if (agent->removed_cb)
+		agent->removed_cb(agent->removed_data);
+
+	g_free(agent->path);
+	g_free(agent->bus);
+	g_free(agent);
+}
+
+static void netmon_agent_disconnect_cb(DBusConnection *conn, void *user_da=
ta)
+{
+	struct netmon_agent *agent =3D user_data;
+
+	ofono_debug("Agent excited without calling UnregisterAgent");
+
+	agent->disconnect_watch =3D 0;
+
+	netmon_agent_free(agent);
+}
+
+struct netmon_agent *netmon_agent_new(const char *path,
+						const char *sender)
+{
+	struct netmon_agent *agent =3D g_try_new0(struct netmon_agent, 1);
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	if (agent =3D=3D NULL)
+		return NULL;
+
+	agent->bus =3D g_strdup(sender);
+	agent->path =3D g_strdup(path);
+
+	agent->disconnect_watch =3D g_dbus_add_disconnect_watch(conn, sender,
+						netmon_agent_disconnect_cb,
+						agent, NULL);
+
+	return agent;
+}
diff --git a/src/netmonagent.h b/src/netmonagent.h
new file mode 100644
index 0000000..f64a503
--- /dev/null
+++ b/src/netmonagent.h
@@ -0,0 +1,23 @@
+struct netmon_agent;
+
+struct netmon_agent *netmon_agent_new(const char *path, const char *sender=
);
+
+void netmon_agent_free(struct netmon_agent *agent);
+
+void netmon_agent_set_removed_notify(struct netmon_agent *agent,
+					ofono_destroy_func removed_cb,
+					void *user_data);
+
+ofono_bool_t netmon_agent_matches(struct netmon_agent *agent,
+				const char *path, const char *sender);
+
+ofono_bool_t netmon_agent_sender_matches(struct netmon_agent *agent,
+					const char *sender);
+
+DBusMessage *netmon_agent_new_method_call(struct netmon_agent *netmon,
+					const char *method);
+
+void netmon_agent_send_no_reply(struct netmon_agent *agent,
+				DBusMessage *message);
+
+void netmon_agent_test(struct netmon_agent *agent);
diff --git a/src/ofono.conf b/src/ofono.conf
index ed56d3b..61e0bde 100644
--- a/src/ofono.conf
+++ b/src/ofono.conf
@@ -15,6 +15,7 @@
     <allow send_interface=3D"org.ofono.SmartMessagingAgent"/>
     <allow send_interface=3D"org.ofono.PositioningRequestAgent"/>
     <allow send_interface=3D"org.ofono.HandsfreeAudioAgent"/>
+    <allow send_interface=3D"org.ofono.NetworkMonitorAgent"/>
   </policy>
 =

   <policy at_console=3D"true">
-- =

1.9.1


--===============3003561626504661678==--

