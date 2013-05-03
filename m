Content-Type: multipart/mixed; boundary="===============5567123467575919704=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH] handsfree-audio: Fix replying to an empty D-Bus message
Date: Thu, 02 May 2013 21:47:16 -0300
Message-ID: <1367542036-19595-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5567123467575919704==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In the case that ofono_handsfree_card_connect_sco() is called outside the
context of a .Connect() call, there's no message we need to reply.  This
happens, for example, when the HFP AG plugin initiates a SCO connection when
it receives an AT+BCC command from the HF.
---
 src/handsfree-audio.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index d78498a..5179ddd 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -248,7 +248,8 @@ static gboolean sco_connect_cb(GIOChannel *io, GIOCondi=
tion cond,
 	}
 =

 	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL)) {
-		reply =3D __ofono_error_failed(card->msg);
+		if (card->msg)
+			reply =3D __ofono_error_failed(card->msg);
 		goto done;
 	}
 =

@@ -258,9 +259,13 @@ static gboolean sco_connect_cb(GIOChannel *io, GIOCond=
ition cond,
 =

 	close(sk);
 =

-	reply =3D dbus_message_new_method_return(card->msg);
+	if (card->msg)
+		reply =3D dbus_message_new_method_return(card->msg);
 =

 done:
+	if (card->msg =3D=3D NULL)
+		return FALSE;
+
 	if (reply)
 		g_dbus_send_message(ofono_dbus_get_connection(), reply);
 =

-- =

1.8.2.1


--===============5567123467575919704==--

