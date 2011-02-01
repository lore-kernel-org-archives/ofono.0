Content-Type: multipart/mixed; boundary="===============5004069326039400147=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: [RFC 1/2] plugins: Add basic support for history agent interface
Date: Tue, 01 Feb 2011 18:28:59 +0100
Message-ID: <1296581340-21570-1-git-send-email-marcel@holtmann.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5004069326039400147==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/history-agent.c |  509 +++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 509 insertions(+), 0 deletions(-)
 create mode 100644 plugins/history-agent.c

diff --git a/plugins/history-agent.c b/plugins/history-agent.c
new file mode 100644
index 0000000..42298c1
--- /dev/null
+++ b/plugins/history-agent.c
@@ -0,0 +1,509 @@
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
+#include <string.h>
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
+
+#define HISTORY_INTERFACE "org.ofono.History"
+#define AGENT_INTERFACE "org.ofono.HistoryAgent"
+
+struct history_agent {
+	DBusConnection *conn;
+	const char *path;
+	char *agent_path;
+	char *agent_owner;
+	guint agent_watch;
+};
+
+struct agent_request {
+	struct history_agent *history;
+	DBusMessage *msg;
+	DBusMessageIter iter;
+	DBusPendingCall *call;
+};
+
+static struct agent_request *agent_request_new(struct history_agent *histo=
ry,
+							const char *method)
+{
+	struct agent_request *req;
+
+	DBG("owner: %s", history->agent_owner);
+
+	if (history->agent_owner =3D=3D NULL || history->agent_path =3D=3D NULL)
+		return NULL;
+
+	req =3D g_try_new0(struct agent_request, 1);
+	if (req =3D=3D NULL)
+		return NULL;
+
+	req->history =3D history;
+
+	req->msg =3D dbus_message_new_method_call(history->agent_owner,
+						history->agent_path,
+						AGENT_INTERFACE, method);
+	if (req->msg =3D=3D NULL) {
+		g_free(req);
+		return NULL;
+	}
+
+	dbus_message_iter_init_append(req->msg, &req->iter);
+
+	return req;
+}
+
+static void agent_request_free(struct agent_request *req)
+{
+	dbus_pending_call_unref(req->call);
+
+	dbus_message_unref(req->msg);
+
+	g_free(req);
+}
+
+static void agent_request_reply_cb(DBusPendingCall *call, void *data)
+{
+	struct agent_request *req =3D data;
+	DBusMessage *reply =3D dbus_pending_call_steal_reply(call);
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, reply) =3D=3D TRUE) {
+		ofono_error("Agent method failed: %s", error.name);
+		dbus_error_free(&error);
+	}
+
+	dbus_message_unref(reply);
+
+	agent_request_free(req);
+}
+
+static void agent_request_dispatch(struct agent_request *req)
+{
+	struct history_agent *history =3D req->history;
+
+	if (dbus_connection_send_with_reply(history->conn, req->msg,
+						&req->call, -1) =3D=3D FALSE) {
+		ofono_error("Sending D-Bus method failed");
+		return;
+	}
+
+	dbus_pending_call_set_notify(req->call, agent_request_reply_cb,
+								req, NULL);
+}
+
+static void free_agent_data(struct history_agent *history)
+{
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
+	sender =3D dbus_message_get_sender(msg);
+
+	history->agent_path =3D g_strdup(path);
+	history->agent_owner =3D g_strdup(sender);
+
+	history->agent_watch =3D g_dbus_add_disconnect_watch(history->conn,
+						sender, agent_disconnect_cb,
+						history, NULL);
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
+	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+						DBUS_TYPE_INVALID) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	sender =3D dbus_message_get_sender(msg);
+
+	if (history->agent_owner =3D=3D NULL)
+		return __ofono_error_failed(msg);
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
+static int history_probe(struct ofono_history_context *context)
+{
+	struct history_agent *history;
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
+	if (g_dbus_register_interface(history->conn, history->path,
+					HISTORY_INTERFACE, history_methods,
+					NULL, NULL, history, NULL) =3D=3D FALSE) {
+		ofono_error("Could not create %s interface",
+						HISTORY_INTERFACE);
+		g_free(history);
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
+}
+
+static void history_call_ended(struct ofono_history_context *context,
+					const struct ofono_call *call,
+					time_t start, time_t end)
+{
+	struct history_agent *history =3D context->data;
+	struct agent_request *req;
+	DBusMessageIter dict;
+	char buf[29];
+	const char *str;
+
+	req =3D agent_request_new(history, "CallEnded");
+	if (req =3D=3D NULL)
+		return;
+
+	dbus_message_iter_open_container(&req->iter, DBUS_TYPE_ARRAY,
+				OFONO_PROPERTIES_ARRAY_SIGNATURE, &dict);
+
+	str =3D call->direction =3D=3D 0 ? "outgoing" : "incoming";
+	ofono_dbus_dict_append(&dict, "Direction", DBUS_TYPE_STRING, &str);
+
+	if (call->clip_validity =3D=3D 0) {
+		str =3D phone_number_to_string(&call->phone_number);
+		ofono_dbus_dict_append(&dict, "Number",
+						DBUS_TYPE_STRING, &str);
+	}
+
+	if (call->cnap_validity =3D=3D 0) {
+		str =3D call->name;
+		ofono_dbus_dict_append(&dict, "Name",
+						DBUS_TYPE_STRING, &str);
+	}
+
+	strftime(buf, 28, "%Y-%m-%dT%H:%M:%S%z", localtime(&start));
+	buf[28] =3D '\0';
+
+	str =3D buf;
+	ofono_dbus_dict_append(&dict, "StartTime", DBUS_TYPE_STRING, &str);
+
+	strftime(buf, 28, "%Y-%m-%dT%H:%M:%S%z", localtime(&end));
+	buf[28] =3D '\0';
+
+	str =3D buf;
+	ofono_dbus_dict_append(&dict, "EndTime", DBUS_TYPE_STRING, &str);
+
+	dbus_message_iter_close_container(&req->iter, &dict);
+
+	agent_request_dispatch(req);
+}
+
+static void history_call_missed(struct ofono_history_context *context,
+					const struct ofono_call *call,
+					time_t when)
+{
+	struct history_agent *history =3D context->data;
+	struct agent_request *req;
+	DBusMessageIter dict;
+	char buf[29];
+	const char *str;
+
+	req =3D agent_request_new(history, "CallMissed");
+	if (req =3D=3D NULL)
+		return;
+
+	dbus_message_iter_open_container(&req->iter, DBUS_TYPE_ARRAY,
+				OFONO_PROPERTIES_ARRAY_SIGNATURE, &dict);
+
+	if (call->clip_validity =3D=3D 0) {
+		str =3D phone_number_to_string(&call->phone_number);
+		ofono_dbus_dict_append(&dict, "Number",
+						DBUS_TYPE_STRING, &str);
+	}
+
+	if (call->cnap_validity =3D=3D 0) {
+		str =3D call->name;
+		ofono_dbus_dict_append(&dict, "Name",
+						DBUS_TYPE_STRING, &str);
+	}
+
+	strftime(buf, 28, "%Y-%m-%dT%H:%M:%S%z", localtime(&when));
+	buf[28] =3D '\0';
+
+	str =3D buf;
+	ofono_dbus_dict_append(&dict, "LocalTime", DBUS_TYPE_STRING, &str);
+
+	dbus_message_iter_close_container(&req->iter, &dict);
+
+	agent_request_dispatch(req);
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
+	struct agent_request *req;
+	DBusMessageIter dict;
+	char buf[29];
+	const char *str;
+
+	req =3D agent_request_new(history, "MessageReceived");
+	if (req =3D=3D NULL)
+		return;
+
+	dbus_message_iter_open_container(&req->iter, DBUS_TYPE_ARRAY,
+				OFONO_PROPERTIES_ARRAY_SIGNATURE, &dict);
+
+	str =3D ofono_uuid_to_str(uuid);
+	ofono_dbus_dict_append(&dict, "Identifier", DBUS_TYPE_STRING, &str);
+
+	ofono_dbus_dict_append(&dict, "Sender", DBUS_TYPE_STRING, &from);
+
+	ofono_dbus_dict_append(&dict, "Text", DBUS_TYPE_STRING, &text);
+
+	strftime(buf, 28, "%Y-%m-%dT%H:%M:%S%z", remote);
+	buf[28] =3D '\0';
+
+	str =3D buf;
+	ofono_dbus_dict_append(&dict, "RemoteTime", DBUS_TYPE_STRING, &str);
+
+	strftime(buf, 28, "%Y-%m-%dT%H:%M:%S%z", local);
+	buf[28] =3D '\0';
+
+	str =3D buf;
+	ofono_dbus_dict_append(&dict, "LocalTime", DBUS_TYPE_STRING, &str);
+
+	dbus_message_iter_close_container(&req->iter, &dict);
+
+	agent_request_dispatch(req);
+}
+
+static void history_sms_send_pending(struct ofono_history_context *context,
+						const struct ofono_uuid *uuid,
+						const char *to, time_t when,
+						const char *text)
+{
+	struct history_agent *history =3D context->data;
+	struct agent_request *req;
+	DBusMessageIter dict;
+	char buf[29];
+	const char *str;
+
+	req =3D agent_request_new(history, "MessageSubmitted");
+	if (req =3D=3D NULL)
+		return;
+
+	dbus_message_iter_open_container(&req->iter, DBUS_TYPE_ARRAY,
+				OFONO_PROPERTIES_ARRAY_SIGNATURE, &dict);
+
+	str =3D ofono_uuid_to_str(uuid);
+	ofono_dbus_dict_append(&dict, "Identifier", DBUS_TYPE_STRING, &str);
+
+	ofono_dbus_dict_append(&dict, "Receiver", DBUS_TYPE_STRING, &to);
+
+	ofono_dbus_dict_append(&dict, "Text", DBUS_TYPE_STRING, &text);
+
+	strftime(buf, 28, "%Y-%m-%dT%H:%M:%S%z", localtime(&when));
+	buf[28] =3D '\0';
+
+	str =3D buf;
+	ofono_dbus_dict_append(&dict, "LocalTime", DBUS_TYPE_STRING, &str);
+
+	dbus_message_iter_close_container(&req->iter, &dict);
+
+	agent_request_dispatch(req);
+}
+
+static void history_sms_send_status(struct ofono_history_context *context,
+				const struct ofono_uuid *uuid, time_t when,
+				enum ofono_history_sms_status status)
+{
+	struct history_agent *history =3D context->data;
+	struct agent_request *req;
+	DBusMessageIter dict;
+	char buf[29];
+	const char *str;
+
+	req =3D agent_request_new(history, "MessageStatus");
+	if (req =3D=3D NULL)
+		return;
+
+	dbus_message_iter_open_container(&req->iter, DBUS_TYPE_ARRAY,
+				OFONO_PROPERTIES_ARRAY_SIGNATURE, &dict);
+
+	str =3D ofono_uuid_to_str(uuid);
+	ofono_dbus_dict_append(&dict, "Identifier", DBUS_TYPE_STRING, &str);
+
+	switch (status) {
+	case OFONO_HISTORY_SMS_STATUS_PENDING:
+		str =3D "pending";
+		break;
+	case OFONO_HISTORY_SMS_STATUS_SUBMITTED:
+		str =3D "submitted";
+		break;
+	case OFONO_HISTORY_SMS_STATUS_SUBMIT_FAILED:
+		str =3D "submit-failed";
+		break;
+	case OFONO_HISTORY_SMS_STATUS_DELIVERED:
+		str =3D "delivered";
+		break;
+	case OFONO_HISTORY_SMS_STATUS_DELIVER_FAILED:
+		str =3D "deliver-failed";
+		break;
+	}
+
+	ofono_dbus_dict_append(&dict, "Status", DBUS_TYPE_STRING, &str);
+
+	strftime(buf, 28, "%Y-%m-%dT%H:%M:%S%z", localtime(&when));
+	buf[28] =3D '\0';
+
+	str =3D buf;
+	ofono_dbus_dict_append(&dict, "LocalTime", DBUS_TYPE_STRING, &str);
+
+	dbus_message_iter_close_container(&req->iter, &dict);
+
+	agent_request_dispatch(req);
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

1.7.3.5


--===============5004069326039400147==--

