Content-Type: multipart/mixed; boundary="===============7013072939191194099=="
MIME-Version: 1.0
From: jussi.pakkanen@canonical.com
Subject: [PATCH 1/2] Basic blocks for control channel.
Date: Mon, 07 Apr 2014 14:55:47 +0300
Message-ID: <1396871748-10062-1-git-send-email-jussi.pakkanen@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7013072939191194099==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello

Here's a revised way of changing phonesim modem configurations at
runtime. It works by adding a dbus interface via which you can add new
modems, delete all existing modems or reset modem status to what it
was at startup. This first patch adds the dbus bits and the second one
calls the corresponding ofono functions.

This patch set is not fully polished yet but should give an idea what
we are aiming for. I'm not fully versed in phonesim's internals so I'm
not sure if I'm poking all the right bits in the dbus functions, so
please verify that with extra care.

Thanks,

---
 plugins/phonesim.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 58 insertions(+)

diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index 5561a05..12cd591 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -35,6 +35,7 @@
 #include <glib.h>
 #include <gatmux.h>
 #include <gatchat.h>
+#include <gdbus.h>
 =

 #define OFONO_API_SUBJECT_TO_CHANGE
 #include <ofono/plugin.h>
@@ -73,6 +74,8 @@ static const char *none_prefix[] =3D { NULL };
 static const char *ptty_prefix[] =3D { "+PTTY:", NULL };
 static const char *simstate_prefix[] =3D { "+SIMSTATE:", NULL };
 static int next_iface =3D 0;
+static const char CONTROL_PATH[] =3D "/phonesim";
+static const char CONTROL_INTERFACE[] =3D "org.ofono.phonesim.Control";
 =

 struct phonesim_data {
 	GAtMux *mux;
@@ -1068,6 +1071,55 @@ done:
 	g_key_file_free(keyfile);
 }
 =

+static DBusMessage *control_add(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	return NULL;
+}
+
+static DBusMessage *control_remove_all(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	return NULL;
+}
+
+static DBusMessage *control_reset(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	return NULL;
+}
+
+static const GDBusMethodTable control_methods[] =3D {
+	{ GDBUS_METHOD("Add",
+			NULL, GDBUS_ARGS({ "properties", "sss" }),
+			control_add) },
+	{ GDBUS_METHOD("RemoveAll",
+			NULL, GDBUS_ARGS({ "properties", "" }),
+			control_remove_all) },
+	{ GDBUS_METHOD("Reset",
+			NULL, GDBUS_ARGS({ "properties", "" }),
+			control_reset) },
+	{}
+};
+
+static int setup_control_channel() {
+	int err =3D 0;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	void *user_data =3D NULL;
+	g_dbus_register_interface(conn,
+			CONTROL_PATH, CONTROL_INTERFACE,
+			control_methods,
+			NULL,
+			NULL,
+			user_data,
+			NULL);
+	return err;
+}
+
+static void shutdown_control_channel() {
+	g_dbus_unregister_interface(ofono_dbus_get_connection(), CONTROL_PATH, CO=
NTROL_INTERFACE);
+}
+
 static int phonesim_init(void)
 {
 	int err;
@@ -1087,6 +1139,10 @@ static int phonesim_init(void)
 	else
 		parse_config(CONFIGDIR "/phonesim.conf");
 =

+	err =3D setup_control_channel();
+	if (err < 0)
+		return err;
+
 	return 0;
 }
 =

@@ -1094,6 +1150,8 @@ static void phonesim_exit(void)
 {
 	GSList *list;
 =

+	shutdown_control_channel();
+
 	for (list =3D modem_list; list; list =3D list->next) {
 		struct ofono_modem *modem =3D list->data;
 =

-- =

1.9.1


--===============7013072939191194099==--

