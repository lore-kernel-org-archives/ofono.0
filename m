Content-Type: multipart/mixed; boundary="===============6564957065326244149=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 03/11] Add basic command parsing
Date: Wed, 17 Mar 2010 22:30:33 +0800
Message-ID: <1268836241-4834-3-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1268836241-4834-2-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6564957065326244149==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

According to V.250 5.3.1, the basic command is either a single
character or the '&' followed by a single character.
---
 gatchat/gatserver.c |   68 +++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 67 insertions(+), 1 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index fb82ad4..b68894d 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -211,10 +211,67 @@ static char *parse_extended_command(GAtServer *server=
, const char *buf,
 	return NULL;
 }
 =

+static gboolean get_basic_prefix(const char *buf, char *prefix)
+{
+	char c =3D *buf;
+
+	if (g_ascii_isalpha(c)) {
+		c =3D g_ascii_toupper(c);
+		if (c =3D=3D 'S') {
+			int i =3D 0;
+
+			prefix[0] =3D 'S';
+
+			/* V.250 5.3.2 'S' command follows with
+			 * a parameter number.
+			 */
+			while (g_ascii_isdigit(buf[++i]))
+				prefix[i] =3D buf[i];
+
+			prefix[i] =3D '\0';
+		} else {
+			prefix[0] =3D c;
+			prefix[1] =3D '\0';
+		}
+	} else if (c =3D=3D '&') {
+		prefix[0] =3D '&';
+		prefix[1] =3D g_ascii_toupper(buf[1]);
+		prefix[2] =3D '\0';
+	} else
+		return FALSE;
+
+	return TRUE;
+}
+
 static char *parse_basic_command(GAtServer *server, const char *buf,
 					char *prefix)
 {
-	return NULL;
+	char t =3D server->v250.s3;
+	int i;
+
+	if (!get_basic_prefix(buf, prefix))
+		return NULL;
+
+	i =3D strlen(prefix);
+
+	if (*buf =3D=3D 'D' || *buf =3D=3D 'd') {
+		/* All following characters are the part of the call */
+		while (buf[i] && buf[i] !=3D t)
+			i++;
+	} else {
+		/* Skip '=3D', '?' if have */
+		if (buf[i] =3D=3D '=3D')
+			i++;
+
+		if (buf[i] =3D=3D '?')
+			i++;
+
+		/* V.250 5.3.1 The subparameter are all digits if have */
+		while (g_ascii_isdigit(buf[i]))
+			i++;
+	}
+
+	return g_strndup(buf, i);
 }
 =

 static char *parse_next_command(GAtServer *server, const char *buf,
@@ -263,6 +320,15 @@ static void server_parse_line(GAtServer *server, char =
*line)
 			break;
 		}
 =

+		/* Commands like ATA, ATD, ATZ cause the remainder line
+		 * to be ignored.
+		 */
+		if (!strcmp(prefix, "A") || !strcmp(prefix, "D") ||
+				!strcmp(prefix, "Z")) {
+			g_free(command);
+			break;
+		}
+
 		buf +=3D strlen(command);
 =

 		g_free(command);
-- =

1.6.6.1


--===============6564957065326244149==--

