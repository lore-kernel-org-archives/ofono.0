Content-Type: multipart/mixed; boundary="===============8861220794704027830=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 4/5] handsfree-audio: Add .Connect using the card driver
Date: Wed, 27 Mar 2013 21:13:01 -0300
Message-ID: <1364429582-12518-4-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1364429582-12518-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8861220794704027830==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Now each handsfree implementation may be notified that a card wants
its audio to be connected.
---
 src/handsfree-audio.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 571ed54..3f24a2a 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -273,10 +273,24 @@ done:
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
+	__ofono_dbus_pending_reply(&card->msg, reply);
+}
+
 static DBusMessage *card_connect(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
 	struct ofono_handsfree_card *card =3D data;
+	const struct ofono_handsfree_card_driver *driver =3D card->driver;
 	const char *sender;
 	int err;
 =

@@ -291,6 +305,17 @@ static DBusMessage *card_connect(DBusConnection *conn,
 	if (card->msg)
 		return __ofono_error_busy(msg);
 =

+	if (!driver || !driver->connect)
+		goto fallback;
+
+	card->msg =3D dbus_message_ref(msg);
+
+	driver->connect(card, card_connect_reply_cb, card);
+
+	return NULL;
+
+fallback:
+	/* There's no driver, fallback to direct SCO connection */
 	err =3D ofono_handsfree_card_connect_sco(card);
 	if (err < 0)
 		return __ofono_error_failed(msg);
-- =

1.8.2


--===============8861220794704027830==--

