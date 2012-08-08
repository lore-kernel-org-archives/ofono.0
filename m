Content-Type: multipart/mixed; boundary="===============4011851725478702981=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCHv2 1/3] service: Add DBus method to set delivery-report
Date: Wed, 08 Aug 2012 15:21:44 +0200
Message-ID: <1344432106-23105-2-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1344432106-23105-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4011851725478702981==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/service.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/src/service.c b/src/service.c
index 7243efd..22d19c7 100644
--- a/src/service.c
+++ b/src/service.c
@@ -887,6 +887,48 @@ out:
 	return reply;
 }

+static DBusMessage *set_property(DBusConnection *conn, DBusMessage *dbus_m=
sg,
+								void *data)
+{
+	struct mms_service *service =3D data;
+	DBusMessageIter iter;
+	DBusMessageIter var;
+	const char *property;
+
+	if (!dbus_message_iter_init(dbus_msg, &iter))
+		return __mms_error_invalid_args(dbus_msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_STRING)
+		return __mms_error_invalid_args(dbus_msg);
+
+	dbus_message_iter_get_basic(&iter, &property);
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) !=3D DBUS_TYPE_VARIANT)
+		return __mms_error_invalid_args(dbus_msg);
+
+	dbus_message_iter_recurse(&iter, &var);
+
+	if (!strcmp(property, "UseDeliveryReports")) {
+		dbus_bool_t value;
+
+		if (dbus_message_iter_get_arg_type(&var) !=3D DBUS_TYPE_BOOLEAN)
+			return __mms_error_invalid_args(dbus_msg);
+
+		dbus_message_iter_get_basic(&var, &value);
+
+		if (service->use_delivery_reports !=3D (gboolean) value) {
+			DBG("use_delivery_reports =3D %d", value);
+
+			service->use_delivery_reports =3D value;
+		}
+
+		return g_dbus_create_reply(dbus_msg, DBUS_TYPE_INVALID);
+	}
+
+	return __mms_error_invalid_args(dbus_msg);
+}
+
 static gboolean mms_attachment_is_smil(const struct mms_attachment *part)
 {
 	if (g_str_has_prefix(part->content_type, "application/smil"))
@@ -1023,6 +1065,10 @@ static const GDBusMethodTable service_methods[] =3D {
 			GDBUS_ARGS({ "number", "s" }, { "count", "s" }),
 			GDBUS_ARGS({ "messages_with_properties", "a(oa{sv}" }),
 			get_conversation) },
+	{ GDBUS_METHOD("SetProperty",
+			GDBUS_ARGS({ "property", "s" }, { "value", "v" }),
+			NULL,
+			set_property) },
 	{ }
 };

--
1.7.9.5


--===============4011851725478702981==--

