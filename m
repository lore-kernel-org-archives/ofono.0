Content-Type: multipart/mixed; boundary="===============0104184865840397857=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [PATCH 1/4] nettime: Network time plugin implementation
Date: Tue, 01 Feb 2011 16:49:28 +0200
Message-ID: <1296571771-26513-2-git-send-email-antti.paila@nokia.com>
In-Reply-To: <1296571771-26513-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0104184865840397857==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/nettime.c |  326 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 326 insertions(+), 0 deletions(-)
 create mode 100644 plugins/nettime.c

diff --git a/plugins/nettime.c b/plugins/nettime.c
new file mode 100644
index 0000000..894dce7
--- /dev/null
+++ b/plugins/nettime.c
@@ -0,0 +1,326 @@
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
+#include <stdlib.h>
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
+#define TIMED_PATH "/com/meego/time"
+#define TIMED_SERVICE "com.meego.time"
+
+struct nt_data {
+	gboolean time_available;
+	gboolean time_pending;
+	time_t nw_time_utc;
+	time_t received;
+	int dst;
+	int time_zone;
+	const char *mcc;
+	const char *mnc;
+	unsigned int timed_watch;
+	gboolean timed_present;
+	struct ofono_netreg *netreg;
+	unsigned int netreg_st_watch;
+
+};
+
+static void nettime_register(struct ofono_nettime_context *);
+
+static gboolean encode_time_format(struct ofono_network_time *time,
+				 struct tm *tm)
+{
+
+	tm->tm_gmtoff =3D time->utcoff;
+	tm->tm_isdst =3D time->dst;
+
+	if (time->year < 0)
+		return FALSE;
+
+	tm->tm_year =3D time->year - 1900;
+	tm->tm_mon =3D time->mon - 1;
+	tm->tm_mday =3D time->mday;
+	tm->tm_hour =3D time->hour;
+	tm->tm_min =3D time->min;
+	tm->tm_sec =3D time->sec;
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
+static int fill_time_notification(DBusMessage *msg,
+		struct nt_data *ntd)
+{
+	DBusMessageIter iter, iter_array;
+	int64_t utc;
+
+	dbus_message_iter_init_append(msg, &iter);
+	dbus_message_iter_open_container(&iter,
+					DBUS_TYPE_ARRAY,
+					"{sv}",
+					&iter_array);
+
+	if (ntd->time_pending) {
+		if (ntd->time_available) {
+			utc =3D ntd->nw_time_utc - ntd->received;
+			ofono_dbus_dict_append(&iter_array,
+						"UTC",
+						DBUS_TYPE_INT64,
+						&utc);
+		}
+
+		ofono_dbus_dict_append(&iter_array,
+					"DST",
+					DBUS_TYPE_INT32,
+					&ntd->dst);
+		ofono_dbus_dict_append(&iter_array,
+					"Timezone",
+					DBUS_TYPE_INT32,
+					&ntd->time_zone);
+	}
+
+	ofono_dbus_dict_append(&iter_array,
+			"MobileCountryCode",
+			DBUS_TYPE_STRING,
+			&ntd->mcc);
+	ofono_dbus_dict_append(&iter_array,
+			"MobileNetworkCode",
+			DBUS_TYPE_STRING,
+			&ntd->mnc);
+
+	dbus_message_iter_close_container(&iter, &iter_array);
+	return 0;
+}
+
+static DBusMessage *create_time_notification(
+			struct ofono_nettime_context *context)
+{
+	DBusMessage *message;
+	struct nt_data *ntd =3D context->data;
+	const char *path =3D ofono_modem_get_path(context->modem);
+
+	if (path =3D=3D NULL) {
+		ofono_error("Fetching path for modem failed");
+		return NULL;
+	}
+
+	message =3D dbus_message_new_method_call(TIMED_SERVICE, TIMED_PATH,
+					"com.meego.NetworkTime", "Notify");
+	if (message =3D=3D NULL)
+		return NULL;
+
+	dbus_message_set_no_reply(message, TRUE);
+	fill_time_notification(message, ntd);
+
+	return message;
+}
+
+static void init_time(struct ofono_nettime_context *context)
+{
+	struct nt_data *nt_data =3D g_new0(struct nt_data, 1);
+
+	nt_data->time_available =3D FALSE;
+	nt_data->time_pending =3D FALSE;
+	nt_data->dst =3D 0;
+	nt_data->time_zone =3D 0;
+
+	context->data =3D nt_data;
+}
+
+static int nettime_probe(struct ofono_nettime_context *context)
+{
+	DBG("Network Time Probe for modem: %p", context->modem);
+
+	init_time(context);
+	nettime_register(context);
+
+	return 0;
+}
+
+static void nettime_remove(struct ofono_nettime_context *context)
+{
+	struct nt_data *ntd =3D context->data;
+
+	DBG("Network Time Remove for modem: %p", context->modem);
+	g_dbus_remove_watch(ofono_dbus_get_connection(),
+				ntd->timed_watch);
+	g_free(ntd);
+}
+
+static void notify(int status, int lac, int ci, int tech, const char *mcc,
+			const char *mnc, void *data)
+{
+	struct ofono_nettime_context *context =3D data;
+	struct nt_data *ntd =3D context->data;
+	DBusMessage *message;
+
+	if (mcc =3D=3D NULL || mnc =3D=3D NULL)
+		return;
+
+	ntd->mcc =3D mcc;
+	ntd->mnc =3D mnc;
+
+	if (ntd->timed_present =3D=3D FALSE) {
+		DBG("Timed not present. Caching time info");
+		return;
+	}
+
+	message =3D create_time_notification(context);
+	if (message =3D=3D NULL) {
+		ofono_error("Failed to create Notification message");
+		return;
+	}
+
+	g_dbus_send_message(ofono_dbus_get_connection(), message);
+	ntd->time_pending =3D FALSE;
+}
+
+static void nr_st_watch_destroy(void *data)
+{
+	struct ofono_nettime_context *context =3D data;
+	struct nt_data *ntd =3D context->data;
+	DBG("");
+
+	ntd->netreg_st_watch =3D 0;
+}
+
+static void nettime_info_received(struct ofono_nettime_context *context,
+				struct ofono_network_time *info)
+{
+	struct tm t;
+	struct nt_data *ntd =3D context->data;
+	const char *mcc, *mnc;
+
+	DBG("Network time notification received, modem: %p",
+			context->modem);
+
+	if (info =3D=3D NULL)
+		return;
+
+	ntd->received =3D get_monotonic_time();
+	ntd->time_pending =3D TRUE;
+
+	ntd->time_available =3D encode_time_format(info, &t);
+	if (ntd->time_available =3D=3D TRUE)
+		ntd->nw_time_utc =3D timegm(&t);
+
+	ntd->dst =3D info->dst;
+	ntd->time_zone =3D info->utcoff;
+
+	ntd->netreg =3D __ofono_atom_get_data(__ofono_modem_find_atom(
+				context->modem, OFONO_ATOM_TYPE_NETREG));
+
+	mcc =3D ofono_netreg_get_mcc(ntd->netreg);
+	mnc =3D ofono_netreg_get_mnc(ntd->netreg);
+	if ((mcc =3D=3D NULL) || (mnc =3D=3D NULL)) {
+		DBG("Mobile country/network code missing");
+
+		if (ntd->netreg_st_watch !=3D 0)
+			return;
+
+		ntd->netreg_st_watch =3D __ofono_netreg_add_status_watch(
+					ntd->netreg, notify,
+					context, nr_st_watch_destroy);
+	} else {
+		notify(0, 0, 0, 0, mcc, mnc, context);
+	}
+
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
+static void timed_connect(DBusConnection *connection, void *user_data)
+{
+	struct ofono_nettime_context *context =3D user_data;
+	struct nt_data *ntd =3D context->data;
+	const char *mcc, *mnc;
+
+	DBG("");
+
+	ntd->timed_present =3D TRUE;
+	mcc =3D ofono_netreg_get_mcc(ntd->netreg);
+	mnc =3D ofono_netreg_get_mnc(ntd->netreg);
+
+	notify(0, 0, 0, 0, mcc, mnc, context);
+}
+
+static void timed_disconnect(DBusConnection *connection, void *user_data)
+{
+	struct ofono_nettime_context *context =3D user_data;
+	struct nt_data *ntd =3D context->data;
+
+	DBG("");
+
+	ntd->timed_present =3D FALSE;
+}
+
+static void nettime_register(struct ofono_nettime_context *context)
+{
+	DBusConnection *conn;
+	struct nt_data *ntd =3D context->data;
+
+	DBG("Registering Network time for modem %s" ,
+		ofono_modem_get_path(context->modem));
+
+	conn =3D ofono_dbus_get_connection();
+
+	ntd->timed_watch =3D g_dbus_add_service_watch(conn, TIMED_SERVICE,
+					timed_connect, timed_disconnect,
+					context, NULL);
+}
+
+OFONO_PLUGIN_DEFINE(nettime, "Network Time Plugin",
+		VERSION, OFONO_PLUGIN_PRIORITY_DEFAULT,
+		nettime_init, nettime_exit)
+
-- =

1.7.1


--===============0104184865840397857==--

