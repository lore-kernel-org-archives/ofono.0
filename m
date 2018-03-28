Content-Type: multipart/mixed; boundary="===============4938917151372336988=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC PATCH 10/30] qmi: remove unused qmi_service_cancel
Date: Wed, 28 Mar 2018 20:59:56 +0200
Message-ID: <20180328190016.28509-11-jonas@southpole.se>
In-Reply-To: <20180328190016.28509-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4938917151372336988==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The function is not used anywhere in the codebase.
---
 drivers/qmimodem/qmi.c | 41 -----------------------------------------
 drivers/qmimodem/qmi.h |  1 -
 2 files changed, 42 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 2e920abd..6cc858be 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -2284,47 +2284,6 @@ uint16_t qmi_service_send(struct qmi_service *servic=
e,
 	return 1;
 }
 =

-bool qmi_service_cancel(struct qmi_service *service, uint16_t id)
-{
-	unsigned int tid =3D id;
-	struct qmi_device *device;
-	struct qmi_request *req;
-	GList *list;
-
-	if (!service || !tid)
-		return false;
-
-	if (!service->client_id)
-		return false;
-
-	device =3D service->device;
-	if (!device)
-		return false;
-
-	list =3D g_queue_find_custom(device->req_queue,
-				GUINT_TO_POINTER(tid), __request_compare);
-	if (list) {
-		req =3D list->data;
-
-		g_queue_delete_link(device->req_queue, list);
-	} else {
-		list =3D g_queue_find_custom(device->service_queue,
-				GUINT_TO_POINTER(tid), __request_compare);
-		if (!list)
-			return false;
-
-		req =3D list->data;
-
-		g_queue_delete_link(device->service_queue, list);
-	}
-
-	service_send_free(req->user_data);
-
-	__request_free(req, NULL);
-
-	return true;
-}
-
 static GQueue *remove_client(GQueue *queue, uint8_t client)
 {
 	GQueue *new_queue;
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index e1801045..bb8eb4a0 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -170,7 +170,6 @@ uint16_t qmi_service_send(struct qmi_service *service,
 				uint16_t message, struct qmi_param *param,
 				qmi_result_func_t func,
 				void *user_data, qmi_destroy_func_t destroy);
-bool qmi_service_cancel(struct qmi_service *service, uint16_t id);
 bool qmi_service_cancel_all(struct qmi_service *service);
 =

 uint16_t qmi_service_register(struct qmi_service *service,
-- =

2.15.1


--===============4938917151372336988==--

