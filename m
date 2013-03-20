Content-Type: multipart/mixed; boundary="===============1337001591110461650=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 3/3] handsfree-audio: Add support for sending the SCO socket
Date: Tue, 19 Mar 2013 21:10:35 -0300
Message-ID: <1363738235-15211-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1363738235-15211-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1337001591110461650==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When there's an agent registered, send the SCO file descriptor to the
agent associated with the card after the connection is established.
---
 src/handsfree-audio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 9eecb8e..129f33f 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -286,6 +286,9 @@ static gboolean sco_connect_cb(GIOChannel *io, GIOCondi=
tion cond,
 =

 	sk =3D g_io_channel_unix_get_fd(io);
 =

+	if (agent)
+		send_new_connection(card->path, sk);
+
 	close(sk);
 =

 	reply =3D dbus_message_new_method_return(card->msg);
-- =

1.8.1.5


--===============1337001591110461650==--

