Content-Type: multipart/mixed; boundary="===============5899305596826143521=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCHv2 6/6] service: Send a delivery changed signal
Date: Wed, 12 Sep 2012 15:55:13 +0200
Message-ID: <1347458113-29039-7-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1347458113-29039-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5899305596826143521==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/service.c |  125 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++--
 1 file changed, 121 insertions(+), 4 deletions(-)

diff --git a/src/service.c b/src/service.c
index e867aa1..f72bb6f 100644
--- a/src/service.c
+++ b/src/service.c
@@ -80,6 +80,15 @@ static const char *delivery_status[] =3D {
 	"unreachable"
 };

+#define MMS_DELIVERY_STATUS_FLAG_NONE		(1 << 0)
+#define MMS_DELIVERY_STATUS_FLAG_EXPIRED	(1 << 1)
+#define MMS_DELIVERY_STATUS_FLAG_RETRIEVED	(1 << 2)
+#define MMS_DELIVERY_STATUS_FLAG_REJECTED	(1 << 3)
+#define MMS_DELIVERY_STATUS_FLAG_DEFERRED	(1 << 4)
+#define MMS_DELIVERY_STATUS_FLAG_INDETERMINATE	(1 << 5)
+#define MMS_DELIVERY_STATUS_FLAG_FORWARDED	(1 << 6)
+#define MMS_DELIVERY_STATUS_FLAG_UNREACHABLE	(1 << 7)
+
 struct mms_request;

 typedef gboolean (*mms_request_result_cb_t) (struct mms_request *request);
@@ -218,6 +227,83 @@ static void emit_msg_status_changed(const char *path, =
const char *new_status)
 	g_dbus_send_message(connection, signal);
 }

+static char *compute_delivery_status(char **rec_status)
+{
+	unsigned int status =3D 0;
+
+	while (*rec_status) {
+		if (strcmp(*rec_status, delivery_status[0]) =3D=3D 0)
+			status |=3D MMS_DELIVERY_STATUS_FLAG_NONE;
+		else if (strcmp(*rec_status, delivery_status[1]) =3D=3D 0)
+			status |=3D MMS_DELIVERY_STATUS_FLAG_EXPIRED;
+		else if (strcmp(*rec_status, delivery_status[2]) =3D=3D 0)
+			status |=3D MMS_DELIVERY_STATUS_FLAG_RETRIEVED;
+		else if (strcmp(*rec_status, delivery_status[3]) =3D=3D 0)
+			status |=3D MMS_DELIVERY_STATUS_FLAG_REJECTED;
+		else if (strcmp(*rec_status, delivery_status[4]) =3D=3D 0)
+			status |=3D MMS_DELIVERY_STATUS_FLAG_DEFERRED;
+		else if (strcmp(*rec_status, delivery_status[5]) =3D=3D 0)
+			status |=3D MMS_DELIVERY_STATUS_FLAG_INDETERMINATE;
+		else if (strcmp(*rec_status, delivery_status[6]) =3D=3D 0)
+			status |=3D MMS_DELIVERY_STATUS_FLAG_FORWARDED;
+		else if (strcmp(*rec_status, delivery_status[7]) =3D=3D 0)
+			status |=3D MMS_DELIVERY_STATUS_FLAG_UNREACHABLE;
+		rec_status++;
+	}
+
+	if (status & MMS_DELIVERY_STATUS_FLAG_RETRIEVED) {
+		if (status =3D=3D MMS_DELIVERY_STATUS_FLAG_RETRIEVED)
+			return g_strdup("delivered");
+		return g_strdup("partially_delivered");
+	}
+
+	return g_strdup("not_delivered");
+}
+
+static void emit_msg_delivery_changed(const char *path, char **rec,
+							char **rec_status)
+{
+	DBusMessage *signal;
+	DBusMessageIter iter;
+	DBusMessageIter variant;
+	DBusMessageIter dict;
+	const char *type =3D "delivery_report";
+	char *dlv_status;
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
+	dlv_status =3D compute_delivery_status(rec_status);
+
+	dbus_message_iter_append_basic(&variant, DBUS_TYPE_STRING, &dlv_status);
+
+	g_free(dlv_status);
+
+	dbus_message_iter_close_container(&iter, &variant);
+
+	mms_dbus_dict_open(&iter, &dict);
+
+	while (*rec) {
+		mms_dbus_dict_append_basic(&dict, *rec, DBUS_TYPE_STRING,
+								&(*rec_status));
+		rec++;
+		rec_status++;
+	}
+
+	mms_dbus_dict_close(&iter, &dict);
+
+	g_dbus_send_message(connection, signal);
+}
+
 static DBusMessage *msg_mark_read(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -269,6 +355,10 @@ static const GDBusMethodTable message_methods[] =3D {
 static const GDBusSignalTable message_signals[] =3D {
 	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
+	{ GDBUS_SIGNAL("ReportChanged",
+			GDBUS_ARGS({ "name", "s" },
+					{ "glob_status", "v" },
+					{ "details", "a{sv}" })) },
 	{ }
 };

@@ -1372,6 +1462,11 @@ static void process_delivery_ind_notification(struct=
 mms_service *service,
 	char uuid[MMS_META_UUID_LEN + 1];
 	char *path;
 	char *to;
+	char **tos;
+	char **statutes;
+	gsize length;
+	unsigned int i;
+	const char *new_status;

 	if (get_meta_by_msgid(service, di_msg->di.msgid, uuid) =3D=3D FALSE)
 		goto exit;
@@ -1384,17 +1479,39 @@ static void process_delivery_ind_notification(struc=
t mms_service *service,

 	mms_address_to_string(to);

-	g_key_file_set_string(meta, "delivery_status", to,
-				delivery_status[di_msg->di.dr_status - 127]);
+	new_status =3D delivery_status[di_msg->di.dr_status - 127];

-	g_free(to);
+	g_key_file_set_string(meta, "delivery_status", to, new_status);
+
+	path =3D g_strdup_printf("%s/%s/%s", MMS_PATH, service->identity, uuid);
+
+	statutes =3D NULL;
+
+	tos =3D g_key_file_get_keys(meta, "delivery_status", &length, NULL);
+	if (tos =3D=3D NULL)
+		goto bail;
+
+	statutes =3D g_try_new0(char *, length + 1);
+	if (statutes =3D=3D NULL)
+		goto bail;
+
+	for (i =3D 0; i < length; i++)
+		statutes[i] =3D g_key_file_get_string(meta, "delivery_status",
+								tos[i], NULL);

 	mms_store_meta_close(service->identity, uuid, meta, TRUE);

-	path =3D g_strdup_printf("%s/%s/%s", MMS_PATH, service->identity, uuid);
+	emit_msg_delivery_changed(path, tos, statutes);
+
+bail:
+	g_strfreev(statutes);
+
+	g_strfreev(tos);

 	g_free(path);

+	g_free(to);
+
 exit:
 	mms_store_remove(service->identity, di_msg->uuid);

--
1.7.9.5


--===============5899305596826143521==--

