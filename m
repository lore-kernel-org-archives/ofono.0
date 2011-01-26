Content-Type: multipart/mixed; boundary="===============1138322707021092104=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [RFC 1/6] main: Add basic support for main.conf
Date: Wed, 26 Jan 2011 10:56:21 +0200
Message-ID: <1296032186-21497-2-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1296032186-21497-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1138322707021092104==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/main.c  |   62 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 src/ofono.h |   11 ++++++++++
 2 files changed, 72 insertions(+), 1 deletions(-)

diff --git a/src/main.c b/src/main.c
index 3db8819..129d36c 100644
--- a/src/main.c
+++ b/src/main.c
@@ -41,6 +41,7 @@
 #define SHUTDOWN_GRACE_SECONDS 10
 =

 static GMainLoop *event_loop;
+struct main_opts main_opts;
 =

 void __ofono_exit(void)
 {
@@ -92,6 +93,51 @@ static void system_bus_disconnected(DBusConnection *conn=
, void *user_data)
 	g_main_loop_quit(event_loop);
 }
 =

+static GKeyFile *load_config(const char *file)
+{
+	GError *err =3D NULL;
+	GKeyFile *keyfile;
+
+	keyfile =3D g_key_file_new();
+
+	g_key_file_set_list_separator(keyfile, ',');
+
+	if (!g_key_file_load_from_file(keyfile, file, 0, &err)) {
+		ofono_error("Parsing %s failed: %s", file, err->message);
+		g_error_free(err);
+		g_key_file_free(keyfile);
+		return NULL;
+	}
+
+	return keyfile;
+}
+
+static void parse_config(GKeyFile *config)
+{
+	GError *err =3D NULL;
+	char *str;
+
+	if (!config)
+		return;
+
+	str =3D g_key_file_get_string(config, "General", "DisablePlugins", &err);
+	if (err) {
+		DBG("%s", err->message);
+		g_clear_error(&err);
+	} else {
+		DBG("DisablePlugins=3D%s", str);
+		main_opts.noplugin =3D g_strdup(str);
+		main_opts.flags |=3D OFONO_SET_NOPLUGIN;
+		g_free(str);
+	}
+}
+
+static void init_defaults(void)
+{
+	/* Default oFono daemon settings */
+	memset(&main_opts, 0, sizeof(main_opts));
+}
+
 static gchar *option_debug =3D NULL;
 static gchar *option_plugin =3D NULL;
 static gchar *option_noplugin =3D NULL;
@@ -135,6 +181,9 @@ int main(int argc, char **argv)
 	int signal_fd;
 	GIOChannel *signal_io;
 	int signal_source;
+	GKeyFile *config =3D NULL;
+
+	init_defaults();
 =

 #ifdef HAVE_CAPNG
 	/* Drop capabilities */
@@ -235,10 +284,18 @@ int main(int argc, char **argv)
 =

 	__ofono_manager_init();
 =

-	__ofono_plugin_init(option_plugin, option_noplugin);
+	config =3D load_config(CONFIGDIR "/main.conf");
+
+	parse_config(config);
+
+	if (main_opts.flags & OFONO_SET_NOPLUGIN)
+		__ofono_plugin_init(option_plugin, main_opts.noplugin);
+	else
+		__ofono_plugin_init(option_plugin, option_noplugin);
 =

 	g_free(option_plugin);
 	g_free(option_noplugin);
+	g_free(main_opts.noplugin);
 =

 	g_main_loop_run(event_loop);
 =

@@ -255,6 +312,9 @@ cleanup:
 	g_source_remove(signal_source);
 	g_main_loop_unref(event_loop);
 =

+	if (config)
+		g_key_file_free(config);
+
 	__ofono_log_cleanup();
 =

 	return 0;
diff --git a/src/ofono.h b/src/ofono.h
index e48dbf6..54de5a6 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -25,6 +25,17 @@
 =

 #include <ofono/types.h>
 =

+struct main_opts {
+	char *noplugin;
+	unsigned long flags;
+};
+
+enum {
+	OFONO_SET_NOPLUGIN =3D	1,
+};
+
+extern struct main_opts main_opts;
+
 void __ofono_exit(void);
 =

 int __ofono_manager_init(void);
-- =

1.7.1


--===============1138322707021092104==--

