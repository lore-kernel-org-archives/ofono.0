Content-Type: multipart/mixed; boundary="===============4945125299437191104=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC PATCH 30/30] qmi: add requests to service queue
Date: Wed, 28 Mar 2018 21:00:16 +0200
Message-ID: <20180328190016.28509-31-jonas@southpole.se>
In-Reply-To: <20180328190016.28509-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4945125299437191104==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Each service description wants to keep its own list of pending requests.
This allows the requests to be safely and efficently cancelled when the
service is 'closed'.
---
 drivers/qmimodem/qmi.c | 41 +++++++++++++++--------------------------
 1 file changed, 15 insertions(+), 26 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 2286f703..921f3205 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -110,6 +110,7 @@ struct qmi_device {
 struct qmi_service {
 	struct list_head node;
 	struct qmi_service_info *info;
+	struct list_head requests;
 	struct list_head notify_list;
 };
 =

@@ -128,6 +129,7 @@ struct qmi_result {
 =

 struct qmi_request {
 	struct list_head node;
+	struct list_head service_node;
 	uint16_t tid;
 	uint8_t client;
 	void *buf;
@@ -212,6 +214,7 @@ static int __request_submit(struct qmi_device* device,
 =

 	req =3D calloc(1, sizeof(*req));
 	INIT_LIST_HEAD(&req->node);
+	INIT_LIST_HEAD(&req->service_node);
 =

 	req->len =3D QMI_MUX_HDR_SIZE + headroom + QMI_MESSAGE_HDR_SIZE + length;
 =

@@ -257,6 +260,8 @@ static int __request_submit(struct qmi_device* device,
 		if (device->next_service_tid < 256)
 			device->next_service_tid =3D 256;
 		req->tid =3D hdr->transaction;
+
+		list_add_tail(&req->service_node, &service->requests);
 	}
 =

 	list_add_tail(&req->node, &device->req_queue);
@@ -813,6 +818,7 @@ static void handle_packet(struct qmi_device *device,
 			return;
 =

 		list_del(&req->node);
+		list_del(&req->service_node);
 	}
 =

 	if (req->callback)
@@ -995,6 +1001,7 @@ void qmi_device_unref(struct qmi_device *device)
 		 * request with a 'destroy' function
 		 */
 		list_del(&req->node);
+		list_del(&req->service_node);
 		g_free(req->buf);
 		g_free(req);
 	}
@@ -1004,6 +1011,7 @@ void qmi_device_unref(struct qmi_device *device)
 		 * request with a 'destroy' function
 		 */
 		list_del(&req->node);
+		list_del(&req->service_node);
 		g_free(req->buf);
 		g_free(req);
 	}
@@ -2021,6 +2029,7 @@ bool qmi_service_open(struct qmi_device *device,
 =

 	service =3D calloc(1, sizeof(*service));
 	INIT_LIST_HEAD(&service->node);
+	INIT_LIST_HEAD(&service->requests);
 	INIT_LIST_HEAD(&service->notify_list);
 	service->info =3D info;
 =

@@ -2194,39 +2203,19 @@ uint16_t qmi_service_send(struct qmi_service *servi=
ce,
 =

 bool qmi_service_cancel_all(struct qmi_service *service)
 {
-	struct qmi_device *device;
 	struct qmi_request *req, *req_t;
 =

 	if (!service)
 		return false;
 =

-	if (!service->info->client_id)
-		return false;
-
-	device =3D service->info->device;
-	if (!device)
-		return false;
-
-	list_for_each_entry_safe(req, req_t, &device->req_queue, node) {
-		if (req->client =3D=3D service->info->client_id) {
-			list_del(&req->node);
-
-			service_send_free(req->user_data);
-
-			g_free(req->buf);
-			g_free(req);
-		}
-	}
-
-	list_for_each_entry_safe(req, req_t, &device->service_queue, node) {
-		if (req->client =3D=3D service->info->client_id) {
-			list_del(&req->node);
+	list_for_each_entry_safe(req, req_t, &service->requests, service_node) {
+		list_del(&req->node);
+		list_del(&req->service_node);
 =

-			service_send_free(req->user_data);
+		service_send_free(req->user_data);
 =

-			g_free(req->buf);
-			g_free(req);
-		}
+		g_free(req->buf);
+		g_free(req);
 	}
 =

 	return true;
-- =

2.15.1


--===============4945125299437191104==--

