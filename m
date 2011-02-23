Content-Type: multipart/mixed; boundary="===============7880899388148872080=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 3/4] test-server:Remove root user test and add resume CB
 registration
Date: Wed, 23 Feb 2011 16:29:25 +0100
Message-ID: <1298474966-1691-4-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7880899388148872080==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/test-server.c |   21 ++++++++++++++++-----
 1 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/gatchat/test-server.c b/gatchat/test-server.c
index 28bad1d..f9bd9fa 100644
--- a/gatchat/test-server.c
+++ b/gatchat/test-server.c
@@ -128,6 +128,16 @@ static void ppp_connect(const char *iface, const char =
*local, const char *peer,
 	execute(buf);
 }
 =

+static void at_server_resume(gpointer user)
+{
+	GAtServer *server =3D user;
+
+	g_at_server_resume(server);
+	g_at_server_set_debug(server, server_debug, "Server");
+
+	g_at_server_send_final(server, G_AT_SERVER_RESULT_NO_CARRIER);
+}
+
 static void ppp_disconnect(GAtPPPDisconnectReason reason, gpointer user)
 {
 	GAtServer *server =3D user;
@@ -143,6 +153,11 @@ static void ppp_disconnect(GAtPPPDisconnectReason reas=
on, gpointer user)
 		return;
 	}
 =

+	if (reason =3D=3D G_AT_PPP_REASON_NET_FAIL) {
+		g_print("Failed to create tun\nNeed root privilege to configure PPP inte=
rface\n");
+		return;
+	}
+
 	g_at_server_resume(server);
 	g_at_server_set_debug(server, server_debug, "Server");
 =

@@ -164,11 +179,6 @@ static gboolean setup_ppp(gpointer user)
 	GAtServer *server =3D user;
 	GAtIO *io;
 =

-	if (getuid() !=3D 0) {
-		g_print("Need root privilege for PPP connection\n");
-		return FALSE;
-	}
-
 	io =3D g_at_server_get_io(server);
 =

 	g_at_server_suspend(server);
@@ -187,6 +197,7 @@ static gboolean setup_ppp(gpointer user)
 	/* set connect and disconnect callbacks */
 	g_at_ppp_set_connect_function(ppp, ppp_connect, server);
 	g_at_ppp_set_disconnect_function(ppp, ppp_disconnect, server);
+	g_at_ppp_set_resume_function(ppp, at_server_resume, server);
 =

 	g_idle_add(update_ppp, ppp);
 =

-- =

1.7.1


--===============7880899388148872080==--

