Content-Type: multipart/mixed; boundary="===============1417332571189751068=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH 10/12] service: Send a delivery changed signal
Date: Fri, 17 Aug 2012 16:35:11 +0200
Message-ID: <1345214113-25597-11-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1345214113-25597-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1417332571189751068==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/service.c |   48 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/src/service.c b/src/service.c
index 44184cb..ba23b4a 100644
--- a/src/service.c
+++ b/src/service.c
@@ -218,6 +218,40 @@ static void emit_msg_status_changed(const char *path, =
const char *new_status)
 	g_dbus_send_message(connection, signal);
 }
 =

+static void emit_msg_delivery_changed(const char *path, const char *rec,
+							const char *status)
+{
+	DBusMessage *signal;
+	DBusMessageIter iter;
+	DBusMessageIter variant;
+	const char *type =3D "delivery_report";
+
+	signal =3D dbus_message_new_signal(path, MMS_MESSAGE_INTERFACE,
+							"ReportChanged");
+	if (signal =3D=3D NULL)
+		return;
+
+	dbus_message_iter_init_append(signal, &iter);
+
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &type);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_VARIANT,
+					DBUS_TYPE_STRING_AS_STRING, &variant);
+
+	dbus_message_iter_append_basic(&variant, DBUS_TYPE_STRING, &rec);
+
+	dbus_message_iter_close_container(&iter, &variant);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_VARIANT,
+					DBUS_TYPE_STRING_AS_STRING, &variant);
+
+	dbus_message_iter_append_basic(&variant, DBUS_TYPE_STRING, &status);
+
+	dbus_message_iter_close_container(&iter, &variant);
+
+	g_dbus_send_message(connection, signal);
+}
+
 static DBusMessage *msg_mark_read(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -269,6 +303,10 @@ static const GDBusMethodTable message_methods[] =3D {
 static const GDBusSignalTable message_signals[] =3D {
 	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
+	{ GDBUS_SIGNAL("ReportChanged",
+			GDBUS_ARGS({ "name", "s" },
+					{ "rec", "v" },
+					{ "status", "v" })) },
 	{ }
 };
 =

@@ -1369,6 +1407,7 @@ static void process_delivery_ind_notification(struct =
mms_service *service,
 	char uuid[MMS_META_UUID_LEN + 1];
 	char *path;
 	char *to;
+	const char *new_status;
 =

 	if (get_meta_by_msgid(service, di_msg->di.msgid, uuid) =3D=3D FALSE)
 		goto bail;
@@ -1381,15 +1420,18 @@ static void process_delivery_ind_notification(struc=
t mms_service *service,
 =

 	mms_address_to_string(to);
 =

-	g_key_file_set_string(meta, "delivery_status", to,
-				delivery_status[di_msg->di.dr_status - 127]);
+	new_status =3D delivery_status[di_msg->di.dr_status - 127];
 =

-	g_free(to);
+	g_key_file_set_string(meta, "delivery_status", to, new_status);
 =

 	mms_store_meta_close(service->identity, uuid, meta, TRUE);
 =

 	path =3D g_strdup_printf("%s/%s/%s", MMS_PATH, service->identity, uuid);
 =

+	emit_msg_delivery_changed(path, to, new_status);
+
+	g_free(to);
+
 	g_free(path);
 =

 bail:
-- =

1.7.9.5


--===============1417332571189751068==--

