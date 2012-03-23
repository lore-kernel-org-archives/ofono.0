Content-Type: multipart/mixed; boundary="===============2611814966684365522=="
MIME-Version: 1.0
From: =?unknown-8bit?q?S=C3=A9bastien?= Bianti <sebastien.bianti@linux.intel.com>
Subject: [PATCH v2 3/6] service: remove pdu without meta
Date: Fri, 23 Mar 2012 17:45:38 +0100
Message-ID: <1332521141-31865-4-git-send-email-sebastien.bianti@linux.intel.com>
In-Reply-To: <1332521141-31865-1-git-send-email-sebastien.bianti@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2611814966684365522==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/service.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/src/service.c b/src/service.c
index 0161ec0..8dbee12 100644
--- a/src/service.c
+++ b/src/service.c
@@ -777,11 +777,17 @@ static DBusMessage *send_message(DBusConnection *conn,
 		return __mms_error_trans_failure(dbus_msg);
 	}
 =

+	g_free(request->data_path);
+
+	request->data_path =3D g_strdup_printf("%s/.mms/%s/%s", g_get_home_dir(),
+						service->identity, msg->uuid);
+
 	meta =3D mms_store_meta_open(service->identity, msg->uuid);
 	if (meta =3D=3D NULL) {
 		release_attachement_data(msg->attachments);
 		mms_message_free(msg);
 =

+		unlink(request->data_path);
 		mms_request_destroy(request);
 =

 		return __mms_error_trans_failure(dbus_msg);
@@ -804,11 +810,6 @@ static DBusMessage *send_message(DBusConnection *conn,
 =

 	release_attachement_data(msg->attachments);
 =

-	g_free(request->data_path);
-
-	request->data_path =3D g_strdup_printf("%s/.mms/%s/%s", g_get_home_dir(),
-						service->identity, msg->uuid);
-
 	g_queue_push_tail(service->request_queue, request);
 =

 	activate_bearer(service);
-- =

1.7.4.4


--===============2611814966684365522==--

