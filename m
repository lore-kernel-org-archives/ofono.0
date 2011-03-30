Content-Type: multipart/mixed; boundary="===============3338766998305336106=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2 3/4] stkagent: Call the new display method when user
 termination is allowed
Date: Wed, 30 Mar 2011 12:27:43 +0200
Message-ID: <1301480864-8116-3-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3338766998305336106==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkagent.c |   61 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/stkagent.h |    9 ++++++++
 2 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/src/stkagent.c b/src/stkagent.c
index 2395182..15ad4fa 100644
--- a/src/stkagent.c
+++ b/src/stkagent.c
@@ -1081,3 +1081,64 @@ int stk_agent_confirm_launch_browser(struct stk_agen=
t *agent, const char *text,
 =

 	return 0;
 }
+
+static void display_action_cb(DBusPendingCall *call, void *data)
+{
+	struct stk_agent *agent =3D data;
+	stk_agent_user_termination_cb cb =3D agent->user_cb;
+	DBusMessage *reply =3D dbus_pending_call_steal_reply(call);
+	enum stk_agent_result result;
+	gboolean remove_agent;
+
+	if (check_error(agent, reply,
+			ALLOWED_ERROR_TERMINATE, &result) =3D=3D -EINVAL) {
+		remove_agent =3D TRUE;
+		goto error;
+	}
+
+	if (dbus_message_get_args(reply, NULL, DBUS_TYPE_INVALID) =3D=3D FALSE) {
+		ofono_error("Can't parse the reply to DisplayAction()");
+		remove_agent =3D TRUE;
+		goto error;
+	}
+
+	cb(result, agent->user_data);
+	goto done;
+
+	CALLBACK_END();
+}
+
+int stk_agent_display_action(struct stk_agent *agent,
+					const char *text,
+					const struct stk_icon_id *icon,
+					stk_agent_user_termination_cb cb,
+					void *user_data,
+					ofono_destroy_func destroy)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	agent->msg =3D dbus_message_new_method_call(agent->bus, agent->path,
+						OFONO_SIM_APP_INTERFACE,
+						"DisplayAction");
+	if (agent->msg =3D=3D NULL)
+		return -ENOMEM;
+
+	dbus_message_append_args(agent->msg,
+					DBUS_TYPE_STRING, &text,
+					DBUS_TYPE_BYTE, &icon->id,
+					DBUS_TYPE_INVALID);
+
+	if (dbus_connection_send_with_reply(conn, agent->msg, &agent->call,
+						0) =3D=3D FALSE ||
+						agent->call =3D=3D NULL)
+		return -EIO;
+
+	agent->user_cb =3D cb;
+	agent->user_data =3D user_data;
+	agent->user_destroy =3D destroy;
+
+	dbus_pending_call_set_notify(agent->call, display_action_cb,
+					agent, NULL);
+
+	return 0;
+}
diff --git a/src/stkagent.h b/src/stkagent.h
index 1f0c4fa..fd60824 100644
--- a/src/stkagent.h
+++ b/src/stkagent.h
@@ -60,6 +60,9 @@ typedef void (*stk_agent_string_cb)(enum stk_agent_result=
 result,
 typedef void (*stk_agent_tone_cb)(enum stk_agent_result result,
 						void *user_data);
 =

+typedef void (*stk_agent_user_termination_cb)(enum stk_agent_result result,
+						void *user_data);
+
 struct stk_agent *stk_agent_new(const char *path, const char *sender,
 					ofono_bool_t remove_on_terminate);
 =

@@ -147,3 +150,9 @@ int stk_agent_confirm_launch_browser(struct stk_agent *=
agent, const char *text,
 					void *user_data,
 					ofono_destroy_func destroy,
 					int timeout);
+
+int stk_agent_display_action(struct stk_agent *agent, const char *text,
+					const struct stk_icon_id *icon,
+					stk_agent_user_termination_cb cb,
+					void *user_data,
+					ofono_destroy_func destroy);
-- =

1.7.1


--===============3338766998305336106==--

