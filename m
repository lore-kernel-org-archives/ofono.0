Content-Type: multipart/mixed; boundary="===============1448420387185512525=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/5] stk: Add agent registration and logic.
Date: Thu, 22 Jul 2010 13:42:49 +0200
Message-ID: <1279798973-6612-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1448420387185512525==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds a skeleton that command implementations use in the
subsequent patches.

Icons and text attributes are not implemented in this series, I'll
send them separately.  There are slight differences from
doc/stk-api.txt, for example org.ofono.Error.EndSession can be used
to terminate either a user-initiated or UICC-initiated session.

Should we change the ".Error" part to something like ".Navigation",
since these are not error conditions and may be confusing?
---
 src/stk.c |  396 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 396 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 556dc68..3ccb7e9 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -46,6 +46,28 @@ struct stk_timer {
 	time_t start;
 };
 =

+enum stk_agent_result {
+	STK_AGENT_RESULT_OK,
+	STK_AGENT_RESULT_BACK,
+	STK_AGENT_RESULT_TERMINATE,
+	STK_AGENT_RESULT_HELP,
+	STK_AGENT_RESULT_TIMEOUT,
+	STK_AGENT_RESULT_CANCEL,
+};
+
+struct stk_app_agent {
+	char *path;
+	char *bus;
+	DBusMessage *msg;
+	DBusPendingCall *call;
+	guint watch;
+	guint cmd_timeout;
+	void (*cmd_send)(struct ofono_stk *stk, DBusMessage *call);
+	void (*cmd_cb)(struct ofono_stk *stk, enum stk_agent_result result,
+			DBusMessage *reply);
+	struct ofono_stk *stk;
+};
+
 struct ofono_stk {
 	const struct ofono_stk_driver *driver;
 	void *driver_data;
@@ -57,6 +79,10 @@ struct ofono_stk {
 	struct stk_timer timers[8];
 	guint timers_source;
 =

+	int timeout;
+	int short_timeout;
+	struct stk_app_agent *primary_agent;
+	struct stk_app_agent *default_agent;
 	struct sms_submit_req *sms_submit_req;
 	char *idle_mode_text;
 };
@@ -76,6 +102,10 @@ struct sms_submit_req {
 =

 #define ENVELOPE_RETRIES_DEFAULT 5
 =

+#define OFONO_NAVIGATION_PREFIX OFONO_SERVICE ".Error"
+#define OFONO_NAVIGATION_GOBACK OFONO_NAVIGATION_PREFIX ".GoBack"
+#define OFONO_NAVIGATION_TERMINATED OFONO_NAVIGATION_PREFIX ".EndSession"
+
 static void envelope_queue_run(struct ofono_stk *stk);
 static void timers_update(struct ofono_stk *stk);
 =

@@ -255,8 +285,361 @@ static DBusMessage *stk_get_properties(DBusConnection=
 *conn,
 	return reply;
 }
 =

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
+	if (agent->cmd_timeout) {
+		g_source_remove(agent->cmd_timeout);
+		agent->cmd_timeout =3D 0;
+	}
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
+static void app_agent_request_cancel(struct stk_app_agent *agent)
+{
+	if (!agent->cmd_send)
+		return;
+
+	agent->cmd_cb(agent->stk, STK_AGENT_RESULT_CANCEL, NULL);
+
+	app_agent_request_end(agent);
+
+	app_agent_request_send_cancel(agent);
+}
+
+static void stk_agent_request_cancel(struct ofono_stk *stk)
+{
+	if (stk->primary_agent)
+		app_agent_request_cancel(stk->primary_agent);
+
+	if (stk->default_agent)
+		app_agent_request_cancel(stk->default_agent);
+}
+
+static gboolean app_agent_request_timeout(gpointer user_data)
+{
+	struct stk_app_agent *agent =3D user_data;
+
+	agent->cmd_timeout =3D 0;
+
+	agent->cmd_cb(agent->stk, STK_AGENT_RESULT_TIMEOUT, NULL);
+
+	app_agent_request_end(agent);
+
+	app_agent_request_send_cancel(agent);
+
+	return FALSE;
+}
+
+static void app_agent_request_terminate(struct stk_app_agent *agent)
+{
+	agent->cmd_cb(agent->stk, STK_AGENT_RESULT_TERMINATE, NULL);
+
+	app_agent_request_end(agent);
+}
+
+static void app_agent_remove(void *user_data)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	struct stk_app_agent *agent =3D user_data;
+
+	if (agent->watch) {
+		DBusMessage *message;
+
+		if (agent->cmd_cb) {
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
+		g_dbus_remove_watch(conn, agent->watch);
+		agent->watch =3D 0;
+	} else {
+		if (agent->cmd_cb)
+			app_agent_request_terminate(agent);
+	}
+
+	if (agent->stk->primary_agent =3D=3D agent)
+		agent->stk->primary_agent =3D NULL;
+	if (agent->stk->default_agent =3D=3D agent)
+		agent->stk->default_agent =3D NULL;
+
+	if (agent->remove_agent_source) {
+		g_source_remove(agent->remove_agent_source);
+		agent->remove_agent_source =3D 0;
+	}
+
+	g_free(agent->path);
+	g_free(agent->bus);
+	g_free(agent);
+}
+
+static gboolean app_agent_remove_cb(gpointer user_data)
+{
+	struct stk_app_agent *agent =3D user_data;
+
+	agent->remove_agent_source =3D 0;
+
+	app_agent_remove(user_data);
+
+	return FALSE;
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
+		if (g_str_has_prefix(err.name, OFONO_NAVIGATION_GOBACK))
+			result =3D STK_AGENT_RESULT_BACK;
+		else
+			result =3D STK_AGENT_RESULT_TERMINATE;
+
+		dbus_error_free(&err);
+	}
+
+	agent->cmd_cb(agent->stk, result, reply);
+
+	app_agent_request_end(agent);
+
+	dbus_message_unref(reply);
+
+	if (result !=3D STK_AGENT_RESULT_TERMINATE)
+		return;
+
+	if (agent->stk->primary_agent !=3D agent)
+		return;
+
+	app_agent_remove(agent);
+}
+
+static gboolean app_agent_request_send(struct stk_app_agent *agent)
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
+	agent->cmd_send(agent->stk, agent->msg);
+
+	if (dbus_connection_send_with_reply(conn,
+				agent->msg, &agent->call, INT_MAX) =3D=3D FALSE ||
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
+static void app_agent_request_start(struct ofono_stk *stk,
+					void (*send)(struct ofono_stk *stk,
+							DBusMessage *call),
+					void (*cb)(struct ofono_stk *stk,
+						enum stk_agent_result result,
+						DBusMessage *reply),
+					int timeout)
+{
+	struct stk_app_agent *agent =3D stk->default_agent;
+
+	if (stk->primary_agent)
+		agent =3D stk->primary_agent;
+
+	if (agent =3D=3D NULL) {
+		cb(stk, STK_AGENT_RESULT_TERMINATE, NULL);
+
+		return;
+	}
+
+	if (agent->cmd_cb)
+		app_agent_request_cancel(agent);
+
+	agent->cmd_send =3D send;
+	agent->cmd_cb =3D cb;
+
+	if (!app_agent_request_send(agent)) {
+		app_agent_request_terminate(agent);
+
+		return;
+	}
+
+	/* Use the timeout value specified in the command or the default.  */
+	if (timeout =3D=3D 0)
+		timeout =3D stk->timeout * 1000;
+
+	if (timeout < 0)
+		return;
+
+	agent->cmd_timeout =3D g_timeout_add(timeout, app_agent_request_timeout,
+						agent);
+}
+
+static void app_agent_disconnect_cb(DBusConnection *conn, void *user_data)
+{
+	struct stk_app_agent *agent =3D user_data;
+
+	ofono_debug("Agent exited without calling Unregister");
+
+	agent->watch =3D 0;
+
+	app_agent_remove(user_data);
+}
+
+static struct stk_app_agent *app_agent_create(struct ofono_stk *stk,
+						const char *path,
+						const char *sender)
+{
+	struct stk_app_agent *agent =3D g_try_new0(struct stk_app_agent, 1);
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	if (!agent)
+		return NULL;
+
+	agent->path =3D g_strdup(path);
+	agent->bus =3D g_strdup(sender);
+	agent->stk =3D stk;
+
+	agent->watch =3D g_dbus_add_disconnect_watch(conn, sender,
+							app_agent_disconnect_cb,
+							agent, NULL);
+
+	return agent;
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
+	stk->default_agent =3D app_agent_create(stk, agent_path,
+						dbus_message_get_sender(msg));
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
+	if (stk->primary_agent)
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
+	return NULL;
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
@@ -576,6 +959,11 @@ static void stk_proactive_command_cancel(struct ofono_=
stk *stk)
 void ofono_stk_proactive_session_end_notify(struct ofono_stk *stk)
 {
 	stk_proactive_command_cancel(stk);
+
+	if (stk->primary_agent) {
+		app_agent_remove(stk->primary_agent);
+		stk->primary_agent =3D NULL;
+	}
 }
 =

 void ofono_stk_proactive_command_notify(struct ofono_stk *stk,
@@ -687,6 +1075,12 @@ static void stk_unregister(struct ofono_atom *atom)
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
 	const char *path =3D __ofono_atom_get_path(atom);
 =

+	if (stk->primary_agent)
+		app_agent_remove(stk->primary_agent);
+
+	if (stk->default_agent)
+		app_agent_remove(stk->default_agent);
+
 	if (stk->pending_cmd) {
 		stk_command_free(stk->pending_cmd);
 		stk->pending_cmd =3D NULL;
@@ -778,6 +1172,8 @@ void ofono_stk_register(struct ofono_stk *stk)
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


--===============1448420387185512525==--

