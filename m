Content-Type: multipart/mixed; boundary="===============2513511234419291491=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: [PATCH 2/5] cdma-voicecall: Add CDMA MO Call Support
Date: Thu, 02 Dec 2010 15:31:22 -0800
Message-ID: <1291332685-18740-3-git-send-email-dara.spieker-doyle@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2513511234419291491==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am          |    3 +-
 src/cdma-voicecall.c |  449 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/common.c         |   42 +++++
 src/common.h         |   14 ++
 src/ofono.h          |    3 +
 5 files changed, 510 insertions(+), 1 deletions(-)
 create mode 100644 src/cdma-voicecall.c

diff --git a/Makefile.am b/Makefile.am
index aea3fd3..f111f96 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -319,7 +319,8 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) src/ofono.ver \
 			src/radio-settings.c src/stkutil.h src/stkutil.c \
 			src/nettime.c src/stkagent.c src/stkagent.h \
 			src/simfs.c src/simfs.h src/audio-settings.c \
-			src/smsagent.c src/smsagent.h src/ctm.c
+			src/smsagent.c src/smsagent.h src/ctm.c \
+			src/cdma-voicecall.c
 =

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ -ldl
 =

diff --git a/src/cdma-voicecall.c b/src/cdma-voicecall.c
new file mode 100644
index 0000000..8ba3222
--- /dev/null
+++ b/src/cdma-voicecall.c
@@ -0,0 +1,449 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010 Nokia Corporation. All rights reserved.
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
+#include <stdio.h>
+#include <time.h>
+#include <errno.h>
+#include <stdint.h>
+
+#include <glib.h>
+#include <gdbus.h>
+
+#include "ofono.h"
+
+#include "common.h"
+
+static GSList *g_drivers;
+
+struct ofono_cdma_voicecall_manager {
+	struct ofono_cdma_phone_number phone_number;
+	int direction;
+	enum cdma_call_status status;
+	time_t start_time;
+	DBusMessage *pending;
+	const struct ofono_cdma_voicecall_manager_driver *driver;
+	void *driver_data;
+	struct ofono_atom *atom;
+};
+
+static void generic_callback(const struct ofono_error *error, void *data);
+
+static const char *disconnect_reason_to_string(enum ofono_disconnect_reaso=
n r)
+{
+	switch (r) {
+	case OFONO_DISCONNECT_REASON_LOCAL_HANGUP:
+		return "local";
+	case OFONO_DISCONNECT_REASON_REMOTE_HANGUP:
+		return "remote";
+	default:
+		return "network";
+	}
+}
+
+static const char *cdma_call_status_to_string(enum cdma_call_status status)
+{
+	switch (status) {
+	case CDMA_CALL_STATUS_ACTIVE:
+		return "active";
+	case CDMA_CALL_STATUS_DIALING:
+		return "dialing";
+	case CDMA_CALL_STATUS_ALERTING:
+		return "alerting";
+	case CDMA_CALL_STATUS_INCOMING:
+		return "incoming";
+	default:
+		return "disconnected";
+	}
+}
+
+static const char *time_to_str(const time_t *t)
+{
+	static char buf[128];
+	struct tm tm;
+
+	strftime(buf, 127, "%Y-%m-%dT%H:%M:%S%z", localtime_r(t, &tm));
+	buf[127] =3D '\0';
+
+	return buf;
+}
+
+static void append_voicecall_properties(struct ofono_cdma_voicecall_manage=
r *v,
+					DBusMessageIter *dict)
+{
+	const char *status;
+	const char *lineid;
+	const char *timestr;
+
+	status =3D cdma_call_status_to_string(v->status);
+	lineid =3D cdma_phone_number_to_string(&v->phone_number);
+
+	ofono_dbus_dict_append(dict, "State", DBUS_TYPE_STRING, &status);
+
+	ofono_dbus_dict_append(dict, "LineIdentification",
+				DBUS_TYPE_STRING, &lineid);
+
+	if (v->status =3D=3D CDMA_CALL_STATUS_ACTIVE ||
+			(v->status =3D=3D CDMA_CALL_STATUS_DISCONNECTED &&
+				v->start_time !=3D 0)) {
+		timestr =3D time_to_str(&v->start_time);
+
+		ofono_dbus_dict_append(dict, "StartTime", DBUS_TYPE_STRING,
+					&timestr);
+	}
+}
+
+static DBusMessage *voicecall_manager_get_properties(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	struct ofono_cdma_voicecall_manager *v =3D data;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+
+	reply =3D dbus_message_new_method_return(msg);
+
+	if (reply =3D=3D NULL)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+	append_voicecall_properties(v, &dict);
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static const char *voicecall_build_path(struct ofono_cdma_voicecall_manage=
r *vc)
+{
+	static char path[256];
+
+	snprintf(path, sizeof(path), "%s/voicecall",
+			__ofono_atom_get_path(vc->atom));
+
+	return path;
+}
+
+static void voicecall_emit_disconnect_reason(
+		struct ofono_cdma_voicecall_manager *vc,
+		enum ofono_disconnect_reason reason)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path;
+	const char *reason_str;
+
+	reason_str =3D disconnect_reason_to_string(reason);
+	path =3D voicecall_build_path(vc);
+
+	g_dbus_emit_signal(conn, path, OFONO_CDMA_VOICECALL_MANAGER_INTERFACE,
+				"DisconnectReason",
+				DBUS_TYPE_STRING, &reason_str,
+				DBUS_TYPE_INVALID);
+}
+
+static void voicecall_set_call_status(struct ofono_cdma_voicecall_manager =
*vc,
+		enum cdma_call_status status)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path;
+	const char *status_str;
+	enum cdma_call_status old_status;
+
+	if (vc->status =3D=3D status)
+		return;
+
+	old_status =3D vc->status;
+
+	vc->status =3D status;
+
+	status_str =3D cdma_call_status_to_string(status);
+	path =3D voicecall_build_path(vc);
+
+	ofono_dbus_signal_property_changed(conn, path,
+					OFONO_CDMA_VOICECALL_MANAGER_INTERFACE,
+					"State", DBUS_TYPE_STRING,
+					&status_str);
+
+	if (status =3D=3D CDMA_CALL_STATUS_ACTIVE &&
+			old_status =3D=3D CDMA_CALL_STATUS_DIALING) {
+		const char *timestr;
+
+		vc->start_time =3D time(NULL);
+		timestr =3D time_to_str(&vc->start_time);
+
+		ofono_dbus_signal_property_changed(conn, path,
+					OFONO_CDMA_VOICECALL_MANAGER_INTERFACE,
+					"StartTime", DBUS_TYPE_STRING,
+					&timestr);
+	}
+}
+
+static void voicecall_set_call_lineid(struct ofono_cdma_voicecall_manager =
*v)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path;
+	const char *lineid_str;
+
+	path =3D voicecall_build_path(v);
+
+	/* For MO calls, LineID is the dialed phone number */
+	lineid_str =3D cdma_phone_number_to_string(&v->phone_number);
+
+	ofono_dbus_signal_property_changed(conn, path,
+					OFONO_CDMA_VOICECALL_MANAGER_INTERFACE,
+					"LineIdentification",
+					DBUS_TYPE_STRING, &lineid_str);
+}
+
+static void manager_dial_callback(const struct ofono_error *error, void *d=
ata)
+{
+	struct ofono_cdma_voicecall_manager *vc =3D data;
+	DBusMessage *reply;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		reply =3D __ofono_error_failed(vc->pending);
+	} else {
+		const char *path =3D voicecall_build_path(vc);
+
+		reply =3D dbus_message_new_method_return(vc->pending);
+
+		dbus_message_append_args(reply, DBUS_TYPE_OBJECT_PATH, &path,
+						DBUS_TYPE_INVALID);
+	}
+
+	__ofono_dbus_pending_reply(&vc->pending, reply);
+}
+
+static DBusMessage *voicecall_manager_dial(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct ofono_cdma_voicecall_manager *vc =3D data;
+	const char *number;
+
+	if (vc->pending)
+		return __ofono_error_busy(msg);
+
+	if (vc->status !=3D CDMA_CALL_STATUS_DISCONNECTED)
+		return __ofono_error_failed(msg);
+
+	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &number,
+					DBUS_TYPE_INVALID) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	if (!valid_cdma_phone_number_format(number))
+		return __ofono_error_invalid_format(msg);
+
+	if (vc->driver->dial =3D=3D NULL)
+		return __ofono_error_not_implemented(msg);
+
+	vc->pending =3D dbus_message_ref(msg);
+
+	string_to_cdma_phone_number(number, &vc->phone_number);
+	voicecall_set_call_lineid(vc);
+	vc->direction =3D CALL_DIRECTION_MOBILE_ORIGINATED;
+	voicecall_set_call_status(vc, CDMA_CALL_STATUS_DIALING);
+	vc->driver->dial(vc, &vc->phone_number, manager_dial_callback, vc);
+
+	return NULL;
+}
+
+static DBusMessage *voicecall_manager_hangup(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct ofono_cdma_voicecall_manager *vc =3D data;
+
+	if (vc->pending)
+		return __ofono_error_busy(msg);
+
+	if (vc->driver->hangup =3D=3D NULL)
+		return __ofono_error_not_implemented(msg);
+
+	if (vc->status =3D=3D CDMA_CALL_STATUS_DISCONNECTED)
+		return __ofono_error_failed(msg);
+
+	vc->pending =3D dbus_message_ref(msg);
+
+	vc->driver->hangup(vc, generic_callback, vc);
+
+	return NULL;
+}
+
+static GDBusMethodTable manager_methods[] =3D {
+	{ "GetProperties",    "",    "a{sv}",
+					voicecall_manager_get_properties },
+	{ "Dial",             "ss",  "o",        voicecall_manager_dial,
+						G_DBUS_METHOD_FLAG_ASYNC },
+	{ "Hangup",           "",    "",         voicecall_manager_hangup,
+						G_DBUS_METHOD_FLAG_ASYNC },
+	{ }
+};
+
+static GDBusSignalTable manager_signals[] =3D {
+	{ "PropertyChanged",	"sv" },
+	{ "DisconnectReason",	"s" },
+	{ }
+};
+
+void ofono_cdma_voicecall_manager_disconnected(
+					struct ofono_cdma_voicecall_manager *vc,
+					enum ofono_disconnect_reason reason,
+					const struct ofono_error *error)
+{
+	DBG("Got disconnection event for reason: %d", reason);
+
+	if (reason !=3D OFONO_DISCONNECT_REASON_UNKNOWN)
+		voicecall_emit_disconnect_reason(vc, reason);
+
+	voicecall_set_call_status(vc, CDMA_CALL_STATUS_DISCONNECTED);
+}
+
+static void generic_callback(const struct ofono_error *error, void *data)
+{
+	struct ofono_cdma_voicecall_manager *vc =3D data;
+	DBusMessage *reply;
+
+	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR)
+		reply =3D dbus_message_new_method_return(vc->pending);
+	else
+		reply =3D __ofono_error_failed(vc->pending);
+
+	__ofono_dbus_pending_reply(&vc->pending, reply);
+}
+
+int ofono_cdma_voicecall_manager_driver_register(
+		const struct ofono_cdma_voicecall_manager_driver *d)
+{
+	DBG("driver: %p, name: %s", d, d->name);
+
+	if (d->probe =3D=3D NULL)
+		return -EINVAL;
+
+	g_drivers =3D g_slist_prepend(g_drivers, (void *)d);
+
+	return 0;
+}
+
+void ofono_cdma_voicecall_manager_driver_unregister(
+		const struct ofono_cdma_voicecall_manager_driver *d)
+{
+	DBG("driver: %p, name: %s", d, d->name);
+
+	g_drivers =3D g_slist_remove(g_drivers, (void *)d);
+}
+
+
+static void voicecall_manager_remove(struct ofono_atom *atom)
+{
+	struct ofono_cdma_voicecall_manager *vc =3D __ofono_atom_get_data(atom);
+
+	DBG("atom: %p", atom);
+
+	if (vc =3D=3D NULL)
+		return;
+
+	if (vc->driver && vc->driver->remove)
+		vc->driver->remove(vc);
+
+	g_free(vc);
+}
+
+struct ofono_cdma_voicecall_manager *ofono_cdma_voicecall_manager_create(
+						struct ofono_modem *modem,
+						unsigned int vendor,
+						const char *driver,
+						void *data)
+{
+	struct ofono_cdma_voicecall_manager *vc;
+	GSList *l;
+
+	if (driver =3D=3D NULL)
+		return NULL;
+
+	vc =3D g_try_new0(struct ofono_cdma_voicecall_manager, 1);
+	if (vc =3D=3D NULL)
+		return NULL;
+
+	vc->status =3D CDMA_CALL_STATUS_DISCONNECTED;
+
+	vc->atom =3D __ofono_modem_add_atom(modem,
+			OFONO_ATOM_TYPE_CDMA_VOICECALL_MANAGER,
+			voicecall_manager_remove, vc);
+
+	for (l =3D g_drivers; l; l =3D l->next) {
+		const struct ofono_cdma_voicecall_manager_driver *drv =3D l->data;
+
+		if (g_strcmp0(drv->name, driver))
+			continue;
+
+		if (drv->probe(vc, vendor, data) < 0)
+			continue;
+
+		vc->driver =3D drv;
+		break;
+	}
+
+	return vc;
+}
+
+void ofono_cdma_voicecall_manager_register(
+				struct ofono_cdma_voicecall_manager *vc)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(vc->atom);
+	const char *path =3D __ofono_atom_get_path(vc->atom);
+
+	if (!g_dbus_register_interface(conn, path,
+					OFONO_CDMA_VOICECALL_MANAGER_INTERFACE,
+					manager_methods, manager_signals, NULL,
+					vc, NULL)) {
+		ofono_error("Could not create %s interface",
+				OFONO_CDMA_VOICECALL_MANAGER_INTERFACE);
+		return;
+	}
+
+	ofono_modem_add_interface(modem,
+			OFONO_CDMA_VOICECALL_MANAGER_INTERFACE);
+}
+
+void ofono_cdma_voicecall_manager_remove(
+			struct ofono_cdma_voicecall_manager *vc)
+{
+	__ofono_atom_free(vc->atom);
+}
+
+void ofono_cdma_voicecall_manager_set_data(
+			struct ofono_cdma_voicecall_manager *vc, void *data)
+{
+	vc->driver_data =3D data;
+}
+
+void *ofono_cdma_voicecall_manager_get_data(
+			struct ofono_cdma_voicecall_manager *vc)
+{
+	return vc->driver_data;
+}
diff --git a/src/common.c b/src/common.c
index 5154b8d..7aa63ce 100644
--- a/src/common.c
+++ b/src/common.c
@@ -262,6 +262,31 @@ gboolean valid_phone_number_format(const char *number)
 	return TRUE;
 }
 =

