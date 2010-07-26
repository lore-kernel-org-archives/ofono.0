Content-Type: multipart/mixed; boundary="===============8056169314235915723=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/6] stk: Add STK agent registration api.
Date: Mon, 26 Jul 2010 15:14:36 +0200
Message-ID: <1280150080-6257-2-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1280150080-6257-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8056169314235915723==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This implements the agent registration and lifecycle and the command
implementations will use the functions added here and in the previous
patch.
---
 src/stk.c |  159 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 159 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 556dc68..a4a091c 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -38,6 +38,7 @@
 #include "common.h"
 #include "smsutil.h"
 #include "stkutil.h"
+#include "stkagent.h"
 =

 static GSList *g_drivers =3D NULL;
 =

@@ -57,6 +58,11 @@ struct ofono_stk {
 	struct stk_timer timers[8];
 	guint timers_source;
 =

+	int timeout;
+	int short_timeout;
+	guint remove_agent_source;
+	struct stk_app_agent *session_agent;
+	struct stk_app_agent *default_agent;
 	struct sms_submit_req *sms_submit_req;
 	char *idle_mode_text;
 };
@@ -255,8 +261,148 @@ static DBusMessage *stk_get_properties(DBusConnection=
 *conn,
 	return reply;
 }
 =

+static void stk_agent_request_start(struct ofono_stk *stk,
+					stk_agent_request_send cmd_send,
+					stk_agent_request_return cmd_cb,
+					int timeout)
+{
+	struct stk_app_agent *agent =3D stk->default_agent;
+
+	if (stk->session_agent)
+		agent =3D stk->session_agent;
+
+	/* Use the timeout value specified in the command or the default.  */
+	if (timeout =3D=3D 0)
+		timeout =3D stk->timeout * 1000;
+	else if (timeout < 0)
+		timeout =3D INT_MAX;
+
+	return app_agent_request_start(agent, cmd_send, cmd_cb, timeout);
+}
+
+static void stk_agent_request_cancel(struct ofono_stk *stk)
+{
+	if (stk->session_agent)
+		app_agent_request_cancel(stk->session_agent);
+
+	if (stk->default_agent)
+		app_agent_request_cancel(stk->default_agent);
+}
+
+static void default_agent_notify(gpointer user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+
+	stk->default_agent =3D NULL;
+}
+
+static void session_agent_notify(gpointer user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+
+	stk->session_agent =3D NULL;
+
+	if (stk->remove_agent_source) {
+		g_source_remove(stk->remove_agent_source);
+		stk->remove_agent_source =3D 0;
+	}
+}
+
+static gboolean session_agent_remove_cb(gpointer user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+
+	stk->remove_agent_source =3D 0;
+
+	app_agent_remove(stk->session_agent);
+
+	return FALSE;
+}
+
+/* Safely remove the agent even inside a callback */
+static void session_agent_remove(struct ofono_stk *stk)
+{
+	if (!stk->remove_agent_source)
+		stk->remove_agent_source =3D
+			g_timeout_add(0, session_agent_remove_cb, stk);
+}
+
+static DBusMessage *stk_register_agent(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct ofono_stk *stk =3D data;
+	const char *agent_path;
+
+	if (stk->default_agent)
+		return __ofono_error_busy(msg);
+
+	if (dbus_message_get_args(msg, NULL,
+					DBUS_TYPE_OBJECT_PATH, &agent_path,
+					DBUS_TYPE_INVALID) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	stk->default_agent =3D app_agent_create(agent_path,
+						dbus_message_get_sender(msg),
+						TRUE, stk,
+						default_agent_notify);
+	if (!stk->default_agent)
+		return __ofono_error_failed(msg);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *stk_unregister_agent(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	struct ofono_stk *stk =3D data;
+	const char *agent_path;
+	const char *agent_bus =3D dbus_message_get_sender(msg);
+
+	if (dbus_message_get_args(msg, NULL,
+					DBUS_TYPE_OBJECT_PATH, &agent_path,
+					DBUS_TYPE_INVALID) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	if (!stk->default_agent)
+		return __ofono_error_failed(msg);
+
+	if (strcmp(stk->default_agent->path, agent_path))
+		return __ofono_error_failed(msg);
+	if (strcmp(stk->default_agent->bus, agent_bus))
+		return __ofono_error_failed(msg);
+
+	app_agent_remove(stk->default_agent);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *stk_select_item(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct ofono_stk *stk =3D data;
+	const char *agent_path;
+	unsigned char selection;
+
+	if (stk->session_agent)
+		return __ofono_error_busy(msg);
+
+	if (dbus_message_get_args(msg, NULL,
+					DBUS_TYPE_BYTE, &selection,
+					DBUS_TYPE_OBJECT_PATH, &agent_path,
+					DBUS_TYPE_INVALID) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	/* TODO */
+
+	return __ofono_error_not_implemented(msg);
+}
+
 static GDBusMethodTable stk_methods[] =3D {
 	{ "GetProperties",		"",	"a{sv}",stk_get_properties },
+	{ "SelectItem",			"yo",	"",	stk_select_item,
+					G_DBUS_METHOD_FLAG_ASYNC },
+	{ "RegisterAgent",		"o",	"",	stk_register_agent },
+	{ "UnregisterAgent",		"o",	"",	stk_unregister_agent },
 =

 	{ }
 };
@@ -576,6 +722,11 @@ static void stk_proactive_command_cancel(struct ofono_=
stk *stk)
 void ofono_stk_proactive_session_end_notify(struct ofono_stk *stk)
 {
 	stk_proactive_command_cancel(stk);
+
+	if (stk->session_agent) {
+		app_agent_remove(stk->session_agent);
+		stk->session_agent =3D NULL;
+	}
 }
 =

 void ofono_stk_proactive_command_notify(struct ofono_stk *stk,
@@ -687,6 +838,12 @@ static void stk_unregister(struct ofono_atom *atom)
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
 	const char *path =3D __ofono_atom_get_path(atom);
 =

+	if (stk->session_agent)
+		app_agent_remove(stk->session_agent);
+
+	if (stk->default_agent)
+		app_agent_remove(stk->default_agent);
+
 	if (stk->pending_cmd) {
 		stk_command_free(stk->pending_cmd);
 		stk->pending_cmd =3D NULL;
@@ -778,6 +935,8 @@ void ofono_stk_register(struct ofono_stk *stk)
 =

 	__ofono_atom_register(stk->atom, stk_unregister);
 =

+	stk->timeout =3D 600; /* 10 minutes */
+	stk->short_timeout =3D 20; /* 20 seconds */
 	stk->envelope_q =3D g_queue_new();
 }
 =

-- =

1.7.1.86.g0e460.dirty


--===============8056169314235915723==--

