Content-Type: multipart/mixed; boundary="===============8716997619400588735=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/6] stk: Add STK agent registration api.
Date: Wed, 28 Jul 2010 12:26:07 +0200
Message-ID: <1280312771-30579-2-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1280312771-30579-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8716997619400588735==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |  149 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 149 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 556dc68..4d895b5 100644
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

@@ -57,6 +58,12 @@ struct ofono_stk {
 	struct stk_timer timers[8];
 	guint timers_source;
 =

+	int timeout;
+	int short_timeout;
+	guint remove_agent_source;
+	struct stk_agent *session_agent;
+	struct stk_agent *default_agent;
+	struct stk_agent *current_agent; /* Always equals one of the above */
 	struct sms_submit_req *sms_submit_req;
 	char *idle_mode_text;
 };
@@ -255,8 +262,139 @@ static DBusMessage *stk_get_properties(DBusConnection=
 *conn,
 	return reply;
 }
 =

+static void stk_request_cancel(struct ofono_stk *stk)
+{
+	if (stk->session_agent)
+		stk_agent_request_cancel(stk->session_agent);
+
+	if (stk->default_agent)
+		stk_agent_request_cancel(stk->default_agent);
+}
+
+static void default_agent_notify(gpointer user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+
+	stk->default_agent =3D NULL;
+
+	stk->current_agent =3D stk->session_agent;
+}
+
+static void session_agent_notify(gpointer user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+
+	stk->session_agent =3D NULL;
+
+	stk->current_agent =3D stk->default_agent;
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
+	stk_agent_remove(stk->session_agent);
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
+	if (!__ofono_dbus_valid_object_path(agent_path))
+		return __ofono_error_invalid_format(msg);
+
+	stk->default_agent =3D stk_agent_new(agent_path,
+						dbus_message_get_sender(msg),
+						TRUE);
+	if (!stk->default_agent)
+		return __ofono_error_failed(msg);
+
+	stk_agent_set_destroy_watch(stk->default_agent,
+					default_agent_notify, stk);
+
+	if (!stk->session_agent)
+		stk->current_agent =3D stk->default_agent;
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
+	if (!stk_agent_matches(stk->default_agent, agent_path, agent_bus))
+		return __ofono_error_failed(msg);
+
+	stk_agent_remove(stk->default_agent);
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
@@ -576,6 +714,9 @@ static void stk_proactive_command_cancel(struct ofono_s=
tk *stk)
 void ofono_stk_proactive_session_end_notify(struct ofono_stk *stk)
 {
 	stk_proactive_command_cancel(stk);
+
+	if (stk->session_agent)
+		stk_agent_remove(stk->session_agent);
 }
 =

 void ofono_stk_proactive_command_notify(struct ofono_stk *stk,
@@ -687,6 +828,12 @@ static void stk_unregister(struct ofono_atom *atom)
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
 	const char *path =3D __ofono_atom_get_path(atom);
 =

+	if (stk->session_agent)
+		stk_agent_remove(stk->session_agent);
+
+	if (stk->default_agent)
+		stk_agent_remove(stk->default_agent);
+
 	if (stk->pending_cmd) {
 		stk_command_free(stk->pending_cmd);
 		stk->pending_cmd =3D NULL;
@@ -778,6 +925,8 @@ void ofono_stk_register(struct ofono_stk *stk)
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


--===============8716997619400588735==--

