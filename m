Content-Type: multipart/mixed; boundary="===============6785242927558762063=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 2/4] handsfree-audio: Add support for sending the SCO socket
Date: Wed, 20 Mar 2013 20:03:02 -0300
Message-ID: <1363820584-24513-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1363820584-24513-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6785242927558762063==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Send the SCO socket to the agent associated with the card that
just got connected.
---
 src/handsfree-audio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 1da2224..3600255 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -289,6 +289,8 @@ static gboolean sco_connect_cb(GIOChannel *io, GIOCondi=
tion cond,
 =

 	sk =3D g_io_channel_unix_get_fd(io);
 =

+	send_new_connection(card->path, sk);
+
 	close(sk);
 =

 	reply =3D dbus_message_new_method_return(card->msg);
-- =

1.8.1.5


--===============6785242927558762063==--

