Content-Type: multipart/mixed; boundary="===============1573727433805706630=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/2] stkagent: Add PlayTone and LoopTone requests.
Date: Mon, 11 Oct 2010 09:51:57 +0200
Message-ID: <1286783518-5464-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1573727433805706630==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkagent.c |   94 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/stkagent.h |   13 ++++++++
 2 files changed, 107 insertions(+), 0 deletions(-)

diff --git a/src/stkagent.c b/src/stkagent.c
index 354b87d..e123bd2 100644
--- a/src/stkagent.c
+++ b/src/stkagent.c
@@ -861,3 +861,97 @@ int stk_agent_confirm_call(struct stk_agent *agent, co=
nst char *text,
 =

 	return 0;
 }
+
+static void play_tone_cb(DBusPendingCall *call, void *data)
+{
+	struct stk_agent *agent =3D data;
+	stk_agent_tone_cb cb =3D agent->user_cb;
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
+		ofono_error("Can't parse the reply to PlayTone()");
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
+int stk_agent_play_tone(struct stk_agent *agent, const char *text,
+			const struct stk_icon_id *icon, ofono_bool_t vibrate,
+			const char *tone, stk_agent_tone_cb cb, void *user_data,
+			ofono_destroy_func destroy, int timeout)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	agent->msg =3D dbus_message_new_method_call(agent->bus, agent->path,
+							OFONO_SIM_APP_INTERFACE,
+							"PlayTone");
+	if (agent->msg =3D=3D NULL)
+		return -ENOMEM;
+
+	dbus_message_append_args(agent->msg,
+					DBUS_TYPE_STRING, &tone,
+					DBUS_TYPE_STRING, &text,
+					DBUS_TYPE_BYTE, &icon->id,
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
+	dbus_pending_call_set_notify(agent->call, play_tone_cb,
+					agent, NULL);
+
+	return 0;
+}
+
+int stk_agent_loop_tone(struct stk_agent *agent, const char *text,
+			const struct stk_icon_id *icon, ofono_bool_t vibrate,
+			const char *tone, stk_agent_tone_cb cb, void *user_data,
+			ofono_destroy_func destroy, int timeout)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	agent->msg =3D dbus_message_new_method_call(agent->bus, agent->path,
+							OFONO_SIM_APP_INTERFACE,
+							"LoopTone");
+	if (agent->msg =3D=3D NULL)
+		return -ENOMEM;
+
+	dbus_message_append_args(agent->msg,
+					DBUS_TYPE_STRING, &tone,
+					DBUS_TYPE_STRING, &text,
+					DBUS_TYPE_BYTE, &icon->id,
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
+	dbus_pending_call_set_notify(agent->call, play_tone_cb,
+					agent, NULL);
+
+	return 0;
+}
diff --git a/src/stkagent.h b/src/stkagent.h
index 97c4eca..c8e1886 100644
--- a/src/stkagent.h
+++ b/src/stkagent.h
@@ -56,6 +56,9 @@ typedef void (*stk_agent_confirmation_cb)(enum stk_agent_=
result result,
 typedef void (*stk_agent_string_cb)(enum stk_agent_result result,
 					char *string, void *user_data);
 =

+typedef void (*stk_agent_tone_cb)(enum stk_agent_result result,
+						void *user_data);
+
 struct stk_agent *stk_agent_new(const char *path, const char *sender,
 					ofono_bool_t remove_on_terminate);
 =

@@ -121,5 +124,15 @@ int stk_agent_confirm_call(struct stk_agent *agent, co=
nst char *text,
 				stk_agent_confirmation_cb cb, void *user_data,
 				ofono_destroy_func destroy, int timeout);
 =

+int stk_agent_play_tone(struct stk_agent *agent, const char *text,
+			const struct stk_icon_id *icon, ofono_bool_t vibrate,
+			const char *tone, stk_agent_tone_cb cb, void *user_data,
+			ofono_destroy_func destroy, int timeout);
+
+int stk_agent_loop_tone(struct stk_agent *agent, const char *text,
+			const struct stk_icon_id *icon, ofono_bool_t vibrate,
+			const char *tone, stk_agent_tone_cb cb, void *user_data,
+			ofono_destroy_func destroy, int timeout);
+
 void append_menu_items_variant(DBusMessageIter *iter,
 				const struct stk_menu_item *items);
-- =

1.7.1.86.g0e460.dirty


--===============1573727433805706630==--

