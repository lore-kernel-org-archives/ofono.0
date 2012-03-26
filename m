Content-Type: multipart/mixed; boundary="===============1110569531151713961=="
MIME-Version: 1.0
From: =?unknown-8bit?q?S=C3=A9bastien?= Bianti <sebastien.bianti@linux.intel.com>
Subject: [PATCH v3 3/3] service: remove orphan file
Date: Mon, 26 Mar 2012 18:12:39 +0200
Message-ID: <1332778359-5756-4-git-send-email-sebastien.bianti@linux.intel.com>
In-Reply-To: <1332778359-5756-1-git-send-email-sebastien.bianti@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1110569531151713961==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/service.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/src/service.c b/src/service.c
index 25a2563..755ebc3 100644
--- a/src/service.c
+++ b/src/service.c
@@ -753,6 +753,11 @@ static DBusMessage *send_message(DBusConnection *conn,
 	if (msg->uuid =3D=3D NULL)
 		goto release_request;
 =

+	g_free(request->data_path);
+
+	request->data_path =3D g_strdup_printf("%s/.mms/%s/%s", g_get_home_dir(),
+						service->identity, msg->uuid);
+
 	meta =3D mms_store_meta_open(service->identity, msg->uuid);
 	if (meta =3D=3D NULL)
 		goto release_request;
@@ -768,11 +773,6 @@ static DBusMessage *send_message(DBusConnection *conn,
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
@@ -789,6 +789,7 @@ static DBusMessage *send_message(DBusConnection *conn,
 	return reply;
 =

 release_request:
+	unlink(request->data_path);
 	mms_request_destroy(request);
 =

 release_msg:
-- =

1.7.4.4


--===============1110569531151713961==--

