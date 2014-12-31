Content-Type: multipart/mixed; boundary="===============1838208309757374038=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH] network: Add NetworkRegistration.OperatorsChanged signal
Date: Wed, 31 Dec 2014 16:24:16 +0300
Message-ID: <1420032256-2616-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1838208309757374038==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This signal gets emitted when operator list has changed.
It contains the current list of operators.
---
 doc/network-api.txt |  5 +++++
 src/network.c       | 44 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/doc/network-api.txt b/doc/network-api.txt
index 83a2bc0..d635ba7 100644
--- a/doc/network-api.txt
+++ b/doc/network-api.txt
@@ -57,6 +57,11 @@ Signals		PropertyChanged(string property, variant value)
 			This signal indicates a changed value of the given
 			property.
 =

+		OperatorsChanged(array{object,dict})
+
+			Signal that gets emitted when operator list has
+			changed. It contains the current list of operators.
+
 Properties	string Mode [readonly]
 =

 			The current registration mode. The default of this
diff --git a/src/network.c b/src/network.c
index d1bfca6..1b8b759 100644
--- a/src/network.c
+++ b/src/network.c
@@ -934,6 +934,40 @@ static void append_operator_struct_list(struct ofono_n=
etreg *netreg,
 	dbus_free_string_array(children);
 }
 =

+static void network_signal_operators_changed(struct ofono_netreg *netreg)
+{
+	const char *path =3D __ofono_atom_get_path(netreg->atom);
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	DBusMessage *signal;
+	DBusMessageIter iter;
+	DBusMessageIter array;
+
+	signal =3D dbus_message_new_signal(path,
+		OFONO_NETWORK_REGISTRATION_INTERFACE, "OperatorsChanged");
+	if (signal =3D=3D NULL) {
+		ofono_error("Unable to allocate new "
+					OFONO_NETWORK_REGISTRATION_INTERFACE
+					".OperatorsChanged signal");
+		return;
+	}
+
+	dbus_message_iter_init_append(signal, &iter);
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					DBUS_STRUCT_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_OBJECT_PATH_AS_STRING
+					DBUS_TYPE_ARRAY_AS_STRING
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING
+					DBUS_STRUCT_END_CHAR_AS_STRING,
+					&array);
+	append_operator_struct_list(netreg, &array);
+	dbus_message_iter_close_container(&iter, &array);
+
+	g_dbus_send_message(conn, signal);
+}
+
 static void operator_list_callback(const struct ofono_error *error, int to=
tal,
 				const struct ofono_network_operator *list,
 				void *data)
@@ -942,6 +976,7 @@ static void operator_list_callback(const struct ofono_e=
rror *error, int total,
 	DBusMessage *reply;
 	DBusMessageIter iter;
 	DBusMessageIter array;
+	gboolean changed;
 =

 	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
 		DBG("Error occurred during operator list");
@@ -950,7 +985,7 @@ static void operator_list_callback(const struct ofono_e=
rror *error, int total,
 		return;
 	}
 =

-	update_operator_list(netreg, total, list);
+	changed =3D update_operator_list(netreg, total, list);
 =

 	reply =3D dbus_message_new_method_return(netreg->pending);
 =

@@ -970,6 +1005,11 @@ static void operator_list_callback(const struct ofono=
_error *error, int total,
 	dbus_message_iter_close_container(&iter, &array);
 =

 	__ofono_dbus_pending_reply(&netreg->pending, reply);
+
+	DBG("operator list %schanged", changed ? "" : "not ");
+
+	if (changed)
+		network_signal_operators_changed(netreg);
 }
 =

 static DBusMessage *network_scan(DBusConnection *conn,
@@ -1041,6 +1081,8 @@ static const GDBusMethodTable network_registration_me=
thods[] =3D {
 static const GDBusSignalTable network_registration_signals[] =3D {
 	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
+	{ GDBUS_SIGNAL("OperatorsChanged",
+			GDBUS_ARGS({ "operators", "a(oa{sv})"})) },
 	{ }
 };
 =

-- =

1.8.3.2


--===============1838208309757374038==--

