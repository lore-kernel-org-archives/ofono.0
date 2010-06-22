Content-Type: multipart/mixed; boundary="===============1030811399563073415=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 8/8] stk: Handle the Display Text command.
Date: Tue, 22 Jun 2010 13:20:51 +0200
Message-ID: <1277205651-29369-8-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1277205651-29369-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1030811399563073415==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |  255 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+---
 1 files changed, 244 insertions(+), 11 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index b752e49..cf28a96 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -77,6 +77,7 @@ struct ofono_stk {
 =

 	struct stk_menu *default_menu;
 	struct stk_menu *current_menu; /* For Select Item menus */
+	const char *display_text;
 	int timeout;
 };
 =

@@ -355,6 +356,8 @@ static void emit_menu_changed(struct ofono_stk *stk)
 		menu =3D stk->default_menu;
 	if (stk->current_menu)
 		menu =3D stk->current_menu;
+	if (stk->display_text)
+		menu =3D &no_menu;
 =

 	if (stk->cmd_timeout && stk->current_menu)
 		ofono_dbus_signal_property_changed(conn, path,
@@ -425,6 +428,78 @@ static gboolean select_item_timeout(gpointer user_data)
 	return FALSE;
 }
 =

+static void emit_text_changed(struct ofono_stk *stk)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(stk->atom);
+	dbus_uint16_t timeout =3D stk->timeout;
+	const char *text =3D stk->display_text ?: "";
+	dbus_bool_t boolval;
+
+	if (stk->cmd_timeout && stk->display_text)
+		ofono_dbus_signal_property_changed(conn, path,
+						OFONO_SIM_APP_INTERFACE,
+						"Timeout",
+						DBUS_TYPE_UINT16, &timeout);
+
+	ofono_dbus_signal_property_changed(conn, path,
+						OFONO_SIM_APP_INTERFACE,
+						"Message", DBUS_TYPE_STRING,
+						&text);
+
+	boolval =3D stk->display_text &&
+		(stk->pending_cmd->qualifier & (1 << 7)) !=3D 0;
+	ofono_dbus_signal_property_changed(conn, path,
+						OFONO_SIM_APP_INTERFACE,
+						"UserConfirmMessage",
+						DBUS_TYPE_BOOLEAN, &boolval);
+
+	boolval =3D stk->display_text &&
+		(stk->pending_cmd->qualifier & (1 << 0)) !=3D 0;
+	ofono_dbus_signal_property_changed(conn, path,
+						OFONO_SIM_APP_INTERFACE,
+						"PriorityMessage",
+						DBUS_TYPE_BOOLEAN, &boolval);
+}
+
+static gboolean display_text_timeout(gpointer user_data)
+{
+	struct ofono_stk *stk =3D user_data;
+	struct stk_response rsp;
+
+	stk->cmd_timeout =3D 0;
+
+	if (stk->pending)
+		/* A command is currently executing, do nothing.  */
+		return FALSE;
+
+	ofono_debug("Display Text command timed out");
+
+	stk->display_text =3D NULL;
+
+	if (stk->pending_cmd->display_text.immediate_response =3D=3D TRUE) {
+		/* Already responded */
+		stk_command_free(stk->pending_cmd);
+		stk->pending_cmd =3D NULL;
+
+		return FALSE;
+	}
+
+	memset(&rsp, 0, sizeof(rsp));
+	if (stk->pending_cmd->qualifier & (1 << 7))
+		rsp.result.type =3D STK_RESULT_TYPE_NO_RESPONSE;
+
+	stk_respond(stk, &rsp, stk_command_cb);
+
+	emit_text_changed(stk);
+
+	/* If manu was overridden by text, now re-show it */
+	if (stk->default_menu)
+		emit_menu_changed(stk);
+
+	return FALSE;
+}
+
 static DBusMessage *stk_get_properties(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -440,6 +515,8 @@ static DBusMessage *stk_get_properties(DBusConnection *=
conn,
 =

 	if (stk->current_menu)
 		menu =3D stk->current_menu;
+	if (stk->display_text)
+		menu =3D NULL;
 =

 	reply =3D dbus_message_new_method_return(msg);
 	if (!reply)
@@ -451,13 +528,26 @@ static DBusMessage *stk_get_properties(DBusConnection=
 *conn,
 					OFONO_PROPERTIES_ARRAY_SIGNATURE,
 					&dict);
 =

-	if (!menu)
-		goto done;
-
-	if (stk->cmd_timeout && stk->current_menu)
+	if (stk->cmd_timeout && (stk->current_menu || stk->display_text))
 		ofono_dbus_dict_append(&dict, "Timeout",
 					DBUS_TYPE_UINT16, &timeout);
 =

+	if (stk->display_text) {
+		ofono_dbus_dict_append(&dict, "Message",
+					DBUS_TYPE_STRING, &stk->display_text);
+
+		boolval =3D (stk->pending_cmd->qualifier & (1 << 7)) !=3D 0;
+		ofono_dbus_dict_append(&dict, "UserConfirmMessage",
+					DBUS_TYPE_BOOLEAN, &boolval);
+
+		boolval =3D (stk->pending_cmd->qualifier & (1 << 0)) !=3D 0;
+		ofono_dbus_dict_append(&dict, "PriorityMessage",
+					DBUS_TYPE_BOOLEAN, &boolval);
+	}
+
+	if (!menu)
+		goto done;
+
 	items =3D stk_menu_items_strlist(menu);
 	ofono_dbus_dict_append_array(&dict, "MenuItems",
 					DBUS_TYPE_STRING, &items);
@@ -511,7 +601,7 @@ static DBusMessage *stk_set_property(DBusConnection *co=
nn,
 =

 	dbus_message_iter_recurse(&iter, &var);
 =

-	if (stk->cmd_timeout && stk->current_menu &&
+	if (stk->cmd_timeout && (stk->current_menu && stk->display_text) &&
 			!strcmp(property, "Timeout")) {
 		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_UINT16)
 			return __ofono_error_invalid_args(msg);
@@ -522,10 +612,18 @@ static DBusMessage *stk_set_property(DBusConnection *=
conn,
 =

 		stk->timeout =3D timeout;
 =

-		g_source_remove(stk->cmd_timeout);
-		stk->cmd_timeout =3D g_timeout_add_seconds(stk->timeout,
+		if (stk->current_menu) {
+			g_source_remove(stk->cmd_timeout);
+			stk->cmd_timeout =3D g_timeout_add_seconds(stk->timeout,
 							select_item_timeout,
 							stk);
+		} else if (stk->display_text && stk->pending_cmd->display_text.
+				duration.interval =3D=3D 0) {
+			g_source_remove(stk->cmd_timeout);
+			stk->cmd_timeout =3D g_timeout_add_seconds(stk->timeout,
+							display_text_timeout,
+							stk);
+		}
 =

 		ofono_dbus_signal_property_changed(conn, path,
 						OFONO_SIM_APP_INTERFACE,
@@ -562,6 +660,37 @@ static void select_item_cancel(struct ofono_stk *stk)
 	emit_menu_changed(stk);
 }
 =

+static void display_text_cancel(struct ofono_stk *stk)
+{
+	if (stk->pending)
+		stk->cancelled =3D TRUE;
+
+	if (stk->cmd_timeout) {
+		g_source_remove(stk->cmd_timeout);
+		stk->cmd_timeout =3D 0;
+	}
+
+	stk->display_text =3D NULL;
+
+	stk_command_free(stk->pending_cmd);
+	stk->pending_cmd =3D NULL;
+
+	emit_text_changed(stk);
+	emit_menu_changed(stk);
+}
+
+static void display_text_immediate_cb(const struct ofono_error *error,
+					struct ofono_stk *stk)
+{
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		ofono_error("TERMINAL RESPONSE to Display Text failed: %s",
+				telephony_error_to_str(error));
+		return;
+	}
+
+	DBG("TERMINAL RESPONSE to Display Text reported no errors");
+}
+
 static void select_item_cb(const struct ofono_error *error,
 				struct ofono_stk *stk)
 {
@@ -591,7 +720,7 @@ static void select_item_cb(const struct ofono_error *er=
ror,
 	emit_menu_changed(stk);
 =

 out:
-	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR)
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
 		reply =3D __ofono_error_failed(stk->pending);
 	else
 		reply =3D dbus_message_new_method_return(stk->pending);
@@ -657,6 +786,8 @@ static DBusMessage *stk_menu_select(DBusConnection *con=
n, DBusMessage *msg,
 =

 	if (stk->pending)
 		return __ofono_error_busy(msg);
+	if (stk->pending_cmd && !stk->current_menu)
+		return __ofono_error_busy(msg);
 =

 	if (!dbus_message_iter_init(msg, &iter))
 		return __ofono_error_invalid_args(msg);
@@ -705,6 +836,47 @@ static DBusMessage *stk_get_help(DBusConnection *conn,
 	return stk_menu_select(conn, msg, data, TRUE);
 }
 =

+static void display_text_cb(const struct ofono_error *error,
+				struct ofono_stk *stk)
+{
+	DBusMessage *reply;
+
+	if (stk->cancelled =3D=3D TRUE)
+		/* Command cancelled */
+		goto out;
+
+	if (stk->cmd_timeout) {
+		/*
+		 * If the command has not timed out yet, return error and
+		 * the user may then retry the command.  Otherwise assume
+		 * the text is no longer valid.
+		 */
+		if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
+			goto out;
+
+		g_source_remove(stk->cmd_timeout);
+	}
+
+	stk->display_text =3D NULL;
+
+	if (error)
+		stk_command_cb(error, stk);
+
+	emit_text_changed(stk);
+	emit_menu_changed(stk);
+
+out:
+	if (!error)
+		return;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
+		reply =3D __ofono_error_failed(stk->pending);
+	else
+		reply =3D dbus_message_new_method_return(stk->pending);
+
+	__ofono_dbus_pending_reply(&stk->pending, reply);
+}
+
 static DBusMessage *stk_back_or_terminate(DBusConnection *conn,
 					DBusMessage *msg, void *data,
 					enum stk_result_type type)
@@ -716,19 +888,34 @@ static DBusMessage *stk_back_or_terminate(DBusConnect=
ion *conn,
 	if (stk->pending)
 		return __ofono_error_busy(msg);
 =

-	if (!stk->current_menu)
+	if (!stk->current_menu && !stk->display_text)
 		return __ofono_error_failed(msg);
 =

 	if (dbus_message_iter_init(msg, &iter))
 		return __ofono_error_invalid_args(msg);
 =

 	stk->cancelled =3D FALSE;
-	stk->pending =3D dbus_message_ref(msg);
 =

 	memset(&rsp, 0, sizeof(rsp));
 	rsp.result.type =3D type;
 =

-	stk_respond(stk, &rsp, select_item_cb);
+	if (stk->current_menu) {
+		stk->pending =3D dbus_message_ref(msg);
+
+		stk_respond(stk, &rsp, select_item_cb);
+	} else if (stk->display_text) {
+		if (stk->pending_cmd->display_text.immediate_response =3D=3D TRUE) {
+			if (type !=3D STK_RESULT_TYPE_SUCCESS)
+				return __ofono_error_failed(msg);
+
+			display_text_cb(NULL, stk);
+			return dbus_message_new_method_return(msg);
+		}
+
+		stk->pending =3D dbus_message_ref(msg);
+
+		stk_respond(stk, &rsp, display_text_cb);
+	}
 =

 	return NULL;
 }
@@ -747,6 +934,13 @@ static DBusMessage *stk_end_session(DBusConnection *co=
nn,
 					STK_RESULT_TYPE_USER_TERMINATED);
 }
 =

+static DBusMessage *stk_confirm(DBusConnection *conn,
+				DBusMessage *msg, void *data)
+{
+	return stk_back_or_terminate(conn, msg, data,
+					STK_RESULT_TYPE_SUCCESS);
+}
+
 static GDBusMethodTable stk_methods[] =3D {
 	{ "GetProperties",	"",	"a{sv}",	stk_get_properties },
 	{ "SetProperty",	"sv",	"",		stk_set_property },
@@ -758,6 +952,8 @@ static GDBusMethodTable stk_methods[] =3D {
 				G_DBUS_METHOD_FLAG_ASYNC },
 	{ "EndSession",		"",	"",		stk_end_session,
 				G_DBUS_METHOD_FLAG_ASYNC },
+	{ "Confirm",		"",	"",		stk_confirm,
+				G_DBUS_METHOD_FLAG_ASYNC },
 	{ }
 };
 =

@@ -829,6 +1025,41 @@ out:
 	return TRUE;
 }
 =

+static gboolean handle_command_display_text(const struct stk_command *cmd,
+						struct stk_response *rsp,
+						struct ofono_stk *stk)
+{
+	int timeout =3D stk->timeout * 1000;
+
+	if (cmd->display_text.duration.interval) {
+		timeout =3D cmd->display_text.duration.interval;
+		switch (cmd->display_text.duration.unit) {
+		case STK_DURATION_TYPE_MINUTES:
+			timeout *=3D 60;
+		case STK_DURATION_TYPE_SECONDS:
+			timeout *=3D 10;
+		case STK_DURATION_TYPE_SECOND_TENTHS:
+			timeout *=3D 100;
+		}
+	}
+
+	stk->display_text =3D cmd->display_text.text;
+
+	/* May need to hide the menu to display the message */
+	if (stk->default_menu)
+		emit_menu_changed(stk);
+
+	emit_text_changed(stk);
+
+	stk->cmd_timeout =3D g_timeout_add(timeout, display_text_timeout, stk);
+	stk->cancel_cmd =3D display_text_cancel;
+
+	if (cmd->display_text.immediate_response =3D=3D TRUE)
+		stk_respond(stk, rsp, display_text_immediate_cb);
+
+	return FALSE;
+}
+
 int ofono_stk_driver_register(const struct ofono_stk_driver *d)
 {
 	DBG("driver: %p, name: %s", d, d->name);
@@ -934,6 +1165,8 @@ struct ofono_stk *ofono_stk_create(struct ofono_modem =
*modem,
 					handle_command_select_item);
 	stk_command_handler_register(stk, STK_COMMAND_TYPE_SETUP_MENU,
 					handle_command_set_up_menu);
+	stk_command_handler_register(stk, STK_COMMAND_TYPE_DISPLAY_TEXT,
+					handle_command_display_text);
 =

 	return stk;
 }
-- =

1.7.1.86.g0e460.dirty


--===============1030811399563073415==--

