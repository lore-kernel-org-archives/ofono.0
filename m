Content-Type: multipart/mixed; boundary="===============6569333447207965520=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] Support multiple -p and -P option
Date: Wed, 22 Sep 2010 18:11:16 +0300
Message-ID: <1285168276-2809-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6569333447207965520==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 src/main.c   |   12 ++++++------
 src/ofono.h  |    2 +-
 src/plugin.c |   28 ++++++++++++++++++----------
 3 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/src/main.c b/src/main.c
index 20bf0d7..9cf32eb 100644
--- a/src/main.c
+++ b/src/main.c
@@ -93,8 +93,8 @@ static void system_bus_disconnected(DBusConnection *conn,=
 void *user_data)
 }
 =

 static gchar *option_debug =3D NULL;
-static gchar *option_plugin =3D NULL;
-static gchar *option_noplugin =3D NULL;
+static gchar **option_plugin;
+static gchar **option_noplugin;
 static gboolean option_detach =3D TRUE;
 static gboolean option_version =3D FALSE;
 =

@@ -113,9 +113,9 @@ static GOptionEntry options[] =3D {
 	{ "debug", 'd', G_OPTION_FLAG_OPTIONAL_ARG,
 				G_OPTION_ARG_CALLBACK, parse_debug,
 				"Specify debug options to enable", "DEBUG" },
-	{ "plugin", 'p', 0, G_OPTION_ARG_STRING, &option_plugin,
+	{ "plugin", 'p', 0, G_OPTION_ARG_STRING_ARRAY, &option_plugin,
 				"Specify plugins to load", "NAME" },
-	{ "noplugin", 'P', 0, G_OPTION_ARG_STRING, &option_noplugin,
+	{ "noplugin", 'P', 0, G_OPTION_ARG_STRING_ARRAY, &option_noplugin,
 				"Specify plugins not to load", "NAME" },
 	{ "nodetach", 'n', G_OPTION_FLAG_REVERSE,
 				G_OPTION_ARG_NONE, &option_detach,
@@ -230,8 +230,8 @@ int main(int argc, char **argv)
 =

 	__ofono_plugin_init(option_plugin, option_noplugin);
 =

-	g_free(option_plugin);
-	g_free(option_noplugin);
+	g_strfreev(option_plugin);
+	g_strfreev(option_noplugin);
 =

 	g_main_loop_run(event_loop);
 =

diff --git a/src/ofono.h b/src/ofono.h
index 41ce011..64a04e7 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -84,7 +84,7 @@ void __ofono_watchlist_free(struct ofono_watchlist *watch=
list);
 =

 #include <ofono/plugin.h>
 =

-int __ofono_plugin_init(const char *pattern, const char *exclude);
+int __ofono_plugin_init(char **patterns, char **excludes);
 void __ofono_plugin_cleanup(void);
 =

 #include <ofono/modem.h>
diff --git a/src/plugin.c b/src/plugin.c
index 159014b..bb5e73d 100644
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
@@ -91,7 +99,7 @@ static gboolean check_plugin(struct ofono_plugin_desc *de=
sc,
 =

 #include "builtin.h"
 =

-int __ofono_plugin_init(const char *pattern, const char *exclude)
+int __ofono_plugin_init(char **pattern, char **exclude)
 {
 	GSList *list;
 	GDir *dir;
-- =

1.7.0.4


--===============6569333447207965520==--

