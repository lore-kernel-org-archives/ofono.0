Content-Type: multipart/mixed; boundary="===============9205441996405661228=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 06/13] stk: Pass icon IDs in stk agent request parameters.
Date: Wed, 13 Oct 2010 15:54:09 +0200
Message-ID: <1286978056-16600-6-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1286978056-16600-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9205441996405661228==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c      |   28 ++++++++++++++--------------
 src/stkagent.c |   39 +++++++++++++++++++++++----------------
 src/stkagent.h |   32 ++++++++++++++++++--------------
 3 files changed, 55 insertions(+), 44 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 3792d2f..c5478b8 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -1151,8 +1151,8 @@ static gboolean handle_command_display_text(const str=
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
@@ -1295,7 +1295,6 @@ static gboolean handle_command_get_inkey(const struct=
 stk_command *cmd,
 	 * Note: immediate response and help parameter values are not
 	 * provided by current api.
 	 */
-	uint8_t icon_id =3D 0;
 	int err;
 =

 	if (gi->duration.interval) {
@@ -1314,16 +1313,17 @@ static gboolean handle_command_get_inkey(const stru=
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
@@ -1389,19 +1389,18 @@ static gboolean handle_command_get_input(const stru=
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
@@ -1508,7 +1507,8 @@ static void confirm_call_cb(enum stk_agent_result res=
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
@@ -1589,8 +1589,8 @@ static gboolean handle_command_set_up_call(const stru=
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
diff --git a/src/stkagent.c b/src/stkagent.c
index f62c2bd..82518f1 100644
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
index c644210..ea84a49 100644
--- a/src/stkagent.h
+++ b/src/stkagent.h
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


--===============9205441996405661228==--

