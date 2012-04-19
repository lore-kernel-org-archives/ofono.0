Content-Type: multipart/mixed; boundary="===============1860894668959775015=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCH 2/7] modules: Add support for history agent interface
Date: Thu, 19 Apr 2012 11:20:51 +0300
Message-ID: <1334823656-3366-3-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1334823656-3366-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1860894668959775015==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Marcel Holtmann <marcel@holtmann.org>

---
 plugins/history-agent.c |  686 +++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 686 insertions(+), 0 deletions(-)
 create mode 100644 plugins/history-agent.c

diff --git a/plugins/history-agent.c b/plugins/history-agent.c
new file mode 100644
index 0000000..6979195
--- /dev/null
+++ b/plugins/history-agent.c
@@ -0,0 +1,686 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+#include <errno.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+#include <glib.h>
+#include <gdbus.h>
+#include <ofono.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/dbus.h>
+#include "common.h"
+#include "storage.h"
+
+#define HISTORY_SPOOL_MODE 0600
+#define HISTORY_SPOOL_BASE STORAGEDIR "/%s/history"
+#define HISTORY_SPOOL_PATH HISTORY_SPOOL_BASE "/%08x"
+
+#define HISTORY_INTERFACE "org.ofono.History"
+#define AGENT_INTERFACE "org.ofono.HistoryAgent"
+
+struct history_agent {
+	DBusConnection *conn;
+	const char *path;
+	char *imsi;
+
+	char *agent_path;
+	char *agent_owner;
+	guint agent_watch;
+
+	GQueue *queue;
+	guint32 next_idx;
+	guint32 current_idx;
+	DBusPendingCall *agent_call;
+};
+
+static void process_queue(struct history_agent *history);
+
+static void agent_reply_cb(DBusPendingCall *call, void *data)
+{
+	struct history_agent *history =3D data;
+	DBusMessage *reply =3D dbus_pending_call_steal_reply(call);
+	DBusError error;
+	char *path;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, reply) =3D=3D TRUE) {
+		ofono_error("Agent method failed: %s", error.name);
+		dbus_error_free(&error);
+		goto done;
+	}
+
+	DBG("index: %08x", history->current_idx);
+
+	path =3D g_strdup_printf(HISTORY_SPOOL_PATH, history->imsi,
+						history->current_idx);
+	unlink(path);
+	g_free(path);
+
+done:
+	dbus_message_unref(reply);
+
+	history->agent_call =3D NULL;
+
+	process_queue(history);
+}
+
+static const char *buffer_next(const unsigned char **buffer, size_t *size)
+{
+	const void *ptr =3D *buffer;
+	guint32 len;
+
+	if (*size < 5)
+		return NULL;
+
+	len =3D *((guint32 *) ptr);
+	if (len =3D=3D 0)
+		return NULL;
+
+	if (len + 4 > *size)
+		return NULL;
+
+	*size -=3D len + 4;
+	*buffer +=3D len + 4;
+
+	return ptr + 4;
+}
+
+static void process_history(struct history_agent *history,
+				const unsigned char *buffer, size_t size)
+{
+	const unsigned char *ptr =3D buffer;
+	size_t len =3D size;
+	DBusMessage *msg;
+	DBusMessageIter iter, dict;
+	const char *method;
+
+	method =3D buffer_next(&ptr, &len);
+	if (method =3D=3D NULL)
+		return;
+
+	DBG("method: %s", method);
+
+	msg =3D dbus_message_new_method_call(history->agent_owner,
+						history->agent_path,
+						AGENT_INTERFACE, method);
+	if (msg =3D=3D NULL)
+		return;
+
+	dbus_message_iter_init_append(msg, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+				OFONO_PROPERTIES_ARRAY_SIGNATURE, &dict);
+
+	while (1) {
+		const char *key, *val;
+
+		key =3D buffer_next(&ptr, &len);
+		if (key =3D=3D NULL)
+			break;
+
+		val =3D buffer_next(&ptr, &len);
+		if (val =3D=3D NULL)
+			break;
+
+		ofono_dbus_dict_append(&dict, key, DBUS_TYPE_STRING, &val);
+        }
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	if (dbus_connection_send_with_reply(history->conn, msg,
+					&history->agent_call, -1) =3D=3D FALSE) {
+		ofono_error("Sending D-Bus method failed");
+		goto done;
+	}
+
+	dbus_pending_call_set_notify(history->agent_call, agent_reply_cb,
+							history, NULL);
+
+	dbus_pending_call_unref(history->agent_call);
+
+done:
+	dbus_message_unref(msg);
+}
+
+static void process_queue(struct history_agent *history)
+{
+	int fd;
+	struct stat st;
+	unsigned char *addr;
+	char *path;
+	gpointer head;
+
+	DBG("owner: %s", history->agent_owner);
+
+	if (history->agent_owner =3D=3D NULL)
+		return;
+
+	if (history->agent_call !=3D NULL)
+		return;
+
+	head =3D g_queue_pop_head(history->queue);
+	if (head =3D=3D NULL) {
+		history->next_idx =3D 0;
+		return;
+	}
+
+	history->current_idx =3D GPOINTER_TO_UINT(head);
+
+	DBG("index: %08x", history->current_idx);
+
+	path =3D g_strdup_printf(HISTORY_SPOOL_PATH, history->imsi,
+						history->current_idx);
+	fd =3D TFR(open(path, O_RDONLY));
+	g_free(path);
+
+	if (fd < 0) {
+		ofono_error("Failed to open history index %08x",
+						history->current_idx);
+		return;
+	}
+
+	if (TFR(fstat(fd, &st)) < 0)
+		goto done;
+
+	addr =3D mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (addr =3D=3D MAP_FAILED)
+		goto done;
+
+	process_history(history, addr, st.st_size);
+
+	munmap(addr, st.st_size);
+
+done:
+	TFR(close(fd));
+}
+
+static gint compare_index(gconstpointer a, gconstpointer b,
+						gpointer user_data)
+{
+	guint32 one =3D GPOINTER_TO_UINT@;
+	guint32 two =3D GPOINTER_TO_UINT(b);
+
+	return one - two;
+}
+
+static void process_spool(struct history_agent *history)
+{
+	GDir *dir;
+	char *path;
+	gpointer tail;
+
+	path =3D g_strdup_printf(HISTORY_SPOOL_BASE, history->imsi);
+
+	DBG("path: %s", path);
+
+	dir =3D g_dir_open(path, 0, NULL);
+
+	g_free(path);
+
+	if (dir =3D=3D NULL)
+		return;
+
+	while (1) {
+		const char *path;
+		guint32 idx;
+
+		path =3D g_dir_read_name(dir);
+		if (path =3D=3D NULL)
+			break;
+
+		idx =3D strtol(path, NULL, 16);
+		if (errno =3D=3D ERANGE || errno =3D=3D EINVAL)
+			continue;
+
+		DBG("index: %08x", idx);
+
+		g_queue_insert_sorted(history->queue, GUINT_TO_POINTER(idx),
+							compare_index, NULL);
+	}
+
+	g_dir_close(dir);
+
+	tail =3D g_queue_peek_tail(history->queue);
+	if (tail =3D=3D NULL)
+		return;
+
+	history->next_idx =3D GPOINTER_TO_UINT(tail);
+}
+
+static void array_append(GByteArray *array, const char *str)
+{
+	guint32 len;
+
+	if (str =3D=3D NULL) {
+		len =3D 0;
+		g_byte_array_append(array, (guint8 *) &len, 4);
+	} else {
+		len =3D strlen(str) + 1;
+		g_byte_array_append(array, (guint8 *) &len, 4);
+		g_byte_array_append(array, (guint8 *) str, len);
+	}
+}
+
+static void create_history(struct history_agent *history,
+					const char *method, ...)
+{
+	GByteArray *array;
+	va_list args;
+
+	DBG("method: %s", method);
+
+	array =3D g_byte_array_sized_new(128);
+	if (array =3D=3D NULL)
+		return;
+
+	array_append(array, method);
+
+	va_start(args, method);
+
+	while (1) {
+		const char *key, *val;
+
+		key =3D va_arg(args, const char *);
+		if (key =3D=3D NULL)
+			break;
+
+		array_append(array, key);
+
+		val =3D va_arg(args, const char *);
+
+		array_append(array, val);
+	}
+
+	va_end(args);
+
+	array_append(array, NULL);
+
+	history->next_idx++;
+
+	DBG("index: %08x", history->next_idx);
+
+	write_file(array->data, array->len, HISTORY_SPOOL_MODE,
+			HISTORY_SPOOL_PATH, history->imsi, history->next_idx);
+
+	g_byte_array_free(array, TRUE);
+
+	g_queue_push_tail(history->queue, GUINT_TO_POINTER(history->next_idx));
+
+	process_queue(history);
+}
+
+static void free_agent_data(struct history_agent *history)
+{
+	if (history->agent_call !=3D NULL) {
+		dbus_pending_call_cancel(history->agent_call);
+		history->agent_call =3D NULL;
+	}
+
+	g_free(history->agent_path);
+	history->agent_path =3D NULL;
+
+	g_free(history->agent_owner);
+	history->agent_owner =3D NULL;
+}
+
+static void agent_disconnect_cb(DBusConnection *conn, void *data)
+{
+	struct history_agent *history =3D data;
+
+	history->agent_watch =3D 0;
+
+	free_agent_data(history);
+}
+
+static DBusMessage *register_agent(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct history_agent *history =3D data;
+	const char *path, *sender;
+
+	sender =3D dbus_message_get_sender(msg);
+
+	DBG("sender: %s", sender);
+
+	if (history->agent_owner !=3D NULL)
+		return __ofono_error_busy(msg);
+
+	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+						DBUS_TYPE_INVALID) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	if (!__ofono_dbus_valid_object_path(path))
+		return __ofono_error_invalid_format(msg);
+
+	history->agent_path =3D g_strdup(path);
+	history->agent_owner =3D g_strdup(sender);
+
+	history->agent_watch =3D g_dbus_add_disconnect_watch(history->conn,
+						sender, agent_disconnect_cb,
+						history, NULL);
+
+	process_queue(history);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *unregister_agent(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct history_agent *history =3D data;
+	const char *path, *sender;
+
+	sender =3D dbus_message_get_sender(msg);
+
+	DBG("sender: %s", sender);
+
+	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+						DBUS_TYPE_INVALID) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	if (history->agent_owner =3D=3D NULL)
+		return __ofono_error_not_available(msg);
+
+	if (g_str_equal(sender, history->agent_owner) =3D=3D FALSE)
+		return __ofono_error_access_denied(msg);
+
+	g_dbus_remove_watch(history->conn, history->agent_watch);
+	history->agent_watch =3D 0;
+
+	free_agent_data(history);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static GDBusMethodTable history_methods[] =3D {
+	{ "RegisterAgent",   "o", "",  register_agent   },
+	{ "UnregisterAgent", "o", "",  unregister_agent },
+	{ }
+};
+
+static void send_release(struct history_agent *history)
+{
+	DBusMessage *msg;
+
+	msg =3D dbus_message_new_method_call(history->agent_owner,
+						history->agent_path,
+						AGENT_INTERFACE, "Release");
+	if (msg =3D=3D NULL)
+		return;
+
+	dbus_message_set_no_reply(msg, TRUE);
+
+	g_dbus_send_message(history->conn, msg);
+}
+
+static void free_history(struct history_agent *history)
+{
+	g_queue_free(history->queue);
+
+	g_free(history->imsi);
+	g_free(history);
+}
+
+static int history_probe(struct ofono_history_context *context)
+{
+	struct history_agent *history;
+	struct ofono_atom *atom;
+	struct ofono_sim *sim;
+
+	DBG("modem: %p", context->modem);
+
+	history =3D g_try_new0(struct history_agent, 1);
+	if (history =3D=3D NULL)
+		return -ENOMEM;
+
+	history->conn =3D ofono_dbus_get_connection();
+	history->path =3D ofono_modem_get_path(context->modem);
+
+	atom =3D __ofono_modem_find_atom(context->modem, OFONO_ATOM_TYPE_SIM);
+	sim =3D __ofono_atom_get_data(atom);
+
+	history->imsi =3D g_strdup(ofono_sim_get_imsi(sim));
+
+	DBG("imsi: %s", history->imsi);
+
+	history->queue =3D g_queue_new();
+
+	process_spool(history);
+
+	if (g_dbus_register_interface(history->conn, history->path,
+					HISTORY_INTERFACE, history_methods,
+					NULL, NULL, history, NULL) =3D=3D FALSE) {
+		ofono_error("Could not create %s interface",
+						HISTORY_INTERFACE);
+		free_history(history);
+		return -EIO;
+	}
+
+	ofono_modem_add_interface(context->modem, HISTORY_INTERFACE);
+
+	context->data =3D history;
+
+	return 0;
+}
+
+static void history_remove(struct ofono_history_context *context)
+{
+	struct history_agent *history =3D context->data;
+
+	DBG("modem: %p", context->modem);
+
+	ofono_modem_remove_interface(context->modem, HISTORY_INTERFACE);
+
+	if (history->agent_watch > 0) {
+		g_dbus_remove_watch(history->conn, history->agent_watch);
+
+		send_release(history);
+	}
+
+	free_agent_data(history);
+
+	g_dbus_unregister_interface(history->conn, history->path,
+						HISTORY_INTERFACE);
+
+	free_history(history);
+}
+
+static void history_call_ended(struct ofono_history_context *context,
+					const struct ofono_call *call,
+					time_t start, time_t end)
+{
+	struct history_agent *history =3D context->data;
+	char stime_str[29], etime_str[29];
+	const char *number_str, *name_str, *dir_str;
+
+	strftime(stime_str, 28, "%Y-%m-%dT%H:%M:%S%z", localtime(&start));
+	stime_str[28] =3D '\0';
+
+	strftime(etime_str, 28, "%Y-%m-%dT%H:%M:%S%z", localtime(&end));
+	etime_str[28] =3D '\0';
+
+	dir_str =3D call->direction =3D=3D 0 ? "outgoing" : "incoming";
+
+	if (call->clip_validity =3D=3D 0)
+		number_str =3D phone_number_to_string(&call->phone_number);
+	else
+		number_str =3D "";
+
+	if (call->cnap_validity =3D=3D 0)
+		name_str =3D call->name;
+	else
+		name_str =3D "";
+
+	create_history(history, "CallEnded", "Number", number_str,
+						"Name", name_str,
+						"Direction", dir_str,
+						"StartTime", stime_str,
+						"EndTime", etime_str, NULL);
+}
+
+static void history_call_missed(struct ofono_history_context *context,
+					const struct ofono_call *call,
+					time_t when)
+{
+	struct history_agent *history =3D context->data;
+	char time_str[29];
+	const char *number_str, *name_str;
+
+	strftime(time_str, 28, "%Y-%m-%dT%H:%M:%S%z", localtime(&when));
+	time_str[28] =3D '\0';
+
+	if (call->clip_validity =3D=3D 0)
+		number_str =3D phone_number_to_string(&call->phone_number);
+	else
+		number_str =3D "";
+
+	if (call->cnap_validity =3D=3D 0)
+		name_str =3D call->name;
+	else
+		name_str =3D "";
+
+	create_history(history, "CallMissed", "Number", number_str,
+						"Name", name_str,
+						"LocalTime", time_str, NULL);
+}
+
+static void history_sms_received(struct ofono_history_context *context,
+						const struct ofono_uuid *uuid,
+						const char *from,
+						const struct tm *remote,
+						const struct tm *local,
+						const char *text)
+{
+	struct history_agent *history =3D context->data;
+	char ltime_str[29], rtime_str[29];
+	const char *uuid_str;
+
+	strftime(rtime_str, 28, "%Y-%m-%dT%H:%M:%S%z", remote);
+	rtime_str[28] =3D '\0';
+
+	strftime(ltime_str, 28, "%Y-%m-%dT%H:%M:%S%z", local);
+	ltime_str[28] =3D '\0';
+
+	uuid_str =3D ofono_uuid_to_str(uuid);
+
+	create_history(history, "MessageReceived", "Identifier", uuid_str,
+						"Sender", from,
+						"Text", text,
+						"RemoteTime", rtime_str,
+						"LocalTime", ltime_str, NULL);
+}
+
+static void history_sms_send_pending(struct ofono_history_context *context,
+						const struct ofono_uuid *uuid,
+						const char *to, time_t when,
+						const char *text)
+{
+	struct history_agent *history =3D context->data;
+	char time_str[29];
+	const char *uuid_str;
+
+	strftime(time_str, 28, "%Y-%m-%dT%H:%M:%S%z", localtime(&when));
+	time_str[28] =3D '\0';
+
+	uuid_str =3D ofono_uuid_to_str(uuid);
+
+	create_history(history, "MessageSubmitted", "Identifier", uuid_str,
+						"Receiver", to,
+						"Text", text,
+						"LocalTime", time_str, NULL);
+}
+
+static void history_sms_send_status(struct ofono_history_context *context,
+				const struct ofono_uuid *uuid, time_t when,
+				enum ofono_history_sms_status status)
+{
+	struct history_agent *history =3D context->data;
+	char time_str[29];
+	const char *uuid_str, *status_str =3D NULL;
+
+	switch (status) {
+	case OFONO_HISTORY_SMS_STATUS_PENDING:
+		status_str =3D "pending";
+		break;
+	case OFONO_HISTORY_SMS_STATUS_SUBMITTED:
+		status_str =3D "submitted";
+		break;
+	case OFONO_HISTORY_SMS_STATUS_SUBMIT_FAILED:
+		status_str =3D "submit-failed";
+		break;
+	case OFONO_HISTORY_SMS_STATUS_DELIVERED:
+		status_str =3D "delivered";
+		break;
+	case OFONO_HISTORY_SMS_STATUS_DELIVER_FAILED:
+		status_str =3D "deliver-failed";
+		break;
+	}
+
+	if (status_str =3D=3D NULL)
+		return;
+
+	strftime(time_str, 28, "%Y-%m-%dT%H:%M:%S%z", localtime(&when));
+	time_str[28] =3D '\0';
+
+	uuid_str =3D ofono_uuid_to_str(uuid);
+
+	create_history(history, "MessageStatus", "Identifier", uuid_str,
+						"Status", status_str,
+						"LocalTime", time_str, NULL);
+}
+
+static struct ofono_history_driver history_driver =3D {
+	.name			=3D "History Agent",
+	.probe			=3D history_probe,
+	.remove			=3D history_remove,
+	.call_ended		=3D history_call_ended,
+	.call_missed		=3D history_call_missed,
+	.sms_received		=3D history_sms_received,
+	.sms_send_pending	=3D history_sms_send_pending,
+	.sms_send_status	=3D history_sms_send_status,
+};
+
+static int history_agent_init(void)
+{
+	return ofono_history_driver_register(&history_driver);
+}
+
+static void history_agent_exit(void)
+{
+	ofono_history_driver_unregister(&history_driver);
+}
+
+OFONO_PLUGIN_DEFINE(history_agent, "History Agent Plugin",
+				VERSION, OFONO_PLUGIN_PRIORITY_DEFAULT,
+				history_agent_init, history_agent_exit)
-- =

1.7.5.4


--===============1860894668959775015==--

