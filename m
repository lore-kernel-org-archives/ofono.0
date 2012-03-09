Content-Type: multipart/mixed; boundary="===============3126901758039521225=="
MIME-Version: 1.0
From: =?unknown-8bit?q?S=C3=A9bastien?= Bianti <sebastien.bianti@linux.intel.com>
Subject: [PATCH 1/1] service: mms_request_destroy shouldn't free msg
Date: Fri, 09 Mar 2012 15:51:43 +0100
Message-ID: <1331304703-25244-2-git-send-email-sebastien.bianti@linux.intel.com>
In-Reply-To: <1331304703-25244-1-git-send-email-sebastien.bianti@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3126901758039521225==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

mms_message is referenced in the hash table mms_service->messages
---
 src/service.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/service.c b/src/service.c
index affe454..ef6b544 100644
--- a/src/service.c
+++ b/src/service.c
@@ -115,9 +115,6 @@ static void mms_request_destroy(struct mms_request *req=
uest)
 {
 	g_free(request->data_path);
 	g_free(request->location);
-	if (request->msg !=3D NULL)
-		mms_message_free(request->msg);
-
 	g_free(request);
 }
 =

@@ -756,6 +753,8 @@ static DBusMessage *send_message(DBusConnection *conn,
 =

 	if (mms_message_encode(msg, request->fd) =3D=3D FALSE) {
 		release_attachement_data(msg->attachments);
+		mms_message_free(msg);
+
 		mms_request_destroy(request);
 =

 		return __mms_error_trans_failure(dbus_msg);
@@ -771,6 +770,8 @@ static DBusMessage *send_message(DBusConnection *conn,
 	meta =3D mms_store_meta_open(service->identity, msg->uuid);
 	if (meta =3D=3D NULL) {
 		release_attachement_data(msg->attachments);
+		mms_message_free(msg);
+
 		mms_request_destroy(request);
 =

 		return __mms_error_trans_failure(dbus_msg);
-- =

1.7.4.4


--===============3126901758039521225==--

