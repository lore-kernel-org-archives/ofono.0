Content-Type: multipart/mixed; boundary="===============6354066740553849061=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH] gatchat: fix canceling in progress commands
Date: Thu, 02 Dec 2010 17:13:42 -0300
Message-ID: <1291320822-10879-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6354066740553849061==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

As g_queue_peek_head() returns the node data field, we have to compare
it against the actual command, not against the pointer to the queue node.
---
 gatchat/gatchat.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gatchat/gatchat.c b/gatchat/gatchat.c
index d82a02e..96da657 100644
--- a/gatchat/gatchat.c
+++ b/gatchat/gatchat.c
@@ -1060,7 +1060,7 @@ static gboolean at_chat_cancel(struct at_chat *chat, =
guint group, guint id)
 	if (c->gid !=3D group)
 		return FALSE;
 =

-	if (l =3D=3D g_queue_peek_head(chat->command_queue) &&
+	if (c =3D=3D g_queue_peek_head(chat->command_queue) &&
 			chat->cmd_bytes_written > 0) {
 		/* We can't actually remove it since it is most likely
 		 * already in progress, just null out the callback
-- =

1.7.3.2


--===============6354066740553849061==--

