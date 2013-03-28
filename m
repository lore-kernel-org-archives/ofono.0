Content-Type: multipart/mixed; boundary="===============2928218681721183192=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 3/5] handsfree-audio: Add ofono_handsfree_card_connect_sco
Date: Wed, 27 Mar 2013 21:13:00 -0300
Message-ID: <1364429582-12518-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1364429582-12518-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2928218681721183192==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/handsfree-audio.c | 87 ++++++++++++++++++++++++++---------------------=
----
 1 file changed, 44 insertions(+), 43 deletions(-)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index f8df6d6..571ed54 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -236,40 +236,6 @@ static DBusMessage *card_get_properties(DBusConnection=
 *conn,
 	return reply;
 }
 =

-static int card_connect_sco(struct ofono_handsfree_card *card)
-{
-	struct sockaddr_sco addr;
-	int sk, ret;
-
-	sk =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET | O_NONBLOCK | SOCK_CLOEXEC,
-								BTPROTO_SCO);
-	if (sk < 0)
-		return -1;
-
-	/* Bind to local address */
-	memset(&addr, 0, sizeof(addr));
-	addr.sco_family =3D AF_BLUETOOTH;
-	bt_str2ba(card->local, &addr.sco_bdaddr);
-
-	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
-		close(sk);
-		return -1;
-	}
-
-	/* Connect to remote device */
-	memset(&addr, 0, sizeof(addr));
-	addr.sco_family =3D AF_BLUETOOTH;
-	bt_str2ba(card->remote, &addr.sco_bdaddr);
-
-	ret =3D connect(sk, (struct sockaddr *) &addr, sizeof(addr));
-	if (ret < 0 && errno !=3D EINPROGRESS) {
-		close(sk);
-		return -1;
-	}
-
-	return sk;
-}
-
 static gboolean sco_connect_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 =

@@ -311,9 +277,8 @@ static DBusMessage *card_connect(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
 	struct ofono_handsfree_card *card =3D data;
-	GIOChannel *io;
 	const char *sender;
-	int sk;
+	int err;
 =

 	if (agent =3D=3D NULL)
 		return __ofono_error_not_available(msg);
@@ -326,15 +291,10 @@ static DBusMessage *card_connect(DBusConnection *conn,
 	if (card->msg)
 		return __ofono_error_busy(msg);
 =

-	sk =3D card_connect_sco(card);
-	if (sk < 0)
+	err =3D ofono_handsfree_card_connect_sco(card);
+	if (err < 0)
 		return __ofono_error_failed(msg);
 =

-	io =3D g_io_channel_unix_new(sk);
-	g_io_add_watch(io, G_IO_OUT | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-						sco_connect_cb, card);
-	g_io_channel_unref(io);
-
 	card->msg =3D dbus_message_ref(msg);
 =

 	return NULL;
@@ -420,6 +380,47 @@ const char *ofono_handsfree_card_get_local(struct ofon=
o_handsfree_card *card)
 	return card->local;
 }
 =

+int ofono_handsfree_card_connect_sco(struct ofono_handsfree_card *card)
+{
+	GIOChannel *io;
+	struct sockaddr_sco addr;
+	int sk, ret;
+
+	sk =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET | O_NONBLOCK | SOCK_CLOEXEC,
+								BTPROTO_SCO);
+	if (sk < 0)
+		return -1;
+
+	/* Bind to local address */
+	memset(&addr, 0, sizeof(addr));
+	addr.sco_family =3D AF_BLUETOOTH;
+	bt_str2ba(card->local, &addr.sco_bdaddr);
+
+	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		ofono_error("Could not bind SCO socket");
+		close(sk);
+		return -1;
+	}
+
+	/* Connect to remote device */
+	memset(&addr, 0, sizeof(addr));
+	addr.sco_family =3D AF_BLUETOOTH;
+	bt_str2ba(card->remote, &addr.sco_bdaddr);
+
+	ret =3D connect(sk, (struct sockaddr *) &addr, sizeof(addr));
+	if (ret < 0 && errno !=3D EINPROGRESS) {
+		close(sk);
+		return -1;
+	}
+
+	io =3D g_io_channel_unix_new(sk);
+	g_io_add_watch(io, G_IO_OUT | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+						sco_connect_cb, card);
+	g_io_channel_unref(io);
+
+	return 0;
+}
+
 static void emit_card_added(struct ofono_handsfree_card *card)
 {
 	DBusMessage *signal;
-- =

1.8.2


--===============2928218681721183192==--

