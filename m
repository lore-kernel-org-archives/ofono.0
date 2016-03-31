Content-Type: multipart/mixed; boundary="===============7960019527952627786=="
MIME-Version: 1.0
From: Samrat Guha Niyogi <samrat.guha.niyogi@intel.com>
Subject: [PATCH] devinfo: Add support of IMEISV
Date: Thu, 31 Mar 2016 13:06:22 +0530
Message-ID: <1459409782-1895-1-git-send-email-samrat.guha.niyogi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7960019527952627786==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/modem.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/src/modem.c b/src/modem.c
index 2de8d98..a4d4490 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -94,6 +94,7 @@ struct ofono_devinfo {
 	char *model;
 	char *revision;
 	char *serial;
+	char *svn;
 	unsigned int dun_watch;
 	const struct ofono_devinfo_driver *driver;
 	void *driver_data;
@@ -815,6 +816,11 @@ void __ofono_modem_append_properties(struct ofono_mode=
m *modem,
 			ofono_dbus_dict_append(dict, "Serial",
 						DBUS_TYPE_STRING,
 						&info->serial);
+
+		if (info->svn)
+			ofono_dbus_dict_append(dict, "SoftwareVersionNumber",
+						DBUS_TYPE_STRING,
+						&info->svn);
 	}
 =

 	interfaces =3D g_new0(char *, g_slist_length(modem->interface_list) + 1);
@@ -1343,6 +1349,32 @@ void ofono_modem_remove_interface(struct ofono_modem=
 *modem,
 	modem->interface_update =3D g_idle_add(trigger_interface_update, modem);
 }
 =

+static void query_svn_cb(const struct ofono_error *error,
+				const char *svn, void *user)
+{
+	struct ofono_devinfo *info =3D user;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(info->atom);
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
+		return;
+
+	info->svn =3D g_strdup(svn);
+
+	ofono_dbus_signal_property_changed(conn, path,
+						OFONO_MODEM_INTERFACE,
+						"SoftwareVersionNumber", DBUS_TYPE_STRING,
+						&info->svn);
+}
+
+static void query_svn(struct ofono_devinfo *info)
+{
+	if (info->driver->query_svn =3D=3D NULL)
+		return;
+
+	info->driver->query_svn(info, query_svn_cb, info);
+}
+
 static void query_serial_cb(const struct ofono_error *error,
 				const char *serial, void *user)
 {
@@ -1351,7 +1383,7 @@ static void query_serial_cb(const struct ofono_error =
*error,
 	const char *path =3D __ofono_atom_get_path(info->atom);
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
-		return;
+		goto out;
 =

 	info->serial =3D g_strdup(serial);
 =

@@ -1359,6 +1391,8 @@ static void query_serial_cb(const struct ofono_error =
*error,
 						OFONO_MODEM_INTERFACE,
 						"Serial", DBUS_TYPE_STRING,
 						&info->serial);
+out:
+	query_svn(info);
 }
 =

 static void query_serial(struct ofono_devinfo *info)
@@ -1619,6 +1653,9 @@ static void devinfo_unregister(struct ofono_atom *ato=
m)
 =

 	g_free(info->serial);
 	info->serial =3D NULL;
+
+	g_free(info->svn);
+	info->svn =3D NULL;
 }
 =

 void ofono_devinfo_register(struct ofono_devinfo *info)
-- =

1.9.1


--===============7960019527952627786==--

