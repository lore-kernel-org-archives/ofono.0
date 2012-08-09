Content-Type: multipart/mixed; boundary="===============6792639527529681749=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH 1/3] service: Add DBus method to get service properties
Date: Thu, 09 Aug 2012 17:51:41 +0200
Message-ID: <1344527503-9965-2-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1344527503-9965-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6792639527529681749==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/service.c |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/src/service.c b/src/service.c
index 22d19c7..db9c514 100644
--- a/src/service.c
+++ b/src/service.c
@@ -887,6 +887,31 @@ out:
 	return reply;
 }
 =

+static DBusMessage *get_properties(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct mms_service *service =3D data;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+
+	reply =3D dbus_message_new_method_return(msg);
+	if (reply =3D=3D NULL)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	mms_dbus_dict_open(&iter, &dict);
+
+	mms_dbus_dict_append_basic(&dict, "UseDeliveryReports",
+					DBUS_TYPE_BOOLEAN,
+					&service->use_delivery_reports);
+
+	mms_dbus_dict_close(&iter, &dict);
+
+	return reply;
+}
+
 static DBusMessage *set_property(DBusConnection *conn, DBusMessage *dbus_m=
sg,
 								void *data)
 {
@@ -1069,6 +1094,10 @@ static const GDBusMethodTable service_methods[] =3D {
 			GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
 			NULL,
 			set_property) },
+	{ GDBUS_METHOD("GetProperties",
+			NULL,
+			GDBUS_ARGS({ "properties", "a{sv}" }),
+			get_properties) },
 	{ }
 };
 =

-- =

1.7.9.5


--===============6792639527529681749==--

