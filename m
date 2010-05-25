Content-Type: multipart/mixed; boundary="===============4029353831603203622=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: [PATCH 3/9] Bring back -d option without need for argument
Date: Tue, 25 May 2010 04:18:02 -0300
Message-ID: <1274771888-2565-4-git-send-email-gustavo@padovan.org>
In-Reply-To: <1274771888-2565-3-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4029353831603203622==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/main.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/src/main.c b/src/main.c
index 8e686ac..8f4092c 100644
--- a/src/main.c
+++ b/src/main.c
@@ -96,8 +96,19 @@ static gchar *option_debug =3D NULL;
 static gboolean option_detach =3D TRUE;
 static gboolean option_version =3D FALSE;
 =

+static gboolean parse_debug(const char *key, const char *value, gpointer u=
ser_data, GError **error)
+{
+	if (value)
+		option_debug =3D g_strdup(value);
+	else
+		option_debug =3D g_strdup("*");
+
+	return TRUE;
+}
+
 static GOptionEntry options[] =3D {
-	{ "debug", 'd', 0, G_OPTION_ARG_STRING, &option_debug,
+	{ "debug", 'd', G_OPTION_FLAG_OPTIONAL_ARG,
+				G_OPTION_ARG_CALLBACK, parse_debug,
 				"Specify debug options to enable", "DEBUG" },
 	{ "nodetach", 'n', G_OPTION_FLAG_REVERSE,
 				G_OPTION_ARG_NONE, &option_detach,
-- =

1.7.1


--===============4029353831603203622==--

