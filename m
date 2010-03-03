Content-Type: multipart/mixed; boundary="===============6716672312798104725=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 4/7] Add extended command parsing
Date: Wed, 03 Mar 2010 22:56:49 +0800
Message-ID: <1267628212-14079-4-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1267628212-14079-3-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6716672312798104725==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

See V.250 5.4 Extended syntax commands for details.
---
 gatchat/gatserver.c |   56 +++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 55 insertions(+), 1 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index b3c3f5f..4a19b6b 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -197,6 +197,28 @@ static gboolean is_basic_command_prefix(char *buf)
 	return FALSE;
 }
 =

+static gboolean is_extended_character(const char c)
+{
+	if (g_ascii_isalpha(c))
+		return TRUE;
+
+	if (g_ascii_isdigit(c))
+		return TRUE;
+
+	switch (c) {
+	case '!':
+	case '%':
+	case '-':
+	case '.':
+	case '/':
+	case ':':
+	case '_':
+		return TRUE;
+	default:
+		return FALSE;
+	}
+}
+
 static GAtServerResult at_notify_callback(GAtServer *server, char *command,
 					char *prefix)
 {
@@ -205,10 +227,42 @@ static GAtServerResult at_notify_callback(GAtServer *=
server, char *command,
 	return res;
 }
 =

+static gboolean get_extended_prefix(char *buf, char *prefix, char t)
+{
+	char c;
+	int i =3D 0;
+
+	/* Skip '+' */
+	prefix[0] =3D buf[0];
+
+	while ((c =3D buf[++i])) {
+		/* V.250 5.4.1 Extended command naming rules */
+		if (is_extended_character(c))
+			prefix[i] =3D g_ascii_toupper(c);
+		else
+			break;
+	}
+
+	prefix[i] =3D '\0';
+	return TRUE;
+}
+
 static char *parse_extended_command(GAtServer *server, char *buf,
 					char *prefix)
 {
-	return NULL;
+	char *command =3D NULL;
+	char t =3D server->v250.s3;
+	char c =3D buf[0];
+	int i =3D 0;
+
+	while (c && c !=3D t && c !=3D ';')
+		c =3D buf[++i];
+
+	command =3D g_strndup(buf, i);
+
+	get_extended_prefix(command, prefix, t);
+
+	return command;
 }
 =

 static gboolean get_basic_prefix(char *buf, char *prefix)
-- =

1.6.6.1


--===============6716672312798104725==--

