Content-Type: multipart/mixed; boundary="===============3176687274612108631=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 4/7] Add Repeat last command support
Date: Wed, 31 Mar 2010 17:50:37 +0800
Message-ID: <1270029040-21077-4-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1270029040-21077-3-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3176687274612108631==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatserver.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index 5206a12..4796b71 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -996,8 +996,13 @@ static void new_bytes(GAtServer *p)
 		}
 =

 		case PARSER_RESULT_REPEAT_LAST:
-			/* TODO */
-			g_at_server_send_final(p, G_AT_SERVER_RESULT_ERROR);
+			p->cur_pos =3D 0;
+
+			if (p->last_line)
+				server_parse_line(p);
+			else
+				g_at_server_send_final(p,
+						G_AT_SERVER_RESULT_OK);
 			ring_buffer_drain(p->read_buf, p->read_so_far);
 			break;
 =

-- =

1.6.6.1


--===============3176687274612108631==--

