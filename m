Content-Type: multipart/mixed; boundary="===============1037796835496954445=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH 1/2] gatchat: Add function to enable/disable echo
Date: Wed, 23 Feb 2011 14:19:12 +0100
Message-ID: <1298467153-2426-2-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1298467153-2426-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1037796835496954445==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatserver.c |   10 ++++++++++
 gatchat/gatserver.h |    1 +
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index b092a68..d9b1592 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -1235,6 +1235,16 @@ gboolean g_at_server_shutdown(GAtServer *server)
 	return TRUE;
 }
 =

+gboolean g_at_server_set_echo(GAtServer *server, gboolean echo)
+{
+	if (server =3D=3D NULL)
+		return FALSE;
+
+	server->v250.echo =3D echo;
+
+	return TRUE;
+}
+
 gboolean g_at_server_set_disconnect_function(GAtServer *server,
 						GAtDisconnectFunc disconnect,
 						gpointer user_data)
diff --git a/gatchat/gatserver.h b/gatchat/gatserver.h
index a42c8b5..bb0ae84 100644
--- a/gatchat/gatserver.h
+++ b/gatchat/gatserver.h
@@ -80,6 +80,7 @@ void g_at_server_unref(GAtServer *server);
 =

 gboolean g_at_server_shutdown(GAtServer *server);
 =

+gboolean g_at_server_set_echo(GAtServer *server, gboolean echo);
 gboolean g_at_server_set_disconnect_function(GAtServer *server,
 					GAtDisconnectFunc disconnect,
 					gpointer user_data);
-- =

1.7.1


--===============1037796835496954445==--