+gboolean valid_cdma_phone_number_format(const char *number)
+{
+	int len =3D strlen(number);
+	int begin =3D 0;
+	int i;
+
+	if (!len)
+		return FALSE;
+
+	if ((len - begin) > OFONO_MAX_CDMA_PHONE_NUMBER_LENGTH)
+		return FALSE;
+
+	for (i =3D begin; i < len; i++) {
+		if (number[i] >=3D '0' && number[i] <=3D '9')
+			continue;
+
+		if (number[i] =3D=3D '*' || number[i] =3D=3D '#')
+			continue;
+
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
 const char *telephony_error_to_str(const struct ofono_error *error)
 {
 	struct error_entry *e;
@@ -405,6 +430,23 @@ void string_to_phone_number(const char *str, struct of=
ono_phone_number *ph)
 	}
 }
 =

+const char *cdma_phone_number_to_string(
+			const struct ofono_cdma_phone_number *ph)
+{
+	static char buffer[OFONO_MAX_CDMA_PHONE_NUMBER_LENGTH + 1];
+
+	strncpy(buffer, ph->number, OFONO_MAX_CDMA_PHONE_NUMBER_LENGTH);
+	buffer[OFONO_MAX_CDMA_PHONE_NUMBER_LENGTH] =3D '\0';
+
+	return buffer;
+}
+
+void string_to_cdma_phone_number(const char *str,
+			struct ofono_cdma_phone_number *ph)
+{
+	strcpy(ph->number, str);
+}
+
 gboolean valid_ussd_string(const char *str, gboolean call_in_progress)
 {
 	int len =3D strlen(str);
diff --git a/src/common.h b/src/common.h
index 8b5798a..df0adcd 100644
--- a/src/common.h
+++ b/src/common.h
@@ -59,6 +59,14 @@ enum call_status {
 	CALL_STATUS_DISCONNECTED
 };
 =

+enum cdma_call_status {
+	CDMA_CALL_STATUS_ACTIVE =3D 0,
+	CDMA_CALL_STATUS_DIALING =3D 1,
+	CDMA_CALL_STATUS_ALERTING =3D 2,
+	CDMA_CALL_STATUS_INCOMING =3D 4,
+	CDMA_CALL_STATUS_DISCONNECTED
+};
+
 /* 27.007 Section 7.18 */
 enum call_direction {
 	CALL_DIRECTION_MOBILE_ORIGINATED =3D 0,
@@ -128,6 +136,12 @@ gboolean valid_phone_number_format(const char *number);
 const char *phone_number_to_string(const struct ofono_phone_number *ph);
 void string_to_phone_number(const char *str, struct ofono_phone_number *ph=
);
 =

+gboolean valid_cdma_phone_number_format(const char *number);
+const char *cdma_phone_number_to_string(
+				const struct ofono_cdma_phone_number *ph);
+void string_to_cdma_phone_number(const char *str,
+				struct ofono_cdma_phone_number *ph);
+
 int mmi_service_code_to_bearer_class(int code);
 =

 gboolean valid_ussd_string(const char *str, gboolean call_in_progress);
diff --git a/src/ofono.h b/src/ofono.h
index 792134b..cab70cd 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -126,6 +126,7 @@ enum ofono_atom_type {
 	OFONO_ATOM_TYPE_STK =3D 20,
 	OFONO_ATOM_TYPE_NETTIME =3D 21,
 	OFONO_ATOM_TYPE_CTM =3D 22,
+	OFONO_ATOM_TYPE_CDMA_VOICECALL_MANAGER =3D 23,
 };
 =

 enum ofono_atom_watch_condition {
@@ -415,3 +416,5 @@ void __ofono_nettime_probe_drivers(struct ofono_modem *=
modem);
 =

 void __ofono_nettime_info_received(struct ofono_modem *modem,
 					struct ofono_network_time *info);
+
+#include <ofono/cdma-voicecall.h>
-- =

1.7.0.4


--===============2513511234419291491==--

