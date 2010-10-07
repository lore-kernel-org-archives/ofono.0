Content-Type: multipart/mixed; boundary="===============1079445844436809404=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/2] stk: Expose icon IDs on D-Bus.
Date: Thu, 07 Oct 2010 16:20:05 +0200
Message-ID: <1286461206-4446-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1079445844436809404==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Update the docs to match the properties in stk.c.
---
 doc/stk-api.txt |   16 ++++++-
 src/stk.c       |  112 ++++++++++++++++++++++++++++++++++-----------------=
----
 src/stkagent.c  |   41 ++++++++++++--------
 src/stkagent.h  |   34 +++++++++-------
 4 files changed, 125 insertions(+), 78 deletions(-)

diff --git a/doc/stk-api.txt b/doc/stk-api.txt
index f5b9ebc..c29872a 100644
--- a/doc/stk-api.txt
+++ b/doc/stk-api.txt
@@ -55,23 +55,33 @@ Signals		PropertyChanged(string property, variant value)
 			Signal is emitted whenever a property has changed.
 			The new value is passed as the signal argument.
 =

-Properties	string IdleText
+Properties	string IdleModeText
 =

 			Contains the text to be used when the home screen is
-			idle.  This text is set by the SIM and can be changed
+			idle.  This text is set by the SIM and can change
 			at any time.
 =

+		byte IdleModeIcon
+
+			Contains the identifier of the icon accompanying
+			the idle mode text.
+
 		array{struct{string, byte}} MainMenu
 =

 			Contains the items that make up the main menu.  This
 			is populated by the SIM when it sends the Setup Menu
 			Proactive Command.  The main menu is always available,
-			but its contents can be changed at any time.
+			but its contents can be changed at any time.  Each
+			item contains the item label and icon identifier.
 =

 		string MainMenuTitle
 =

 			Contains the title of the main menu.
 =

+		string MainMenuIcon
+
+			Contains the identifier of the icon for the main menu.
+
 		array{byte} Icons
 =

 			Contains the identifiers of all available icons for
diff --git a/src/stk.c b/src/stk.c
index 84a22c9..7aa2ea6 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -72,6 +72,7 @@ struct ofono_stk {
 	guint remove_agent_source;
 	struct extern_req *extern_req;
 	char *idle_mode_text;
+	struct stk_icon_id idle_mode_icon;
 	struct timeval get_inkey_start_ts;
 };
 =

