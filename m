Content-Type: multipart/mixed; boundary="===============6023666739562514157=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 3/7] Add basic command parsing
Date: Wed, 03 Mar 2010 22:56:48 +0800
Message-ID: <1267628212-14079-3-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1267628212-14079-2-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6023666739562514157==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

According to V.250 5.3.1, the basic command is either a single
character or the '&' followed by a single character except for 'D'
and 'S'.

The subparameter should be the numbers.
---
 gatchat/gatserver.c |   67 +++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 66 insertions(+), 1 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index c54170e..b3c3f5f 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -211,9 +211,68 @@ static char *parse_extended_command(GAtServer *server,=
 char *buf,
 	return NULL;
 }
 =

+static gboolean get_basic_prefix(char *buf, char *prefix)
+{
+	char c =3D buf[0];
+
+	if (g_ascii_isalpha(c)) {
+		c =3D g_ascii_toupper(c);
+
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
 static char *parse_basic_command(GAtServer *server, char *buf, char *prefi=
x)
 {
-	return NULL;
+	int i =3D 0;
+	char t =3D server->v250.s3;
+	char c =3D g_ascii_toupper(buf[0]);
+
+	if (!get_basic_prefix(buf, prefix))
+		return NULL;
+
+	i =3D strlen(prefix);
+
+	if (c =3D=3D 'D') {
+		/* All following characters are the part of the call */
+		while (buf[i] && buf[i] !=3D t && buf[i] !=3D ';')
+			i++;
+	} else {
+		/* V.250 5.3.2 Skip '=3D' for S-parameters if have */
+		if (c =3D=3D 'S' && buf[i] =3D=3D '=3D')
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

 static char *server_parse_next_command(GAtServer *server, char *buf,
@@ -258,6 +317,12 @@ static GAtServerResult server_parse_line(GAtServer *se=
rver, char *line)
 		if (res !=3D G_AT_SERVER_RESULT_OK)
 			break;
 =

+		/* Commands like ATA, ATD cause the remainder line
+		 * to be ignored.
+		 */
+		if (!strcmp(prefix, "A") || !strcmp(prefix, "D"))
+			break;
+
 		line +=3D strlen(command);
 =

 		g_free(command);
-- =

1.6.6.1


--===============6023666739562514157==--

