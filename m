Content-Type: multipart/mixed; boundary="===============2333567431720609926=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/2] stk: Send the AlphaId's to agent.
Date: Tue, 21 Dec 2010 10:34:43 +0100
Message-ID: <1292924084-6929-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2333567431720609926==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v2: Method name changed according to irc talk.
---
 src/stk.c      |    9 +++++++--
 src/stkagent.c |   31 +++++++++++++++++++++++++++++++
 src/stkagent.h |    3 +++
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 076acc4..67cb759 100644
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
index e1a6f48..2c43053 100644
--- a/src/stkagent.c
+++ b/src/stkagent.c
@@ -964,3 +964,34 @@ int stk_agent_loop_tone(struct stk_agent *agent, const=
 char *text,
 =

 	return 0;
 }
+
+static void action_info_cb(DBusPendingCall *call, void *data)
+{
+	stk_agent_request_end(data);
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
index 517bcfe..00bacc2 100644
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


--===============2333567431720609926==--

