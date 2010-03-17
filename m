Content-Type: multipart/mixed; boundary="===============5774693348410639243=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 01/11] Rename g_at_server_send_result
Date: Wed, 17 Mar 2010 22:30:31 +0800
Message-ID: <1268836241-4834-1-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5774693348410639243==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Rename it to g_at_server_send_final.
---
 gatchat/gatserver.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index 7577de2..46fa423 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -148,7 +148,7 @@ static void send_common(GAtServer *server, const char *=
buf, unsigned int len)
 	g_at_server_wakeup_writer(server);
 }
 =

-static void g_at_server_send_result(GAtServer *server, GAtServerResult res=
ult)
+static void g_at_server_send_final(GAtServer *server, GAtServerResult resu=
lt)
 {
 	struct v250_settings v250 =3D server->v250;
 	const char *result_str =3D server_result_to_string(result);
@@ -353,7 +353,7 @@ static void new_bytes(GAtServer *p)
 			 * According to section 5.2.4 and 5.6 of V250,
 			 * Empty commands must be OK by the DCE
 			 */
-			g_at_server_send_result(p, G_AT_SERVER_RESULT_OK);
+			g_at_server_send_final(p, G_AT_SERVER_RESULT_OK);
 			ring_buffer_drain(p->read_buf, p->read_so_far);
 			break;
 =

@@ -363,7 +363,7 @@ static void new_bytes(GAtServer *p)
 =

 		case PARSER_RESULT_REPEAT_LAST:
 			/* TODO */
-			g_at_server_send_result(p, G_AT_SERVER_RESULT_OK);
+			g_at_server_send_final(p, G_AT_SERVER_RESULT_OK);
 			ring_buffer_drain(p->read_buf, p->read_so_far);
 			break;
 =

-- =

1.6.6.1


--===============5774693348410639243==--

