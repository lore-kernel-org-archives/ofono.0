Content-Type: multipart/mixed; boundary="===============9171012370849281504=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 1/1] Add support to enable/disable specific plugin
Date: Sat, 11 Sep 2010 16:58:12 +0800
Message-ID: <1284195492-5424-2-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1284195492-5424-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9171012370849281504==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Support to load or not load specific plugin when ofono is started.
E.g., use 'ofonod -P hfp' to disable hfp plugin.
---
 src/main.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/src/main.c b/src/main.c
index d8df2f2..20bf0d7 100644
--- a/src/main.c
+++ b/src/main.c
@@ -93,6 +93,8 @@ static void system_bus_disconnected(DBusConnection *conn,=
 void *user_data)
 }
 =

 static gchar *option_debug =3D NULL;
+static gchar *option_plugin =3D NULL;
+static gchar *option_noplugin =3D NULL;
 static gboolean option_detach =3D TRUE;
 static gboolean option_version =3D FALSE;
 =

@@ -111,6 +113,10 @@ static GOptionEntry options[] =3D {
 	{ "debug", 'd', G_OPTION_FLAG_OPTIONAL_ARG,
 				G_OPTION_ARG_CALLBACK, parse_debug,
 				"Specify debug options to enable", "DEBUG" },
+	{ "plugin", 'p', 0, G_OPTION_ARG_STRING, &option_plugin,
+				"Specify plugins to load", "NAME" },
+	{ "noplugin", 'P', 0, G_OPTION_ARG_STRING, &option_noplugin,
+				"Specify plugins not to load", "NAME" },
 	{ "nodetach", 'n', G_OPTION_FLAG_REVERSE,
 				G_OPTION_ARG_NONE, &option_detach,
 				"Don't run as daemon in background" },
@@ -222,7 +228,10 @@ int main(int argc, char **argv)
 =

 	__ofono_manager_init();
 =

-	__ofono_plugin_init(NULL, NULL);
+	__ofono_plugin_init(option_plugin, option_noplugin);
+
+	g_free(option_plugin);
+	g_free(option_noplugin);
 =

 	g_main_loop_run(event_loop);
 =

-- =

1.7.0.4


--===============9171012370849281504==--

