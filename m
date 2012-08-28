Content-Type: multipart/mixed; boundary="===============5390031187067678581=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2 2/4] stkagent: Add new API to get digit response on single
 key press
Date: Tue, 28 Aug 2012 15:21:20 +0200
Message-ID: <1346160082-11077-3-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1346160082-11077-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5390031187067678581==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkagent.c |   32 ++++++++++++++++++++++++++++++++
 src/stkagent.h |    5 +++++
 2 files changed, 37 insertions(+)

diff --git a/src/stkagent.c b/src/stkagent.c
index 7c3f697..63b82f3 100644
--- a/src/stkagent.c
+++ b/src/stkagent.c
@@ -584,6 +584,38 @@ int stk_agent_request_digit(struct stk_agent *agent, c=
onst char *text,
 	return 0;
 }
 =

+int stk_agent_request_quick_digit(struct stk_agent *agent, const char *tex=
t,
+				const struct stk_icon_id *icon,
+				stk_agent_string_cb cb, void *user_data,
+				ofono_destroy_func destroy, int timeout)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	agent->msg =3D dbus_message_new_method_call(agent->bus, agent->path,
+							OFONO_SIM_APP_INTERFACE,
+							"RequestQuickDigit");
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
+			agent->call =3D=3D NULL)
+		return -EIO;
+
+	agent->user_cb =3D cb;
+	agent->user_data =3D user_data;
+	agent->user_destroy =3D destroy;
+
+	dbus_pending_call_set_notify(agent->call, get_digit_cb, agent, NULL);
+
+	return 0;
+}
+
 static void get_key_cb(DBusPendingCall *call, void *data)
 {
 	struct stk_agent *agent =3D data;
diff --git a/src/stkagent.h b/src/stkagent.h
index 6e267fc..f66f038 100644
--- a/src/stkagent.h
+++ b/src/stkagent.h
@@ -102,6 +102,11 @@ int stk_agent_request_digit(struct stk_agent *agent, c=
onst char *text,
 				stk_agent_string_cb cb, void *user_data,
 				ofono_destroy_func destroy, int timeout);
 =

+int stk_agent_request_quick_digit(struct stk_agent *agent, const char *tex=
t,
+				const struct stk_icon_id *icon,
+				stk_agent_string_cb cb, void *user_data,
+				ofono_destroy_func destroy, int timeout);
+
 int stk_agent_request_key(struct stk_agent *agent, const char *text,
 				const struct stk_icon_id *icon,
 				ofono_bool_t unicode_charset,
-- =

1.7.9.5


--===============5390031187067678581==--