@@ -256,19 +257,28 @@ void __ofono_cbs_sim_download(struct ofono_stk *stk, =
const struct cbs *msg)
 }
 =

 static struct stk_menu *stk_menu_create(const char *title,
-		const struct stk_text_attribute *title_attr, GSList *items,
+		const struct stk_text_attribute *title_attr,
+		const struct stk_icon_id *icon, GSList *items,
 		const struct stk_item_text_attribute_list *item_attrs,
+		const struct stk_item_icon_id_list *item_icon_ids,
 		int default_id, gboolean soft_key, gboolean has_help)
 {
 	struct stk_menu *ret =3D g_new(struct stk_menu, 1);
+	unsigned int len =3D g_slist_length(items);
 	GSList *l;
 	int i;
 =

 	DBG("");
 =

+	if (item_attrs && item_attrs->len && item_attrs->len !=3D len * 4)
+		goto error;
+
+	if (item_icon_ids && item_icon_ids->len && item_icon_ids->len !=3D len)
+		goto error;
+
 	ret->title =3D g_strdup(title ? title : "");
-	ret->icon_id =3D 0;
-	ret->items =3D g_new0(struct stk_menu_item, g_slist_length(items) + 1);
+	memcpy(&ret->icon, icon, sizeof(ret->icon));
+	ret->items =3D g_new0(struct stk_menu_item, len + 1);
 	ret->default_item =3D -1;
 	ret->soft_key =3D soft_key;
 	ret->has_help =3D has_help;
@@ -278,12 +288,18 @@ static struct stk_menu *stk_menu_create(const char *t=
itle,
 =

 		ret->items[i].text =3D g_strdup(item->text);
 		ret->items[i].item_id =3D item->id;
+		if (item_icon_ids && item_icon_ids->len)
+			ret->items[i].icon_id =3D item_icon_ids->list[i];
 =

 		if (item->id =3D=3D default_id)
 			ret->default_item =3D i;
 	}
 =

 	return ret;
+
+error:
+	g_free(ret);
+	return NULL;
 }
 =

 static struct stk_menu *stk_menu_create_from_set_up_menu(
@@ -294,8 +310,10 @@ static struct stk_menu *stk_menu_create_from_set_up_me=
nu(
 =

 	return stk_menu_create(cmd->setup_menu.alpha_id,
 				&cmd->setup_menu.text_attr,
+				&cmd->setup_menu.icon_id,
 				cmd->setup_menu.items,
 				&cmd->setup_menu.item_text_attr_list,
+				&cmd->setup_menu.item_icon_id_list,
 				0, soft_key, has_help);
 }
 =

@@ -307,8 +325,10 @@ static struct stk_menu *stk_menu_create_from_select_it=
em(
 =

 	return stk_menu_create(cmd->select_item.alpha_id,
 				&cmd->select_item.text_attr,
+				&cmd->select_item.icon_id,
 				cmd->select_item.items,
 				&cmd->select_item.item_text_attr_list,
+				&cmd->select_item.item_icon_id_list,
 				cmd->select_item.item_id, soft_key, has_help);
 }
 =

@@ -345,6 +365,11 @@ static void emit_menu_changed(struct ofono_stk *stk)
 						"MainMenuTitle",
 						DBUS_TYPE_STRING, &menu->title);
 =

+	ofono_dbus_signal_property_changed(conn, path,
+						OFONO_STK_INTERFACE,
+						"MainMenuIcon",
+						DBUS_TYPE_BYTE, &menu->icon.id);
+
 	signal =3D dbus_message_new_signal(path, OFONO_STK_INTERFACE,
 						"PropertyChanged");
 	if (!signal) {
@@ -371,6 +396,9 @@ static void dict_append_menu(DBusMessageIter *dict, str=
uct stk_menu *menu)
 	ofono_dbus_dict_append(dict, "MainMenuTitle",
 				DBUS_TYPE_STRING, &menu->title);
 =

+	ofono_dbus_dict_append(dict, "MainMenuIcon",
+				DBUS_TYPE_BYTE, &menu->icon.id);
+
 	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
 						NULL, &entry);
 =

@@ -381,7 +409,8 @@ static void dict_append_menu(DBusMessageIter *dict, str=
uct stk_menu *menu)
 	dbus_message_iter_close_container(dict, &entry);
 }
 =

-static void stk_alpha_id_set(struct ofono_stk *stk, const char *text)
+static void stk_alpha_id_set(struct ofono_stk *stk, const char *text,
+		const struct stk_icon_id *icon)
 {
 	/* TODO */
 }
@@ -414,6 +443,10 @@ static DBusMessage *stk_get_properties(DBusConnection =
*conn,
 	ofono_dbus_dict_append(&dict, "IdleModeText",
 				DBUS_TYPE_STRING, &idle_mode_text);
 =

+	if (stk->idle_mode_icon.id)
+		ofono_dbus_dict_append(&dict, "IdleModeIcon", DBUS_TYPE_BYTE,
+					&stk->idle_mode_icon.id);
+
 	if (stk->main_menu)
 		dict_append_menu(&dict, stk->main_menu);
 =

@@ -662,10 +695,6 @@ static void send_sms_cancel(struct ofono_stk *stk)
 {
 	stk->extern_req->cancelled =3D TRUE;
 =

-	if (!stk->pending_cmd->send_sms.alpha_id ||
-			!stk->pending_cmd->send_sms.alpha_id[0])
-		return;
-
 	stk_alpha_id_unset(stk);
 }
 =

@@ -684,9 +713,7 @@ static void send_sms_submit_cb(gboolean ok, void *data)
 		return;
 	}
 =

