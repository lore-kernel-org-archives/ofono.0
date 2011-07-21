Content-Type: multipart/mixed; boundary="===============6432305033667645974=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v2 2/4] cdma-connman: add username and password,
 pass them to drivers
Date: Thu, 21 Jul 2011 06:40:42 +0200
Message-ID: <1311223244-26904-3-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1311223244-26904-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6432305033667645974==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/cdma-connman.c |   48 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 47 insertions(+), 1 deletions(-)

diff --git a/src/cdma-connman.c b/src/cdma-connman.c
index 3321b87..4466dee 100644
--- a/src/cdma-connman.c
+++ b/src/cdma-connman.c
@@ -57,6 +57,8 @@ struct ofono_cdma_connman {
 	const struct ofono_cdma_connman_driver *driver;
 	void *driver_data;
 	struct ofono_atom *atom;
+	char username[OFONO_CDMA_CONNMAN_MAX_USERNAME_LENGTH + 1];
+	char password[OFONO_CDMA_CONNMAN_MAX_PASSWORD_LENGTH + 1];
 };
 =

 static void cdma_connman_settings_free(struct cdma_connman_settings *setti=
ngs)
@@ -371,6 +373,36 @@ static DBusMessage *cdma_connman_get_properties(DBusCo=
nnection *conn,
 	return reply;
 }
 =

+static DBusMessage *cdma_connman_set_username(struct ofono_cdma_connman *c=
m,
+					DBusConnection *conn, DBusMessage *msg,
+					const char *username)
+{
+	if (strlen(username) > OFONO_CDMA_CONNMAN_MAX_USERNAME_LENGTH)
+		return __ofono_error_invalid_format(msg);
+
+	if (g_str_equal(username, cm->username))
+		return dbus_message_new_method_return(msg);
+
+	strcpy(cm->username, username);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *cdma_connman_set_password(struct ofono_cdma_connman *c=
m,
+					DBusConnection *conn, DBusMessage *msg,
+					const char *password)
+{
+	if (strlen(password) > OFONO_CDMA_CONNMAN_MAX_PASSWORD_LENGTH)
+		return __ofono_error_invalid_format(msg);
+
+	if (g_str_equal(password, cm->password))
+		return dbus_message_new_method_return(msg);
+
+	strcpy(cm->password, password);
+
+	return dbus_message_new_method_return(msg);
+}
+
 static DBusMessage *cdma_connman_set_property(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -379,6 +411,7 @@ static DBusMessage *cdma_connman_set_property(DBusConne=
ction *conn,
 	DBusMessageIter var;
 	const char *property;
 	dbus_bool_t value;
+	const char *str;
 =

 	DBG("");
 =

@@ -416,11 +449,24 @@ static DBusMessage *cdma_connman_set_property(DBusCon=
nection *conn,
 =

 		/* TODO: add logic to support CDMA Network Registration */
 		if (value)
-			cm->driver->activate(cm, activate_callback, cm);
+			cm->driver->activate(cm, cm->username, cm->password,
+						activate_callback, cm);
 		else
 			cm->driver->deactivate(cm, deactivate_callback, cm);
 =

 		return dbus_message_new_method_return(msg);
+	} else if (!strcmp(property, "Username")) {
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_STRING)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &str);
+		return cdma_connman_set_username(cm, conn, msg, str);
+	} else if (!strcmp(property, "Password")) {
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_STRING)
+			return __ofono_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&var, &str);
+		return cdma_connman_set_password(cm, conn, msg, str);
 	}
 =

 	/* TODO: Dormant property. Not yet supported. */
-- =

1.7.1


--===============6432305033667645974==--

