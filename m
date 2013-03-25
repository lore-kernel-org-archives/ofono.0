Content-Type: multipart/mixed; boundary="===============4910242245085149696=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 5/5] handsfree-audio: Add .Connect using the card driver
Date: Mon, 25 Mar 2013 19:05:22 -0300
Message-ID: <1364249122-18332-5-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1364249122-18332-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4910242245085149696==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/handsfree-audio.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index f8df6d6..9d3d64e 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -307,6 +307,40 @@ done:
 	return FALSE;
 }
 =

+static void card_connect_reply_cb(const struct ofono_error *error, void *d=
ata)
+{
+	struct ofono_handsfree_card *card =3D data;
+	DBusMessage *reply;
+
+	if (error->type =3D=3D OFONO_ERROR_TYPE_NO_ERROR)
+		reply =3D dbus_message_new_method_return(card->msg);
+	else
+		reply =3D __ofono_error_failed(card->msg);
+
+	g_dbus_send_message(ofono_dbus_get_connection(), reply);
+
+	dbus_message_unref(card->msg);
+	card->msg =3D NULL;
+}
+
+static DBusMessage *card_connect_driver(struct ofono_handsfree_card *card,
+							DBusMessage *msg)
+{
+	const struct ofono_handsfree_card_driver *driver =3D card->driver;
+	int err;
+
+	err =3D driver->connect(card, card_connect_reply_cb, card);
+	if (err =3D=3D -EINPROGRESS) {
+		card->msg =3D dbus_message_ref(msg);
+		return NULL;
+	}
+
+	if (err < 0)
+		return __ofono_error_failed(msg);
+
+	return dbus_message_new_method_return(msg);
+}
+
 static DBusMessage *card_connect(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
@@ -326,6 +360,10 @@ static DBusMessage *card_connect(DBusConnection *conn,
 	if (card->msg)
 		return __ofono_error_busy(msg);
 =

+	if (card->driver && card->driver->connect)
+		return card_connect_driver(card, msg);
+
+	/* There's no driver, fallback to direct SCO connection */
 	sk =3D card_connect_sco(card);
 	if (sk < 0)
 		return __ofono_error_failed(msg);
-- =

1.8.2


--===============4910242245085149696==--

