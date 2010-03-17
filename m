Content-Type: multipart/mixed; boundary="===============3628984412649720370=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 04/11] Add extended command parsing
Date: Wed, 17 Mar 2010 22:30:34 +0800
Message-ID: <1268836241-4834-4-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1268836241-4834-3-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3628984412649720370==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatserver.c |   57 +++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 56 insertions(+), 1 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index b68894d..f3807eb 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -197,6 +197,28 @@ static gboolean is_basic_command_prefix(const char *bu=
f)
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
 static GAtServerResult at_command_notify(GAtServer *server, char *command,
 						char *prefix)
 {
@@ -205,10 +227,43 @@ static GAtServerResult at_command_notify(GAtServer *s=
erver, char *command,
 	return res;
 }
 =

+static gboolean get_extended_prefix(const char *buf, char *prefix)
+{
+	char c;
+	int i =3D 0;
+
+	/* Skip '+' */
+	prefix[0] =3D buf[0];
+
+	while ((c =3D buf[++i])) {
+		/* V.250 5.4.1 Extended command naming rules */
+		if (!is_extended_character(c))
+			break;
+
+		prefix[i] =3D g_ascii_toupper(c);
+	}
+
+	prefix[i] =3D '\0';
+
+	return TRUE;
+}
+
 static char *parse_extended_command(GAtServer *server, const char *buf,
 					char *prefix)
 {
-	return NULL;
+	char *command;
+	char t =3D server->v250.s3;
+	char c =3D *buf;
+	int i =3D 0;
+
+	while (c && c !=3D t && c !=3D ';')
+		c =3D buf[++i];
+
+	command =3D g_strndup(buf, i);
+
+	get_extended_prefix(command, prefix);
+
+	return command;
 }
 =

 static gboolean get_basic_prefix(const char *buf, char *prefix)
-- =

1.6.6.1


--===============3628984412649720370==--

