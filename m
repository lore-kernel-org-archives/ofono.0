Content-Type: multipart/mixed; boundary="===============0937830527169984135=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 3/5] handsfree-audio: Reject .Connect() from other senders
Date: Mon, 25 Mar 2013 19:05:20 -0300
Message-ID: <1364249122-18332-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1364249122-18332-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0937830527169984135==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Only the agent should be able to call .Connect() on the card.
---
 src/handsfree-audio.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 4232074..f8df6d6 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -312,11 +312,17 @@ static DBusMessage *card_connect(DBusConnection *conn,
 {
 	struct ofono_handsfree_card *card =3D data;
 	GIOChannel *io;
+	const char *sender;
 	int sk;
 =

 	if (agent =3D=3D NULL)
 		return __ofono_error_not_available(msg);
 =

+	sender =3D dbus_message_get_sender(msg);
+
+	if (!g_str_equal(sender, agent->owner))
+		return __ofono_error_not_allowed(msg);
+
 	if (card->msg)
 		return __ofono_error_busy(msg);
 =

-- =

1.8.2


--===============0937830527169984135==--

