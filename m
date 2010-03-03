Content-Type: multipart/mixed; boundary="===============4985138770011332100=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 1/7] Remove old server_parse_line
Date: Wed, 03 Mar 2010 22:56:46 +0800
Message-ID: <1267628212-14079-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4985138770011332100==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatserver.c |   45 ---------------------------------------------
 1 files changed, 0 insertions(+), 45 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index c9256e2..4175112 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -173,55 +173,10 @@ static void g_at_server_send_result(GAtServer *server=
, GAtServerResult result)
 	send_common(server, buf, MIN(len, sizeof(buf)-1));
 }
 =

-static inline gboolean is_at_command_prefix(const char c)
-{
-	switch (c) {
-	case '+':
-	case '*':
-	case '!':
-	case '%':
-		return TRUE;
-	default:
-		return FALSE;
-	}
-}
-
-static GAtServerResult parse_at_command(GAtServer *server, char *buf)
-{
-	return G_AT_SERVER_RESULT_ERROR;
-}
-
-static GAtServerResult parse_v250_settings(GAtServer *server, char *buf)
-{
-	return G_AT_SERVER_RESULT_ERROR;
-}
-
 static GAtServerResult server_parse_line(GAtServer *server, char *line)
 {
-	gsize i =3D 0;
-	char c;
 	GAtServerResult res =3D G_AT_SERVER_RESULT_ERROR;
 =

-	if (line =3D=3D NULL)
-		goto done;
-
-	if (line[0] =3D=3D '\0') {
-		res =3D G_AT_SERVER_RESULT_OK;
-		goto done;
-	}
-
-	c =3D line[i];
-	/* skip semicolon */
-	if (c =3D=3D ';')
-		c =3D line[++i];
-
-	if (is_at_command_prefix(c))
-		res =3D parse_at_command(server, line + i);
-	else if (g_ascii_isalpha(c) || c =3D=3D '&')
-		res =3D parse_v250_settings(server, line + i);
-
-done:
-	g_free(line);
 	return res;
 }
 =

-- =

1.6.6.1


--===============4985138770011332100==--

