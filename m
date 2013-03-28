Content-Type: multipart/mixed; boundary="===============3004659181858714684=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 5/5] handsfree-audio: Handle when .Connect() was already
 replied to
Date: Wed, 27 Mar 2013 21:13:02 -0300
Message-ID: <1364429582-12518-5-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1364429582-12518-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3004659181858714684==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In some cases, it is possible that when sco_connect_cb() is called
the .Connect() message (stored in card->msg) is not valid anymore.
---
 src/handsfree-audio.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 3f24a2a..841cc3f 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -242,16 +242,19 @@ static gboolean sco_connect_cb(GIOChannel *io, GIOCon=
dition cond,
 {
 	struct ofono_handsfree_card *card =3D user_data;
 	DBusMessage *reply;
-	int sk;
+	int sk, err;
 =

 	if (agent =3D=3D NULL) {
 		/* There's no agent, so there's no one to reply to */
-		reply =3D NULL;
+		if (card->msg)
+			dbus_message_unref(card->msg);
+
+		card->msg =3D NULL;
 		goto done;
 	}
 =

 	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL)) {
-		reply =3D __ofono_error_failed(card->msg);
+		err =3D -EIO;
 		goto done;
 	}
 =

@@ -261,14 +264,19 @@ static gboolean sco_connect_cb(GIOChannel *io, GIOCon=
dition cond,
 =

 	close(sk);
 =

-	reply =3D dbus_message_new_method_return(card->msg);
+	err =3D 0;
 =

 done:
-	if (reply)
-		g_dbus_send_message(ofono_dbus_get_connection(), reply);
+	/* Or the msg was already replied to, or the agent exited */
+	if (card->msg =3D=3D NULL)
+		return FALSE;
 =

-	dbus_message_unref(card->msg);
-	card->msg =3D NULL;
+	if (err < 0)
+		reply =3D __ofono_error_failed(card->msg);
+	else
+		reply =3D dbus_message_new_method_return(card->msg);
+
+	__ofono_dbus_pending_reply(&card->msg, reply);
 =

 	return FALSE;
 }
-- =

1.8.2


--===============3004659181858714684==--

