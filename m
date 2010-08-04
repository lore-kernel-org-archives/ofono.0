Content-Type: multipart/mixed; boundary="===============7757135755189467223=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/4] stkagent: Implement RequestInput/RequestDigits.
Date: Wed, 04 Aug 2010 06:55:03 +0200
Message-ID: <1280897704-15361-3-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1280897704-15361-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7757135755189467223==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkagent.c |  179 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/stkagent.h |   13 ++++
 2 files changed, 192 insertions(+), 0 deletions(-)

diff --git a/src/stkagent.c b/src/stkagent.c
index 6352fb2..692b470 100644
--- a/src/stkagent.c
+++ b/src/stkagent.c
@@ -670,3 +670,182 @@ int stk_agent_request_key(struct stk_agent *agent, co=
nst char *text,
 =

 	return 0;
 }
+
+static void get_digits_cb(DBusPendingCall *call, void *data)
+{
+	struct stk_agent *agent =3D data;
+	stk_agent_string_cb cb =3D agent->user_cb;
+	DBusMessage *reply =3D dbus_pending_call_steal_reply(call);
+	enum stk_agent_result result;
+	gboolean remove_agent;
+	char *string;
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
+					DBUS_TYPE_STRING, &string,
+					DBUS_TYPE_INVALID) =3D=3D FALSE) {
+		ofono_error("Can't parse the reply to GetDigits()");
+		remove_agent =3D TRUE;
+		goto error;
+	}
+
+	cb(result, string, agent->user_data);
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
+int stk_agent_request_digits(struct stk_agent *agent, const char *text,
+				uint8_t icon_id, const char *default_text,
+				int min, int max, ofono_bool_t hidden,
+				stk_agent_string_cb cb, void *user_data,
+				ofono_destroy_func destroy, int timeout)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	uint8_t min_val =3D min;
+	uint8_t max_val =3D max;
+	dbus_bool_t hidden_val =3D hidden;
+
+	agent->msg =3D dbus_message_new_method_call(agent->bus, agent->path,
+							OFONO_SIM_APP_INTERFACE,
+							"RequestDigits");
+	if (agent->msg =3D=3D NULL)
+		return -ENOMEM;
+
+	if (default_text =3D=3D NULL)
+		default_text =3D "";
+
+	dbus_message_append_args(agent->msg,
+					DBUS_TYPE_STRING, &text,
+					DBUS_TYPE_BYTE, &icon_id,
+					DBUS_TYPE_STRING, &default_text,
+					DBUS_TYPE_BYTE, &min_val,
+					DBUS_TYPE_BYTE, &max_val,
+					DBUS_TYPE_BOOLEAN, &hidden_val,
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
+	dbus_pending_call_set_notify(agent->call, get_digits_cb,
+					agent, NULL);
+
+	return 0;
+}
+
+static void get_input_cb(DBusPendingCall *call, void *data)
+{
+	struct stk_agent *agent =3D data;
+	stk_agent_string_cb cb =3D agent->user_cb;
+	DBusMessage *reply =3D dbus_pending_call_steal_reply(call);
+	enum stk_agent_result result;
+	gboolean remove_agent;
+	char *string;
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
+					DBUS_TYPE_STRING, &string,
+					DBUS_TYPE_INVALID) =3D=3D FALSE) {
+		ofono_error("Can't parse the reply to GetInput()");
+		remove_agent =3D TRUE;
+		goto error;
+	}
+
+	cb(result, string, agent->user_data);
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
+int stk_agent_request_input(struct stk_agent *agent, const char *text,
+				uint8_t icon_id, const char *default_text,
+				ofono_bool_t unicode_charset, int min, int max,
+				ofono_bool_t hidden, stk_agent_string_cb cb,
+				void *user_data, ofono_destroy_func destroy,
+				int timeout)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	uint8_t min_val =3D min;
+	uint8_t max_val =3D max;
+	dbus_bool_t hidden_val =3D hidden;
+
+	agent->msg =3D dbus_message_new_method_call(agent->bus, agent->path,
+							OFONO_SIM_APP_INTERFACE,
+							"RequestInput");
+	if (agent->msg =3D=3D NULL)
+		return -ENOMEM;
+
+	if (default_text =3D=3D NULL)
+		default_text =3D "";
+
+	dbus_message_append_args(agent->msg,
+					DBUS_TYPE_STRING, &text,
+					DBUS_TYPE_BYTE, &icon_id,
+					DBUS_TYPE_STRING, &default_text,
+					DBUS_TYPE_BYTE, &min_val,
+					DBUS_TYPE_BYTE, &max_val,
+					DBUS_TYPE_BOOLEAN, &hidden_val,
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
+	dbus_pending_call_set_notify(agent->call, get_input_cb,
+					agent, NULL);
+
+	return 0;
+}
diff --git a/src/stkagent.h b/src/stkagent.h
index 8b9a931..3faabe7 100644
--- a/src/stkagent.h
+++ b/src/stkagent.h
@@ -100,5 +100,18 @@ int stk_agent_request_key(struct stk_agent *agent, con=
st char *text,
 				stk_agent_string_cb cb, void *user_data,
 				ofono_destroy_func destroy, int timeout);
 =

+int stk_agent_request_digits(struct stk_agent *agent, const char *text,
+				uint8_t icon_id, const char *default_text,
+				int min, int max, ofono_bool_t hidden,
+				stk_agent_string_cb cb, void *user_data,
+				ofono_destroy_func destroy, int timeout);
+
+int stk_agent_request_input(struct stk_agent *agent, const char *text,
+				uint8_t icon_id, const char *default_text,
+				ofono_bool_t unicode_charset, int min, int max,
+				ofono_bool_t hidden, stk_agent_string_cb cb,
+				void *user_data, ofono_destroy_func destroy,
+				int timeout);
+
 void append_menu_items_variant(DBusMessageIter *iter,
 				const struct stk_menu_item *items);
-- =

1.7.1.86.g0e460.dirty


--===============7757135755189467223==--

