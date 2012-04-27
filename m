Content-Type: multipart/mixed; boundary="===============1011656738427112881=="
MIME-Version: 1.0
From: =?unknown-8bit?q?S=C3=A9bastien?= Bianti <sebastien.bianti@linux.intel.com>
Subject: [PATCH 2/2] service: emit signal when send has failed
Date: Fri, 27 Apr 2012 17:47:04 +0200
Message-ID: <1335541624-23000-3-git-send-email-sebastien.bianti@linux.intel.com>
In-Reply-To: <1335541624-23000-1-git-send-email-sebastien.bianti@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1011656738427112881==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Event if status doesn't really change, we need to alert the application
by sending the same value "draft" which means the message hasn't been recei=
ved.
---
 src/service.c |   32 ++++++++++++++++++++------------
 1 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/src/service.c b/src/service.c
index f89fd3f..8dd0a2e 100644
--- a/src/service.c
+++ b/src/service.c
@@ -596,16 +596,23 @@ static gboolean result_request_send_conf(struct mms_r=
equest *request)
 	size_t len;
 	char *path;
 =

-	if (request->status !=3D 200)
+	if (request->msg =3D=3D NULL)
 		return FALSE;
 =

+	uuid =3D request->msg->uuid;
+
+	path =3D g_strdup_printf("%s/%s/%s", MMS_PATH, service->identity,	uuid);
+
+	if (request->status !=3D 200)
+		goto error;
+
 	msg =3D g_try_new0(struct mms_message, 1);
 	if (msg =3D=3D NULL)
-		return FALSE;
+		goto error;
 =

 	if (mmap_file(request->data_path, &pdu, &len) =3D=3D FALSE) {
 		mms_message_free(msg);
-		return FALSE;
+		goto error;
 	}
 =

 	if (mms_message_decode(pdu, len, msg) =3D=3D FALSE) {
@@ -615,7 +622,7 @@ static gboolean result_request_send_conf(struct mms_req=
uest *request)
 =

 		mms_message_free(msg);
 =

-		return FALSE;
+		goto error;
 	}
 =

 	mms_debug("response status : %d", msg->sc.rsp_status);
@@ -626,26 +633,27 @@ static gboolean result_request_send_conf(struct mms_r=
equest *request)
 =

 	unlink(request->data_path);
 =

-	if (request->msg =3D=3D NULL)
-		return FALSE;
-
-	uuid =3D request->msg->uuid;
-
 	meta =3D mms_store_meta_open(service->identity, uuid);
 	if (meta =3D=3D NULL)
-		return FALSE;
+		goto error;
 =

 	g_key_file_set_string(meta, "info", "state", "sent");
 =

 	mms_store_meta_close(service->identity, uuid, meta, TRUE);
 =

-	path =3D g_strdup_printf("%s/%s/%s", MMS_PATH, service->identity,	uuid);
-
 	emit_msg_status_changed(path, "sent");
 =

 	g_free(path);
 =

 	return TRUE;
+
+error:
+	if (request->attempt =3D=3D MAX_ATTEMPTS)
+		emit_msg_status_changed(path, "draft");
+
+	g_free(path);
+
+	return FALSE;
 }
 =

 static void append_message(const char *path, const struct mms_service *ser=
vice,
-- =

1.7.4.4


--===============1011656738427112881==--

