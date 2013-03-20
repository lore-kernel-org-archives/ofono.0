Content-Type: multipart/mixed; boundary="===============5476141320090597388=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 3/4] handsfree-audio: Reject .Connect() from other senders
Date: Wed, 20 Mar 2013 20:03:03 -0300
Message-ID: <1363820584-24513-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1363820584-24513-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5476141320090597388==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Only the agent should be able to call .Connect() on the card.
---
 src/handsfree-audio.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 3600255..c2bdc7f 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -314,11 +314,17 @@ static DBusMessage *card_connect(DBusConnection *conn,
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
 	if (card->sco_watch)
 		return __ofono_error_busy(msg);
 =

-- =

1.8.1.5


--===============5476141320090597388==--