-	if (stk->pending_cmd->send_sms.alpha_id &&
-			stk->pending_cmd->send_sms.alpha_id[0])
-		stk_alpha_id_unset(stk);
+	stk_alpha_id_unset(stk);
 =

 	memset(&rsp, 0, sizeof(rsp));
 =

@@ -735,8 +762,7 @@ static gboolean handle_command_send_sms(const struct st=
k_command *cmd,
 =

 	stk->cancel_cmd =3D send_sms_cancel;
 =

-	if (cmd->send_sms.alpha_id && cmd->send_sms.alpha_id[0])
-		stk_alpha_id_set(stk, cmd->send_sms.alpha_id);
+	stk_alpha_id_set(stk, cmd->send_sms.alpha_id, &cmd->send_sms.icon_id);
 =

 	return FALSE;
 }
@@ -763,6 +789,16 @@ static gboolean handle_command_set_idle_text(const str=
uct stk_command *cmd,
 						DBUS_TYPE_STRING,
 						&idle_mode_text);
 =

+	if (stk->idle_mode_icon.id !=3D cmd->setup_idle_mode_text.icon_id.id) {
+		memcpy(&stk->idle_mode_icon, &cmd->setup_idle_mode_text.icon_id,
+				sizeof(stk->idle_mode_icon));
+
+		ofono_dbus_signal_property_changed(conn, path,
+						OFONO_STK_INTERFACE,
+						"IdleModeIcon", DBUS_TYPE_BYTE,
+						&stk->idle_mode_icon.id);
+	}
+
 	return TRUE;
 }
 =

@@ -1144,8 +1180,8 @@ static gboolean handle_command_display_text(const str=
uct stk_command *cmd,
 	}
 =

 	/* We most likely got an out of memory error, tell SIM to retry */
