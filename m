Content-Type: multipart/mixed; boundary="===============0377034555833630566=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [PATCH 1/3] nettime: Network time plugin implementation
Date: Wed, 09 Feb 2011 21:12:49 +0200
Message-ID: <1297278771-14468-2-git-send-email-antti.paila@nokia.com>
In-Reply-To: <1297278771-14468-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0377034555833630566==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/meego-nettime.c |  321 +++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 321 insertions(+), 0 deletions(-)
 create mode 100644 plugins/meego-nettime.c

diff --git a/plugins/meego-nettime.c b/plugins/meego-nettime.c
new file mode 100644
index 0000000..442925c
--- /dev/null
+++ b/plugins/meego-nettime.c
@@ -0,0 +1,321 @@
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
+#include <string.h>
+#include "ofono.h"
+#include "common.h"
+
+#define TIMED_PATH "/com/meego/timed"
+#define TIMED_SERVICE "com.meego.timed"
+
+struct nt_data {
+	gboolean time_available;
+	gboolean time_pending;
+	time_t nw_time_utc;
+	time_t received;
+	int dst;
+	int time_zone;
+	char mcc[OFONO_MAX_MCC_LENGTH + 1];
+	char mnc[OFONO_MAX_MNC_LENGTH + 1];
+	unsigned int timed_watch;
+	gboolean timed_present;
+	struct ofono_netreg *netreg;
+	unsigned int netreg_status_watch;
+	unsigned int netreg_watch;
+};
+
+static gboolean encode_time_format(struct ofono_network_time *time,
+				 struct tm *tm)
+{
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
+
+	return ts.tv_sec;
+}
+
+static int fill_time_notification(DBusMessage *msg,
+		struct nt_data *ntd)
+{
+	DBusMessageIter iter, iter_array;
+	int64_t utc;
+
+	const char *mcc =3D ntd->mcc;
+	const char *mnc =3D ntd->mnc;
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
+			&mcc);
+	ofono_dbus_dict_append(&iter_array,
+			"MobileNetworkCode",
+			DBUS_TYPE_STRING,
+			&mnc);
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
+
+	if (message =3D=3D NULL)
+		return NULL;
+
+	dbus_message_set_no_reply(message, TRUE);
+	fill_time_notification(message, ntd);
+
+	return message;
+}
+
+static void nettime_remove(struct ofono_nettime_context *context)
+{
+	struct nt_data *ntd =3D context->data;
+
+	DBG("Network Time Remove for modem: %p", context->modem);
+
+	if (ntd->timed_watch > 0)
+		g_dbus_remove_watch(ofono_dbus_get_connection(),
+					ntd->timed_watch);
+
+	if (ntd->netreg_status_watch > 0 && ntd->netreg !=3D NULL) {
+		__ofono_netreg_remove_status_watch(ntd->netreg,
+						ntd->netreg_status_watch);
+	}
+
+	__ofono_modem_remove_atom_watch(context->modem,
+				ntd->netreg_watch);
+	g_free(ntd);
+}
+
+static void notify(void *data)
+{
+	struct ofono_nettime_context *context =3D data;
+	struct nt_data *ntd =3D context->data;
+	DBusMessage *message;
+	const char *mcc, *mnc;
+
+	mcc =3D ofono_netreg_get_mcc(ntd->netreg);
+	mnc =3D ofono_netreg_get_mnc(ntd->netreg);
+
+	if (ntd->timed_present =3D=3D FALSE ||
+			mcc =3D=3D NULL ||
+			mnc =3D=3D NULL ||
+			(strcmp(ntd->mnc, mnc) =3D=3D 0 &&
+			strcmp(ntd->mcc, mcc) =3D=3D 0 &&
+			ntd->time_pending =3D=3D FALSE))
+		return;
+
+	strcpy(ntd->mnc, mnc);
+	strcpy(ntd->mcc, mcc);
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
+static void notify_cb(int status, int lac, int ci, int tech,
+			const char *mcc, const char *mnc, void *data)
+{
+	if (mcc !=3D NULL && mnc !=3D NULL)
+		notify(data);
+}
+
+
+static void nettime_info_received(struct ofono_nettime_context *context,
+				struct ofono_network_time *info)
+{
+	struct tm t;
+	struct nt_data *ntd =3D context->data;
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
+	notify(context);
+
+}
+
+static void timed_connect(DBusConnection *connection, void *user_data)
+{
+	struct ofono_nettime_context *context =3D user_data;
+	struct nt_data *ntd =3D context->data;
+
+	ntd->timed_present =3D TRUE;
+
+	notify(context);
+}
+
+static void timed_disconnect(DBusConnection *connection, void *user_data)
+{
+	struct ofono_nettime_context *context =3D user_data;
+	struct nt_data *ntd =3D context->data;
+
+	ntd->timed_present =3D FALSE;
+}
+
+static void netreg_watch_cb(struct ofono_atom *atom,
+				enum ofono_atom_watch_condition cond,
+				void *data)
+{
+	struct ofono_nettime_context *context =3D data;
+	struct nt_data *ntd =3D context->data;
+
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_REGISTERED) {
+		ntd->netreg =3D __ofono_atom_get_data(atom);
+		ntd->netreg_status_watch =3D __ofono_netreg_add_status_watch(
+					ntd->netreg, notify_cb,
+					context, NULL);
+	} else {
+		ntd->netreg_status_watch =3D 0;
+		ntd->netreg =3D NULL;
+	}
+}
+
+static int nettime_probe(struct ofono_nettime_context *context)
+{
+
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct nt_data *ntd =3D g_new0(struct nt_data, 1);
+
+	DBG("Network Time Probe for modem: %p", context->modem);
+
+	context->data =3D ntd;
+
+	if (ntd->timed_watch =3D=3D 0)
+		ntd->timed_watch =3D g_dbus_add_service_watch(conn, TIMED_SERVICE,
+					timed_connect, timed_disconnect,
+					context, NULL);
+
+	if (ntd->netreg_watch =3D=3D 0)
+		ntd->netreg_watch =3D __ofono_modem_add_atom_watch(
+					context->modem,
+					OFONO_ATOM_TYPE_NETREG,
+					netreg_watch_cb,
+					context, NULL);
+
+	return 0;
+}
+
+static struct ofono_nettime_driver nettime_driver =3D {
+	.name		=3D "Meego Network Time",
+	.probe		=3D nettime_probe,
+	.remove		=3D nettime_remove,
+	.info_received	=3D nettime_info_received,
+};
+
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
+OFONO_PLUGIN_DEFINE(meego_nettime, "Meego Network Time Plugin",
+		VERSION, OFONO_PLUGIN_PRIORITY_DEFAULT,
+		nettime_init, nettime_exit)
+
-- =

1.7.1


--===============0377034555833630566==--

