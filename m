Content-Type: multipart/mixed; boundary="===============7719778793254025093=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/6] stk: Add Agent register/unregister methods and logic.
Date: Thu, 15 Jul 2010 15:18:06 +0200
Message-ID: <1279199891-22746-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7719778793254025093==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The interface is mostly unchanged since
http://lists.ofono.org/pipermail/ofono/2010-June/003040.html
but Timeout property is removed and set to 10 minutes and an agent
disconnect sends a User Ended Session response.  If no agent is
registered when the card sends a command for the UI, a User Ended
Session is sent back immediately.  This has made the code a little
shorter.  The "proactive session interaction with terminal display"
(TS 102.223 Section 6.9) is also more correctly implemented now.

This patch adds a skeleton that command implementations use in the
subsequent patches.

org.ofono.SimApplicationAgent
Methods
  (int item, bool help) or GoBack/Terminate Menu(string title,
       array{string} items, bool has_help, bool
       soft_key_preferred, int default_item, bool is_main_menu)
     Handles both Set Up Menu type of menu and Select Item
     since they're similar.  The agent can return GoBack or
     Terminate if is_main_menu is False.  The agent may
     decide to release the display when it receives a main
     menu request following an event other than a GoBack
     response.  default_item may be -1 meaning no default is
     given.

  Ok/GoBack/Terminate DisplayText(string text, bool
       confirmation, bool urgent, bool navigation)
     The UI should show the message, optionally asking the
     user for confirmation.  If navigation is false, the
     returned value will have no effect.  If confirmation is
     false it is optional whether the user can clear the
     message through MMI action (if so, the agent should
     send a reply on user MMI action).  Frames are not
     supported currently.  A low priority message should
     only be shown when the screen is only used for idle
     text display at the moment.  A high priority message
     should be shown when the screen is not used for other
     high priority message such as low battery or incoming
     call information.  (Should there also be a "Screen busy"
     reply so we can pass this information to SIM app, as
     mandated by the spec?)

  string/Back/Terminate/Help GetKey(string message, string charset,
       bool help_available, bool single_key)

     charset is one of:
       "yesno" - response needs to be "yes" or "no"
       "digit" - one of 0-9, *, #, +
       "gsm" - only characters from the GSM SMS charset
       "any" - UCS2 characters
     single_key indicates that only characters from the device's
     key faces are allowed (e.g. no "+" allowed if device only
     has a basic keypad), and that the key should be returned
     without being shown on screen or waiting for any kind of
     user confirmation.

  string/Back/Terminate/Help GetText(string message, string default,
     string charset, byte min, byte max, bool
     help_available, bool password)

     charset is one of:
       "digit" - one of 0-9, *, #, +
       "gsm" - only characters from the GSM SMS charset
       "any" - UCS2 characters
     The returned string must be between min and max characters long.
     The default value should be used as the initial value of the
     text field being edited by user.  If password is True, individual
     characters entered must not be revealed on the screen, but
     indication of new characters can be given, for example by
     showing them as '*'.

  void Cancel(void)
     Cancels a method call in progress, usually due to
     user taking too long to respond (timeout defined
     by the SIM application or manufacturer defined) or
     session termination or other events.  No reply to
     the cancelled call is expected.

  void Release(void)
     Agent is being released, possibly because of ofono
     terminating, SimToolkit interface torn down or modem off.
     Agent is unregistered, no UnregisterAgent call is
     expected.

org.ofono.SimToolkit
Methods
  void RegisterAgent(object)
  void UnregisterAgent(object)
---
 src/stk.c |  346 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 346 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 556dc68..28a1beb 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -46,6 +46,28 @@ struct stk_timer {
 	time_t start;
 };
 =

