Content-Type: multipart/mixed; boundary="===============0053979174228615488=="
MIME-Version: 1.0
From: jussi.pakkanen@canonical.com
Subject: [PATCH 2/2] Can set name replacement with command line arguments.
Date: Wed, 02 Apr 2014 16:56:21 +0300
Message-ID: <1396446981-19749-2-git-send-email-jussi.pakkanen@canonical.com>
In-Reply-To: <1396446981-19749-1-git-send-email-jussi.pakkanen@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0053979174228615488==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jussi Pakkanen <jussi.pakkanen@canonical.com>

---
 src/main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/src/main.c b/src/main.c
index d2042c5..489a9d8 100644
--- a/src/main.c
+++ b/src/main.c
@@ -133,6 +133,8 @@ static gchar *option_plugin =3D NULL;
 static gchar *option_noplugin =3D NULL;
 static gboolean option_detach =3D TRUE;
 static gboolean option_version =3D FALSE;
+static gboolean option_try_replace =3D FALSE;
+static gboolean option_allow_replace =3D FALSE;
 =

 static gboolean parse_debug(const char *key, const char *value,
 					gpointer user_data, GError **error)
@@ -156,6 +158,10 @@ static GOptionEntry options[] =3D {
 	{ "nodetach", 'n', G_OPTION_FLAG_REVERSE,
 				G_OPTION_ARG_NONE, &option_detach,
 				"Don't run as daemon in background" },
+	{ "replace", 0, 0, G_OPTION_ARG_NONE, &option_try_replace,
+				"Try to replace existing service", NULL },
+	{ "allow-replace", 0, 0, G_OPTION_ARG_NONE, &option_allow_replace,
+				"Allow dbus service name to be replaced", NULL },
 	{ "version", 'v', 0, G_OPTION_ARG_NONE, &option_version,
 				"Show version information and exit" },
 	{ NULL },
@@ -203,6 +209,12 @@ int main(int argc, char **argv)
 		}
 	}
 =

+	if (option_try_replace =3D=3D TRUE)
+		name_flags |=3D G_DBUS_NAME_TRY_REPLACEMENT;
+
+	if (option_allow_replace =3D=3D TRUE)
+		name_flags |=3D G_DBUS_NAME_ALLOW_REPLACEMENT;
+
 	event_loop =3D g_main_loop_new(NULL, FALSE);
 =

 #ifdef NEED_THREADS
-- =

1.9.1


--===============0053979174228615488==--

