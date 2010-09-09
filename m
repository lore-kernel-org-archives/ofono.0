Content-Type: multipart/mixed; boundary="===============9065220133731938313=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCHv2 3/6] Add message agent implementation
Date: Thu, 09 Sep 2010 12:52:53 +0300
Message-ID: <1284025976-13294-4-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1284025976-13294-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9065220133731938313==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/smsagent.c |  416 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/smsagent.h |   66 +++++++++
 2 files changed, 482 insertions(+), 0 deletions(-)
 create mode 100644 src/smsagent.c
 create mode 100644 src/smsagent.h

diff --git a/src/smsagent.c b/src/smsagent.c
new file mode 100644
index 0000000..bd99fa0
--- /dev/null
+++ b/src/smsagent.c
@@ -0,0 +1,416 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2009-2010 Nokia Corporation and/or its subsidiary(-ies).
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
+#define _GNU_SOURCE
+#include <stdint.h>
+#include <string.h>
+#include <errno.h>
+
+#include <glib.h>
+#include <gdbus.h>
+
+#include "ofono.h"
+
+#include "common.h"
+#include "smsagent.h"
+
+enum sms_agent_port {
+	SMS_AGENT_PORT_WAP_PUSH =3D 2948,
+	SMS_AGENT_PORT_WAP_PUSH_S =3D 2949,	/* Secure push?? */
+	SMS_AGENT_PORT_VCARD =3D 9204,
+	SMS_AGENT_PORT_VCAL =3D 9205,
+	SMS_AGENT_PORT_VCARD_S =3D 9206,		/* vCard secure?? */
+	SMS_AGENT_PORT_VCAL_S =3D 9207,		/* vCal secure?? */
+};
+
+struct sms_agent {
+	char *path;
+	char *name;
+	enum sms_agent_type type;
+	guint disconnect_watch;
+	sms_agent_remove_cb remove_cb;
+	void *remove_data;
+	GSList *reqs;
+};
+
+struct sms_agent_request {
+	struct sms_agent *agent;
+	DBusMessage *msg;
+	DBusPendingCall *call;
+	sms_agent_dispatch_cb dispatch_cb;
+	void *dispatch_data;
+	ofono_destroy_func destroy;
+};
+
+static inline const char *sms_agent_string_from_port(int port)
+{
+	switch (port) {
+	case SMS_AGENT_PORT_WAP_PUSH:
+	case SMS_AGENT_PORT_WAP_PUSH_S:
+		return "application/vnd.oma.push";
+
+	case SMS_AGENT_PORT_VCARD:
+	case SMS_AGENT_PORT_VCARD_S:
+		return "text/x-vcard";
+
+	case SMS_AGENT_PORT_VCAL:
+	case SMS_AGENT_PORT_VCAL_S:
+		return "text/calendar";
+	}
+	return NULL;
+}
+
+static inline ofono_bool_t sms_agent_type_matches_port(enum sms_agent_type=
 type,
+							int port)
+{
+	switch (type) {
+	case SMS_AGENT_TYPE_TEXT:
+		return FALSE;
+
+	case SMS_AGENT_TYPE_VCARD:
+		return port =3D=3D SMS_AGENT_PORT_VCARD
+			|| port =3D=3D SMS_AGENT_PORT_VCARD_S;
+
+	case SMS_AGENT_TYPE_VCAL:
+		return port =3D=3D SMS_AGENT_PORT_VCAL
+			|| port =3D=3D SMS_AGENT_PORT_VCAL_S;
+
+	case SMS_AGENT_TYPE_WAP_PUSH:
+		return port =3D=3D SMS_AGENT_PORT_WAP_PUSH
+			|| port =3D=3D SMS_AGENT_PORT_WAP_PUSH_S;
+	}
+	return FALSE;
+}
+
+
+static struct sms_agent_request *sms_agent_request_create(struct sms_agent=
 *agent,
+						sms_agent_dispatch_cb cb,
+						void *user_data,
+						ofono_destroy_func destroy)
+{
+	struct sms_agent_request *req;
+
+	req =3D g_try_new0(struct sms_agent_request, 1);
+	if (!req)
+		return NULL;
+
+	req->agent =3D agent;
+	req->dispatch_cb =3D cb;
+	req->dispatch_data =3D user_data;
+	req->destroy =3D destroy;
+
+	return req;
+}
+
+static void sms_agent_request_destroy(struct sms_agent_request *req)
+{
+	if (req->msg) {
+		dbus_message_unref(req->msg);
+		req->msg =3D NULL;
+	}
+
+	if (req->call) {
+		dbus_pending_call_unref(req->call);
+		req->call =3D NULL;
+	}
+
+	if (req->destroy)
+		req->destroy(req->dispatch_data);
+
+	g_free(req);
+}
+
+static void sms_agent_request_cancel(struct sms_agent_request *req)
+{
+	if (!req->call)
+		return;
+
+	dbus_pending_call_cancel(req->call);
+
+	sms_agent_request_destroy(req);
+}
+
+static void sms_agent_send_noreply(struct sms_agent *agent, const char *me=
thod)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	DBusMessage *message;
+
+	message =3D dbus_message_new_method_call(agent->name, agent->path,
+						OFONO_MESSAGE_AGENT_INTERFACE,
+							method);
+
+	if (!message)
+		return;
+
+	dbus_message_set_no_reply(message, TRUE);
+
+	DBG("Sending: '%s' to '%s' at '%s'", method, agent->name, agent->path);
+	g_dbus_send_message(conn, message);
+}
+
+static inline void sms_agent_send_release(struct sms_agent *agent)
+{
+	sms_agent_send_noreply(agent, "Release");
+}
+
+static void sms_agent_disconnect_cb(DBusConnection *conn, void *data)
+{
+	struct sms_agent *agent =3D data;
+
+	ofono_debug("Agent exited without calling Unregister");
+
+	agent->disconnect_watch =3D 0;
+
+	if (agent->remove_cb)
+		agent->remove_cb(agent, agent->remove_data);
+}
+
+struct sms_agent *sms_agent_create(const char *path, const char *name,
+					enum sms_agent_type type,
+					sms_agent_remove_cb cb,
+					void *user_data)
+{
+	struct sms_agent *agent =3D g_try_new0(struct sms_agent, 1);
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	if (!agent)
+		return NULL;
+
+	agent->path =3D g_strdup(path);
+	agent->name =3D g_strdup(name);
+	agent->remove_cb =3D cb;
+	agent->remove_data =3D user_data;
+	agent->type =3D type;
+
+	agent->disconnect_watch =3D g_dbus_add_disconnect_watch(conn, name,
+							sms_agent_disconnect_cb,
+							agent, NULL);
+	return agent;
+}
+
+void sms_agent_destroy(struct sms_agent *agent)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	if (!agent)
+		return;
+
+	if (agent->disconnect_watch) {
+		sms_agent_send_release(agent);
+
+		g_dbus_remove_watch(conn, agent->disconnect_watch);
+		agent->disconnect_watch =3D 0;
+	}
+
+	g_slist_foreach(agent->reqs, (GFunc)sms_agent_request_cancel, NULL);
+	g_slist_free(agent->reqs);
+
+	g_free(agent->path);
+	g_free(agent->name);
+	g_free(agent);
+}
+
+ofono_bool_t sms_agent_matches(struct sms_agent *agent, const char *path,
+				const char *name)
+{
+	return (path && strcmp(agent->path, path) =3D=3D 0)
+		&& (name && strcmp(agent->name, name) =3D=3D 0);
+}
+
+static enum sms_agent_result sms_agent_check_error(struct sms_agent *agent,
+							DBusMessage *reply)
+{
+	enum sms_agent_result result =3D SMS_AGENT_RESULT_FAILED;
+	DBusError err;
+
+	dbus_error_init(&err);
+
+	if (!dbus_set_error_from_message(&err, reply))
+		return SMS_AGENT_RESULT_OK;
+
+	if (g_str_equal(err.name, DBUS_ERROR_NO_REPLY))
+		result =3D SMS_AGENT_RESULT_TIMEOUT;
+
+	ofono_debug("MessageAgent %s replied with error %s, %s",
+			agent->name, err.name, err.message);
+
+	dbus_error_free(&err);
+	return result;
+}
+
+static void sms_agent_dispatch_reply_cb(DBusPendingCall *call, void *data)
+{
+	struct sms_agent_request *req =3D data;
+	struct sms_agent *agent =3D req->agent;
+	sms_agent_dispatch_cb cb =3D req->dispatch_cb;
+	void *dispatch_data =3D req->dispatch_data;
+	DBusMessage *reply =3D dbus_pending_call_steal_reply(req->call);
+	enum sms_agent_result result;
+
+	result =3D sms_agent_check_error(agent, reply);
+
+	agent->reqs =3D g_slist_remove(agent->reqs, req);
+	sms_agent_request_destroy(req);
+
+	if (cb)
+		cb(agent, result, dispatch_data);
+
+	dbus_message_unref(reply);
+}
+
+int sms_agent_dispatch_text(struct sms_agent *agent, const char *from,
+				const char *sent_time,
+				const char *local_sent_time,
+				const char *message,
+				sms_agent_dispatch_cb cb, void *user_data,
+				ofono_destroy_func destroy)
+{
+	struct sms_agent_request *req;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+
+	if (agent->type !=3D SMS_AGENT_TYPE_TEXT)
+		return -EOPNOTSUPP;
+
+	req =3D sms_agent_request_create(agent, cb, user_data, destroy);
+	if (!req)
+		return -ENOMEM;
+
+	req->msg =3D dbus_message_new_method_call(agent->name, agent->path,
+						OFONO_MESSAGE_AGENT_INTERFACE,
+						"HandleMessage");
+	if (!req->msg) {
+		sms_agent_request_destroy(req);
+		return -ENOMEM;
+	}
+
+	dbus_message_iter_init_append(req->msg, &iter);
+
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &message);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+
+	ofono_dbus_dict_append(&dict, "LocalSentTime", DBUS_TYPE_STRING,
+				&local_sent_time);
+	ofono_dbus_dict_append(&dict, "SentTime", DBUS_TYPE_STRING,
+				&sent_time);
+	ofono_dbus_dict_append(&dict, "Sender", DBUS_TYPE_STRING, &from);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	if (!dbus_connection_send_with_reply(conn, req->msg, &req->call, -1)) {
+		ofono_error("Sending D-Bus method failed");
+		sms_agent_request_destroy(req);
+		return -EIO;
+	}
+
+	agent->reqs =3D g_slist_append(agent->reqs, req);
+
+	dbus_pending_call_set_notify(req->call, sms_agent_dispatch_reply_cb,
+					req, NULL);
+
+	return 0;
+}
+
+int sms_agent_dispatch_data(struct sms_agent *agent, const char *from,
+				const char *sent_time,
+				const char *local_sent_time,
+				int src_port, int dst_port,
+				const unsigned char *message,
+				unsigned int len,
+				sms_agent_dispatch_cb cb, void *user_data,
+				ofono_destroy_func destroy)
+{
+	struct sms_agent_request *req;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	DBusMessageIter iter;
+	DBusMessageIter array;
+	DBusMessageIter dict;
+	const char *type;
+	dbus_uint16_t src16;
+	dbus_uint16_t dst16;
+
+	if (!sms_agent_type_matches_port(agent->type, dst_port))
+		return -EOPNOTSUPP;
+
+	req =3D sms_agent_request_create(agent, cb, user_data, destroy);
+	if (!req)
+		return -ENOMEM;
+
+	req->msg =3D dbus_message_new_method_call(agent->name, agent->path,
+						OFONO_MESSAGE_AGENT_INTERFACE,
+						"HandleDatagram");
+	if (!req->msg) {
+		sms_agent_request_destroy(req);
+		return -ENOMEM;
+	}
+
+	dbus_message_iter_init_append(req->msg, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY, "y", &array);
+	dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE, &message, le=
n);
+	dbus_message_iter_close_container(&iter, &array);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+
+	ofono_dbus_dict_append(&dict, "LocalSentTime", DBUS_TYPE_STRING,
+				&local_sent_time);
+	ofono_dbus_dict_append(&dict, "SentTime", DBUS_TYPE_STRING,
+				&sent_time);
+	ofono_dbus_dict_append(&dict, "Sender", DBUS_TYPE_STRING, &from);
+
+	src16 =3D src_port;
+	dst16 =3D dst_port;
+
+	type =3D sms_agent_string_from_port(dst_port);
+	if (type)
+		ofono_dbus_dict_append(&dict, "ContentType", DBUS_TYPE_STRING,
+					&type);
+	else
+		ofono_dbus_dict_append(&dict, "DestinationPort", DBUS_TYPE_UINT16,
+					&dst16);
+
+	ofono_dbus_dict_append(&dict, "SourcePort", DBUS_TYPE_UINT16, &src16);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	if (!dbus_connection_send_with_reply(conn, req->msg, &req->call, -1)) {
+		ofono_error("Sending D-Bus method failed");
+		sms_agent_request_destroy(req);
+		return -EIO;
+	}
+
+	agent->reqs =3D g_slist_append(agent->reqs, req);
+
+	dbus_pending_call_set_notify(req->call, sms_agent_dispatch_reply_cb,
+					req, NULL);
+
+	return 0;
+}
diff --git a/src/smsagent.h b/src/smsagent.h
new file mode 100644
index 0000000..e9f95bc
--- /dev/null
+++ b/src/smsagent.h
@@ -0,0 +1,66 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2009-2010 Nokia Corporation and/or its subsidiary(-ies).
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
+struct sms_agent;
+
+enum sms_agent_type {
+	SMS_AGENT_TYPE_TEXT =3D 0,
+	SMS_AGENT_TYPE_VCARD,
+	SMS_AGENT_TYPE_VCAL,
+	SMS_AGENT_TYPE_WAP_PUSH,
+};
+
+enum sms_agent_result {
+	SMS_AGENT_RESULT_OK =3D 0,
+	SMS_AGENT_RESULT_FAILED,
+	SMS_AGENT_RESULT_TIMEOUT,
+};
+
+typedef void (*sms_agent_remove_cb) (struct sms_agent *agent, void *data);
+
+typedef void (*sms_agent_dispatch_cb) (struct sms_agent *agent,
+					enum sms_agent_result result,
+					void *data);
+
+struct sms_agent *sms_agent_create(const char *path, const char *name,
+					enum sms_agent_type type,
+					sms_agent_remove_cb cb, void *data);
+
+void sms_agent_destroy(struct sms_agent *agent);
+
+ofono_bool_t sms_agent_matches(struct sms_agent *agent, const char *name,
+				const char *path);
+
+int sms_agent_dispatch_text(struct sms_agent *agent, const char *from,
+				const char *sent_time,
+				const char *local_sent_time,
+				const char *message,
+				sms_agent_dispatch_cb cb, void *user_data,
+				ofono_destroy_func destroy);
+
+int sms_agent_dispatch_data(struct sms_agent *agent, const char *from,
+				const char *sent_time,
+				const char *local_sent_time,
+				int src_port, int dst_port,
+				const unsigned char *message,
+				unsigned int len,
+				sms_agent_dispatch_cb cb, void *user_data,
+				ofono_destroy_func destroy);
-- =

1.7.0.4


--===============9065220133731938313==--

