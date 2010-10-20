Content-Type: multipart/mixed; boundary="===============8608744316727192143=="
MIME-Version: 1.0
From: Rajyalakshmi Bommaraju <Rajyalakshmi.Bommaraju@intel.com>
Subject: [PATCH] Implementation of some of the history plugin functions
Date: Wed, 20 Oct 2010 16:08:34 -0700
Message-ID: <1287616114-22348-2-git-send-email-Rajyalakshmi.Bommaraju@intel.com>
In-Reply-To: <1287616114-22348-1-git-send-email-Rajyalakshmi.Bommaraju@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8608744316727192143==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am             |    4 +
 plugins/history.c       |  237 +++++++++++++++++++++++++++++++++++++++++++=
+++
 plugins/history_agent.c |  240 +++++++++++++++++++++++++++++++++++++++++++=
++++
 plugins/history_agent.h |   67 +++++++++++++
 4 files changed, 548 insertions(+), 0 deletions(-)
 create mode 100755 plugins/history.c
 create mode 100644 plugins/history_agent.c
 create mode 100644 plugins/history_agent.h

diff --git a/Makefile.am b/Makefile.am
index fd791cf..1d2b8a1 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -285,6 +285,10 @@ builtin_sources +=3D plugins/ste.c
 =

 builtin_modules +=3D caif
 builtin_sources +=3D plugins/caif.c
+
+builtin_modules +=3D history
+builtin_sources +=3D plugins/history_agent.c
+builtin_sources +=3D plugins/history.c
 endif
 =

 if MAINTAINER_MODE