-	if (stk_agent_display_text(stk->current_agent, dt->text, 0, priority,
-					display_text_cb, stk,
+	if (stk_agent_display_text(stk->current_agent, dt->text, &dt->icon_id,
+					priority, display_text_cb, stk,
 					display_text_destroy, timeout) < 0) {
 		rsp->result.type =3D STK_RESULT_TYPE_TERMINAL_BUSY;
 		return TRUE;
@@ -1288,7 +1324,6 @@ static gboolean handle_command_get_inkey(const struct=
 stk_command *cmd,
 	 * Note: immediate response and help parameter values are not
 	 * provided by current api.
 	 */
-	uint8_t icon_id =3D 0;
 	int err;
 =

 	if (gi->duration.interval) {
@@ -1307,16 +1342,17 @@ static gboolean handle_command_get_inkey(const stru=
ct stk_command *cmd,
 =

 	if (yesno)
 		err =3D stk_agent_request_confirmation(stk->current_agent,
-							gi->text, icon_id,
+							gi->text, &gi->icon_id,
 							request_confirmation_cb,
 							stk, NULL, timeout);
 	else if (alphabet)
 		err =3D stk_agent_request_key(stk->current_agent, gi->text,
-						icon_id, ucs2, request_key_cb,
-						stk, NULL, timeout);
+						&gi->icon_id, ucs2,
+						request_key_cb, stk, NULL,
+						timeout);
 	else
 		err =3D stk_agent_request_digit(stk->current_agent, gi->text,
-						icon_id, request_key_cb,
+						&gi->icon_id, request_key_cb,
 						stk, NULL, timeout);
 =

 	if (err < 0) {
@@ -1382,19 +1418,18 @@ static gboolean handle_command_get_input(const stru=
ct stk_command *cmd,
 	gboolean alphabet =3D (qualifier & (1 << 0)) !=3D 0;
 	gboolean ucs2 =3D (qualifier & (1 << 1)) !=3D 0;
 	gboolean hidden =3D (qualifier & (1 << 2)) !=3D 0;
-	uint8_t icon_id =3D 0;
 	int err;
 =

 	if (alphabet)
 		err =3D stk_agent_request_input(stk->current_agent, gi->text,
-						icon_id, gi->default_text, ucs2,
-						gi->resp_len.min,
+						&gi->icon_id, gi->default_text,
+						ucs2, gi->resp_len.min,
 						gi->resp_len.max, hidden,
 						request_string_cb,
 						stk, NULL, timeout);
 	else
 		err =3D stk_agent_request_digits(stk->current_agent, gi->text,
-						icon_id, gi->default_text,
+						&gi->icon_id, gi->default_text,
 						gi->resp_len.min,
 						gi->resp_len.max, hidden,
 						request_string_cb,
@@ -1501,7 +1536,8 @@ static void confirm_call_cb(enum stk_agent_result res=
ult, gboolean confirm,
 	}
 =

 	err =3D __ofono_voicecall_dial(vc, sc->addr.number, sc->addr.ton_npi,
-					sc->alpha_id_call_setup, 0,
+					sc->alpha_id_call_setup,
+					sc->icon_id_call_setup.id,
 					qualifier >> 1, call_setup_connected,
 					stk);
 	if (err >=3D 0) {
@@ -1582,8 +1618,8 @@ static gboolean handle_command_set_up_call(const stru=
ct stk_command *cmd,
 	}
 =

 	err =3D stk_agent_confirm_call(stk->current_agent, sc->alpha_id_usr_cfm,
-					0, confirm_call_cb, stk, NULL,
-					stk->timeout * 1000);
+					&sc->icon_id_usr_cfm, confirm_call_cb,
+					stk, NULL, stk->timeout * 1000);
 =

 	if (err < 0) {
 		/*
@@ -1614,9 +1650,7 @@ static void send_ussd_cancel(struct ofono_stk *stk)
 	if (ussd)
 		__ofono_ussd_initiate_cancel(ussd);
 =

-	if (stk->pending_cmd->send_ussd.alpha_id &&
-			stk->pending_cmd->send_ussd.alpha_id[0])
-		stk_alpha_id_unset(stk);
+	stk_alpha_id_unset(stk);
 }
 =

 static void send_ussd_callback(int error, int dcs, const unsigned char *ms=
g,
@@ -1628,9 +1662,7 @@ static void send_ussd_callback(int error, int dcs, co=
nst unsigned char *msg,
 	enum sms_charset charset;
 	unsigned char no_cause[] =3D { 0x00 };
 =

-	if (stk->pending_cmd->send_ussd.alpha_id &&
-			stk->pending_cmd->send_ussd.alpha_id[0])
-		stk_alpha_id_unset(stk);
+	stk_alpha_id_unset(stk);
 =

 	memset(&rsp, 0, sizeof(rsp));
 =

@@ -1762,8 +1794,7 @@ static gboolean handle_command_send_ussd(const struct=
 stk_command *cmd,
 		return TRUE;
 	}
 =

-	if (cmd->send_ussd.alpha_id && cmd->send_ussd.alpha_id[0])
-		stk_alpha_id_set(stk, cmd->send_ussd.alpha_id);
+	stk_alpha_id_set(stk, cmd->send_ussd.alpha_id, &cmd->send_ussd.icon_id);
 =

 	return FALSE;
 }
@@ -1834,9 +1865,7 @@ static void send_dtmf_cancel(struct ofono_stk *stk)
 	stk->respond_on_exit =3D FALSE;
 	stk->extern_req->cancelled =3D TRUE;
 =

-	if (stk->pending_cmd->send_dtmf.alpha_id &&
-			stk->pending_cmd->send_dtmf.alpha_id[0])
-		stk_alpha_id_unset(stk);
+	stk_alpha_id_unset(stk);
 }
 =

 static void dtmf_sent_cb(const struct ofono_error *error, void *user_data)
@@ -1855,9 +1884,7 @@ static void dtmf_sent_cb(const struct ofono_error *er=
ror, void *user_data)
 =

 	stk->respond_on_exit =3D FALSE;
 =

-	if (stk->pending_cmd->send_dtmf.alpha_id &&
-			stk->pending_cmd->send_dtmf.alpha_id[0])
-		stk_alpha_id_unset(stk);
+	stk_alpha_id_unset(stk);
 =

 	if (error->type =3D=3D OFONO_ERROR_TYPE_FAILURE &&
 			error->error =3D=3D ENOENT) {
@@ -1957,8 +1984,7 @@ static gboolean handle_command_send_dtmf(const struct=
 stk_command *cmd,
 		return TRUE;
 	}
 =

-	if (cmd->send_dtmf.alpha_id && cmd->send_dtmf.alpha_id[0])
-		stk_alpha_id_set(stk, cmd->send_dtmf.alpha_id);
+	stk_alpha_id_set(stk, cmd->send_dtmf.alpha_id, &cmd->send_dtmf.icon_id);
 =

 	/*
 	 * Note that we don't strictly require an agent to be connected,
diff --git a/src/stkagent.c b/src/stkagent.c
index f62c2bd..354b87d 100644
--- a/src/stkagent.c
+++ b/src/stkagent.c
@@ -34,6 +34,8 @@
 #include "ofono.h"
 =

 #include "common.h"
+#include "smsutil.h"
+#include "stkutil.h"
 #include "stkagent.h"
 =

 enum allowed_error {
@@ -343,7 +345,7 @@ int stk_agent_request_selection(struct stk_agent *agent,
 	dbus_message_iter_init_append(agent->msg, &iter);
 =

 	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &menu->title);
-	dbus_message_iter_append_basic(&iter, DBUS_TYPE_BYTE, &menu->icon_id);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_BYTE, &menu->icon.id);
 	append_menu_items(&iter, menu->items);
 	dbus_message_iter_append_basic(&iter, DBUS_TYPE_INT16, &default_item);
 =

@@ -396,7 +398,8 @@ static void display_text_cb(DBusPendingCall *call, void=
 *data)
 }
 =

 int stk_agent_display_text(struct stk_agent *agent, const char *text,
-				uint8_t icon_id, ofono_bool_t urgent,
+				const struct stk_icon_id *icon,
+				ofono_bool_t urgent,
 				stk_agent_display_text_cb cb,
 				void *user_data, ofono_destroy_func destroy,
 				int timeout)
@@ -412,7 +415,7 @@ int stk_agent_display_text(struct stk_agent *agent, con=
st char *text,
 =

 	dbus_message_append_args(agent->msg,
 					DBUS_TYPE_STRING, &text,
-					DBUS_TYPE_BYTE, &icon_id,
+					DBUS_TYPE_BYTE, &icon->id,
 					DBUS_TYPE_BOOLEAN, &priority,
 					DBUS_TYPE_INVALID);
 =

@@ -465,8 +468,8 @@ static void get_confirmation_cb(DBusPendingCall *call, =
void *data)
 	CALLBACK_END();
 }
 =

-int stk_agent_request_confirmation(struct stk_agent *agent,
-					const char *text, uint8_t icon_id,
+int stk_agent_request_confirmation(struct stk_agent *agent, const char *te=
xt,
+					const struct stk_icon_id *icon,
 					stk_agent_confirmation_cb cb,
 					void *user_data,
 					ofono_destroy_func destroy,
@@ -482,7 +485,7 @@ int stk_agent_request_confirmation(struct stk_agent *ag=
ent,
 =

 	dbus_message_append_args(agent->msg,
 					DBUS_TYPE_STRING, &text,
-					DBUS_TYPE_BYTE, &icon_id,
+					DBUS_TYPE_BYTE, &icon->id,
 					DBUS_TYPE_INVALID);
 =

 	if (dbus_connection_send_with_reply(conn, agent->msg, &agent->call,
@@ -536,8 +539,8 @@ static void get_digit_cb(DBusPendingCall *call, void *d=
ata)
 	CALLBACK_END();
 }
 =

-int stk_agent_request_digit(struct stk_agent *agent,
-				const char *text, uint8_t icon_id,
+int stk_agent_request_digit(struct stk_agent *agent, const char *text,
+				const struct stk_icon_id *icon,
 				stk_agent_string_cb cb, void *user_data,
 				ofono_destroy_func destroy, int timeout)
 {
@@ -551,7 +554,7 @@ int stk_agent_request_digit(struct stk_agent *agent,
 =

 	dbus_message_append_args(agent->msg,
 					DBUS_TYPE_STRING, &text,
-					DBUS_TYPE_BYTE, &icon_id,
+					DBUS_TYPE_BYTE, &icon->id,
 					DBUS_TYPE_INVALID);
 =

 	if (dbus_connection_send_with_reply(conn, agent->msg, &agent->call,
@@ -604,7 +607,8 @@ static void get_key_cb(DBusPendingCall *call, void *dat=
a)
 }
 =

 int stk_agent_request_key(struct stk_agent *agent, const char *text,
-				uint8_t icon_id, ofono_bool_t unicode_charset,
+				const struct stk_icon_id *icon,
+				ofono_bool_t unicode_charset,
 				stk_agent_string_cb cb, void *user_data,
 				ofono_destroy_func destroy, int timeout)
 {
@@ -618,7 +622,7 @@ int stk_agent_request_key(struct stk_agent *agent, cons=
t char *text,
 =

 	dbus_message_append_args(agent->msg,
 					DBUS_TYPE_STRING, &text,
-					DBUS_TYPE_BYTE, &icon_id,
+					DBUS_TYPE_BYTE, &icon->id,
 					DBUS_TYPE_INVALID);
 =

 	if (dbus_connection_send_with_reply(conn, agent->msg, &agent->call,
@@ -670,7 +674,8 @@ static void get_digits_cb(DBusPendingCall *call, void *=
data)
 }
 =

 int stk_agent_request_digits(struct stk_agent *agent, const char *text,
-				uint8_t icon_id, const char *default_text,
+				const struct stk_icon_id *icon,
+				const char *default_text,
 				int min, int max, ofono_bool_t hidden,
 				stk_agent_string_cb cb, void *user_data,
 				ofono_destroy_func destroy, int timeout)
@@ -691,7 +696,7 @@ int stk_agent_request_digits(struct stk_agent *agent, c=
onst char *text,
 =

 	dbus_message_append_args(agent->msg,
 					DBUS_TYPE_STRING, &text,
-					DBUS_TYPE_BYTE, &icon_id,
+					DBUS_TYPE_BYTE, &icon->id,
 					DBUS_TYPE_STRING, &default_text,
 					DBUS_TYPE_BYTE, &min_val,
 					DBUS_TYPE_BYTE, &max_val,
@@ -747,7 +752,8 @@ static void get_input_cb(DBusPendingCall *call, void *d=
ata)
 }
 =

 int stk_agent_request_input(struct stk_agent *agent, const char *text,
-				uint8_t icon_id, const char *default_text,
+				const struct stk_icon_id *icon,
+				const char *default_text,
 				ofono_bool_t unicode_charset, int min, int max,
 				ofono_bool_t hidden, stk_agent_string_cb cb,
 				void *user_data, ofono_destroy_func destroy,
@@ -769,7 +775,7 @@ int stk_agent_request_input(struct stk_agent *agent, co=
nst char *text,
 =

 	dbus_message_append_args(agent->msg,
 					DBUS_TYPE_STRING, &text,
-					DBUS_TYPE_BYTE, &icon_id,
+					DBUS_TYPE_BYTE, &icon->id,
 					DBUS_TYPE_STRING, &default_text,
 					DBUS_TYPE_BYTE, &min_val,
 					DBUS_TYPE_BYTE, &max_val,
@@ -824,7 +830,8 @@ static void confirm_call_cb(DBusPendingCall *call, void=
 *data)
 }
 =

 int stk_agent_confirm_call(struct stk_agent *agent, const char *text,
-				uint8_t icon_id, stk_agent_confirmation_cb cb,
+				const struct stk_icon_id *icon,
+				stk_agent_confirmation_cb cb,
 				void *user_data, ofono_destroy_func destroy,
 				int timeout)
 {
@@ -838,7 +845,7 @@ int stk_agent_confirm_call(struct stk_agent *agent, con=
st char *text,
 =

 	dbus_message_append_args(agent->msg,
 					DBUS_TYPE_STRING, &text,
-					DBUS_TYPE_BYTE, &icon_id,
+					DBUS_TYPE_BYTE, &icon->id,
 					DBUS_TYPE_INVALID);
 =

 	if (dbus_connection_send_with_reply(conn, agent->msg, &agent->call,
diff --git a/src/stkagent.h b/src/stkagent.h
index c644210..97c4eca 100644
--- a/src/stkagent.h
+++ b/src/stkagent.h
@@ -36,7 +36,7 @@ struct stk_menu_item {
 =

 struct stk_menu {
 	char *title;
-	uint8_t icon_id;
+	struct stk_icon_id icon;
 	struct stk_menu_item *items;
 	int default_item;
 	gboolean soft_key;
@@ -77,45 +77,49 @@ int stk_agent_request_selection(struct stk_agent *agent,
 				int timeout);
 =

 int stk_agent_display_text(struct stk_agent *agent, const char *text,
-				uint8_t icon_id, ofono_bool_t urgent,
+				const struct stk_icon_id *icon,
+				ofono_bool_t urgent,
 				stk_agent_display_text_cb cb,
 				void *user_data, ofono_destroy_func destroy,
 				int timeout);
 =

-int stk_agent_request_confirmation(struct stk_agent *agent,
-					const char *text, uint8_t icon_id,
+int stk_agent_request_confirmation(struct stk_agent *agent, const char *te=
xt,
+					const struct stk_icon_id *icon,
 					stk_agent_confirmation_cb cb,
 					void *user_data,
 					ofono_destroy_func destroy,
 					int timeout);
 =

-int stk_agent_request_digit(struct stk_agent *agent,
-				const char *text, uint8_t icon_id,
+int stk_agent_request_digit(struct stk_agent *agent, const char *text,
+				const struct stk_icon_id *icon,
 				stk_agent_string_cb cb, void *user_data,
 				ofono_destroy_func destroy, int timeout);
 =

 int stk_agent_request_key(struct stk_agent *agent, const char *text,
-				uint8_t icon_id, ofono_bool_t unicode_charset,
+				const struct stk_icon_id *icon,
+				ofono_bool_t unicode_charset,
 				stk_agent_string_cb cb, void *user_data,
 				ofono_destroy_func destroy, int timeout);
 =

 int stk_agent_request_digits(struct stk_agent *agent, const char *text,
-				uint8_t icon_id, const char *default_text,
-				int min, int max, ofono_bool_t hidden,
-				stk_agent_string_cb cb, void *user_data,
-				ofono_destroy_func destroy, int timeout);
+				const struct stk_icon_id *icon,
+				const char *default_text, int min, int max,
+				ofono_bool_t hidden, stk_agent_string_cb cb,
+				void *user_data, ofono_destroy_func destroy,
+				int timeout);
 =

 int stk_agent_request_input(struct stk_agent *agent, const char *text,
-				uint8_t icon_id, const char *default_text,
+				const struct stk_icon_id *icon,
+				const char *default_text,
 				ofono_bool_t unicode_charset, int min, int max,
 				ofono_bool_t hidden, stk_agent_string_cb cb,
 				void *user_data, ofono_destroy_func destroy,
 				int timeout);
 =

 int stk_agent_confirm_call(struct stk_agent *agent, const char *text,
-				uint8_t icon_id, stk_agent_confirmation_cb cb,
-				void *user_data, ofono_destroy_func destroy,
-				int timeout);
+				const struct stk_icon_id *icon,
+				stk_agent_confirmation_cb cb, void *user_data,
+				ofono_destroy_func destroy, int timeout);
 =

 void append_menu_items_variant(DBusMessageIter *iter,
 				const struct stk_menu_item *items);
-- =

1.7.1.86.g0e460.dirty


--===============1079445844436809404==--

