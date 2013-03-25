Content-Type: multipart/mixed; boundary="===============7438090445260081740=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 1/5] handsfree-audio: Add support for initiating SCO
 connections
Date: Mon, 25 Mar 2013 19:05:18 -0300
Message-ID: <1364249122-18332-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7438090445260081740==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When calling the card's .Connect() method, we should be able to
establish a SCO connection.

Right now, we only have support for establishing the SCO connection
directly, this is what is expected from HFP 1.5 HF/AG devices.
---
 src/handsfree-audio.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 92 insertions(+), 1 deletion(-)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index c7fa2fb..795a68b 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -53,6 +53,7 @@ struct ofono_handsfree_card {
 	char *remote;
 	char *local;
 	char *path;
+	DBusMessage *msg;
 	const struct ofono_handsfree_card_driver *driver;
 	void *driver_data;
 };
@@ -235,10 +236,100 @@ static DBusMessage *card_get_properties(DBusConnecti=
on *conn,
 	return reply;
 }
 =

+static int card_connect_sco(struct ofono_handsfree_card *card)
+{
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
+	return sk;
+}
+
+static gboolean sco_connect_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+
+{
+	struct ofono_handsfree_card *card =3D user_data;
+	DBusMessage *reply;
+	int sk;
+
+	if (agent =3D=3D NULL) {
+		/* There's no agent, so there's no one to reply to */
+		reply =3D NULL;
+		goto done;
+	}
+
+	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL)) {
+		reply =3D __ofono_error_failed(card->msg);
+		goto done;
+	}
+
+	sk =3D g_io_channel_unix_get_fd(io);
+
+	close(sk);
+
+	reply =3D dbus_message_new_method_return(card->msg);
+
+done:
+	if (reply)
+		g_dbus_send_message(ofono_dbus_get_connection(), reply);
+
+	dbus_message_unref(card->msg);
+	card->msg =3D NULL;
+
+	return FALSE;
+}
+
 static DBusMessage *card_connect(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
-	return __ofono_error_not_implemented(msg);
+	struct ofono_handsfree_card *card =3D data;
+	GIOChannel *io;
+	int sk;
+
+	if (agent =3D=3D NULL)
+		return __ofono_error_not_available(msg);
+
+	if (card->msg)
+		return __ofono_error_busy(msg);
+
+	sk =3D card_connect_sco(card);
+	if (sk < 0)
+		return __ofono_error_failed(msg);
+
+	io =3D g_io_channel_unix_new(sk);
+	g_io_add_watch(io, G_IO_OUT | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+						sco_connect_cb, card);
+	g_io_channel_unref(io);
+
+	card->msg =3D dbus_message_ref(msg);
+
+	return NULL;
 }
 =

 static const GDBusMethodTable card_methods[] =3D {
-- =

1.8.2


--===============7438090445260081740==--