diff --git a/plugins/history.c b/plugins/history.c
new file mode 100755
index 0000000..06d5f2f
--- /dev/null
+++ b/plugins/history.c
@@ -0,0 +1,237 @@
+/*
+ *
+ * oFono - Open Source Telephony
+ *
+ * Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
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
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <errno.h>
+
+#include "gdbus/gdbus.h"
+#include <ofono/history.h>
+#include "plugins/history_agent.h"
+#include "src/common.h"
+#include "src/ofono.h"
+
+#define HISTORY_FILE_PATH "/var/cache/ofonohistory/"
+#define HISTORY_FILE HISTORY_FILE_PATH"ofonohistorydata"
+#define OFONO_MANAGER_PATH "/"
+#define OFONO_HISTORY_INTERFACE "com.meego.TelephonyHistory"
+
+struct ofono_history {
+	struct history_agent *current_agent;
+	int timeout;
+} *history;
+
+
+static int history_probe(struct ofono_history_context *context)
+{
+	DBG("History Probe for modem: %p", context->modem);
+	return 0;
+}
+
+static void history_remove(struct ofono_history_context *context)
+{
+	DBG("History Remove for modem: %p", context->modem);
+}
+
+/**
+ * history_call_ended:
+ * ofono calls this method with the call information
+ */
+static void history_call_ended(struct ofono_history_context *context,
+					const struct ofono_call *call,
+					time_t start,
+					time_t end)
+{
+
+	struct voice_history *v =3D g_try_new0(struct voice_history, 1);
+	if (!v)
+		return;
+
+	DBG("Call Ended on modem: %p", context->modem);
+	strcpy(v->lineid, "Unknown");
+
+	if (call->type !=3D 0)
+		return;
+
+	DBG("Voice Call, %s",
+	call->direction ? "Incoming" : "Outgoing");
+	v->type =3D call->direction;
+
+	if (call->clip_validity =3D=3D 0)
+		strcpy(v->lineid, phone_number_to_string(&call->phone_number));
+
+	v->start_time =3D start;
+	v->end_time =3D end;
+
+	if (!history) {
+		g_free(v);
+		return;
+	}
+
+	history_report_voicecall(v, history->current_agent,
+					history->timeout);
+	g_free(v);
+}
+
+/**
+ * history_call_missed:
+ * ofono calls this method with the call information
+ */
+static void history_call_missed(struct ofono_history_context *context,
+					const struct ofono_call *call,
+					time_t when)
+{
+	struct voice_history *v =3D g_try_new0(struct voice_history, 1);
+	if (!v)
+		return;
+
+	DBG("Call Missed on modem: %p", context->modem);
+
+	strcpy(v->lineid, "Unknown");
+
+	if (call->type !=3D 0)
+		return;
+
+	v->type =3D MISSED;
+
+	if (call->clip_validity =3D=3D 0)
+		strcpy(v->lineid, phone_number_to_string(&call->phone_number));
+
+	v->start_time =3D when;
+
+	v->end_time =3D when;
+
+	if (!history) {
+		g_free(v);
+		return;
+	}
+
+	history_report_voicecall(v, history->current_agent, history->timeout);
+}
+
+static DBusMessage *history_register_agent(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	const char *agent_path;
+	if (dbus_message_get_args(msg, NULL,
+					DBUS_TYPE_OBJECT_PATH, &agent_path,
+					DBUS_TYPE_INVALID) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	if (!__ofono_dbus_valid_object_path(agent_path))
+		return __ofono_error_invalid_format(msg);
+
+	if (!history)
+		return __ofono_error_failed(msg);
+
+	history->current_agent =3D history_agent_new(agent_path,
+					dbus_message_get_sender(msg),
+					FALSE);
+
+	if (!history->current_agent)
+		return __ofono_error_failed(msg);
+
+	DBG("History agent created");
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *history_unregister_agent(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	const char *agent_path;
+
+	const char *agent_bus =3D dbus_message_get_sender(msg);
+	if (dbus_message_get_args(msg, NULL,
+					DBUS_TYPE_OBJECT_PATH, &agent_path,
+					DBUS_TYPE_INVALID) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	if (!history->current_agent)
+		return __ofono_error_failed(msg);
+
+	if (!history_agent_matches(history->current_agent, agent_path,
+						agent_bus))
+		return __ofono_error_failed(msg);
+
+	history_agent_free(history->current_agent);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static GDBusMethodTable history_methods[] =3D {
+	{ "RegisterAgent",	"o",	"",	history_register_agent },
+	{ "UnregisterAgent",	"o",	"",	history_unregister_agent },
+	{ }
+};
+
+static struct ofono_history_driver history_driver =3D {
+	.name =3D "history",
+	.probe =3D history_probe,
+	.remove =3D history_remove,
+	.call_ended =3D history_call_ended,
+	.call_missed =3D history_call_missed,
+};
+
+static int history_init(void)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	if (!g_dbus_register_interface(conn,
+					OFONO_MANAGER_PATH,
+					OFONO_HISTORY_INTERFACE,
+					history_methods,
+					NULL,
+					NULL,	/* Properties */
+					NULL,	/* Userdata   */
+					NULL)) {	/* Destroy func */
+		ofono_error("Could not create %s interface",
+					OFONO_HISTORY_INTERFACE);
+
+		return -EIO;
+	}
+
+	history =3D g_try_new0(struct ofono_history, 1);
+
+	if (!history)
+		return -EIO;
+
+	history->timeout =3D 600;		/* 10 minutes */
+	return ofono_history_driver_register(&history_driver);
+}
+
+static void history_exit(void)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	g_dbus_unregister_interface(conn, OFONO_MANAGER_PATH,
+				OFONO_HISTORY_INTERFACE);
+	if (history)
+		g_free(history);
+	ofono_history_driver_unregister(&history_driver);
+}
+
+OFONO_PLUGIN_DEFINE(history, "History Plugin",
+		OFONO_VERSION, OFONO_PLUGIN_PRIORITY_DEFAULT,
+		history_init, history_exit)
diff --git a/plugins/history_agent.c b/plugins/history_agent.c
new file mode 100644
index 0000000..63b13b4
--- /dev/null
+++ b/plugins/history_agent.c
@@ -0,0 +1,240 @@
+/*
+ *
+ * oFono - Open Source Telephony
+ *
+ * Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
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
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include "plugins/history_agent.h"
+
+#define OFONO_HISTORY_AGENT "com.meego.TelephonyHistoryAgent"
+#define ERROR_PREFIX OFONO_SERVICE ".Error"
+#define FAILED_ERROR ERROR_PREFIX ".Failed"
+
+enum allowed_errors {
+	ALLOWED_ERROR_FAILED =3D 0x1
+};
+
+struct history_agent {
+	char *path;
+	char *bus;
+	guint disconnect_watch;
+	ofono_bool_t remove_on_terminate;
+	ofono_destroy_func removed_cb;
+	DBusPendingCall *call;
+	void *user_data;
+};
+
+void history_agent_free(struct history_agent *agent)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	if (agent->disconnect_watch) {
+		/*TODO	history_agent_send_release(agent); */
+		g_dbus_remove_watch(conn, agent->disconnect_watch);
+		agent->disconnect_watch =3D 0;
+	}
+
+	g_free(agent->path);
+	g_free(agent->bus);
+	g_free(agent);
+}
+
+ofono_bool_t history_agent_matches(struct history_agent *agent,
+					const char *path, const char *sender)
+{
+	return !strcmp(agent->path, path) && !strcmp(agent->bus, sender);
+}
+
+struct history_agent *history_agent_new(const char *path, const char *send=
er,
+					ofono_bool_t remove_on_terminate)
+{
+	struct history_agent *agent =3D g_try_new0(struct history_agent, 1);
+	if (!agent)
+		return NULL;
+
+	agent->path =3D g_strdup(path);
+	agent->bus =3D g_strdup(sender);
+	agent->remove_on_terminate =3D remove_on_terminate;
+
+	return agent;
+}
+
+static int check_error(struct history_agent *agent, DBusMessage *reply,
+				int allowed_errors,
+				enum HISTORY_AGENT_RESULT *out_result)
+{
+	DBusError err;
+	int result =3D 0;
+
+	dbus_error_init(&err);
+
+	if (dbus_set_error_from_message(&err, reply) =3D=3D FALSE) {
+		*out_result =3D HISTORY_AGENT_RESULT_OK;
+		return 0;
+	}
+
+	ofono_debug("HistoryAgent %s replied with error %s, %s",
+			agent->path, err.name, err.message);
+
+	/* Timeout is always valid */
+	if (g_str_equal(err.name, DBUS_ERROR_NO_REPLY)) {
+		/* Send a Cancel() to the agent since its taking too long */
+		*out_result =3D HISTORY_AGENT_RESULT_TIMEOUT;
+		goto out;
+	}
+
+	if ((allowed_errors & ALLOWED_ERROR_FAILED) &&
+		g_str_equal(err.name, FAILED_ERROR)) {
+		*out_result =3D HISTORY_AGENT_RESULT_FAILED;
+		goto out;
+	}
+
+	result =3D -EINVAL;
+out:
+	dbus_error_free(&err);
+	return result;
+}
+
+static const char *call_type_to_string(enum type tp)
+{
+	switch (tp) {
+	case INCOMING:
+		return "incoming";
+	case OUTGOING:
+		return "outgoing";
+	case MISSED:
+		return "missed";
+	default:
+		return "unknown";
+	}
+}
+
+static void data_delivery_cb(DBusPendingCall *call, void *data)
+{
+	struct history_agent *agent =3D data;
+	enum HISTORY_AGENT_RESULT result =3D -EINVAL;
+	DBusMessage *reply =3D dbus_pending_call_steal_reply(call);
+
+	if (check_error(agent, reply,
+				 ALLOWED_ERROR_FAILED,
+				&result) =3D=3D -EINVAL) {
+		g_print("Agent disappeared\n");
+		/* TODO - persist  agent->user_data and free it */
+	}
+
+	if (result =3D=3D HISTORY_AGENT_RESULT_OK) {
+		g_print("Agent reply ok");
+		g_free(agent->user_data);
+	}
+
+	if (result =3D=3D HISTORY_AGENT_RESULT_TIMEOUT) {
+		g_print("Reply timedout\n");
+		/* TODO - persist  agent->user_data and free it */
+	}
+}
+
+static void append_voicehistory_properties(struct voice_history *h,
+						DBusMessageIter *array)
+{
+	const char *sttime, *entime;
+	static char starttime[128], endtime[128];
+	struct tm starttm, endtm;
+	const char *phone;
+	DBusMessageIter dict;
+
+	dbus_message_iter_open_container(array, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+					&dict);
+
+	strftime(starttime, 127, "%Y-%m-%dT%H:%M:%S%z",
+				localtime_r(&h->start_time, &starttm));
+	starttime[127] =3D '\0';
+	sttime =3D starttime;
+
+	strftime(endtime, 127, "%Y-%m-%dT%H:%M:%S%z",
+				localtime_r(&h->end_time, &endtm));
+	endtime[127] =3D '\0';
+	entime =3D endtime;
+
+	ofono_dbus_dict_append(&dict, "Uid", DBUS_TYPE_UINT32, &h->uid);
+
+	const char *type_str =3D call_type_to_string(h->type);
+
+	ofono_dbus_dict_append(&dict, "Type",
+				DBUS_TYPE_STRING, &type_str);
+
+	phone =3D h->lineid;
+	ofono_dbus_dict_append(&dict, "LineIdentification", DBUS_TYPE_STRING,
+				&(phone));
+
+	ofono_dbus_dict_append(&dict, "StartTime", DBUS_TYPE_STRING,
+				&sttime);
+
+	ofono_dbus_dict_append(&dict, "EndTime", DBUS_TYPE_STRING,
+				&entime);
+
+	dbus_message_iter_close_container(array, &dict);
+}
+
+int history_report_voicecall(struct voice_history *history,
+				struct history_agent *agent, int timeout)
+{
+	if (!agent)
+		return -1;
+
+	DBusMessage *msg ;
+	DBusMessageIter iter, array;
+	struct voice_history *vhistory =3D history;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	msg =3D dbus_message_new_method_call(agent->bus,
+					   agent->path,
+						OFONO_HISTORY_AGENT,
+						"ReportVoiceCall");
+	if (msg =3D=3D NULL)
+		return -ENOMEM;
+
+	dbus_message_iter_init_append(msg, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_ARRAY_AS_STRING
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&array);
+	append_voicehistory_properties(vhistory, &array);
+
+	dbus_message_iter_close_container(&iter, &array);
+
+	agent->user_data =3D (void *)history;
+
+	if (dbus_connection_send_with_reply(conn, msg, &agent->call,
+						timeout) =3D=3D FALSE ||
+			agent->call =3D=3D NULL)
+		return -EIO;
+
+	dbus_pending_call_set_notify(agent->call, data_delivery_cb,
+							agent, NULL);
+	return 0;
+}
diff --git a/plugins/history_agent.h b/plugins/history_agent.h
new file mode 100644
index 0000000..65af9bb
--- /dev/null
+++ b/plugins/history_agent.h
@@ -0,0 +1,67 @@
+/*
+ *
+ * oFono - Open Source Telephony
+ *
+ * Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
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
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <errno.h>
+#include <string.h>
+
+#include "gdbus/gdbus.h"
+#include <ofono/dbus.h>
+#include <ofono/log.h>
+#include <ofono/types.h>
+
+#define PHONE_NUMBER_LENGTH 64
+struct history_agent;
+
+struct voice_history {
+	guint32 uid;
+	guint8 type;
+	char lineid[PHONE_NUMBER_LENGTH];
+	time_t start_time;
+	time_t end_time;
+};
+
+enum HISTORY_AGENT_RESULT {
+	HISTORY_AGENT_RESULT_OK,
+	HISTORY_AGENT_RESULT_FAILED,
+	HISTORY_AGENT_RESULT_TIMEOUT
+};
+
+enum type {
+	INCOMING =3D 0,
+	OUTGOING,
+	MISSED
+};
+
+struct history_agent *history_agent_new(const char *path, const char *send=
er,
+					ofono_bool_t remove_on_terminate);
+
+void history_agent_free(struct history_agent *agent);
+
+ofono_bool_t history_agent_matches(struct history_agent *agent,
+					const char *path, const char *sender);
+
+int history_report_voicecall(struct voice_history *vhistory,
+				struct history_agent *agent, int timeout);
-- =

1.6.3.3


--===============8608744316727192143==--

