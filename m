Content-Type: multipart/mixed; boundary="===============3987616871965021257=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/4] stkagent: Implement RequestConfirmation/Key/Digit.
Date: Wed, 04 Aug 2010 06:55:01 +0200
Message-ID: <1280897704-15361-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3987616871965021257==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkagent.c |  240 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/stkagent.h |   24 ++++++
 2 files changed, 264 insertions(+), 0 deletions(-)

diff --git a/src/stkagent.c b/src/stkagent.c
index 22ff7c6..6352fb2 100644
--- a/src/stkagent.c
+++ b/src/stkagent.c
@@ -33,6 +33,7 @@
 =

 #include "ofono.h"
 =

+#include "common.h"
 #include "stkagent.h"
 =

 enum allowed_error {
@@ -430,3 +431,242 @@ int stk_agent_display_text(struct stk_agent *agent, c=
onst char *text,
 =

 	return 0;
 }
+
+static void get_confirmation_cb(DBusPendingCall *call, void *data)
+{
+	struct stk_agent *agent =3D data;
+	stk_agent_confirmation_cb cb =3D agent->user_cb;
+	DBusMessage *reply =3D dbus_pending_call_steal_reply(call);
+	enum stk_agent_result result;
+	gboolean remove_agent;
+	dbus_bool_t confirm;
+
+	if (check_error(agent, reply,
+			ALLOWED_ERROR_GO_BACK | ALLOWED_ERROR_TERMINATE,
+			&result) =3D=3D -EINVAL) {
+		remove_agent =3D TRUE;
+		goto error;
+	}
+
+	if (result !=3D STK_AGENT_RESULT_OK) {
+		cb(result, FALSE, agent->user_data);
+		goto done;
+	}
+
+	if (dbus_message_get_args(reply, NULL,
+					DBUS_TYPE_BOOLEAN, &confirm,
+					DBUS_TYPE_INVALID) =3D=3D FALSE) {
+		ofono_error("Can't parse the reply to GetConfirmation()");
+		remove_agent =3D TRUE;
+		goto error;
+	}
+
+	cb(result, confirm, agent->user_data);
+
+done:
+	if (result =3D=3D STK_AGENT_RESULT_TERMINATE && agent->remove_on_terminat=
e)
+		remove_agent =3D TRUE;
+	else
+		remove_agent =3D FALSE;
+
+error:
+	stk_agent_request_end(agent);
+	dbus_message_unref(reply);
+
+	if (remove_agent)
+		stk_agent_free(agent);
+}
+
+int stk_agent_request_confirmation(struct stk_agent *agent,
+					const char *text, uint8_t icon_id,
+					stk_agent_confirmation_cb cb,
+					void *user_data,
+					ofono_destroy_func destroy,
+					int timeout)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	agent->msg =3D dbus_message_new_method_call(agent->bus, agent->path,
+							OFONO_SIM_APP_INTERFACE,
+							"RequestConfirmation");
+	if (agent->msg =3D=3D NULL)
+		return -ENOMEM;
+
+	dbus_message_append_args(agent->msg,
+					DBUS_TYPE_STRING, &text,
+					DBUS_TYPE_BYTE, &icon_id,
+					DBUS_TYPE_INVALID);
+
+	if (dbus_connection_send_with_reply(conn, agent->msg, &agent->call,
+						timeout) =3D=3D FALSE ||
+			agent->call =3D=3D NULL)
+		return -EIO;
+
+	agent->user_cb =3D cb;
+	agent->user_data =3D user_data;
+	agent->user_destroy =3D destroy;
+
+	dbus_pending_call_set_notify(agent->call, get_confirmation_cb,
+					agent, NULL);
+
+	return 0;
+}
+
+static void get_digit_cb(DBusPendingCall *call, void *data)
+{
+	struct stk_agent *agent =3D data;
+	stk_agent_string_cb cb =3D agent->user_cb;
+	DBusMessage *reply =3D dbus_pending_call_steal_reply(call);
+	enum stk_agent_result result;
+	gboolean remove_agent;
+	char *digit;
+
+	if (check_error(agent, reply,
+			ALLOWED_ERROR_GO_BACK | ALLOWED_ERROR_TERMINATE,
+			&result) =3D=3D -EINVAL) {
+		remove_agent =3D TRUE;
+		goto error;
+	}
+
+	if (result !=3D STK_AGENT_RESULT_OK) {
+		cb(result, NULL, agent->user_data);
+		goto done;
+	}
+
+	if (dbus_message_get_args(reply, NULL,
+					DBUS_TYPE_STRING, &digit,
+					DBUS_TYPE_INVALID) =3D=3D FALSE ||
+			strlen(digit) !=3D 1 ||
+			!valid_phone_number_format(digit)) {
+		ofono_error("Can't parse the reply to GetDigit()");
+		remove_agent =3D TRUE;
+		goto error;
+	}
+
+	cb(result, digit, agent->user_data);
+
+done:
+	if (result =3D=3D STK_AGENT_RESULT_TERMINATE && agent->remove_on_terminat=
e)
+		remove_agent =3D TRUE;
+	else
+		remove_agent =3D FALSE;
+
+error:
+	stk_agent_request_end(agent);
+	dbus_message_unref(reply);
+
+	if (remove_agent)
+		stk_agent_free(agent);
+}
+
+int stk_agent_request_digit(struct stk_agent *agent,
+				const char *text, uint8_t icon_id,
+				stk_agent_string_cb cb, void *user_data,
+				ofono_destroy_func destroy, int timeout)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	agent->msg =3D dbus_message_new_method_call(agent->bus, agent->path,
+							OFONO_SIM_APP_INTERFACE,
+							"RequestDigit");
+	if (agent->msg =3D=3D NULL)
+		return -ENOMEM;
+
+	dbus_message_append_args(agent->msg,
+					DBUS_TYPE_STRING, &text,
+					DBUS_TYPE_BYTE, &icon_id,
+					DBUS_TYPE_INVALID);
+
+	if (dbus_connection_send_with_reply(conn, agent->msg, &agent->call,
+						timeout) =3D=3D FALSE ||
+			agent->call =3D=3D NULL)
+		return -EIO;
+
+	agent->user_cb =3D cb;
+	agent->user_data =3D user_data;
+	agent->user_destroy =3D destroy;
+
+	dbus_pending_call_set_notify(agent->call, get_digit_cb,
+					agent, NULL);
+
+	return 0;
+}
+
+static void get_key_cb(DBusPendingCall *call, void *data)
+{
+	struct stk_agent *agent =3D data;
+	stk_agent_string_cb cb =3D agent->user_cb;
+	DBusMessage *reply =3D dbus_pending_call_steal_reply(call);
+	enum stk_agent_result result;
+	gboolean remove_agent;
+	char *key;
+
+	if (check_error(agent, reply,
+			ALLOWED_ERROR_GO_BACK | ALLOWED_ERROR_TERMINATE,
+			&result) =3D=3D -EINVAL) {
+		remove_agent =3D TRUE;
+		goto error;
+	}
+
+	if (result !=3D STK_AGENT_RESULT_OK) {
+		cb(result, NULL, agent->user_data);
+		goto done;
+	}
+
+	if (dbus_message_get_args(reply, NULL,
+					DBUS_TYPE_STRING, &key,
+					DBUS_TYPE_INVALID) =3D=3D FALSE ||
+			g_utf8_strlen(key, 10) !=3D 1) {
+		ofono_error("Can't parse the reply to GetKey()");
+		remove_agent =3D TRUE;
+		goto error;
+	}
+
+	cb(result, key, agent->user_data);
+
+done:
+	if (result =3D=3D STK_AGENT_RESULT_TERMINATE && agent->remove_on_terminat=
e)
+		remove_agent =3D TRUE;
+	else
+		remove_agent =3D FALSE;
+
+error:
+	stk_agent_request_end(agent);
+	dbus_message_unref(reply);
+
+	if (remove_agent)
+		stk_agent_free(agent);
+}
+
+int stk_agent_request_key(struct stk_agent *agent, const char *text,
+				uint8_t icon_id, ofono_bool_t unicode_charset,
+				stk_agent_string_cb cb, void *user_data,
+				ofono_destroy_func destroy, int timeout)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	agent->msg =3D dbus_message_new_method_call(agent->bus, agent->path,
+							OFONO_SIM_APP_INTERFACE,
+							"RequestKey");
+	if (agent->msg =3D=3D NULL)
+		return -ENOMEM;
+
+	dbus_message_append_args(agent->msg,
+					DBUS_TYPE_STRING, &text,
+					DBUS_TYPE_BYTE, &icon_id,
+					DBUS_TYPE_INVALID);
+
+	if (dbus_connection_send_with_reply(conn, agent->msg, &agent->call,
+						timeout) =3D=3D FALSE ||
+			agent->call =3D=3D NULL)
+		return -EIO;
+
+	agent->user_cb =3D cb;
+	agent->user_data =3D user_data;
+	agent->user_destroy =3D destroy;
+
+	dbus_pending_call_set_notify(agent->call, get_key_cb,
+					agent, NULL);
+
+	return 0;
+}
diff --git a/src/stkagent.h b/src/stkagent.h
index d9e79dc..8b9a931 100644
--- a/src/stkagent.h
+++ b/src/stkagent.h
@@ -50,6 +50,13 @@ typedef void (*stk_agent_display_text_cb)(enum stk_agent=
_result result,
 typedef void (*stk_agent_selection_cb)(enum stk_agent_result result,
 					uint8_t id, void *user_data);
 =

+typedef void (*stk_agent_confirmation_cb)(enum stk_agent_result result,
+						ofono_bool_t confirm,
+						void *user_data);
+
+typedef void (*stk_agent_string_cb)(enum stk_agent_result result,
+					char *string, void *user_data);
+
 struct stk_agent *stk_agent_new(const char *path, const char *sender,
 					ofono_bool_t remove_on_terminate);
 =

@@ -76,5 +83,22 @@ int stk_agent_display_text(struct stk_agent *agent, cons=
t char *text,
 				void *user_data, ofono_destroy_func destroy,
 				int timeout);
 =

+int stk_agent_request_confirmation(struct stk_agent *agent,
+					const char *text, uint8_t icon_id,
+					stk_agent_confirmation_cb cb,
+					void *user_data,
+					ofono_destroy_func destroy,
+					int timeout);
+
+int stk_agent_request_digit(struct stk_agent *agent,
+				const char *text, uint8_t icon_id,
+				stk_agent_string_cb cb, void *user_data,
+				ofono_destroy_func destroy, int timeout);
+
+int stk_agent_request_key(struct stk_agent *agent, const char *text,
+				uint8_t icon_id, ofono_bool_t unicode_charset,
+				stk_agent_string_cb cb, void *user_data,
+				ofono_destroy_func destroy, int timeout);
+
 void append_menu_items_variant(DBusMessageIter *iter,
 				const struct stk_menu_item *items);
-- =

1.7.1.86.g0e460.dirty


--===============3987616871965021257==--