+enum stk_agent_result {
+	STK_AGENT_RESULT_OK,
+	STK_AGENT_RESULT_HELP,
+	STK_AGENT_RESULT_BACK,
+	STK_AGENT_RESULT_TERMINATE,
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
+	guint send_menu_source;
+	guint cmd_timeout;
+	void (*cmd_send)(struct ofono_stk *stk, DBusMessage *call);
+	void (*cmd_cb)(struct ofono_stk *stk, enum stk_agent_result result,
+			DBusMessage *reply);
+};
+
 struct ofono_stk {
 	const struct ofono_stk_driver *driver;
 	void *driver_data;
@@ -57,6 +79,8 @@ struct ofono_stk {
 	struct stk_timer timers[8];
 	guint timers_source;
 =

+	int timeout;
+	struct stk_app_agent *app_agent;
 	struct sms_submit_req *sms_submit_req;
 	char *idle_mode_text;
 };
@@ -76,6 +100,11 @@ struct sms_submit_req {
 =

 #define ENVELOPE_RETRIES_DEFAULT 5
 =

+#define OFONO_NAVIGATION_PREFIX OFONO_SERVICE ".Navigation"
+#define OFONO_NAVIGATION_GOBACK OFONO_NAVIGATION_PREFIX ".Back"
+#define OFONO_NAVIGATION_TERMINATED OFONO_NAVIGATION_PREFIX ".Terminated"
+#define OFONO_NAVIGATION_HELP OFONO_NAVIGATION_PREFIX ".Help"
+
 static void envelope_queue_run(struct ofono_stk *stk);
 static void timers_update(struct ofono_stk *stk);
 =

@@ -255,8 +284,319 @@ static DBusMessage *stk_get_properties(DBusConnection=
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
+static void app_agent_request_cancel(struct ofono_stk *stk)
+{
+	struct stk_app_agent *agent =3D stk->app_agent;
+
+	if (!agent)
+		return;
+
+	agent->cmd_cb(stk, STK_AGENT_RESULT_CANCEL, NULL);
+
+	app_agent_request_end(agent);
+
+	app_agent_request_send_cancel(agent);
+}
+
+static gboolean app_agent_request_timeout(gpointer user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+	struct stk_app_agent *agent =3D stk->app_agent;
+
+	agent->cmd_timeout =3D 0;
+
+	agent->cmd_cb(stk, STK_AGENT_RESULT_TIMEOUT, NULL);
+
+	app_agent_request_end(agent);
+
+	app_agent_request_send_cancel(agent);
+
+	return FALSE;
+}
+
+static void app_agent_request_reply_handle(DBusPendingCall *call, void *da=
ta)
+{
+	struct ofono_stk *stk =3D data;
+	DBusError err;
+	DBusMessage *reply =3D dbus_pending_call_steal_reply(call);
+	enum stk_agent_result result =3D STK_AGENT_RESULT_OK;
+
+	dbus_error_init(&err);
+	if (dbus_set_error_from_message(&err, reply)) {
+		ofono_error("SimAppAgent %s replied with error %s, %s",
+				stk->app_agent ? stk->app_agent->path :
+				"(destroyed)", err.name, err.message);
+
+		if (g_str_has_prefix(err.name, OFONO_NAVIGATION_GOBACK))
+			result =3D STK_AGENT_RESULT_BACK;
+		else if (g_str_has_prefix(err.name, OFONO_NAVIGATION_HELP))
+			result =3D STK_AGENT_RESULT_HELP;
+		else
+			result =3D STK_AGENT_RESULT_TERMINATE;
+
+		dbus_error_free(&err);
+	}
+
+	if (stk->app_agent) {
+		stk->app_agent->cmd_cb(stk, result, reply);
+
+		app_agent_request_end(stk->app_agent);
+	}
+
+	dbus_message_unref(reply);
+}
+
+static gboolean app_agent_request_send(struct ofono_stk *stk,
+					struct stk_app_agent *agent)
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
+	agent->cmd_send(stk, agent->msg);
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
+					stk, NULL);
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
+	struct stk_app_agent *agent =3D stk->app_agent;
+
+	if (agent =3D=3D NULL) {
+		cb(stk, STK_AGENT_RESULT_TERMINATE, NULL);
+
+		return;
+	}
+
+	if (agent->cmd_cb)
+		app_agent_request_cancel(stk);
+
+	agent->cmd_send =3D send;
+	agent->cmd_cb =3D cb;
+
+	app_agent_request_send(stk, agent);
+
+	/* Use the timeout value specified in the command, if any.  */
+	if (timeout =3D=3D 0)
+		timeout =3D stk->timeout * 1000;
+
+	if (timeout < 0)
+		return;
+
+	agent->cmd_timeout =3D g_timeout_add(timeout, app_agent_request_timeout,
+						stk);
+}
+
+static gboolean app_agent_send_menu(gpointer user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+
+	stk->app_agent->send_menu_source =3D 0;
+
+	/* TODO */
+
+	return FALSE;
+}
+
+static void app_agent_request_cancel_no_agent(struct ofono_stk *stk,
+						struct stk_app_agent *agent)
+{
+	agent->cmd_cb(stk, STK_AGENT_RESULT_TERMINATE, NULL);
+
+	app_agent_request_end(agent);
+}
+
+static void app_agent_remove(struct ofono_stk *stk, struct stk_app_agent *=
agent)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	if (agent->watch) {
+		DBusMessage *message;
+
+		g_dbus_remove_watch(conn, agent->watch);
+		agent->watch =3D 0;
+
+		if (agent->cmd_cb) {
+			app_agent_request_cancel_no_agent(stk, agent);
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
+	} else {
+		if (agent->cmd_cb)
+			app_agent_request_cancel_no_agent(stk, agent);
+	}
+
+	if (agent->send_menu_source)
+		g_source_remove(agent->send_menu_source);
+
+	g_free(agent->path);
+	g_free(agent->bus);
+	g_free(agent);
+}
+
+static void app_agent_disconnect_cb(DBusConnection *conn, void *user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+
+	ofono_debug("Agent exited without calling Unregister");
+
+	stk->app_agent->watch =3D 0;
+
+	app_agent_remove(stk, stk->app_agent);
+	stk->app_agent =3D NULL;
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
+
+	agent->watch =3D g_dbus_add_disconnect_watch(conn, sender,
+							app_agent_disconnect_cb,
+							stk, NULL);
+
+	agent->send_menu_source =3D g_timeout_add(0, app_agent_send_menu, stk);
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
+	if (stk->app_agent)
+		return __ofono_error_busy(msg);
+
+	if (dbus_message_get_args(msg, NULL,
+					DBUS_TYPE_OBJECT_PATH, &agent_path,
+					DBUS_TYPE_INVALID) =3D=3D FALSE)
+		return __ofono_error_invalid_args(msg);
+
+	stk->app_agent =3D app_agent_create(stk, agent_path,
+						dbus_message_get_sender(msg));
+	if (!stk->app_agent)
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
+	if (!stk->app_agent)
+		return __ofono_error_failed(msg);
+
+	if (strcmp(stk->app_agent->path, agent_path))
+		return __ofono_error_failed(msg);
+	if (strcmp(stk->app_agent->bus, agent_bus))
+		return __ofono_error_failed(msg);
+
+	app_agent_remove(stk, stk->app_agent);
+	stk->app_agent =3D NULL;
+
+	return dbus_message_new_method_return(msg);
+}
+
 static GDBusMethodTable stk_methods[] =3D {
 	{ "GetProperties",		"",	"a{sv}",stk_get_properties },
+	{ "RegisterSimAppAgent",	"o",	"",	stk_register_agent },
+	{ "UnregisterSimAppAgent",	"o",	"",	stk_unregister_agent },
 =

 	{ }
 };
@@ -687,6 +1027,11 @@ static void stk_unregister(struct ofono_atom *atom)
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(atom);
 	const char *path =3D __ofono_atom_get_path(atom);
 =

+	if (stk->app_agent) {
+		app_agent_remove(stk, stk->app_agent);
+		stk->app_agent =3D NULL;
+	}
+
 	if (stk->pending_cmd) {
 		stk_command_free(stk->pending_cmd);
 		stk->pending_cmd =3D NULL;
@@ -778,6 +1123,7 @@ void ofono_stk_register(struct ofono_stk *stk)
 =

 	__ofono_atom_register(stk->atom, stk_unregister);
 =

+	stk->timeout =3D 600; /* 10 minutes */
 	stk->envelope_q =3D g_queue_new();
 }
 =

-- =

1.7.1.86.g0e460.dirty


--===============7719778793254025093==--

