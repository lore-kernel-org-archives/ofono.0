Content-Type: multipart/mixed; boundary="===============0393032412330361997=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [PATCH 1/3] plugins: Implementation of Network Time plugin
Date: Fri, 03 Dec 2010 11:47:26 +0200
Message-ID: <1291369648-25059-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0393032412330361997==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/dbus.h    |    1 +
 plugins/nettime.c |  293 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 294 insertions(+), 0 deletions(-)
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
index 0000000..0f99bb1
--- /dev/null
+++ b/plugins/nettime.c
@@ -0,0 +1,293 @@
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
+#define MAX_TIME_STR_LEN 128
+#define TIME_FORMAT "%FT%TZ"
+
+
+struct nettime_data {
+	struct ofono_network_time nw_time;
+	time_t received;
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
+static struct tm *refresh_nw_time(struct tm *nw_time,
+				time_t received)
+{
+	time_t now, new_nw_time;
+
+	now =3D get_monotonic_time();
+	new_nw_time =3D timegm(nw_time) + now - received;
+	return gmtime(&new_nw_time);
+}
+
+static int fill_time_changed_signal(DBusMessage *signal,
+		struct nettime_data *ntd)
+{
+	DBusMessageIter iter, iter_array;
+	int time_available;
+	char buf[MAX_TIME_STR_LEN];
+	struct tm time_tm, *new_time_tm;
+	const char *str =3D buf;
+
+	dbus_message_iter_init_append(signal, &iter);
+	dbus_message_iter_open_container(&iter,
+					DBUS_TYPE_ARRAY,
+					"{sv}",
+					&iter_array);
+
+	time_available =3D encode_time_format(&ntd->nw_time, &time_tm);
+	if (time_available !=3D 0) {
+		new_time_tm =3D refresh_nw_time(&time_tm, ntd->received);
+		strftime(buf, MAX_TIME_STR_LEN, TIME_FORMAT, new_time_tm);
+
+		ofono_dbus_dict_append(&iter_array,
+					"DateAndTime",
+					DBUS_TYPE_STRING,
+					&str);
+	}
+
+	ofono_dbus_dict_append(&iter_array,
+				"Timezone",
+				DBUS_TYPE_INT32,
+				&ntd->nw_time.utcoff);
+	ofono_dbus_dict_append(&iter_array,
+				"DST",
+				DBUS_TYPE_UINT32,
+				&ntd->nw_time.dst);
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
+	struct nettime_data *nettime_data;
+	context->data =3D g_try_new0(struct nettime_data, 1);
+
+	nettime_data =3D context->data;
+	nettime_data->nw_time.year =3D -1;
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
+	struct nettime_data *ntd =3D context->data;
+
+	if (info =3D=3D NULL)
+		return;
+
+	ofono_debug("Received a network time notification on modem: %p",
+			context->modem);
+
+	ntd->nw_time =3D *info;
+	ntd->received =3D get_monotonic_time();
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


--===============0393032412330361997==--

