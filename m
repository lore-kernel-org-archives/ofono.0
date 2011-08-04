Content-Type: multipart/mixed; boundary="===============5006778264799494292=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH v2 1/2] gatserver: add command finished functions
Date: Thu, 04 Aug 2011 16:29:49 +0200
Message-ID: <1312468190-27253-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5006778264799494292==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatserver.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 gatchat/gatserver.h |    7 +++++++
 2 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index ab785f7..8e92071 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -115,6 +115,9 @@ struct _GAtServer {
 	gpointer user_disconnect_data;		/* User disconnect data */
 	GAtDebugFunc debugf;			/* Debugging output function */
 	gpointer debug_data;			/* Data to pass to debug func */
+	GAtServerFinishFunc finishf;		/* Command finish function */
+	gpointer finish_data;			/* Finish func data */
+	guint finish_source;
 	GHashTable *command_list;		/* List of AT commands */
 	GQueue *write_queue;			/* Write buffer queue */
 	guint max_read_attempts;		/* Max reads per select */
@@ -1177,12 +1180,27 @@ static void server_wakeup_writer(GAtServer *server)
 	g_at_io_set_write_handler(server->io, can_write_data, server);
 }
 =

+static gboolean notify_finish(void *user_data)
+{
+	GAtServer *server =3D user_data;
+
+	server->finishf(server, server->finish_data);
+	server->finish_source =3D 0;
+
+	return FALSE;
+}
+
 static void server_resume(GAtServer *server)
 {
 	if (server->suspended =3D=3D FALSE)
 		return;
 =

 	server->suspended =3D FALSE;
+
+	if (server->finishf)
+		server->finish_source =3D g_timeout_add_seconds(0, notify_finish,
+								server);
+
 	g_at_io_set_read_handler(server->io, new_bytes, server);
 }
 =

@@ -1336,6 +1354,11 @@ void g_at_server_unref(GAtServer *server)
 	if (server =3D=3D NULL)
 		return;
 =

+	if (server->finish_source) {
+		g_source_remove(server->finish_source);
+		server->finish_source =3D 0;
+	}
+
 	is_zero =3D g_atomic_int_dec_and_test(&server->ref_count);
 =

 	if (is_zero =3D=3D FALSE)
@@ -1455,3 +1478,24 @@ gboolean g_at_server_unregister(GAtServer *server, c=
onst char *prefix)
 =

 	return TRUE;
 }
+
+gboolean g_at_server_set_finish_callback(GAtServer *server,
+					GAtServerFinishFunc finish,
+					gpointer user_data)
+{
+	if (server =3D=3D NULL)
+		return FALSE;
+
+	server->finishf =3D finish;
+	server->finish_data =3D user_data;
+
+	return TRUE;
+}
+
+gboolean g_at_server_command_pending(GAtServer *server)
+{
+	if (server =3D=3D NULL)
+		return FALSE;
+
+	return server->suspended;
+}
diff --git a/gatchat/gatserver.h b/gatchat/gatserver.h
index bb0ae84..599c992 100644
--- a/gatchat/gatserver.h
+++ b/gatchat/gatserver.h
@@ -69,6 +69,8 @@ typedef void (*GAtServerNotifyFunc)(GAtServer *server,
 					GAtServerRequestType type,
 					GAtResult *result, gpointer user_data);
 =

+typedef void (*GAtServerFinishFunc)(GAtServer *server, gpointer user_data);
+
 GAtServer *g_at_server_new(GIOChannel *io);
 GIOChannel *g_at_server_get_channel(GAtServer *server);
 GAtIO *g_at_server_get_io(GAtServer *server);
@@ -94,6 +96,11 @@ gboolean g_at_server_register(GAtServer *server, const c=
har *prefix,
 					GDestroyNotify destroy_notify);
 gboolean g_at_server_unregister(GAtServer *server, const char *prefix);
 =

+gboolean g_at_server_set_finish_callback(GAtServer *server,
+					GAtServerFinishFunc finish,
+					gpointer user_data);
+gboolean g_at_server_command_pending(GAtServer *server);
+
 /* Send a final result code. E.g. G_AT_SERVER_RESULT_NO_DIALTONE */
 void g_at_server_send_final(GAtServer *server, GAtServerResult result);
 =

-- =

1.7.1


--===============5006778264799494292==--

