Content-Type: multipart/mixed; boundary="===============4709388379918563037=="
MIME-Version: 1.0
From: =?unknown-8bit?q?S=C3=A9bastien?= Bianti <sebastien.bianti@linux.intel.com>
Subject: [PATCH v3 1/3] service: factorize error code
Date: Mon, 26 Mar 2012 18:12:37 +0200
Message-ID: <1332778359-5756-2-git-send-email-sebastien.bianti@linux.intel.com>
In-Reply-To: <1332778359-5756-1-git-send-email-sebastien.bianti@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4709388379918563037==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/service.c |   55 +++++++++++++++++++----------------------------------=
--
 1 files changed, 19 insertions(+), 36 deletions(-)

diff --git a/src/service.c b/src/service.c
index 5fda8a1..25a4fc4 100644
--- a/src/service.c
+++ b/src/service.c
@@ -733,30 +733,16 @@ static DBusMessage *send_message(DBusConnection *conn,
 	}
 =

 	msg->transaction_id =3D create_transaction_id();
-	if (msg->transaction_id =3D=3D NULL) {
-		release_attachement_data(msg->attachments);
-		mms_message_free(msg);
-
-		return __mms_error_trans_failure(dbus_msg);
-	}
+	if (msg->transaction_id =3D=3D NULL)
+		goto release_msg;
 =

 	request =3D create_request(MMS_REQUEST_TYPE_POST,
 				result_request_send_conf, NULL, service, msg);
-	if (request =3D=3D NULL) {
-		release_attachement_data(msg->attachments);
-		mms_message_free(msg);
-
-		return __mms_error_trans_failure(dbus_msg);
-	}
-
-	if (mms_message_encode(msg, request->fd) =3D=3D FALSE) {
-		release_attachement_data(msg->attachments);
-		mms_message_free(msg);
-
-		mms_request_destroy(request);
+	if (request =3D=3D NULL)
+		goto release_msg;
 =

-		return __mms_error_trans_failure(dbus_msg);
-	}
+	if (mms_message_encode(msg, request->fd) =3D=3D FALSE)
+		goto release_request;
 =

 	close(request->fd);
 =

@@ -766,27 +752,15 @@ static DBusMessage *send_message(DBusConnection *conn,
 						request->data_path));
 =

 	meta =3D mms_store_meta_open(service->identity, msg->uuid);
-	if (meta =3D=3D NULL) {
-		release_attachement_data(msg->attachments);
-		mms_message_free(msg);
-
-		mms_request_destroy(request);
-
-		return __mms_error_trans_failure(dbus_msg);
-	}
+	if (meta =3D=3D NULL)
+		goto release_request;
 =

 	g_key_file_set_string(meta, "info", "state", "draft");
 =

 	mms_store_meta_close(service->identity, msg->uuid, meta, TRUE);
 =

-	if (mms_message_register(service, msg) < 0) {
-		release_attachement_data(msg->attachments);
-		mms_message_free(msg);
-
-		mms_request_destroy(request);
-
-		return __mms_error_trans_failure(dbus_msg);
-	}
+	if (mms_message_register(service, msg) < 0)
+		goto release_request;
 =

 	emit_message_added(service, msg);
 =

@@ -811,6 +785,15 @@ static DBusMessage *send_message(DBusConnection *conn,
 								&msg->path);
 =

 	return reply;
+
+release_request:
+	mms_request_destroy(request);
+
+release_msg:
+	release_attachement_data(msg->attachments);
+	mms_message_free(msg);
+
+	return __mms_error_trans_failure(dbus_msg);
 }
 =

 static GDBusMethodTable service_methods[] =3D {
-- =

1.7.4.4


--===============4709388379918563037==--

