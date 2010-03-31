Content-Type: multipart/mixed; boundary="===============5127361959253228515=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 5/7] Fix echo command back even if don't process it
Date: Wed, 31 Mar 2010 17:50:38 +0800
Message-ID: <1270029040-21077-5-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1270029040-21077-4-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5127361959253228515==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatserver.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index 4796b71..a47d46c 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -1050,19 +1050,19 @@ static gboolean received_data(GIOChannel *channel, =
GIOCondition cond,
 =

 		read_count++;
 =

+		if (rbytes =3D=3D 0)
+			break;
+
+		if (server->v250.echo)
+			send_common(server, (char *)buf, rbytes);
+
 		/* Ignore incoming bytes when processing a command line */
 		if (server->processing_cmdline)
 			continue;
 =

 		total_read +=3D rbytes;
-
-		if (rbytes > 0) {
-			if (server->v250.echo)
-				send_common(server, (char *)buf, rbytes);
-
-			ring_buffer_write_advance(server->read_buf, rbytes);
-		}
-	} while (err =3D=3D G_IO_ERROR_NONE && rbytes > 0 &&
+		ring_buffer_write_advance(server->read_buf, rbytes);
+	} while (err =3D=3D G_IO_ERROR_NONE &&
 					read_count < server->max_read_attempts);
 =

 	if (total_read > 0)
-- =

1.6.6.1


--===============5127361959253228515==--

