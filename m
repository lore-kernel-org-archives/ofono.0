Content-Type: multipart/mixed; boundary="===============7437238316094084383=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] Support -p and -P options with list of plugins
Date: Fri, 24 Sep 2010 17:22:40 +0300
Message-ID: <1285338160-18844-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7437238316094084383==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 src/main.c   |    4 ++--
 src/plugin.c |   38 +++++++++++++++++++++++++++-----------
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/src/main.c b/src/main.c
index 20bf0d7..9869ac8 100644
--- a/src/main.c
+++ b/src/main.c
@@ -114,9 +114,9 @@ static GOptionEntry options[] =3D {
 				G_OPTION_ARG_CALLBACK, parse_debug,
 				"Specify debug options to enable", "DEBUG" },
 	{ "plugin", 'p', 0, G_OPTION_ARG_STRING, &option_plugin,
-				"Specify plugins to load", "NAME" },
+				"Specify plugins to load", "NAME,..," },
 	{ "noplugin", 'P', 0, G_OPTION_ARG_STRING, &option_noplugin,
-				"Specify plugins not to load", "NAME" },
+				"Specify plugins not to load", "NAME,..." },
 	{ "nodetach", 'n', G_OPTION_FLAG_REVERSE,
 				G_OPTION_ARG_NONE, &option_detach,
 				"Don't run as daemon in background" },
diff --git a/src/plugin.c b/src/plugin.c
index 159014b..68fe318 100644
--- a/src/plugin.c
+++ b/src/plugin.c
@@ -72,18 +72,26 @@ static gboolean add_plugin(void *handle, struct ofono_p=
lugin_desc *desc)
 }
 =

 static gboolean check_plugin(struct ofono_plugin_desc *desc,
-				const char *pattern, const char *exclude)
+				char **patterns, char **excludes)
 {
-	if (exclude !=3D NULL &&
-			g_pattern_match_simple(exclude, desc->name) =3D=3D TRUE) {
-		ofono_info("Excluding %s", desc->description);
-		return FALSE;
+	if (excludes) {
+		for (; *excludes; excludes++)
+			if (g_pattern_match_simple(*excludes, desc->name))
+				break;
+		if (*excludes) {
+			ofono_info("Excluding %s", desc->description);
+			return FALSE;
+		}
 	}
 =

-	if (pattern !=3D NULL &&
-			g_pattern_match_simple(pattern, desc->name) =3D=3D FALSE) {
-		ofono_info("Ignoring %s", desc->description);
-		return FALSE;
+	if (patterns) {
+		for (; *patterns; patterns++)
+			if (g_pattern_match_simple(*patterns, desc->name))
+				break;
+		if (!*patterns) {
+			ofono_info("Ignoring %s", desc->description);
+			return FALSE;
+		}
 	}
 =

 	return TRUE;
@@ -93,6 +101,8 @@ static gboolean check_plugin(struct ofono_plugin_desc *d=
esc,
 =

 int __ofono_plugin_init(const char *pattern, const char *exclude)
 {
+	gchar **patterns =3D NULL;
+	gchar **excludes =3D NULL;
 	GSList *list;
 	GDir *dir;
 	const gchar *file;
@@ -101,9 +111,15 @@ int __ofono_plugin_init(const char *pattern, const cha=
r *exclude)
 =

 	DBG("");
 =

+	if (pattern)
+		patterns =3D g_strsplit_set(pattern, ", ", -1);
+
+	if (exclude)
+		excludes =3D g_strsplit_set(exclude, ", ", -1);
+
 	for (i =3D 0; __ofono_builtin[i]; i++) {
 		if (check_plugin(__ofono_builtin[i],
-					pattern, exclude) =3D=3D FALSE)
+					patterns, excludes) =3D=3D FALSE)
 			continue;
 =

 		add_plugin(NULL, __ofono_builtin[i]);
@@ -139,7 +155,7 @@ int __ofono_plugin_init(const char *pattern, const char=
 *exclude)
 				continue;
 			}
 =

-			if (check_plugin(desc, pattern, exclude) =3D=3D FALSE) {
+			if (check_plugin(desc, patterns, excludes) =3D=3D FALSE) {
 				dlclose(handle);
 				continue;
 			}
-- =

1.7.0.4


--===============7437238316094084383==--

