Content-Type: multipart/mixed; boundary="===============0359441886342831476=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 03/10] Add extended command parsing
Date: Fri, 19 Mar 2010 17:44:41 +0800
Message-ID: <1268991888-17279-4-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1268991888-17279-3-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0359441886342831476==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatserver.c |   65 +++++++++++++++++++++++++++++++++++++++++++++++=
++-
 1 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index 2c53d84..0658553 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -197,16 +197,77 @@ static gboolean is_basic_command_prefix(const char *b=
uf)
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
 static gboolean at_command_notify(GAtServer *server, char *command,
 						char *prefix)
 {
 	return FALSE;
 }
 =

-static void parse_extended_command(GAtServer *server, char *buf,
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
+static void parse_extended_command(GAtServer *server, const char *buf,
 					unsigned int *len)
 {
-	g_at_server_send_final(server, G_AT_SERVER_RESULT_ERROR);
+	char *command =3D NULL;
+	char prefix[20];
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
+	if (at_command_notify(server, command, prefix))
+		*len =3D i;
+	else
+		*len =3D 0;
+
+	g_free(command);
 }
 =

 static gboolean get_basic_prefix(const char *buf, char *prefix)
-- =

1.6.6.1


--===============0359441886342831476==--

