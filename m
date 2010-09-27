Content-Type: multipart/mixed; boundary="===============6937138211771068083=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH 5/7] Add message agent implementation
Date: Mon, 27 Sep 2010 19:54:17 +0300
Message-ID: <1285606459-1297-6-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1285606459-1297-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6937138211771068083==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am    |    2 +-
 src/smsagent.c |  344 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/smsagent.h |   56 +++++++++
 3 files changed, 401 insertions(+), 1 deletions(-)
 create mode 100644 src/smsagent.c
 create mode 100644 src/smsagent.h

diff --git a/Makefile.am b/Makefile.am
index 73de359..0d87006 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -296,7 +296,7 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) src/ofono.ver \
 			src/gprs.c src/idmap.h src/idmap.c \
 			src/radio-settings.c src/stkutil.h src/stkutil.c \
 			src/nettime.c src/stkagent.c src/stkagent.h \
-			src/simfs.c src/simfs.h
+			src/simfs.c src/simfs.h src/smsagent.c src/smsagent.h
 =

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ -ldl
 =

diff --git a/src/smsagent.c b/src/smsagent.c
new file mode 100644
index 0000000..dc08e0a
--- /dev/null
+++ b/src/smsagent.c
@@ -0,0 +1,344 @@
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
+	SMS_AGENT_PORT_VCARD =3D 9204,
+	SMS_AGENT_PORT_VCAL =3D 9205,
+	SMS_AGENT_PORT_VCARD_S =3D 9206,		/* vCard secure?? */
+	SMS_AGENT_PORT_VCAL_S =3D 9207,		/* vCal secure?? */
+};
+
+struct sms_agent {
+	char *path;
+	char *name;
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
+static const char *sms_agent_port_to_type(int port)
+{
+	switch (port) {
+	case SMS_AGENT_PORT_VCARD:
+	case SMS_AGENT_PORT_VCARD_S:
+		return "vcard";
+
+	case SMS_AGENT_PORT_VCAL:
+	case SMS_AGENT_PORT_VCAL_S:
+		return "vcalendar";
+	}
+
+	return NULL;
+}
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
+	agent->disconnect_watch =3D 0;
+
+	if (agent->remove_cb)
+		agent->remove_cb(agent, agent->remove_data);
+}
+
+struct sms_agent *sms_agent_create(const char *path, const char *name,
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
+static int sms_agent_dispatch(struct sms_agent *agent, const char *from,
+				const struct tm *remote, const struct tm *local,
+				const char *message, const char *content_type,
+				sms_agent_dispatch_cb cb, void *user_data,
+				ofono_destroy_func destroy)
+{
+	struct sms_agent_request *req;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	char buf[128];
+	const char *str =3D buf;
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
+	strftime(buf, 127, "%Y-%m-%dT%H:%M:%S%z", local);
+	buf[127] =3D '\0';
+	ofono_dbus_dict_append(&dict, "LocalSentTime", DBUS_TYPE_STRING, &str);
+
+	strftime(buf, 127, "%Y-%m-%dT%H:%M:%S%z", remote);
+	buf[127] =3D '\0';
+	ofono_dbus_dict_append(&dict, "SentTime", DBUS_TYPE_STRING, &str);
+
+	ofono_dbus_dict_append(&dict, "Sender", DBUS_TYPE_STRING, &from);
+	ofono_dbus_dict_append(&dict, "ContentType", DBUS_TYPE_STRING,
+				&content_type);
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
+int sms_agent_dispatch_text(struct sms_agent *agent, const char *from,
+				const struct tm *remote_sent_time,
+				const struct tm *local_sent_time,
+				const char *message, sms_agent_dispatch_cb cb,
+				void *user_data, ofono_destroy_func destroy)
+{
+	return sms_agent_dispatch(agent, from, remote_sent_time, local_sent_time,
+					message, "text", cb, user_data,
+					destroy);
+}
+
+int sms_agent_dispatch_datagram(struct sms_agent *agent, const char *from,
+				const struct tm *remote_sent_time,
+				const struct tm *local_sent_time,
+				int dst_port, int src_port,
+				const unsigned char *buffer,
+				unsigned int len,
+				sms_agent_dispatch_cb cb, void *user_data,
+				ofono_destroy_func destroy)
+{
+	char message[len + 1];
+	const char *content_type;
+
+	content_type =3D sms_agent_port_to_type(dst_port);
+	if (!content_type)
+		return -ENOTSUP;
+
+	memcpy(message, buffer, len);
+	message[len] =3D '\0';
+
+	return sms_agent_dispatch(agent, from, remote_sent_time, local_sent_time,
+					message, content_type, cb, user_data,
+					destroy);
+}
diff --git a/src/smsagent.h b/src/smsagent.h
new file mode 100644
index 0000000..40637d9
--- /dev/null
+++ b/src/smsagent.h
@@ -0,0 +1,56 @@
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
+					sms_agent_remove_cb cb, void *data);
+
+void sms_agent_destroy(struct sms_agent *agent);
+
+ofono_bool_t sms_agent_matches(struct sms_agent *agent, const char *path,
+				const char *name);
+
+int sms_agent_dispatch_text(struct sms_agent *agent, const char *from,
+				const struct tm *remote_sent_time,
+				const struct tm *local_sent_time,
+				const char *message, sms_agent_dispatch_cb cb,
+				void *user_data, ofono_destroy_func destroy);
+
+int sms_agent_dispatch_datagram(struct sms_agent *agent, const char *from,
+				const struct tm *remote_sent_time,
+				const struct tm *local_sent_time,
+				int dst_port, int src_port,
+				const unsigned char *buffer, unsigned int len,
+				sms_agent_dispatch_cb cb, void *user_data,
+				ofono_destroy_func destroy);
-- =

1.7.0.4


--===============6937138211771068083==--

