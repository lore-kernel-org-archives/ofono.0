Content-Type: multipart/mixed; boundary="===============5221195700517313905=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v0 10/13] handsfree-audio: Add connect GIOChannel watch
Date: Fri, 08 Mar 2013 20:11:22 -0300
Message-ID: <1362784285-22731-11-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1362784285-22731-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5221195700517313905==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds the GIOChannel watch of the SCO socket. For HF initiated
connections, when the audio connection is established the reply for the
Card "Connect" method should be sent.
---
 src/handsfree-audio.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 8a0d97d..f5d0a7b 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -54,6 +54,8 @@ struct ofono_handsfree_card {
 	char *local;
 	char *path;
 	const struct ofono_handsfree_card_driver *driver;
+	DBusMessage *msg;
+	guint sco_watch;
 };
 =

 struct agent {
@@ -234,11 +236,40 @@ static DBusMessage *card_get_properties(DBusConnectio=
n *conn,
 	return reply;
 }
 =

+static gboolean sco_connect_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+
+{
+	struct ofono_handsfree_card *card =3D user_data;
+	DBusMessage *reply;
+
+	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL)) {
+		reply =3D __ofono_error_failed(card->msg);
+		goto done;
+	}
+
+	reply =3D dbus_message_new_method_return(card->msg);
+
+done:
+	g_dbus_send_message(ofono_dbus_get_connection(), reply);
+
+	return FALSE;
+}
+
+static void sco_watch_destroy(gpointer user_data)
+{
+	struct ofono_handsfree_card *card =3D user_data;
+
+	card->sco_watch =3D 0;
+	dbus_message_unref(card->msg);
+}
+
 static DBusMessage *card_connect(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
 	struct ofono_handsfree_card *card =3D data;
 	const struct ofono_handsfree_card_driver *driver =3D card->driver;
+	GIOChannel *io;
 	int sk;
 =

 	if (driver =3D=3D NULL)
@@ -248,6 +279,15 @@ static DBusMessage *card_connect(DBusConnection *conn,
 	if (sk < 0)
 		return __ofono_error_failed(msg);
 =

+	io =3D g_io_channel_unix_new(sk);
+	card->sco_watch =3D g_io_add_watch_full(io, G_PRIORITY_DEFAULT,
+				G_IO_OUT | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+				sco_connect_cb, card, sco_watch_destroy);
+
+	g_io_channel_unref(io);
+
+	card->msg =3D dbus_message_ref(msg);
+
 	return NULL;
 }
 =

@@ -383,6 +423,9 @@ void ofono_handsfree_card_remove(struct ofono_handsfree=
_card *card)
 	g_free(card->remote);
 	g_free(card->local);
 =

+	if (card->sco_watch > 0)
+		g_source_remove(card->sco_watch);
+
 	g_free(card);
 }
 =

-- =

1.7.11.7


--===============5221195700517313905==--

