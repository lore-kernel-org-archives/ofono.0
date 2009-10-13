Content-Type: multipart/mixed; boundary="===============8741693774255851916=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re-add Manager.Create / Remove
Date: Wed, 14 Oct 2009 01:34:21 +0200
Message-ID: <1255476861-1027-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8741693774255851916==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a small patch to revive Manager.Create and Manager.Remove that lets
you create a modem over D-Bus dynamically, for example in python that could
be:
modem_path =3D manager.Create('phonesim', { 'Port': 12345, 'Address':
'127.0.0.1' })

This is only posted for those who want to use the patch rather than for
merging.
---
 src/manager.c |  134 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 134 insertions(+), 0 deletions(-)

diff --git a/src/manager.c b/src/manager.c
index e35728a..9bf61ae 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -29,6 +29,8 @@
 =

 #include "ofono.h"
 =

+static GSList *modems;
+
 static DBusMessage *manager_get_properties(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
@@ -62,8 +64,140 @@ static DBusMessage *manager_get_properties(DBusConnecti=
on *conn,
 	return reply;
 }
 =

+static DBusMessage *manager_modem_create(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	DBusMessageIter iter;
+	DBusMessageIter var;
+	DBusMessageIter var_iter;
+	DBusMessageIter var_value;
+	DBusMessage *reply;
+	char *type;
+	char *property;
+	dbus_bool_t bool_value;
+	dbus_int32_t int_value;
+	char *str_value;
+	const char *path;
+	struct ofono_modem *modem;
+
+	if (!dbus_message_iter_init(msg, &iter))
+		return __ofono_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
+		return __ofono_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &type);
+
+	modem =3D ofono_modem_create(type);
+	if (!modem)
+		return __ofono_error_failed(msg);
+
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_ARRAY ||
+			dbus_message_iter_get_element_type(&iter) !=3D
+			DBUS_TYPE_DICT_ENTRY)
+		goto error;
+
+	dbus_message_iter_recurse(&iter, &var);
+
+	while (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_INVALID) {
+		if (dbus_message_iter_get_arg_type(&var) !=3D
+				DBUS_TYPE_DICT_ENTRY)
+			goto error;
+
+		dbus_message_iter_recurse(&var, &var_iter);
+
+		if (dbus_message_iter_get_arg_type(&var_iter) !=3D
+				DBUS_TYPE_STRING)
+			goto error;
+
+		dbus_message_iter_get_basic(&var_iter, &property);
+
+		dbus_message_iter_next(&var_iter);
+
+		if (dbus_message_iter_get_arg_type(&var_iter) !=3D
+				DBUS_TYPE_VARIANT)
+			goto error;
+
+		dbus_message_iter_recurse(&var_iter, &var_value);
+
+		switch (dbus_message_iter_get_arg_type(&var_value)) {
+		case DBUS_TYPE_STRING:
+			dbus_message_iter_get_basic(&var_value, &str_value);
+
+			ofono_modem_set_string(modem, property, str_value);
+			break;
+
+		case DBUS_TYPE_INT32:
+			dbus_message_iter_get_basic(&var_value, &int_value);
+
+			ofono_modem_set_integer(modem, property, int_value);
+			break;
+
+		case DBUS_TYPE_BOOLEAN:
+			dbus_message_iter_get_basic(&var_value, &bool_value);
+
+			ofono_modem_set_boolean(modem, property, bool_value);
+			break;
+
+		default:
+			goto error;
+		}
+
+		dbus_message_iter_next(&var);
+	}
+
+	if (ofono_modem_register(modem) < 0) {
+		ofono_modem_remove(modem);
+
+		return __ofono_error_failed(msg);
+	}
+
+	modems =3D g_slist_prepend(modems, modem);
+
+	reply =3D dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	path =3D ofono_modem_get_path(modem);
+	dbus_message_append_args(reply, DBUS_TYPE_OBJECT_PATH, &path,
+					DBUS_TYPE_INVALID);
+
+	return reply;
+error:
+	ofono_modem_remove(modem);
+
+	return __ofono_error_invalid_args(msg);
+}
+
+static DBusMessage *manager_modem_remove(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	char *path;
+	struct ofono_modem *modem;
+	GSList *l;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+					DBUS_TYPE_INVALID))
+		return __ofono_error_invalid_args(msg);
+
+	for (l =3D modems; l; l =3D l->next) {
+		modem =3D l->data;
+
+		if (!strcmp(path, ofono_modem_get_path(modem))) {
+			ofono_modem_remove(modem);
+			return dbus_message_new_method_return(msg);
+		}
+	}
+
+	return __ofono_error_not_found(msg);
+}
+
 static GDBusMethodTable manager_methods[] =3D {
 	{ "GetProperties",	"",	"a{sv}",	manager_get_properties },
+	{ "Create",		"sa{sv}",	"o",	manager_modem_create },
+	{ "Remove",		"o",	"",		manager_modem_remove },
 	{ }
 };
 =

-- =

1.6.1


--===============8741693774255851916==--

