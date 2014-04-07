Content-Type: multipart/mixed; boundary="===============8407953423608670801=="
MIME-Version: 1.0
From: jussi.pakkanen@canonical.com
Subject: [PATCH 2/2] Basic implementation of dbus methods.
Date: Mon, 07 Apr 2014 14:55:48 +0300
Message-ID: <1396871748-10062-2-git-send-email-jussi.pakkanen@canonical.com>
In-Reply-To: <1396871748-10062-1-git-send-email-jussi.pakkanen@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8407953423608670801==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jussi Pakkanen <jussi.pakkanen@canonical.com>

---
 plugins/phonesim.c | 89 ++++++++++++++++++++++++++++++++++++++++++--------=
----
 1 file changed, 70 insertions(+), 19 deletions(-)

diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index 12cd591..61f15c9 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -1039,6 +1039,14 @@ static void parse_config(const char *filename)
 	char **modems;
 	int i;
 =

+	if (filename =3D=3D NULL) {
+		char *conf_override =3D getenv("OFONO_PHONESIM_CONFIG");
+		if (conf_override)
+			filename =3D conf_override;
+		else
+			filename =3D CONFIGDIR "/phonesim.conf";
+	}
+
 	DBG("filename %s", filename);
 =

 	keyfile =3D g_key_file_new();
@@ -1071,33 +1079,87 @@ done:
 	g_key_file_free(keyfile);
 }
 =

+static void release_modems() {
+	GSList *list;
+
+	for (list =3D modem_list; list; list =3D list->next) {
+		struct ofono_modem *modem =3D list->data;
+
+		ofono_modem_remove(modem);
+	}
+
+	g_slist_free(modem_list);
+	modem_list =3D NULL;
+}
+
 static DBusMessage *control_add(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
-	return NULL;
+	const char *driver =3D "phonesim";
+	struct ofono_modem *modem;
+	DBusMessageIter iter;
+	char *name;
+	char *address;
+	char *port;
+
+	if (!dbus_message_iter_init(msg, &iter))
+		return __ofono_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &name);
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &address);
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &port);
+
+
+	modem =3D ofono_modem_create(name, driver);
+	if (modem =3D=3D NULL)
+		return NULL;
+
+	ofono_modem_set_string(modem, "Address", address);
+	ofono_modem_set_integer(modem, "Port", atoi(port));
+	modem_list =3D g_slist_prepend(modem_list, modem);
+
+	return dbus_message_new_method_return(msg);
 }
 =

 static DBusMessage *control_remove_all(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
-	return NULL;
+	release_modems();
+
+	return dbus_message_new_method_return(msg);
 }
 =

 static DBusMessage *control_reset(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
-	return NULL;
+	release_modems();
+	parse_config(NULL);
+
+	return dbus_message_new_method_return(msg);
 }
 =

 static const GDBusMethodTable control_methods[] =3D {
 	{ GDBUS_METHOD("Add",
-			NULL, GDBUS_ARGS({ "properties", "sss" }),
+			NULL, GDBUS_ARGS({ "name", "s" }, {"address", "s"}, {"port", "s"}),
 			control_add) },
 	{ GDBUS_METHOD("RemoveAll",
-			NULL, GDBUS_ARGS({ "properties", "" }),
+			NULL, GDBUS_ARGS({ }),
 			control_remove_all) },
 	{ GDBUS_METHOD("Reset",
-			NULL, GDBUS_ARGS({ "properties", "" }),
+			NULL, GDBUS_ARGS({ }),
 			control_reset) },
 	{}
 };
@@ -1123,7 +1185,6 @@ static void shutdown_control_channel() {
 static int phonesim_init(void)
 {
 	int err;
-	char *conf_override =3D getenv("OFONO_PHONESIM_CONFIG");
 =

 	err =3D ofono_modem_driver_register(&phonesim_driver);
 	if (err < 0)
@@ -1134,10 +1195,7 @@ static int phonesim_init(void)
 	ofono_gprs_context_driver_register(&context_driver);
 	ofono_ctm_driver_register(&ctm_driver);
 =

-	if (conf_override)
-		parse_config(conf_override);
-	else
-		parse_config(CONFIGDIR "/phonesim.conf");
+	parse_config(NULL);
 =

 	err =3D setup_control_channel();
 	if (err < 0)
@@ -1148,17 +1206,10 @@ static int phonesim_init(void)
 =

 static void phonesim_exit(void)
 {
-	GSList *list;
-
 	shutdown_control_channel();
 =

-	for (list =3D modem_list; list; list =3D list->next) {
-		struct ofono_modem *modem =3D list->data;
-
-		ofono_modem_remove(modem);
-	}
+	release_modems();
 =

-	g_slist_free(modem_list);
 	modem_list =3D NULL;
 =

 	ofono_ctm_driver_unregister(&ctm_driver);
-- =

1.9.1


--===============8407953423608670801==--

