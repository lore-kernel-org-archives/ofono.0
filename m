Content-Type: multipart/mixed; boundary="===============2963538512170465475=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 05/12] qmi: push request_submit into request_alloc
Date: Thu, 29 Mar 2018 15:57:54 +0200
Message-ID: <20180329135801.5981-6-jonas@southpole.se>
In-Reply-To: <20180329135801.5981-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2963538512170465475==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The same pattern, alloc and submit, is repeated for use of these
functions.  As such, merging them is a net simplification.

With this, the return value of request_alloc can be changed from
returning a request object to just returning a result code.
---
 drivers/qmimodem/qmi.c | 47 +++++++++++++++--------------------------------
 1 file changed, 15 insertions(+), 32 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index c2962811..c094b0f2 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -159,7 +159,9 @@ void qmi_free(void *ptr)
 	free(ptr);
 }
 =

-static struct qmi_request *__request_alloc(struct qmi_device* device,
+static void wakeup_writer(struct qmi_device *device);
+
+static int __request_alloc(struct qmi_device* device,
 				uint8_t service,
 				uint8_t client, uint16_t message,
 				const void *data,
@@ -214,6 +216,7 @@ static struct qmi_request *__request_alloc(struct qmi_d=
evice* device,
 		hdr->transaction =3D device->next_control_tid++;
 		if (device->next_control_tid =3D=3D 0)
 			device->next_control_tid =3D 1;
+		req->tid =3D hdr->transaction;
 	} else {
 		struct qmi_service_hdr* hdr;
 		hdr =3D req->buf + QMI_MUX_HDR_SIZE;
@@ -221,9 +224,14 @@ static struct qmi_request *__request_alloc(struct qmi_=
device* device,
 		hdr->transaction =3D device->next_service_tid++;
 		if (device->next_service_tid < 256)
 			device->next_service_tid =3D 256;
+		req->tid =3D hdr->transaction;
 	}
 =

-	return req;
+	g_queue_push_tail(device->req_queue, req);
+
+	wakeup_writer(device);
+
+	return 0;
 }
 =

 static void __request_free(gpointer data, gpointer user_data)
@@ -713,16 +721,6 @@ static void wakeup_writer(struct qmi_device *device)
 				can_write_data, device, write_watch_destroy);
 }
 =

-static void __request_submit(struct qmi_device *device,
-				struct qmi_request *req, uint16_t transaction)
-{
-	req->tid =3D transaction;
-
-	g_queue_push_tail(device->req_queue, req);
-
-	wakeup_writer(device);
-}
-
 static void service_notify(gpointer key, gpointer value, gpointer user_dat=
a)
 {
 	struct qmi_service *service =3D value;
@@ -1247,7 +1245,6 @@ bool qmi_device_discover(struct qmi_device *device, q=
mi_discover_func_t func,
 				void *user_data, qmi_destroy_func_t destroy)
 {
 	struct discover_data *data;
-	struct qmi_request *req;
 	struct qmi_control_hdr *hdr;
 =

 	if (!device)
@@ -1271,14 +1268,12 @@ bool qmi_device_discover(struct qmi_device *device,=
 qmi_discover_func_t func,
 		return true;
 	}
 =

-	req =3D __request_alloc(device, QMI_SERVICE_CONTROL, 0x00,
+	__request_alloc(device, QMI_SERVICE_CONTROL, 0x00,
 			QMI_CTL_GET_VERSION_INFO,
 			NULL, 0, discover_callback, data, (void **) &hdr);
 =

 	data->tid =3D hdr->transaction;
 =

-	__request_submit(device, req, hdr->transaction);
-
 	data->timeout =3D g_timeout_add_seconds(5, discover_reply, data);
 	__qmi_device_discovery_started(device, &data->super);
 =

@@ -1290,15 +1285,12 @@ static void release_client(struct qmi_device *devic=
e,
 				qmi_message_func_t func, void *user_data)
 {
 	unsigned char release_req[] =3D { 0x01, 0x02, 0x00, type, client_id };
-	struct qmi_request *req;
 	struct qmi_control_hdr *hdr;
 =

-	req =3D __request_alloc(device, QMI_SERVICE_CONTROL, 0x00,
+	__request_alloc(device, QMI_SERVICE_CONTROL, 0x00,
 			QMI_CTL_RELEASE_CLIENT_ID,
 			release_req, sizeof(release_req),
 			func, user_data, (void **) &hdr);
-
-	__request_submit(device, req, hdr->transaction);
 }
 =

 static void shutdown_destroy(gpointer user_data)
@@ -1375,7 +1367,6 @@ static void qmi_device_sync_callback(uint16_t message=
, uint16_t length,
 bool qmi_device_sync(struct qmi_device *device,
 		     qmi_sync_func_t func, void *user_data)
 {
-	struct qmi_request *req;
 	struct qmi_control_hdr *hdr;
 	struct sync_data *func_data;
 =

@@ -1388,13 +1379,11 @@ bool qmi_device_sync(struct qmi_device *device,
 	func_data->func =3D func;
 	func_data->user_data =3D user_data;
 =

-	req =3D __request_alloc(device, QMI_SERVICE_CONTROL, 0x00,
+	__request_alloc(device, QMI_SERVICE_CONTROL, 0x00,
 			QMI_CTL_SYNC,
 			NULL, 0,
 			qmi_device_sync_callback, func_data, (void **) &hdr);
 =

-	__request_submit(device, req, hdr->transaction);
-
 	return true;
 }
 =

@@ -1993,7 +1982,6 @@ static void service_create_discover(uint8_t count,
 {
 	struct service_create_data *data =3D user_data;
 	struct qmi_device *device =3D data->device;
-	struct qmi_request *req;
 	struct qmi_control_hdr *hdr;
 	unsigned char client_req[] =3D { 0x01, 0x01, 0x00, data->type };
 	unsigned int i;
@@ -2008,12 +1996,10 @@ static void service_create_discover(uint8_t count,
 		}
 	}
 =

-	req =3D __request_alloc(device, QMI_SERVICE_CONTROL, 0x00,
+	__request_alloc(device, QMI_SERVICE_CONTROL, 0x00,
 			QMI_CTL_GET_CLIENT_ID,
 			client_req, sizeof(client_req),
 			service_create_callback, data, (void **) &hdr);
-
-	__request_submit(device, req, hdr->transaction);
 }
 =

 static bool service_create(struct qmi_device *device, bool shared,
@@ -2268,7 +2254,6 @@ uint16_t qmi_service_send(struct qmi_service *service,
 {
 	struct qmi_device *device;
 	struct service_send_data *data;
-	struct qmi_request *req;
 	struct qmi_service_hdr *hdr;
 =

 	if (!service)
@@ -2289,7 +2274,7 @@ uint16_t qmi_service_send(struct qmi_service *service,
 	data->user_data =3D user_data;
 	data->destroy =3D destroy;
 =

-	req =3D __request_alloc(device, service->type, service->client_id,
+	__request_alloc(device, service->type, service->client_id,
 				message,
 				param ? param->data : NULL,
 				param ? param->length : 0,
@@ -2297,8 +2282,6 @@ uint16_t qmi_service_send(struct qmi_service *service,
 =

 	qmi_param_free(param);
 =

-	__request_submit(device, req, hdr->transaction);
-
 	return hdr->transaction;
 }
 =

-- =

2.15.1


--===============2963538512170465475==--

