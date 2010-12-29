Content-Type: multipart/mixed; boundary="===============2428138135379425474=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@nokia.com>
Subject: [PATCH 1/9] SMS history plugin.
Date: Wed, 29 Dec 2010 14:51:17 +0200
Message-ID: <1293627085-24428-2-git-send-email-oleg.zhurakivskyy@nokia.com>
In-Reply-To: <1293627085-24428-1-git-send-email-oleg.zhurakivskyy@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2428138135379425474==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/messaging-agent.c |  403 +++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 403 insertions(+), 0 deletions(-)
 create mode 100644 plugins/messaging-agent.c

diff --git a/plugins/messaging-agent.c b/plugins/messaging-agent.c
new file mode 100644
index 0000000..fa93fe8
--- /dev/null
+++ b/plugins/messaging-agent.c
@@ -0,0 +1,403 @@
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
+#include <string.h>
+#include <errno.h>
+
+#include <glib.h>
+#include <gdbus.h>
+
+#include <ofono.h>
+#include <smsagent.h>
+
+#define MESSAGING_INTERFACE OFONO_SERVICE ".Messaging"
+#define MESSAGING_AGENT_INTERFACE OFONO_SERVICE ".MessagingAgent"
+
+struct messaging_context_data {
+	struct ofono_history_context *context;
+	GSList *agents;
+};
+
+struct messaging_agent_data {
+	struct messaging_context_data *data;
+	struct sms_agent *agent;
+};
+
+static void messaging_agent_delete(void *data)
+{
+	struct messaging_agent_data *agent_data =3D data;
+
+	if (!g_slist_find(agent_data->data->agents, agent_data))
+		return;
+
+	DBG("modem=3D%s: agent=3D%p",
+		ofono_modem_get_path(agent_data->data->context->modem),
+		agent_data->agent);
+
+	agent_data->data->agents =3D g_slist_remove(agent_data->data->agents,
+							agent_data);
+	g_free(agent_data);
+}
+
+static void messaging_agents_delete(gpointer user)
+{
+	struct messaging_context_data *data =3D user;
+
+	DBG("modem=3D%s", ofono_modem_get_path(data->context->modem));
+
+	while (data->agents) {
+		struct messaging_agent_data *agent_data =3D data->agents->data;
+		sms_agent_free(agent_data->agent);
+	}
+}
+
+static DBusMessage *messaging_agent_register(DBusConnection *conn,
+						DBusMessage *msg, void *param)
+{
+	const char *agent_path;
+	const char *agent_bus =3D dbus_message_get_sender(msg);
+	struct messaging_context_data *data =3D param;
+	struct messaging_agent_data *agent_data;
+	GSList *node;
+
+	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH,
+			&agent_path, DBUS_TYPE_INVALID) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	if (!__ofono_dbus_valid_object_path(agent_path))
+		return __ofono_error_invalid_format(msg);
+
+	for (node =3D data->agents; node; node =3D g_slist_next(node)) {
+
+		agent_data =3D node->data;
+
+		if (sms_agent_matches(agent_data->agent, agent_bus,
+					agent_path) =3D=3D TRUE)
+			return __ofono_error_busy(msg);
+	}
+
+	agent_data =3D g_try_new0(struct messaging_agent_data, 1);
+	if (agent_data =3D=3D NULL)
+		return __ofono_error_failed(msg);
+
+	agent_data->data =3D data;
+	agent_data->agent =3D sms_agent_new(MESSAGING_AGENT_INTERFACE,
+				dbus_message_get_sender(msg), agent_path);
+	if (agent_data->agent =3D=3D NULL) {
+		g_free(agent_data);
+		return __ofono_error_failed(msg);
+	}
+
+	data->agents =3D g_slist_append(data->agents, agent_data);
+
+	DBG("modem=3D%s: agent=3D%p %s:%s:%s",
+		ofono_modem_get_path(data->context->modem), agent_data->agent,
+		dbus_message_get_sender(msg), agent_path,
+		MESSAGING_AGENT_INTERFACE);
+
+	sms_agent_set_removed_notify(agent_data->agent, messaging_agent_delete,
+					agent_data);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *messaging_agent_unregister(DBusConnection *conn,
+						DBusMessage *msg, void *param)
+{
+	const char *agent_path;
+	const char *agent_bus =3D dbus_message_get_sender(msg);
+	struct messaging_context_data *data =3D param;
+	GSList *node;
+
+	DBG("");
+
+	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &agent_path,
+				DBUS_TYPE_INVALID) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	for (node =3D data->agents; node; node =3D g_slist_next(node)) {
+
+		struct messaging_agent_data *agent_data =3D node->data;
+
+		if (sms_agent_matches(agent_data->agent,
+					agent_bus, agent_path) =3D=3D FALSE)
+			continue;
+
+		sms_agent_free(agent_data->agent);
+		return dbus_message_new_method_return(msg);
+	}
+
+	return __ofono_error_failed(msg);
+}
+
+struct messaging_agent_dict_entry {
+	char *s;
+	char *v;
+};
+
+static GSList *messaging_agent_dict_entry_append(GSList *l, char *s, char =
*v)
+{
+	struct messaging_agent_dict_entry *e;
+
+	e =3D g_try_new0(struct messaging_agent_dict_entry, 1);
+	if (e =3D=3D NULL)
+		return NULL;
+
+	e->s =3D g_strdup(s);
+	e->v =3D g_strdup(v);
+	if (e->s =3D=3D NULL || e->v =3D=3D NULL) {
+		g_free(e);
+		return NULL;
+	}
+
+	return g_slist_append(l, e);
+}
+
+static void messaging_agent_dict_delete(GSList *l)
+{
+	while (l) {
+		struct messaging_agent_dict_entry *e =3D l->data;
+
+		l =3D g_slist_remove(l, l->data);
+		g_free(e->s);
+		g_free(e->v);
+		g_free(e);
+	}
+}
+
+static void messaging_agent_dict_append_cb(DBusMessageIter *dict, void *pa=
ram)
+{
+	GSList *node;
+
+	for (node =3D (GSList *)param; node; node =3D g_slist_next(node)) {
+
+		struct messaging_agent_dict_entry *e =3D node->data;
+
+		ofono_dbus_dict_append(dict, e->s, DBUS_TYPE_STRING, &e->v);
+	}
+}
+
+static void messaging_agent_sms_received(struct ofono_history_context *con=
text,
+						const struct ofono_uuid *uuid,
+						const char *from,
+						const struct tm *remote,
+						const struct tm *local,
+						const char *text)
+{
+	GSList *node;
+	GSList *entries =3D NULL;
+	struct messaging_context_data *data =3D context->data;
+
+	entries =3D messaging_agent_dict_entry_append(entries, (char *)"UUID",
+					(char *)ofono_uuid_to_str(uuid));
+
+	for (node =3D data->agents; node; node =3D g_slist_next(node)) {
+		struct messaging_agent_data *agent_data =3D node->data;
+
+		DBG("modem=3D%s -> agent=3D%p: text=3D\"%s\"",
+			ofono_modem_get_path(data->context->modem),
+			agent_data->agent, text);
+
+		sms_agent_dispatch_datagram(agent_data->agent,
+					"MessageReceived",
+					from, remote, local,
+					(unsigned char *)text,
+					strlen(text), NULL, NULL,
+					messaging_agent_dict_append_cb,
+					(void *)entries, NULL);
+	}
+
+	messaging_agent_dict_delete(entries);
+}
+
+static void messaging_agent_sms_send_pending(
+				struct ofono_history_context *context,
+				const struct ofono_uuid *uuid,
+				const char *to, time_t when,
+				const char *text)
+{
+	GSList *node;
+	GSList *entries =3D NULL;
+	struct messaging_context_data *data =3D context->data;
+
+	entries =3D messaging_agent_dict_entry_append(entries, (char *)"UUID",
+					(char *)ofono_uuid_to_str(uuid));
+
+	for (node =3D data->agents; node; node =3D g_slist_next(node)) {
+		struct messaging_agent_data *agent_data =3D node->data;
+
+		DBG("modem=3D%s -> agent=3D%p: text=3D\"%s\"",
+			ofono_modem_get_path(data->context->modem),
+			agent_data->agent, text);
+
+		sms_agent_dispatch_datagram(agent_data->agent,
+						"MessageSendPending",
+						to, localtime(&when),
+						localtime(&when),
+						(unsigned char *)text,
+						strlen(text), NULL, NULL,
+						messaging_agent_dict_append_cb,
+						(void *)entries, NULL);
+	}
+
+	messaging_agent_dict_delete(entries);
+}
+
+#undef _
+#define _(_x) case _x: return #_x
+
+static char *messaging_agent_sms_status(enum ofono_history_sms_status s)
+{
+	switch (s) {
+		_(OFONO_HISTORY_SMS_STATUS_PENDING);
+		_(OFONO_HISTORY_SMS_STATUS_SUBMITTED);
+		_(OFONO_HISTORY_SMS_STATUS_SUBMIT_FAILED);
+		_(OFONO_HISTORY_SMS_STATUS_DELIVERED);
+		_(OFONO_HISTORY_SMS_STATUS_DELIVER_FAILED);
+	}
+	return "OFONO_HISTORY_SMS_STATUS_<UNKNOWN>";
+}
+
+static void messaging_agent_sms_send_status(
+					struct ofono_history_context *context,
+					const struct ofono_uuid *uuid,
+					time_t when,
+					enum ofono_history_sms_status s)
+{
+	GSList *node;
+	GSList *entries =3D NULL;
+	struct messaging_context_data *data =3D context->data;
+
+	entries =3D messaging_agent_dict_entry_append(entries, (char *)"UUID",
+			(char *)ofono_uuid_to_str(uuid));
+	entries =3D messaging_agent_dict_entry_append(entries, (char *)"Status",
+			(char *)messaging_agent_sms_status(s));
+
+	for (node =3D data->agents; node; node =3D g_slist_next(node)) {
+		struct messaging_agent_data *agent_data =3D node->data;
+
+		DBG("modem=3D%s -> agent=3D%p: status=3D%s",
+			ofono_modem_get_path(data->context->modem),
+			agent_data->agent,
+			messaging_agent_sms_status(s));
+
+		sms_agent_dispatch_datagram(agent_data->agent,
+						"MessageSendStatus",
+						NULL, localtime(&when),
+						localtime(&when), NULL, 0,
+						NULL, NULL,
+						messaging_agent_dict_append_cb,
+						(void *)entries, NULL);
+	}
+
+	messaging_agent_dict_delete(entries);
+}
+
+static GDBusMethodTable messaging_agent_methods[] =3D {
+	{ "AgentRegister",	"o", "", messaging_agent_register },
+	{ "AgentUnregister",	"o", "", messaging_agent_unregister },
+	{ }
+};
+
+static int messaging_agent_probe(struct ofono_history_context *context)
+{
+	if (context->data) {
+		ofono_error("modem=3D%s: data already exists: data=3D%p",
+				ofono_modem_get_path(context->modem),
+				context->data);
+		return -EEXIST;
+	}
+
+	context->data =3D g_try_new0(struct messaging_context_data, 1);
+	if (context->data =3D=3D NULL)
+		return -ENOMEM;
+
+	memset(context->data, 0, sizeof(struct messaging_context_data));
+	((struct messaging_context_data *)context->data)->context =3D context;
+
+	DBG("modem=3D%s: data=3D%p", ofono_modem_get_path(context->modem),
+		context->data);
+
+	if (!g_dbus_register_interface(ofono_dbus_get_connection(),
+					ofono_modem_get_path(context->modem),
+					MESSAGING_INTERFACE,
+					messaging_agent_methods,
+					NULL, NULL, context->data, NULL)) {
+		ofono_error("Can't register dbus interface %s",
+				MESSAGING_INTERFACE);
+		return -1;
+	}
+
+	ofono_modem_add_interface(context->modem, MESSAGING_INTERFACE);
+
+	return 0;
+}
+
+static void messaging_agent_remove(struct ofono_history_context *context)
+{
+	DBG("modem=3D%s data=3D%p", ofono_modem_get_path(context->modem),
+		context->data);
+
+	messaging_agents_delete(context->data);
+
+	ofono_modem_remove_interface(context->modem, MESSAGING_INTERFACE);
+
+	if (!g_dbus_unregister_interface(ofono_dbus_get_connection(),
+		ofono_modem_get_path(context->modem),
+		MESSAGING_INTERFACE))
+		ofono_error("Can't unregister dbus interface %s",
+				MESSAGING_INTERFACE);
+
+	g_free(context->data);
+}
+
+static struct ofono_history_driver messaging_agent_driver =3D {
+	.name =3D "Messaging Agent",
+	.probe =3D messaging_agent_probe,
+	.remove =3D messaging_agent_remove,
+	.sms_received =3D messaging_agent_sms_received,
+	.sms_send_pending =3D messaging_agent_sms_send_pending,
+	.sms_send_status =3D messaging_agent_sms_send_status,
+};
+
+static int messaging_agent_init()
+{
+	DBG("");
+
+	ofono_history_driver_register(&messaging_agent_driver);
+
+	return 0;
+}
+
+static void messaging_agent_exit()
+{
+	DBG("");
+
+	ofono_history_driver_unregister(&messaging_agent_driver);
+}
+
+OFONO_PLUGIN_DEFINE(messaging_agent, "Messaging Agent", VERSION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT,
+			messaging_agent_init, messaging_agent_exit)
-- =

1.7.1


--===============2428138135379425474==--

