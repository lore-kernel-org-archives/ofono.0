Content-Type: multipart/mixed; boundary="===============8417171933395150326=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH 2/4] service: Load delivery-report from mms settings
Date: Mon, 06 Aug 2012 17:30:58 +0200
Message-ID: <1344267060-5541-3-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1344267060-5541-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8417171933395150326==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/service.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/src/service.c b/src/service.c
index 83e1fe1..7243efd 100644
--- a/src/service.c
+++ b/src/service.c
@@ -57,6 +57,9 @@
 #define MAX_ATTACHMENTS_NUMBER 25
 #define MAX_ATTEMPTS 3
 =

+#define SETTINGS_STORE "mms"
+#define SETTINGS_GROUP "Settings"
+
 #define uninitialized_var(x) x =3D x
 =

 static const char *ctl_chars =3D "\x01\x02\x03\x04\x05\x06\x07\x08\x0A"
@@ -84,6 +87,8 @@ struct mms_service {
 	guint current_request_id;
 	GWeb *web;
 	GHashTable *messages;
+	GKeyFile *settings;
+	gboolean use_delivery_reports;
 };
 =

 enum mms_request_type {
@@ -111,6 +116,28 @@ static DBusConnection *connection;
 =

 static guint32 transaction_id_start =3D 0;
 =

+static void mms_load_settings(struct mms_service *service)
+{
+	GError *error;
+
+	service->settings =3D mms_settings_open(service->identity,
+							SETTINGS_STORE);
+	if (service->settings =3D=3D NULL)
+		return;
+
+	error =3D NULL;
+	service->use_delivery_reports =3D
+		g_key_file_get_boolean(service->settings, SETTINGS_GROUP,
+						"UseDeliveryReports", &error);
+
+	if (error) {
+		g_error_free(error);
+		g_key_file_set_boolean(service->settings, SETTINGS_GROUP,
+						"UseDeliveryReports",
+						service->use_delivery_reports);
+	}
+}
+
 static void mms_request_destroy(struct mms_request *request)
 {
 	g_free(request->data_path);
@@ -903,6 +930,8 @@ static DBusMessage *send_message(DBusConnection *conn,
 =

 	msg->sr.status =3D MMS_MESSAGE_STATUS_DRAFT;
 =

+	msg->sr.dr =3D service->use_delivery_reports;
+
 	if (send_message_get_args(dbus_msg, msg) =3D=3D FALSE) {
 		mms_debug("Invalid arguments");
 =

@@ -1407,6 +1436,8 @@ int mms_service_register(struct mms_service *service)
 =

 	emit_service_added(service);
 =

+	mms_load_settings(service);
+
 	load_messages(service);
 =

 	return 0;
@@ -1425,6 +1456,17 @@ int mms_service_unregister(struct mms_service *servi=
ce)
 	if (service->messages !=3D NULL)
 		destroy_message_table(service);
 =

+	if (service->settings !=3D NULL) {
+		g_key_file_set_boolean(service->settings, SETTINGS_GROUP,
+					"UseDeliveryReports",
+					service->use_delivery_reports);
+
+		mms_settings_close(service->identity, SETTINGS_STORE,
+						service->settings, TRUE);
+
+		service->settings =3D NULL;
+	}
+
 	if (g_dbus_unregister_interface(connection, service->path,
 					MMS_SERVICE_INTERFACE) =3D=3D FALSE) {
 		mms_error("Failed to unregister service interface");
-- =

1.7.9.5


--===============8417171933395150326==--

