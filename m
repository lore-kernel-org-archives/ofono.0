Content-Type: multipart/mixed; boundary="===============0614195996672217028=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/6] Add STK agent utilities and logic.
Date: Mon, 26 Jul 2010 15:14:35 +0200
Message-ID: <1280150080-6257-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0614195996672217028==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am    |    2 +-
 src/stkagent.c |  260 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/stkagent.h |   60 +++++++++++++
 3 files changed, 321 insertions(+), 1 deletions(-)
 create mode 100644 src/stkagent.c
 create mode 100644 src/stkagent.h

diff --git a/Makefile.am b/Makefile.am
index e256841..0e9086b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -270,7 +270,7 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) \
 			src/storage.c src/cbs.c src/watch.c src/call-volume.c \
 			src/gprs.c src/idmap.h src/idmap.c \
 			src/radio-settings.c src/stkutil.h src/stkutil.c \
-			src/nettime.c
+			src/nettime.c src/stkagent.c src/stkagent.h
 =

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ -ldl
 =

diff --git a/src/stkagent.c b/src/stkagent.c
new file mode 100644
index 0000000..1abd84d
--- /dev/null
+++ b/src/stkagent.c
@@ -0,0 +1,260 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
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
+
+#include <glib.h>
+#include <gdbus.h>
+
+#include "ofono.h"
+
+#include "stkagent.h"
+
+#define OFONO_NAVIGATION_PREFIX OFONO_SERVICE ".Error"
+#define OFONO_NAVIGATION_GOBACK OFONO_NAVIGATION_PREFIX ".GoBack"
+#define OFONO_NAVIGATION_TERMINATED OFONO_NAVIGATION_PREFIX ".EndSession"
+
+static void app_agent_request_send_cancel(struct stk_app_agent *agent)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	DBusMessage *message;
+
+	message =3D dbus_message_new_method_call(agent->bus, agent->path,
+						OFONO_SIM_APP_INTERFACE,
+						"Cancel");
+	if (message =3D=3D NULL)
+		return;
+
+	dbus_message_set_no_reply(message, TRUE);
+
+	g_dbus_send_message(conn, message);
+}
+
+static void app_agent_request_end(struct stk_app_agent *agent)
+{
+	agent->cmd_send =3D NULL;
+	agent->cmd_cb =3D NULL;
+
+	if (agent->msg) {
+		dbus_message_unref(agent->msg);
+		agent->msg =3D NULL;
+	}
+
+	if (agent->call) {
+		dbus_pending_call_cancel(agent->call);
+		dbus_pending_call_unref(agent->call);
+		agent->call =3D NULL;
+	}
+}
+
+static gboolean app_agent_busy(struct stk_app_agent *agent)
+{
+	return agent->cmd_send !=3D NULL;
+}
+
+void app_agent_request_cancel(struct stk_app_agent *agent)
+{
+	if (!app_agent_busy(agent))
+		return;
+
+	agent->cmd_cb(STK_AGENT_RESULT_CANCEL, NULL, agent->data);
+
+	app_agent_request_end(agent);
+
+	app_agent_request_send_cancel(agent);
+}
+
+static void app_agent_request_terminate(struct stk_app_agent *agent)
+{
+	agent->cmd_cb(STK_AGENT_RESULT_TERMINATE, NULL, agent->data);
+
+	app_agent_request_end(agent);
+}
+
+void app_agent_remove(struct stk_app_agent *agent)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	if (agent->disconnect_watch) {
+		DBusMessage *message;
+
+		if (app_agent_busy(agent)) {
+			app_agent_request_terminate(agent);
+
+			app_agent_request_send_cancel(agent);
+		}
+
+		message =3D dbus_message_new_method_call(agent->bus, agent->path,
+							OFONO_SIM_APP_INTERFACE,
+							"Release");
+		if (message) {
+			dbus_message_set_no_reply(message, TRUE);
+
+			g_dbus_send_message(conn, message);
+		}
+
+		g_dbus_remove_watch(conn, agent->disconnect_watch);
+		agent->disconnect_watch =3D 0;
+	} else {
+		if (app_agent_busy(agent))
+			app_agent_request_terminate(agent);
+	}
+
+	if (agent->notify)
+		agent->notify(agent->data);
+
+	g_free(agent->path);
+	g_free(agent->bus);
+	g_free(agent);
+}
+
+static void app_agent_request_reply_handle(DBusPendingCall *call, void *da=
ta)
+{
+	struct stk_app_agent *agent =3D data;
+	DBusError err;
+	DBusMessage *reply =3D dbus_pending_call_steal_reply(call);
+	enum stk_agent_result result =3D STK_AGENT_RESULT_OK;
+
+	dbus_error_init(&err);
+	if (dbus_set_error_from_message(&err, reply)) {
+		ofono_error("SimAppAgent %s replied with error %s, %s",
+				agent->path, err.name, err.message);
+
+		if (g_str_equal(err.name, DBUS_ERROR_NO_REPLY))
+			result =3D STK_AGENT_RESULT_TIMEOUT;
+		if (g_str_equal(err.name, OFONO_NAVIGATION_GOBACK))
+			result =3D STK_AGENT_RESULT_BACK;
+		else
+			result =3D STK_AGENT_RESULT_TERMINATE;
+
+		dbus_error_free(&err);
+	}
+
+	agent->cmd_cb(result, reply, agent->data);
+
+	app_agent_request_end(agent);
+
+	dbus_message_unref(reply);
+
+	if (result !=3D STK_AGENT_RESULT_TERMINATE)
+		return;
+
+	if (agent->is_default)
+		return;
+
+	app_agent_remove(agent);
+}
+
+static gboolean app_agent_request_send(struct stk_app_agent *agent, int ti=
meout)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	/*
+	 * The cmd_send callback needs to set the method name to
+	 * something different than "Cancel".
+	 */
+	agent->msg =3D dbus_message_new_method_call(agent->bus, agent->path,
+							OFONO_SIM_APP_INTERFACE,
+							"Cancel");
+	if (agent->msg =3D=3D NULL) {
+		ofono_error("Couldn't make a DBusMessage");
+		return FALSE;
+	}
+
+	agent->cmd_send(agent->msg, agent->data);
+
+	if (dbus_connection_send_with_reply(conn,
+				agent->msg, &agent->call, timeout) =3D=3D FALSE ||
+			agent->call =3D=3D NULL) {
+		dbus_message_unref(agent->msg);
+		agent->msg =3D NULL;
+
+		ofono_error("Couldn't send a method call");
+		return FALSE;
+	}
+
+	dbus_pending_call_set_notify(agent->call,
+					app_agent_request_reply_handle,
+					agent, NULL);
+
+	return TRUE;
+}
+
+void app_agent_request_start(struct stk_app_agent *agent,
+				stk_agent_request_send send,
+				stk_agent_request_return cb, int timeout)
+{
+	if (agent =3D=3D NULL) {
+		cb(STK_AGENT_RESULT_TERMINATE, NULL, agent->data);
+
+		return;
+	}
+
+	if (app_agent_busy(agent))
+		app_agent_request_cancel(agent);
+
+	agent->cmd_send =3D send;
+	agent->cmd_cb =3D cb;
+
+	if (!app_agent_request_send(agent, timeout)) {
+		app_agent_request_terminate(agent);
+
+		return;
+	}
+}
+
+static void app_agent_disconnect_cb(DBusConnection *conn, void *user_data)
+{
+	struct stk_app_agent *agent =3D user_data;
+
+	ofono_debug("Agent exited without calling Unregister");
+
+	agent->disconnect_watch =3D 0;
+
+	app_agent_remove(user_data);
+}
+
+struct stk_app_agent *app_agent_create(const char *path, const char *sende=
r,
+					ofono_bool_t is_default,
+					void *user_data, GDestroyNotify notify)
+{
+	struct stk_app_agent *agent =3D g_try_new0(struct stk_app_agent, 1);
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	if (!agent)
+		return NULL;
+
+	agent->path =3D g_strdup(path);
+	agent->bus =3D g_strdup(sender);
+	agent->data =3D user_data;
+	agent->notify =3D notify;
+	agent->is_default =3D is_default;
+
+	agent->disconnect_watch =3D g_dbus_add_disconnect_watch(conn, sender,
+							app_agent_disconnect_cb,
+							agent, NULL);
+
+	return agent;
+}
diff --git a/src/stkagent.h b/src/stkagent.h
new file mode 100644
index 0000000..1b64fa7
--- /dev/null
+++ b/src/stkagent.h
@@ -0,0 +1,60 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
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
+enum stk_agent_result {
+	STK_AGENT_RESULT_OK,
+	STK_AGENT_RESULT_BACK,
+	STK_AGENT_RESULT_TERMINATE,
+	STK_AGENT_RESULT_HELP,
+	STK_AGENT_RESULT_TIMEOUT,
+	STK_AGENT_RESULT_CANCEL,
+};
+
+typedef void (*stk_agent_request_send)(DBusMessage *call, void *user_data);
+
+typedef void (*stk_agent_request_return)(enum stk_agent_result result,
+						DBusMessage *reply,
+						void *user_data);
+
+struct stk_app_agent {
+	char *path;
+	char *bus;
+	DBusMessage *msg;
+	DBusPendingCall *call;
+	guint disconnect_watch;
+	stk_agent_request_send cmd_send;
+	stk_agent_request_return cmd_cb;
+	void *data;
+	ofono_bool_t is_default;
+	GDestroyNotify notify;
+};
+
+struct stk_app_agent *app_agent_create(const char *path, const char *sende=
r,
+					ofono_bool_t is_default,
+					void *user_data, GDestroyNotify notify);
+
+void app_agent_remove(struct stk_app_agent *agent);
+
+void app_agent_request_start(struct stk_app_agent *agent,
+				stk_agent_request_send cmd_send,
+				stk_agent_request_return cmd_cb, int timeout);
+
+void app_agent_request_cancel(struct stk_app_agent *agent);
-- =

1.7.1.86.g0e460.dirty


--===============0614195996672217028==--

