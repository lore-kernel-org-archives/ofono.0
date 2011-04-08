Content-Type: multipart/mixed; boundary="===============3204648155162714958=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 1/6] stkagent: Add ConfirmOpenChannel method
Date: Fri, 08 Apr 2011 18:33:26 +0200
Message-ID: <1302280411-20762-1-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3204648155162714958==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkagent.c |   67 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/stkagent.h |    7 ++++++
 2 files changed, 74 insertions(+), 0 deletions(-)

diff --git a/src/stkagent.c b/src/stkagent.c
index 220812e..1a4bdd8 100644
--- a/src/stkagent.c
+++ b/src/stkagent.c
@@ -1145,3 +1145,70 @@ int stk_agent_display_action(struct stk_agent *agent,
 =

 	return 0;
 }
+
+static void confirm_open_channel_cb(DBusPendingCall *call, void *data)
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
+		ofono_error("Can't parse the reply to ConfirmOpenChannel()");
+		remove_agent =3D TRUE;
+		goto error;
+	}
+
+	cb(result, confirm, agent->user_data);
+
+	CALLBACK_END();
+}
+
+int stk_agent_confirm_open_channel(struct stk_agent *agent, const char *te=
xt,
+					const struct stk_icon_id *icon,
+					stk_agent_confirmation_cb cb,
+					void *user_data,
+					ofono_destroy_func destroy, int timeout)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	agent->msg =3D dbus_message_new_method_call(agent->bus, agent->path,
+							OFONO_SIM_APP_INTERFACE,
+							"ConfirmOpenChannel");
+	if (agent->msg =3D=3D NULL)
+		return -ENOMEM;
+
+	dbus_message_append_args(agent->msg,
+					DBUS_TYPE_STRING, &text,
+					DBUS_TYPE_BYTE, &icon->id,
+					DBUS_TYPE_INVALID);
+
+	if (dbus_connection_send_with_reply(conn, agent->msg, &agent->call,
+						timeout) =3D=3D FALSE ||
+						agent->call =3D=3D NULL)
+		return -EIO;
+
+	agent->user_cb =3D cb;
+	agent->user_data =3D user_data;
+	agent->user_destroy =3D destroy;
+
+	dbus_pending_call_set_notify(agent->call, confirm_open_channel_cb,
+					agent, NULL);
+
+	return 0;
+}
diff --git a/src/stkagent.h b/src/stkagent.h
index 4b5d0a6..5e81485 100644
--- a/src/stkagent.h
+++ b/src/stkagent.h
@@ -156,3 +156,10 @@ int stk_agent_display_action(struct stk_agent *agent, =
const char *text,
 					stk_agent_display_action_cb cb,
 					void *user_data,
 					ofono_destroy_func destroy);
+
+int stk_agent_confirm_open_channel(struct stk_agent *agent, const char *te=
xt,
+					const struct stk_icon_id *icon,
+					stk_agent_confirmation_cb cb,
+					void *user_data,
+					ofono_destroy_func destroy,
+					int timeout);
-- =

1.7.1


--===============3204648155162714958==--

