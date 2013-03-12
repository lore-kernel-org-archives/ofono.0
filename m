Content-Type: multipart/mixed; boundary="===============7417330895336425640=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 11/15] handsfree-audio: Add sending SCO fd
Date: Tue, 12 Mar 2013 09:42:09 -0300
Message-ID: <1363092133-1092-12-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1363092133-1092-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7417330895336425640==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds the call of NewConnection method when the SCO connection
is established for HF initiated scenarios.
---
 src/handsfree-audio.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index f5d0a7b..6fa8b67 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -242,12 +242,19 @@ static gboolean sco_connect_cb(GIOChannel *io, GIOCon=
dition cond,
 {
 	struct ofono_handsfree_card *card =3D user_data;
 	DBusMessage *reply;
+	int sk;
 =

 	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL)) {
 		reply =3D __ofono_error_failed(card->msg);
 		goto done;
 	}
 =

+	sk =3D g_io_channel_unix_get_fd(io);
+
+	send_new_connection(card->path, sk);
+
+	close(sk);
+
 	reply =3D dbus_message_new_method_return(card->msg);
 =

 done:
-- =

1.7.11.7


--===============7417330895336425640==--

