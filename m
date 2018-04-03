Content-Type: multipart/mixed; boundary="===============4016709821765920471=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 3/6] qmi: drop header output parameter from request_alloc
Date: Tue, 03 Apr 2018 16:50:53 +0200
Message-ID: <20180403145056.25817-3-jonas@southpole.se>
In-Reply-To: <20180403145056.25817-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4016709821765920471==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The only thing this output parameter is being used for now is for
getting the transaction ID.  Return the TID directly from
__submit_requesta and drop the 'head' parameter altogether.
---
 drivers/qmimodem/qmi.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index a980839b..08d437c1 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -163,7 +163,7 @@ static struct qmi_request *__request_alloc(uint8_t serv=
ice,
 				uint8_t client, uint16_t message,
 				const void *data,
 				uint16_t length, qmi_message_func_t func,
-				void *user_data, void **head)
+				void *user_data)
 {
 	struct qmi_request *req;
 	struct qmi_mux_hdr *hdr;
@@ -203,8 +203,6 @@ static struct qmi_request *__request_alloc(uint8_t serv=
ice,
 	req->callback =3D func;
 	req->user_data =3D user_data;
 =

-	*head =3D req->buf + QMI_MUX_HDR_SIZE;
-
 	return req;
 }
 =

@@ -695,7 +693,8 @@ static void wakeup_writer(struct qmi_device *device)
 				can_write_data, device, write_watch_destroy);
 }
 =

-static void __request_submit(struct qmi_device *device, struct qmi_request=
 *req)
+static uint16_t __request_submit(struct qmi_device *device,
+				struct qmi_request *req)
 {
 	struct qmi_mux_hdr *mux;
 =

@@ -723,6 +722,8 @@ static void __request_submit(struct qmi_device *device,=
 struct qmi_request *req)
 	g_queue_push_tail(device->req_queue, req);
 =

 	wakeup_writer(device);
+
+	return req->tid;
 }
 =

 static void service_notify(gpointer key, gpointer value, gpointer user_dat=
a)
@@ -1250,7 +1251,7 @@ bool qmi_device_discover(struct qmi_device *device, q=
mi_discover_func_t func,
 {
 	struct discover_data *data;
 	struct qmi_request *req;
-	struct qmi_control_hdr *hdr;
+	uint8_t tid;
 =

 	if (!device)
 		return false;
@@ -1275,11 +1276,11 @@ bool qmi_device_discover(struct qmi_device *device,=
 qmi_discover_func_t func,
 =

 	req =3D __request_alloc(QMI_SERVICE_CONTROL, 0x00,
 			QMI_CTL_GET_VERSION_INFO,
-			NULL, 0, discover_callback, data, (void **) &hdr);
+			NULL, 0, discover_callback, data);
 =

-	data->tid =3D hdr->transaction;
+	tid =3D __request_submit(device, req);
 =

-	__request_submit(device, req);
+	data->tid =3D tid;
 =

 	data->timeout =3D g_timeout_add_seconds(5, discover_reply, data);
 	__qmi_device_discovery_started(device, &data->super);
@@ -1293,12 +1294,11 @@ static void release_client(struct qmi_device *devic=
e,
 {
 	unsigned char release_req[] =3D { 0x01, 0x02, 0x00, type, client_id };
 	struct qmi_request *req;
-	struct qmi_control_hdr *hdr;
 =

 	req =3D __request_alloc(QMI_SERVICE_CONTROL, 0x00,
 			QMI_CTL_RELEASE_CLIENT_ID,
 			release_req, sizeof(release_req),
-			func, user_data, (void **) &hdr);
+			func, user_data);
 =

 	__request_submit(device, req);
 }
@@ -1378,7 +1378,6 @@ bool qmi_device_sync(struct qmi_device *device,
 		     qmi_sync_func_t func, void *user_data)
 {
 	struct qmi_request *req;
-	struct qmi_control_hdr *hdr;
 	struct sync_data *func_data;
 =

 	if (!device)
@@ -1393,7 +1392,7 @@ bool qmi_device_sync(struct qmi_device *device,
 	req =3D __request_alloc(QMI_SERVICE_CONTROL, 0x00,
 			QMI_CTL_SYNC,
 			NULL, 0,
-			qmi_device_sync_callback, func_data, (void **) &hdr);
+			qmi_device_sync_callback, func_data);
 =

 	__request_submit(device, req);
 =

@@ -1996,7 +1995,6 @@ static void service_create_discover(uint8_t count,
 	struct service_create_data *data =3D user_data;
 	struct qmi_device *device =3D data->device;
 	struct qmi_request *req;
-	struct qmi_control_hdr *hdr;
 	unsigned char client_req[] =3D { 0x01, 0x01, 0x00, data->type };
 	unsigned int i;
 =

@@ -2013,7 +2011,7 @@ static void service_create_discover(uint8_t count,
 	req =3D __request_alloc(QMI_SERVICE_CONTROL, 0x00,
 			QMI_CTL_GET_CLIENT_ID,
 			client_req, sizeof(client_req),
-			service_create_callback, data, (void **) &hdr);
+			service_create_callback, data);
 =

 	__request_submit(device, req);
 }
@@ -2271,7 +2269,7 @@ uint16_t qmi_service_send(struct qmi_service *service,
 	struct qmi_device *device;
 	struct service_send_data *data;
 	struct qmi_request *req;
-	struct qmi_service_hdr *hdr;
+	uint16_t tid;
 =

 	if (!service)
 		return 0;
@@ -2295,13 +2293,13 @@ uint16_t qmi_service_send(struct qmi_service *servi=
ce,
 				message,
 				param ? param->data : NULL,
 				param ? param->length : 0,
-				service_send_callback, data, (void **) &hdr);
+				service_send_callback, data);
 =

 	qmi_param_free(param);
 =

-	__request_submit(device, req);
+	tid =3D __request_submit(device, req);
 =

-	return hdr->transaction;
+	return tid;
 }
 =

 bool qmi_service_cancel(struct qmi_service *service, uint16_t id)
-- =

2.15.1


--===============4016709821765920471==--

