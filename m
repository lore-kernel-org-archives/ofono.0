Content-Type: multipart/mixed; boundary="===============6350047104237020252=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 2/4] cdma-connman: add possibility to set a username and a
 password
Date: Wed, 20 Jul 2011 11:26:38 +0200
Message-ID: <1311154000-32353-3-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1311154000-32353-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6350047104237020252==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/cdma-connman.c |   44 +++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 43 insertions(+), 1 deletions(-)

diff --git a/src/cdma-connman.c b/src/cdma-connman.c
index 3321b87..7ca5a0a 100644
--- a/src/cdma-connman.c
+++ b/src/cdma-connman.c
@@ -57,6 +57,8 @@ struct ofono_cdma_connman {
 	const struct ofono_cdma_connman_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
+	char *username;
+	char *password;
 };
 =

 static void cdma_connman_settings_free(struct cdma_connman_settings *setti=
ngs)
@@ -379,6 +381,8 @@ static DBusMessage *cdma_connman_set_property(DBusConne=
ction *conn,
 	DBusMessageIter var;
 	const char *property;
 	dbus_bool_t value;
+	const char *username;
+	const char *password;
 =

 	DBG("");
 =

@@ -399,7 +403,7 @@ static DBusMessage *cdma_connman_set_property(DBusConne=
ction *conn,
 =

 	dbus_message_iter_recurse(&iter, &var);
 =

-	if (!strcmp(property, "Powered")) {
+	if (!g_strcmp0(property, "Powered")) {
 		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_BOOLEAN)
 			return __ofono_error_invalid_args(msg);
 =

@@ -421,6 +425,22 @@ static DBusMessage *cdma_connman_set_property(DBusConn=
ection *conn,
 			cm->driver->deactivate(cm, deactivate_callback, cm);
 =

 		return dbus_message_new_method_return(msg);
+	} else if (!g_strcmp0(property, "Username")) {
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_STRING)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &username);
+		cm->username =3D g_strdup(username);
+		DBG("username: %s", username);
+		return dbus_message_new_method_return(msg);
+	} else if (!g_strcmp0(property, "Password")) {
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_STRING)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &password);
+		cm->password =3D g_strdup(password);
+		DBG("password: %s", password);
+		return dbus_message_new_method_return(msg);
 	}
 =

 	/* TODO: Dormant property. Not yet supported. */
@@ -488,6 +508,12 @@ static void cdma_connman_remove(struct ofono_atom *ato=
m)
 	if (cm->driver && cm->driver->remove)
 		cm->driver->remove(cm);
 =

+	if (cm->username)
+		g_free(cm->username);
+
+	if (cm->password)
+		g_free(cm->password);
+
 	g_free(cm);
 }
 =

@@ -568,3 +594,19 @@ void *ofono_cdma_connman_get_data(struct ofono_cdma_co=
nnman *cm)
 {
 	return cm->driver_data;
 }
+
+const char *ofono_cdma_connman_get_username(struct ofono_cdma_connman *cm)
+{
+	if (cm->username)
+		return cm->username;
+
+	return NULL;
+}
+
+const char *ofono_cdma_connman_get_password(struct ofono_cdma_connman *cm)
+{
+	if (cm->password)
+		return cm->password;
+
+	return NULL;
+}
-- =

1.7.1


--===============6350047104237020252==--

