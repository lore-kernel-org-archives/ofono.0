Content-Type: multipart/mixed; boundary="===============0684135999944240725=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 02/11] ofono: Add option for experimental interfaces
Date: Tue, 19 Feb 2013 17:44:43 -0300
Message-ID: <1361306692-959-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361306692-959-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0684135999944240725==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds a command line option for enabling experimental D-Bus
interfaces. --experimental/-E enables experimental interfaces.
---
 src/main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/main.c b/src/main.c
index 46bb90b..1e99b13 100644
--- a/src/main.c
+++ b/src/main.c
@@ -133,6 +133,7 @@ static gchar *option_plugin =3D NULL;
 static gchar *option_noplugin =3D NULL;
 static gboolean option_detach =3D TRUE;
 static gboolean option_version =3D FALSE;
+static gboolean option_experimental =3D FALSE;
 =

 static gboolean parse_debug(const char *key, const char *value,
 					gpointer user_data, GError **error)
@@ -153,6 +154,8 @@ static GOptionEntry options[] =3D {
 				"Specify plugins to load", "NAME,..," },
 	{ "noplugin", 'P', 0, G_OPTION_ARG_STRING, &option_noplugin,
 				"Specify plugins not to load", "NAME,..." },
+	{ "experimental", 'E', 0, G_OPTION_ARG_NONE, &option_experimental,
+				"Enable experimental interfaces" },
 	{ "nodetach", 'n', G_OPTION_FLAG_REVERSE,
 				G_OPTION_ARG_NONE, &option_detach,
 				"Don't run as daemon in background" },
@@ -168,6 +171,7 @@ int main(int argc, char **argv)
 	DBusConnection *conn;
 	DBusError error;
 	guint signal;
+	int gdbus_flags =3D 0;
 =

 #ifdef NEED_THREADS
 	if (g_thread_supported() =3D=3D FALSE)
@@ -233,6 +237,11 @@ int main(int argc, char **argv)
 	g_dbus_set_disconnect_function(conn, system_bus_disconnected,
 					NULL, NULL);
 =

+	if (option_experimental)
+		gdbus_flags =3D G_DBUS_FLAG_ENABLE_EXPERIMENTAL;
+
+	g_dbus_set_flags(gdbus_flags);
+
 	__ofono_dbus_init(conn);
 =

 	__ofono_modemwatch_init();
-- =

1.7.11.7


--===============0684135999944240725==--

