Content-Type: multipart/mixed; boundary="===============6735806646863187866=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 2/4] stkagent: Add argument to notify when immediate digit
 response is required
Date: Fri, 24 Aug 2012 16:28:23 +0200
Message-ID: <1345818505-17175-3-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1345818505-17175-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6735806646863187866==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkagent.c |    6 ++++--
 src/stkagent.h |    5 +++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/src/stkagent.c b/src/stkagent.c
index 7c3f697..ed5d28a 100644
--- a/src/stkagent.c
+++ b/src/stkagent.c
@@ -554,8 +554,9 @@ static void get_digit_cb(DBusPendingCall *call, void *d=
ata)
 =

 int stk_agent_request_digit(struct stk_agent *agent, const char *text,
 				const struct stk_icon_id *icon,
-				stk_agent_string_cb cb, void *user_data,
-				ofono_destroy_func destroy, int timeout)
+				ofono_bool_t immediate, stk_agent_string_cb cb,
+				void *user_data, ofono_destroy_func destroy,
+				int timeout)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 =

@@ -568,6 +569,7 @@ int stk_agent_request_digit(struct stk_agent *agent, co=
nst char *text,
 	dbus_message_append_args(agent->msg,
 					DBUS_TYPE_STRING, &text,
 					DBUS_TYPE_BYTE, &icon->id,
+					DBUS_TYPE_BOOLEAN, &immediate,
 					DBUS_TYPE_INVALID);
 =

 	if (dbus_connection_send_with_reply(conn, agent->msg, &agent->call,
diff --git a/src/stkagent.h b/src/stkagent.h
index 6e267fc..e797c1e 100644
--- a/src/stkagent.h
+++ b/src/stkagent.h
@@ -99,8 +99,9 @@ int stk_agent_request_confirmation(struct stk_agent *agen=
t, const char *text,
 =

 int stk_agent_request_digit(struct stk_agent *agent, const char *text,
 				const struct stk_icon_id *icon,
-				stk_agent_string_cb cb, void *user_data,
-				ofono_destroy_func destroy, int timeout);
+				ofono_bool_t immediate, stk_agent_string_cb cb,
+				void *user_data, ofono_destroy_func destroy,
+				int timeout);
 =

 int stk_agent_request_key(struct stk_agent *agent, const char *text,
 				const struct stk_icon_id *icon,
-- =

1.7.9.5


--===============6735806646863187866==--

