Content-Type: multipart/mixed; boundary="===============4275004456677842970=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] stkagent: Free pending call when destroying agent.
Date: Tue, 17 Aug 2010 17:37:00 +0200
Message-ID: <1282059423-28864-2-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1282059423-28864-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4275004456677842970==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Otherwise we leak memory and additionally D-bus invokes the method
callback and since the agent is already destroyed, we segfault.
---
 src/stkagent.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/src/stkagent.c b/src/stkagent.c
index fc05493..e71436d 100644
--- a/src/stkagent.c
+++ b/src/stkagent.c
@@ -127,19 +127,20 @@ void stk_agent_request_cancel(struct stk_agent *agent)
 		return;
 =

 	dbus_pending_call_cancel(agent->call);
-	stk_agent_send_cancel(agent);
+
+	if (agent->disconnect_watch)
+		stk_agent_send_cancel(agent);
+
 	stk_agent_request_end(agent);
 }
 =

 void stk_agent_free(struct stk_agent *agent)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
-	gboolean busy =3D agent->call !=3D NULL;
 =

-	if (agent->disconnect_watch) {
-		if (busy)
-			stk_agent_send_cancel(agent);
+	stk_agent_request_cancel(agent);
 =

+	if (agent->disconnect_watch) {
 		stk_agent_send_release(agent);
 =

 		g_dbus_remove_watch(conn, agent->disconnect_watch);
-- =

1.7.1.86.g0e460.dirty


--===============4275004456677842970==--

