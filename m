Content-Type: multipart/mixed; boundary="===============2160666412309149787=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/3] stkagent: Add ConfirmCallSetup request.
Date: Wed, 25 Aug 2010 17:49:15 +0200
Message-ID: <1282751357-7086-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2160666412309149787==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkagent.c |   65 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/stkagent.h |    5 ++++
 2 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/src/stkagent.c b/src/stkagent.c
index e71436d..f62c2bd 100644
--- a/src/stkagent.c
+++ b/src/stkagent.c
@@ -789,3 +789,68 @@ int stk_agent_request_input(struct stk_agent *agent, c=
onst char *text,
 =

 	return 0;
 }
+
+static void confirm_call_cb(DBusPendingCall *call, void *data)
+{
+	struct stk_agent *agent =3D data;
+	stk_agent_confirmation_cb cb =3D agent->user_cb;
+	DBusMessage *reply =3D dbus_pending_call_steal_reply(call);
+	enum stk_agent_result result;
+	gboolean remove_agent;
+	dbus_bool_t confirm;
+
+	if (check_error(agent, reply,
+			ALLOWED_ERROR_TERMINATE, &result) =3D=3D -EINVAL) {
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
+		ofono_error("Can't parse the reply to ConfirmCallSetup()");
+		remove_agent =3D TRUE;
+		goto error;
+	}
+
+	cb(result, confirm, agent->user_data);
+
+	CALLBACK_END();
+}
+
+int stk_agent_confirm_call(struct stk_agent *agent, const char *text,
+				uint8_t icon_id, stk_agent_confirmation_cb cb,
+				void *user_data, ofono_destroy_func destroy,
+				int timeout)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	agent->msg =3D dbus_message_new_method_call(agent->bus, agent->path,
+							OFONO_SIM_APP_INTERFACE,
+							"ConfirmCallSetup");
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
+	dbus_pending_call_set_notify(agent->call, confirm_call_cb, agent, NULL);
+
+	return 0;
+}
diff --git a/src/stkagent.h b/src/stkagent.h
index 70f1f88..c644210 100644
--- a/src/stkagent.h
+++ b/src/stkagent.h
@@ -112,5 +112,10 @@ int stk_agent_request_input(struct stk_agent *agent, c=
onst char *text,
 				void *user_data, ofono_destroy_func destroy,
 				int timeout);
 =

+int stk_agent_confirm_call(struct stk_agent *agent, const char *text,
+				uint8_t icon_id, stk_agent_confirmation_cb cb,
+				void *user_data, ofono_destroy_func destroy,
+				int timeout);
+
 void append_menu_items_variant(DBusMessageIter *iter,
 				const struct stk_menu_item *items);
-- =

1.7.1.86.g0e460.dirty


--===============2160666412309149787==--

