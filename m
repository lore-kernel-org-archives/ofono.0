Content-Type: multipart/mixed; boundary="===============0597710404893431242=="
MIME-Version: 1.0
From: =?unknown-8bit?q?S=C3=A9bastien?= Bianti <sebastien.bianti@linux.intel.com>
Subject: [PATCH v2 07/10] service: callbacks should return a boolean
Date: Fri, 13 Apr 2012 18:33:46 +0200
Message-ID: <1334334829-31617-8-git-send-email-sebastien.bianti@linux.intel.com>
In-Reply-To: <1334334829-31617-1-git-send-email-sebastien.bianti@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0597710404893431242==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To decide whether retry or not.
---
 src/service.c |   41 +++++++++++++++++++++++------------------
 1 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/src/service.c b/src/service.c
index 1be0386..f8ad05f 100644
--- a/src/service.c
+++ b/src/service.c
@@ -68,7 +68,7 @@ static const char *sep_chars =3D "()<>@,;:\\\"/[]?=3D{} \=
t";
 =

 struct mms_request;
 =

-typedef void (*mms_request_result_cb_t) (struct mms_request *request);
+typedef gboolean (*mms_request_result_cb_t) (struct mms_request *request);
 =

 struct mms_service {
 	gint refcount;
@@ -581,7 +581,7 @@ static inline char *create_transaction_id(void)
 					"0123456789ABCDEF0123456789ABCDEF");
 }
 =

-static void result_request_send_conf(struct mms_request *request)
+static gboolean result_request_send_conf(struct mms_request *request)
 {
 	struct mms_message *msg;
 	struct mms_service *service =3D request->service;
@@ -592,15 +592,15 @@ static void result_request_send_conf(struct mms_reque=
st *request)
 	char *path;
 =

 	if (request->status !=3D 200)
-		return;
+		return FALSE;
 =

 	msg =3D g_try_new0(struct mms_message, 1);
 	if (msg =3D=3D NULL)
-		return;
+		return FALSE;
 =

 	if (mmap_file(request->data_path, &pdu, &len) =3D=3D FALSE) {
 		mms_message_free(msg);
-		return;
+		return FALSE;
 	}
 =

 	if (mms_message_decode(pdu, len, msg) =3D=3D FALSE) {
@@ -610,7 +610,7 @@ static void result_request_send_conf(struct mms_request=
 *request)
 =

 		mms_message_free(msg);
 =

-		return;
+		return FALSE;
 	}
 =

 	mms_debug("response status : %d", msg->sc.rsp_status);
@@ -622,13 +622,13 @@ static void result_request_send_conf(struct mms_reque=
st *request)
 	unlink(request->data_path);
 =

 	if (request->msg =3D=3D NULL)
-		return;
+		return FALSE;
 =

 	uuid =3D request->msg->uuid;
 =

 	meta =3D mms_store_meta_open(service->identity, uuid);
 	if (meta =3D=3D NULL)
-		return;
+		return FALSE;
 =

 	g_key_file_set_string(meta, "info", "state", "sent");
 =

@@ -639,6 +639,8 @@ static void result_request_send_conf(struct mms_request=
 *request)
 	emit_msg_status_changed(path, "sent");
 =

 	g_free(path);
+
+	return TRUE;
 }
 =

 static void append_message(const char *path, const struct mms_service *ser=
vice,
@@ -1029,8 +1031,8 @@ out:
 	return success;
 }
 =

-static void result_request_retrieve_conf(struct mms_request *request);
-static void result_request_notify_resp(struct mms_request *request);
+static gboolean result_request_retrieve_conf(struct mms_request *request);
+static gboolean result_request_notify_resp(struct mms_request *request);
 =

 static struct mms_request *build_notify_resp_ind(struct mms_service *servi=
ce,
 					enum mms_message_notify_status status,
@@ -1693,7 +1695,7 @@ static gboolean bearer_idle_timeout(gpointer user_dat=
a)
 	return FALSE;
 }
 =

-static void result_request_notify_resp(struct mms_request *request)
+static gboolean result_request_notify_resp(struct mms_request *request)
 {
 	struct mms_message *msg;
 	GKeyFile *meta;
@@ -1703,17 +1705,17 @@ static void result_request_notify_resp(struct mms_r=
equest *request)
 	if (request->status !=3D 200) {
 		mms_error("POST m.notify.resp.ind failed with status %d",
 						request->status);
-		return;
+		return FALSE;
 	}
 =

 	if (request->msg =3D=3D NULL)
-		return;
+		return FALSE;
 =

 	msg =3D mms_request_steal_message(request);
 =

 	if (mms_message_register(request->service, msg) !=3D 0) {
 		mms_message_free(msg);
-		return;
+		return FALSE;
 	}
 =

 	emit_message_added(request->service, msg);
@@ -1721,15 +1723,17 @@ static void result_request_notify_resp(struct mms_r=
equest *request)
 	meta =3D mms_store_meta_open(request->service->identity,
 					msg->uuid);
 	if (meta =3D=3D NULL)
-		return;
+		return FALSE;
 =

 	g_key_file_set_string(meta, "info", "state", "received");
 =

 	mms_store_meta_close(request->service->identity,
 				msg->uuid, meta, TRUE);
+
+	return TRUE;
 }
 =

-static void result_request_retrieve_conf(struct mms_request *request)
+static gboolean result_request_retrieve_conf(struct mms_request *request)
 {
 	struct mms_message *msg;
 	struct mms_service *service =3D request->service;
@@ -1741,10 +1745,10 @@ static void result_request_retrieve_conf(struct mms=
_request *request)
 	gboolean decode_success;
 =

 	if (request->status !=3D 200)
-		return;
+		return FALSE;
 =

 	if (mmap_file(request->data_path, &pdu, &len) =3D=3D FALSE)
-		return;
+		return FALSE;
 =

 	uuid =3D mms_store_file(service->identity, request->data_path);
 	if (uuid =3D=3D NULL)
@@ -1798,6 +1802,7 @@ error:
 =

 exit:
 	munmap(pdu, len);
+	return TRUE;
 }
 =

 static gboolean web_get_cb(GWebResult *result, gpointer user_data)
-- =

1.7.4.4


--===============0597710404893431242==--

