Content-Type: multipart/mixed; boundary="===============8826440322049807220=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH v1 2/2] service: handle error while receiving messages
Date: Fri, 06 Apr 2012 16:02:47 +0200
Message-ID: <1333720967-17878-3-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1333720967-17878-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8826440322049807220==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/service.c |   94 ++++++++++++++++++++++++++++++++++++++++++++---------=
---
 1 files changed, 74 insertions(+), 20 deletions(-)

diff --git a/src/service.c b/src/service.c
index 851db34..c3fc0c6 100644
--- a/src/service.c
+++ b/src/service.c
@@ -55,6 +55,7 @@
 #define CONTENT_TYPE_APP_SMIL "Content-Type: \"application/smil\";charset=
=3Dutf-8"

 #define MAX_ATTACHMENTS_NUMBER 25
+#define MAX_ATTEMPTS 3

 #define uninitialized_var(x) x =3D x

@@ -98,6 +99,7 @@ struct mms_request {
 	gsize data_size;
 	int fd;
 	guint16 status;
+	guint16 attempt;
 	struct mms_service *service;
 	mms_request_result_cb_t result_cb;
 	struct mms_message *msg;
@@ -526,6 +528,8 @@ static struct mms_request *create_request(enum mms_requ=
est_type type,

 	request->status =3D 0;

+	request->attempt =3D 0;
+
 	return request;
 }

@@ -1656,17 +1660,22 @@ int mms_service_set_bearer_handler(struct mms_servi=
ce *service,
 	return 0;
 }

-static void deactivate_bearer(struct mms_service *service)
+static inline gboolean bearer_is_active(struct mms_service *service)
 {
-	DBG("service %p", service);
-
 	if (service->bearer_setup =3D=3D TRUE)
-		return;
-
-	if (service->bearer_active =3D=3D FALSE)
-		return;
+		return FALSE;

 	if (service->bearer_handler =3D=3D NULL)
+		return FALSE;
+
+	return service->bearer_active;
+}
+
+static void deactivate_bearer(struct mms_service *service)
+{
+	DBG("service %p", service);
+
+	if (bearer_is_active(service) =3D=3D FALSE)
 		return;

 	DBG("service %p", service);
@@ -1798,16 +1807,42 @@ exit:
 	munmap(pdu, len);
 }

+static gboolean mms_requeue_request(struct mms_request *request)
+{
+	request->attempt +=3D 1;
+
+	if (request->attempt =3D=3D MAX_ATTEMPTS)
+		return FALSE;
+
+	if (request->type =3D=3D MMS_REQUEST_TYPE_GET) {
+		request->fd =3D open(request->data_path, O_WRONLY | O_TRUNC,
+							S_IWUSR | S_IRUSR);
+		if (request->fd < 0)
+			return FALSE;
+	}
+
+	g_queue_push_tail(request->service->request_queue, request);
+
+	return TRUE;
+}
+
 static gboolean web_get_cb(GWebResult *result, gpointer user_data)
 {
 	gsize written;
 	gsize chunk_size;
 	struct mms_request *request =3D user_data;
-	struct mms_service *service;
 	const guint8 *chunk;

-	if (g_web_result_get_chunk(result, &chunk, &chunk_size) =3D=3D FALSE)
-		goto error;
+	if (g_web_result_get_chunk(result, &chunk, &chunk_size) =3D=3D FALSE) {
+		mms_error("Fail to get data chunk");
+
+		close(request->fd);
+
+		if (mms_requeue_request(request) =3D=3D FALSE)
+			unlink(request->data_path);
+
+		goto exit;
+	}

 	if (chunk_size =3D=3D 0) {
 		close(request->fd);
@@ -1826,26 +1861,35 @@ static gboolean web_get_cb(GWebResult *result, gpoi=
nter user_data)

 	if (written !=3D chunk_size) {
 		mms_error("only %zd/%zd bytes written\n", written, chunk_size);
-		goto error;
+
+		close(request->fd);
+		unlink(request->data_path);
+
+		goto complete;
 	}

 	return TRUE;

-error:
-	close(request->fd);
-	unlink(request->data_path);
-
 complete:
-	service =3D request->service;
+	if (request->status >=3D 300) {
+		mms_error("Fail to get data (http status =3D %03u)",
+							request->status);
+		if (mms_requeue_request(request) =3D=3D TRUE) {
+			mms_error("retry later");
+			goto exit;
+		}
+		unlink(request->data_path);
+	}

 	if (request->result_cb !=3D NULL)
 		request->result_cb(request);

 	mms_request_destroy(request);

-	service->current_request_id =3D 0;
+exit:
+	request->service->current_request_id =3D 0;

-	process_request_queue(service);
+	process_request_queue(request->service);

 	return FALSE;
 }
@@ -1906,8 +1950,15 @@ static guint process_request(struct mms_request *req=
uest)
 		return id;
 	}

+	mms_error("Cannot process request (request type: %d)", request->type);
+
+	if (mms_requeue_request(request) =3D=3D TRUE)
+		return 0;
+
 	unlink(request->data_path);

+	mms_request_destroy(request);
+
 	return 0;
 }

@@ -1926,6 +1977,9 @@ static void process_request_queue(struct mms_service =
*service)
 		return;

 	while (1) {
+		if (bearer_is_active(service) =3D=3D FALSE)
+			return;
+
 		request =3D g_queue_pop_head(service->request_queue);
 		if (request =3D=3D NULL)
 			break;
@@ -1935,8 +1989,6 @@ static void process_request_queue(struct mms_service =
*service)
 		service->current_request_id =3D process_request(request);
 		if (service->current_request_id > 0)
 			return;
-
-		mms_request_destroy(request);
 	}

 	service->bearer_timeout =3D g_timeout_add_seconds(BEARER_IDLE_TIMEOUT,
@@ -2022,6 +2074,8 @@ error:

 out:
 	mms_message_free(msg);
+
+	mms_error("Failed to handle incoming notification");
 }

 void mms_service_bearer_notify(struct mms_service *service, mms_bool_t act=
ive,
--
1.7.4.1


--===============8826440322049807220==--

