Content-Type: multipart/mixed; boundary="===============7766285793341954897=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/2] stk: Send the AlphaId's to agent.
Date: Thu, 23 Dec 2010 05:39:41 +0100
Message-ID: <1293079181-13648-3-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1293079181-13648-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7766285793341954897==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v2: Method name changed according to irc talk.
v3: Terminate session if return signature doesn't match but allow
agent to return from the call if it does match.
---
 src/stk.c      |    9 +++++++--
 src/stkagent.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
 src/stkagent.h |    3 +++
 3 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 87208d1..9dcbda6 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -472,12 +472,17 @@ static void stk_alpha_id_set(struct ofono_stk *stk,
 		const char *text, const struct stk_text_attribute *attr,
 		const struct stk_icon_id *icon)
 {
-	/* TODO */
+	char *alpha =3D dbus_apply_text_attributes(text, attr);
+
+	if (alpha || icon)
+		stk_agent_display_action_info(stk->current_agent, alpha, icon);
+
+	g_free(alpha);
 }
 =

 static void stk_alpha_id_unset(struct ofono_stk *stk)
 {
-	/* TODO */
+	stk_agent_request_cancel(stk->current_agent);
 }
 =

 static int duration_to_msecs(const struct stk_duration *duration)
diff --git a/src/stkagent.c b/src/stkagent.c
index e1a6f48..2cdc6e1 100644
--- a/src/stkagent.c
+++ b/src/stkagent.c
@@ -964,3 +964,52 @@ int stk_agent_loop_tone(struct stk_agent *agent, const=
 char *text,
 =

 	return 0;
 }
+
+static void action_info_cb(DBusPendingCall *call, void *data)
+{
+	struct stk_agent *agent =3D data;
+	DBusMessage *reply =3D dbus_pending_call_steal_reply(call);
+	enum stk_agent_result result;
+	gboolean remove_agent;
+
+	if (check_error(agent, reply, 0, &result) =3D=3D -EINVAL) {
+		remove_agent =3D TRUE;
+		goto error;
+	}
+
+	if (dbus_message_get_args(reply, NULL, DBUS_TYPE_INVALID) =3D=3D FALSE) {
+		ofono_error("Can't parse the reply to DisplayActionInfo()");
+		remove_agent =3D TRUE;
+		goto error;
+	}
+
+	goto done;
+
+	CALLBACK_END();
+}
+
+int stk_agent_display_action_info(struct stk_agent *agent, const char *tex=
t,
+					const struct stk_icon_id *icon)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	agent->msg =3D dbus_message_new_method_call(agent->bus, agent->path,
+						OFONO_SIM_APP_INTERFACE,
+						"DisplayActionInformation");
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
+			agent->call =3D=3D NULL)
+		return -EIO;
+
+	dbus_pending_call_set_notify(agent->call, action_info_cb, agent, NULL);
+
+	return 0;
+}
diff --git a/src/stkagent.h b/src/stkagent.h
index 517bcfe..6477dbf 100644
--- a/src/stkagent.h
+++ b/src/stkagent.h
@@ -137,3 +137,6 @@ int stk_agent_loop_tone(struct stk_agent *agent, const =
char *text,
 =

 void append_menu_items_variant(DBusMessageIter *iter,
 				const struct stk_menu_item *items);
+
+int stk_agent_display_action_info(struct stk_agent *agent, const char *tex=
t,
+					const struct stk_icon_id *icon);
-- =

1.7.1.86.g0e460.dirty


--===============7766285793341954897==--

