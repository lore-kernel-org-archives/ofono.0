Content-Type: multipart/mixed; boundary="===============8917549855404174161=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH] bluetooth: disconnect HFP AG clients
Date: Wed, 16 Feb 2011 18:17:49 +0100
Message-ID: <1297876669-27825-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8917549855404174161==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Clients should be disconnected when VoiceCall atom is unregistered
---
 plugins/hfp_ag.c |   22 +++++++++++++++++-----
 1 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/plugins/hfp_ag.c b/plugins/hfp_ag.c
index cbf3ccd..5fba13d 100644
--- a/plugins/hfp_ag.c
+++ b/plugins/hfp_ag.c
@@ -40,7 +40,7 @@
 static struct server *server;
 static guint modemwatch_id;
 static GList *modems;
-static guint channel_watch;
+static GSList *client_io;
 =

 static const gchar *hfp_ag_record =3D
 "<?xml version=3D\"1.0\" encoding=3D\"UTF-8\" ?>\n"
@@ -89,6 +89,8 @@ static const gchar *hfp_ag_record =3D
 static gboolean hfp_ag_disconnect_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
+	client_io =3D g_slist_remove(client_io, io);
+
 	return FALSE;
 }
 =

@@ -118,8 +120,9 @@ static void hfp_ag_connect_cb(GIOChannel *io, GError *e=
rr, gpointer user_data)
 	fd =3D g_io_channel_unix_get_fd(io);
 	ofono_emulator_register(em, fd);
 =

-	channel_watch =3D g_io_add_watch(io, G_IO_NVAL | G_IO_HUP | G_IO_ERR,
+	g_io_add_watch(io, G_IO_NVAL | G_IO_HUP | G_IO_ERR,
 					hfp_ag_disconnect_cb, NULL);
+	client_io =3D g_slist_append(client_io, io);
 =

 	return;
 =

@@ -143,9 +146,18 @@ static void voicecall_watch(struct ofono_atom *atom,
 							NULL);
 	} else {
 		modems =3D g_list_remove(modems, modem);
-		if (modems =3D=3D NULL &&  server !=3D NULL) {
-			bluetooth_unregister_server(server);
-			server =3D NULL;
+		if (modems =3D=3D NULL) {
+			if (server !=3D NULL) {
+				bluetooth_unregister_server(server);
+				server =3D NULL;
+			}
+
+			while (client_io) {
+				g_io_channel_shutdown(client_io->data, TRUE,
+							NULL);
+				client_io =3D g_slist_remove(client_io,
+							client_io->data);
+			}
 		}
 	}
 }
-- =

1.7.1


--===============8917549855404174161==--

