Content-Type: multipart/mixed; boundary="===============5107488642458799426=="
MIME-Version: 1.0
From: ofono@market.talbothome.com
Subject: [PATCH 06/10] MMSD: Allow for a user configurable max attachments size
Date: Fri, 19 Feb 2021 01:03:48 +0000
Message-ID: <20210219010348.2937.32968@ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5107488642458799426==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To prevent a chat program from accidentally sending too large of an MMS,
this patch watches the attachments and sends back a failure if it is too la=
rge.
The default on here is 1.1 Megabytes (this is the default max size on Andro=
id).
I also made it user changable.

---
 src/service.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/src/service.c b/src/service.c
index a9b07f6..58cd747 100644
--- a/src/service.c
+++ b/src/service.c
@@ -56,6 +56,7 @@
 =

 #define MAX_ATTACHMENTS_NUMBER 25
 #define MAX_ATTEMPTS 3
+#define DEFAULT_MAX_ATTACHMENT_TOTAL_SIZE 1100000
 =

 #define SETTINGS_STORE "mms"
 #define SETTINGS_GROUP "Settings"
@@ -100,6 +101,7 @@ struct mms_service {
 	GHashTable *messages;
 	GKeyFile *settings;
 	gboolean use_delivery_reports;
+	int max_attach_total_size;
 };
 =

 enum mms_request_type {
@@ -146,7 +148,22 @@ static void mms_load_settings(struct mms_service *serv=
ice)
 		g_key_file_set_boolean(service->settings, SETTINGS_GROUP,
 						"UseDeliveryReports",
 						service->use_delivery_reports);
+		error =3D NULL;
 	}
+
+	service->max_attach_total_size =3D
+		g_key_file_get_integer(service->settings, SETTINGS_GROUP,
+						"TotalMaxAttachmentSize", &error);
+
+	if (error) {
+		g_error_free(error);
+		service->max_attach_total_size =3D DEFAULT_MAX_ATTACHMENT_TOTAL_SIZE;
+		g_key_file_set_integer(service->settings, SETTINGS_GROUP,
+						"TotalMaxAttachmentSize",
+						service->max_attach_total_size);
+	}
+	mms_debug("Maximum Attachment Total Size (in bytes): %d", service->max_at=
tach_total_size);
+
 }
 =

 static void mms_request_destroy(struct mms_request *request)
@@ -414,10 +431,11 @@ static gboolean send_message_get_recipients(DBusMessa=
geIter *top_iter,
 }
 =

 static gboolean send_message_get_attachments(DBusMessageIter *top_iter,
-						struct mms_message *msg)
+						struct mms_message *msg, struct mms_service *service)
 {
 	DBusMessageIter attachments;
 	unsigned int attach_num =3D 0;
+	int attach_total_size =3D 0;
 =

 	dbus_message_iter_recurse(top_iter, &attachments);
 =

@@ -430,8 +448,10 @@ static gboolean send_message_get_attachments(DBusMessa=
geIter *top_iter,
 		struct mms_attachment *attach;
 		void *ptr;
 =

-		if (++attach_num > MAX_ATTACHMENTS_NUMBER)
+		if (++attach_num > MAX_ATTACHMENTS_NUMBER) {
+			mms_error("Error: Too many attachments!");
 			return FALSE;
+		}
 =

 		dbus_message_iter_recurse(&attachments, &entry);
 =

@@ -466,6 +486,16 @@ static gboolean send_message_get_attachments(DBusMessa=
geIter *top_iter,
 			return FALSE;
 		}
 =

+		attach_total_size =3D attach_total_size + attach->length;
+
+		mms_debug("Total attachment size: %d", attach_total_size);
+		mms_debug("Maximum Attachment Total Size (in bytes): %d", service->max_a=
ttach_total_size);
+
+		if (attach_total_size > service->max_attach_total_size) {
+			mms_error("Error: Total Attachment size too large!");
+			return FALSE;
+		}
+
 		attach->data =3D ptr;
 =

 		attach->content_id =3D g_strdup(id);
@@ -490,7 +520,7 @@ static gboolean send_message_get_attachments(DBusMessag=
eIter *top_iter,
 }
 =

 static gboolean send_message_get_args(DBusMessage *dbus_msg,
-						struct mms_message *msg)
+						struct mms_message *msg, struct mms_service *service)
 {
 	DBusMessageIter top_iter;
 	const char *smil;
@@ -536,7 +566,7 @@ static gboolean send_message_get_args(DBusMessage *dbus=
_msg,
 	if (dbus_message_iter_get_arg_type(&top_iter) !=3D DBUS_TYPE_ARRAY)
 		return FALSE;
 =

-	return send_message_get_attachments(&top_iter, msg);
+	return send_message_get_attachments(&top_iter, msg, service);
 }
 =

 static struct mms_request *create_request(enum mms_request_type type,
-- =

2.30.0
--===============5107488642458799426==--

