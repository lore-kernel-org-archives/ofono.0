Content-Type: multipart/mixed; boundary="===============4137078666472526897=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH] src/location-reporting: driver properties handling
Date: Sun, 23 Sep 2018 08:19:21 +0200
Message-ID: <20180923061922.23288-2-gciofono@gmail.com>
In-Reply-To: <20180923061922.23288-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4137078666472526897==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/location-reporting.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/src/location-reporting.c b/src/location-reporting.c
index 6a3e03c4..d787f0c0 100644
--- a/src/location-reporting.c
+++ b/src/location-reporting.c
@@ -64,7 +64,6 @@ static const char *location_reporting_type_to_string(
 =

 static DBusMessage *location_reporting_get_properties(DBusConnection *conn,
 						DBusMessage *msg, void *data)
-
 {
 	struct ofono_location_reporting *lr =3D data;
 	DBusMessage *reply;
@@ -74,7 +73,7 @@ static DBusMessage *location_reporting_get_properties(DBu=
sConnection *conn,
 	dbus_bool_t value;
 =

 	reply =3D dbus_message_new_method_return(msg);
-	if (reply =3D=3D NULL)
+	if (lr =3D=3D NULL || reply =3D=3D NULL)
 		return NULL;
 =

 	dbus_message_iter_init_append(reply, &iter);
@@ -88,11 +87,25 @@ static DBusMessage *location_reporting_get_properties(D=
BusConnection *conn,
 	type =3D location_reporting_type_to_string(lr->driver->type);
 	ofono_dbus_dict_append(&dict, "Type", DBUS_TYPE_STRING, &type);
 =

+	if (lr->driver && lr->driver->get_properties)
+		lr->driver->get_properties(lr, &dict);
+
 	dbus_message_iter_close_container(&iter, &dict);
 =

 	return reply;
 }
 =

+static DBusMessage *location_reporting_set_property(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct ofono_location_reporting *lr =3D data;
+
+	if (!lr || !lr->driver || !lr->driver->set_property)
+		return __ofono_error_not_available(msg);
+
+	return lr->driver->set_property(lr, msg);
+}
+
 static void client_remove(struct ofono_location_reporting *lr)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
@@ -243,6 +256,9 @@ static const GDBusMethodTable location_reporting_method=
s[] =3D {
 	{ GDBUS_METHOD("GetProperties",
 			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
 			location_reporting_get_properties) },
+	{ GDBUS_ASYNC_METHOD("SetProperty",
+			GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
+			NULL, location_reporting_set_property) },
 	{ GDBUS_ASYNC_METHOD("Request",
 			NULL, GDBUS_ARGS({ "fd", "h" }),
 			location_reporting_request) },
-- =

2.17.1


--===============4137078666472526897==--

