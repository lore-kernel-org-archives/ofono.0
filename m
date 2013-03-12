Content-Type: multipart/mixed; boundary="===============8309064307124397330=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 14/15] handsfree-audio: Check agent before sending fd
Date: Tue, 12 Mar 2013 09:42:12 -0300
Message-ID: <1363092133-1092-15-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1363092133-1092-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8309064307124397330==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch avoids sending the SCO fd when the connection is established
and the agent left the bus. This check covers the scenario when the
agent leaves the bus between "Connect" method call until the SCO
GIOChannel watch gets called.
---
 src/handsfree-audio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 805f3b6..62d316f 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -251,7 +251,8 @@ static gboolean sco_connect_cb(GIOChannel *io, GIOCondi=
tion cond,
 =

 	sk =3D g_io_channel_unix_get_fd(io);
 =

-	send_new_connection(card->path, sk);
+	if (agent)
+		send_new_connection(card->path, sk);
 =

 	close(sk);
 =

-- =

1.7.11.7


--===============8309064307124397330==--

