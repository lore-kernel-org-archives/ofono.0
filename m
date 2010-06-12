Content-Type: multipart/mixed; boundary="===============6789641743940240879=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 10/11] test-server: Delay ppp_unref after IO processing
Date: Sat, 12 Jun 2010 13:50:49 +0800
Message-ID: <1276321850-13307-11-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1276321850-13307-10-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6789641743940240879==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The ppp_disconnect is invoked during ppp receives LCP packet and enter
PPP dead phase. It's not good to stop the IO processing in disconnect
function.  Delay the ppp_unref after packet is processed.
---
 gatchat/test-server.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/gatchat/test-server.c b/gatchat/test-server.c
index df0bab8..dac7234 100644
--- a/gatchat/test-server.c
+++ b/gatchat/test-server.c
@@ -57,6 +57,7 @@ static int modem_creg =3D 0;
 static int modem_cgreg =3D 0;
 static int network_status =3D 4;
 static int network_attach =3D 0;
+static int resume_source =3D 0;
 =

 struct sock_server{
 	int server_sock;
@@ -72,6 +73,9 @@ static gboolean server_cleanup()
 	if (server_watch)
 		g_source_remove(server_watch);
 =

+	if (resume_source)
+		g_source_remove(resume_source);
+
 	if (ppp) {
 		g_at_ppp_unref(ppp);
 		ppp =3D NULL;
@@ -128,17 +132,28 @@ static void ppp_connect(const char *iface, const char=
 *local, const char *peer,
 	execute(buf);
 }
 =

-static void ppp_disconnect(GAtPPPDisconnectReason reason, gpointer user)
+static gboolean resume_server(gpointer user)
 {
 	GAtServer *server =3D user;
 =

-	g_print("PPP Link down: %d\n", reason);
+	resume_source =3D 0;
 =

 	g_at_ppp_unref(ppp);
 	ppp =3D NULL;
 =

 	g_at_server_resume(server);
 	g_at_server_set_debug(server, server_debug, "Server");
+
+	modem_mode =3D 0;
+
+	return FALSE;
+}
+
+static void ppp_disconnect(GAtPPPDisconnectReason reason, gpointer user)
+{
+	g_print("PPP Link down: %d\n", reason);
+
+	resume_source =3D g_idle_add(resume_server, user);
 }
 =

 static gboolean update_ppp(gpointer user)
-- =

1.6.3.3


--===============6789641743940240879==--

