Content-Type: multipart/mixed; boundary="===============5348582151259695972=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH 2/2] hfp_ag: Do not close client fd on unref
Date: Thu, 17 Feb 2011 16:55:26 +0100
Message-ID: <1297958126-9156-3-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1297958126-9156-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5348582151259695972==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp_ag.c |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/plugins/hfp_ag.c b/plugins/hfp_ag.c
index cbf3ccd..cb4a0be 100644
--- a/plugins/hfp_ag.c
+++ b/plugins/hfp_ag.c
@@ -40,7 +40,6 @@
 static struct server *server;
 static guint modemwatch_id;
 static GList *modems;
-static guint channel_watch;
 =

 static const gchar *hfp_ag_record =3D
 "<?xml version=3D\"1.0\" encoding=3D\"UTF-8\" ?>\n"
@@ -86,12 +85,6 @@ static const gchar *hfp_ag_record =3D
 "  </attribute>\n"
 "</record>\n";
 =

-static gboolean hfp_ag_disconnect_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
-{
-	return FALSE;
-}
-
 static void hfp_ag_connect_cb(GIOChannel *io, GError *err, gpointer user_d=
ata)
 {
 	struct ofono_modem *modem;
@@ -118,8 +111,7 @@ static void hfp_ag_connect_cb(GIOChannel *io, GError *e=
rr, gpointer user_data)
 	fd =3D g_io_channel_unix_get_fd(io);
 	ofono_emulator_register(em, fd);
 =

-	channel_watch =3D g_io_add_watch(io, G_IO_NVAL | G_IO_HUP | G_IO_ERR,
-					hfp_ag_disconnect_cb, NULL);
+	g_io_channel_set_close_on_unref(io, FALSE);
 =

 	return;
 =

-- =

1.7.1


--===============5348582151259695972==--

