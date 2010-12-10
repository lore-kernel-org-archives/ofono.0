Content-Type: multipart/mixed; boundary="===============4582360543654341959=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [PATCH 1/4 v2] plugins: Implementation of Network Time plugin
Date: Fri, 10 Dec 2010 09:53:55 +0200
Message-ID: <1291967638-12371-2-git-send-email-antti.paila@nokia.com>
In-Reply-To: <1291967638-12371-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4582360543654341959==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/dbus.h    |    1 +
 plugins/nettime.c |  285 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 286 insertions(+), 0 deletions(-)
 create mode 100644 plugins/nettime.c

diff --git a/include/dbus.h b/include/dbus.h
index 9e29afb..0c48f83 100644
--- a/include/dbus.h
+++ b/include/dbus.h
@@ -45,6 +45,7 @@ extern "C" {
 #define OFONO_MESSAGE_WAITING_INTERFACE "org.ofono.MessageWaiting"
 #define OFONO_NETWORK_REGISTRATION_INTERFACE "org.ofono.NetworkRegistratio=
n"
 #define OFONO_NETWORK_OPERATOR_INTERFACE "org.ofono.NetworkOperator"
+#define OFONO_NETWORK_TIME_INTERFACE "org.ofono.NetworkTime"
 #define OFONO_PHONEBOOK_INTERFACE "org.ofono.Phonebook"
 #define OFONO_RADIO_SETTINGS_INTERFACE "org.ofono.RadioSettings"
 #define OFONO_AUDIO_SETTINGS_INTERFACE "org.ofono.AudioSettings"
diff --git a/plugins/nettime.c b/plugins/nettime.c
new file mode 100644
index 0000000..d080582
--- /dev/null
+++ b/plugins/nettime.c
@@ -0,0 +1,285 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010  Nokia Corporation and/or its subsidiary(-ies).
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <string.h>
+#include <glib.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/log.h>
+#include <ofono/nettime.h>
+#include <ofono/types.h>
+#include <gdbus.h>
+#include "ofono.h"
+
+#include "common.h"
+
+struct nettime_data {
+
+	gboolean time_available;
+	time_t nw_time_utc;
+	time_t received;
+	int dst;
+	int time_zone;
+};
+
+static void nettime_register(struct ofono_nettime_context *);
+
+static gboolean encode_time_format(struct ofono_network_time *time,
+				 struct tm *tm)
+{
+	if (time->year < 0)
+		return FALSE;
+
+	tm->tm_year =3D time->year - 1900;
+	tm->tm_mon =3D time->mon - 1;
+	tm->tm_mday =3D time->mday;
+	tm->tm_hour =3D time->hour;
+	tm->tm_min =3D time->min;
+	tm->tm_sec =3D time->sec;
+	tm->tm_gmtoff =3D time->utcoff;
+	tm->tm_isdst =3D time->dst;
+
+	return TRUE;
+}
+
+static time_t get_monotonic_time()
+{
+	struct timespec ts;
+	clock_gettime(CLOCK_MONOTONIC, &ts);
+	return ts.tv_sec;
+}
+
+static int fill_time_changed_signal(DBusMessage *signal,
+		struct nettime_data *ntd)
+{
+	DBusMessageIter iter, iter_array;
+	time_t utc;
+
+	dbus_message_iter_init_append(signal, &iter);
+	dbus_message_iter_open_container(&iter,
+					DBUS_TYPE_ARRAY,
+					"{sv}",
+					&iter_array);
+
+	if (ntd->time_available) {
+		utc =3D ntd->nw_time_utc - ntd->received;
+
+		ofono_dbus_dict_append(&iter_array,
+					"UTC",
+					DBUS_TYPE_INT64,
+					&utc);
+	}
+
+	ofono_dbus_dict_append(&iter_array,
+				"Timezone",
+				DBUS_TYPE_INT32,
+				&ntd->time_zone);
+	ofono_dbus_dict_append(&iter_array,
+				"DST",
+				DBUS_TYPE_UINT32,
+				&ntd->dst);
+	dbus_message_iter_close_container(&iter, &iter_array);
+	return 0;
+}
+
+static DBusMessage *create_time_changed_signal(
+			struct ofono_nettime_context *context)
+{
+	DBusMessage *signal;
+	struct nettime_data *ntd =3D context->data;
+	const char *path =3D ofono_modem_get_path(context->modem);
+
+	if (path =3D=3D NULL) {
+		ofono_error("Fetching path for modem failed");
+		return NULL;
+	}
+
+	signal =3D dbus_message_new_signal(path, OFONO_NETWORK_TIME_INTERFACE,
+					"NetworkTimeChanged");
+	fill_time_changed_signal(signal, ntd);
+
+	return signal;
+}
+
+static void init_time(struct ofono_nettime_context *context)
+{
+	struct nettime_data *nettime_data =3D g_new0(struct nettime_data, 1);
+
+	nettime_data->time_available =3D FALSE;
+	nettime_data->dst =3D 0;
+	nettime_data->time_zone =3D 0;
+	context->data =3D nettime_data;
+
+}
+
+static int nettime_probe(struct ofono_nettime_context *context)
+{
+	ofono_debug("Network Time Probe for modem: %p", context->modem);
+
+	init_time(context);
+
+	nettime_register(context);
+	return 0;
+}
+
+static void nettime_remove(struct ofono_nettime_context *context)
+{
+	DBusConnection *conn;
+	const char *path;
+
+	ofono_debug("Network Time Remove for modem: %p", context->modem);
+
+	g_free(context->data);
+
+	conn =3D ofono_dbus_get_connection();
+	path =3D ofono_modem_get_path(context->modem);
+
+	if (!g_dbus_unregister_interface(conn,
+					path,
+					OFONO_NETWORK_TIME_INTERFACE))
+		ofono_error("Could not unregister %s interface",
+				OFONO_NETWORK_TIME_INTERFACE);
+
+	ofono_modem_remove_interface(context->modem,
+			OFONO_NETWORK_TIME_INTERFACE);
+}
+
+static void nettime_info_received(struct ofono_nettime_context *context,
+				struct ofono_network_time *info)
+{
+	DBusMessage *nt_signal;
+	struct tm t;
+	struct nettime_data *ntd =3D context->data;
+
+	if (info =3D=3D NULL)
+		return;
+
+	ofono_debug("Received a network time notification on modem: %p",
+			context->modem);
+
+	ntd->received =3D get_monotonic_time();
+
+	ntd->time_available =3D encode_time_format(info, &t);
+	if (ntd->time_available =3D=3D TRUE)
+		ntd->nw_time_utc =3D timegm(&t);
+
+	ntd->dst =3D info->dst;
+	ntd->time_zone =3D info->utcoff;
+
+	nt_signal =3D create_time_changed_signal(context);
+	if (nt_signal =3D=3D NULL) {
+		ofono_error("Failed to create NetworkTimeChanged signal");
+		return;
+	}
+
+	g_dbus_send_message(ofono_dbus_get_connection(), nt_signal);
+}
+
+static struct ofono_nettime_driver nettime_driver =3D {
+	.name		=3D "Network Time",
+	.probe		=3D nettime_probe,
+	.remove		=3D nettime_remove,
+	.info_received	=3D nettime_info_received,
+};
+
+static int nettime_init(void)
+{
+	return ofono_nettime_driver_register(&nettime_driver);
+}
+
+static void nettime_exit(void)
+{
+	ofono_nettime_driver_unregister(&nettime_driver);
+}
+
+static DBusMessage *nettime_get_time(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	DBusMessage *reply;
+	int status;
+	struct ofono_nettime_context *context =3D data;
+
+	ofono_debug("Time requested from modem %p", context->modem);
+
+	reply =3D dbus_message_new_method_return(msg);
+	if (reply =3D=3D NULL) {
+		ofono_error("Message allocation failed");
+		return NULL;
+	}
+
+	status =3D fill_time_changed_signal(reply, context->data);
+	if (status !=3D 0) {
+		ofono_error("NetworkTimeChaged signal not filled, status: %d",
+			status);
+		return NULL;
+	}
+
+	return reply;
+}
+
+static GDBusMethodTable nettime_methods[] =3D {
+	{ "GetNetworkTime", "", "a{sv}", nettime_get_time },
+	{ }
+};
+
+static GDBusSignalTable nettime_signals[] =3D {
+	{ "NetworkTimeChanged", "a{sv}" },
+	{ }
+};
+
+static void nettime_register(struct ofono_nettime_context *context)
+{
+	DBusConnection *conn;
+	const char *path;
+
+	ofono_debug("Registering Network time for modem %s" ,
+		ofono_modem_get_path(context->modem));
+
+	conn =3D ofono_dbus_get_connection();
+
+	path =3D ofono_modem_get_path(context->modem);
+	if (path =3D=3D NULL) {
+		ofono_error("No path for modem found");
+		return;
+	}
+
+	if (!g_dbus_register_interface(conn, path,
+				OFONO_NETWORK_TIME_INTERFACE,
+				nettime_methods,
+				nettime_signals,
+				NULL, context, NULL)) {
+		ofono_error("Could not create %s interface",
+				OFONO_NETWORK_TIME_INTERFACE);
+		return;
+	}
+
+	ofono_modem_add_interface(context->modem, OFONO_NETWORK_TIME_INTERFACE);
+}
+
+OFONO_PLUGIN_DEFINE(nettime, "Network Time Plugin",
+		VERSION, OFONO_PLUGIN_PRIORITY_DEFAULT,
+		nettime_init, nettime_exit)
+
-- =

1.7.1


--===============4582360543654341959==--

