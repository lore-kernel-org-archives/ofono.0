Content-Type: multipart/mixed; boundary="===============8519794278724403462=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 08/12] qmi: return request TID for __request_submit
Date: Thu, 29 Mar 2018 15:57:57 +0200
Message-ID: <20180329135801.5981-9-jonas@southpole.se>
In-Reply-To: <20180329135801.5981-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8519794278724403462==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The only thing the __request_submit hdr parameter is being used for now
is for getting the request's TID.  Let __request_parameter just return
the TID so that we can drop the hdr parameter altogether.
---
 drivers/qmimodem/qmi.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 670f4c94..c6e6df7c 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -161,12 +161,12 @@ void qmi_free(void *ptr)
 =

 static void wakeup_writer(struct qmi_device *device);
 =

-static int __request_submit(struct qmi_device* device,
+static uint16_t __request_submit(struct qmi_device* device,
 				uint8_t service,
 				uint8_t client, uint16_t message,
 				const void *data,
 				uint16_t length, qmi_message_func_t func,
-				void *user_data, void **head)
+				void *user_data)
 {
 	struct qmi_request *req;
 	struct qmi_mux_hdr *hdr;
@@ -206,8 +206,6 @@ static int __request_submit(struct qmi_device* device,
 	req->callback =3D func;
 	req->user_data =3D user_data;
 =

-	*head =3D req->buf + QMI_MUX_HDR_SIZE;
-
 	if (service =3D=3D QMI_SERVICE_CONTROL) {
 		struct qmi_control_hdr* hdr;
 =

@@ -231,7 +229,7 @@ static int __request_submit(struct qmi_device* device,
 =

 	wakeup_writer(device);
 =

-	return 0;
+	return req->tid;
 }
 =

 static void __request_free(gpointer data, gpointer user_data)
@@ -1245,7 +1243,6 @@ bool qmi_device_discover(struct qmi_device *device, q=
mi_discover_func_t func,
 				void *user_data, qmi_destroy_func_t destroy)
 {
 	struct discover_data *data;
-	struct qmi_control_hdr *hdr;
 =

 	if (!device)
 		return false;
@@ -1270,7 +1267,7 @@ bool qmi_device_discover(struct qmi_device *device, q=
mi_discover_func_t func,
 =

 	__request_submit(device, QMI_SERVICE_CONTROL, 0x00,
 			QMI_CTL_GET_VERSION_INFO,
-			NULL, 0, discover_callback, data, (void **) &hdr);
+			NULL, 0, discover_callback, data);
 =

 	data->tid =3D device->next_control_tid - 1;
 	if (data->tid =3D=3D 0)
@@ -1287,12 +1284,11 @@ static void release_client(struct qmi_device *devic=
e,
 				qmi_message_func_t func, void *user_data)
 {
 	unsigned char release_req[] =3D { 0x01, 0x02, 0x00, type, client_id };
-	struct qmi_control_hdr *hdr;
 =

 	__request_submit(device, QMI_SERVICE_CONTROL, 0x00,
 			QMI_CTL_RELEASE_CLIENT_ID,
 			release_req, sizeof(release_req),
-			func, user_data, (void **) &hdr);
+			func, user_data);
 }
 =

 static void shutdown_destroy(gpointer user_data)
@@ -1369,7 +1365,6 @@ static void qmi_device_sync_callback(uint16_t message=
, uint16_t length,
 bool qmi_device_sync(struct qmi_device *device,
 		     qmi_sync_func_t func, void *user_data)
 {
-	struct qmi_control_hdr *hdr;
 	struct sync_data *func_data;
 =

 	if (!device)
@@ -1384,7 +1379,7 @@ bool qmi_device_sync(struct qmi_device *device,
 	__request_submit(device, QMI_SERVICE_CONTROL, 0x00,
 			QMI_CTL_SYNC,
 			NULL, 0,
-			qmi_device_sync_callback, func_data, (void **) &hdr);
+			qmi_device_sync_callback, func_data);
 =

 	return true;
 }
@@ -1984,7 +1979,6 @@ static void service_create_discover(uint8_t count,
 {
 	struct service_create_data *data =3D user_data;
 	struct qmi_device *device =3D data->device;
-	struct qmi_control_hdr *hdr;
 	unsigned char client_req[] =3D { 0x01, 0x01, 0x00, data->type };
 	unsigned int i;
 =

@@ -2001,7 +1995,7 @@ static void service_create_discover(uint8_t count,
 	__request_submit(device, QMI_SERVICE_CONTROL, 0x00,
 			QMI_CTL_GET_CLIENT_ID,
 			client_req, sizeof(client_req),
-			service_create_callback, data, (void **) &hdr);
+			service_create_callback, data);
 }
 =

 static bool service_create(struct qmi_device *device, bool shared,
@@ -2256,7 +2250,7 @@ uint16_t qmi_service_send(struct qmi_service *service,
 {
 	struct qmi_device *device;
 	struct service_send_data *data;
-	struct qmi_service_hdr *hdr;
+	uint16_t tid;
 =

 	if (!service)
 		return 0;
@@ -2276,15 +2270,15 @@ uint16_t qmi_service_send(struct qmi_service *servi=
ce,
 	data->user_data =3D user_data;
 	data->destroy =3D destroy;
 =

-	__request_submit(device, service->type, service->client_id,
+	tid =3D __request_submit(device, service->type, service->client_id,
 				message,
 				param ? param->data : NULL,
 				param ? param->length : 0,
-				service_send_callback, data, (void **) &hdr);
+				service_send_callback, data);
 =

 	qmi_param_free(param);
 =

-	return hdr->transaction;
+	return tid;
 }
 =

 bool qmi_service_cancel(struct qmi_service *service, uint16_t id)
-- =

2.15.1


--===============8519794278724403462==--

