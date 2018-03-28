Content-Type: multipart/mixed; boundary="===============6204063012927346440=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC PATCH 29/30] qmi: pass service directly to request_submit
Date: Wed, 28 Mar 2018 21:00:15 +0200
Message-ID: <20180328190016.28509-30-jonas@southpole.se>
In-Reply-To: <20180328190016.28509-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6204063012927346440==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For CTL requests, pass NULL instead.
---
 drivers/qmimodem/qmi.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 8c1696bf..2286f703 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -187,8 +187,8 @@ void qmi_free(void *ptr)
 static void wakeup_writer(struct qmi_device *device);
 =

 static int __request_submit(struct qmi_device* device,
-				uint8_t service,
-				uint8_t client, uint16_t message,
+				struct qmi_service *service,
+				uint16_t message,
 				const void *data,
 				uint16_t length, qmi_message_func_t func,
 				void *user_data)
@@ -197,28 +197,35 @@ static int __request_submit(struct qmi_device* device,
 	struct qmi_mux_hdr *hdr;
 	struct qmi_message_hdr *msg;
 	uint16_t headroom;
+	uint8_t type;
+	uint8_t client_id;
+
+	if (service) {
+		type =3D service->info->type;
+		client_id =3D service->info->client_id;
+		headroom =3D QMI_SERVICE_HDR_SIZE;
+	} else {
+		type =3D QMI_SERVICE_CONTROL;
+		client_id =3D 0;
+		headroom =3D QMI_CONTROL_HDR_SIZE;
+	}
 =

 	req =3D calloc(1, sizeof(*req));
 	INIT_LIST_HEAD(&req->node);
 =

-	if (service =3D=3D QMI_SERVICE_CONTROL)
-		headroom =3D QMI_CONTROL_HDR_SIZE;
-	else
-		headroom =3D QMI_SERVICE_HDR_SIZE;
-
 	req->len =3D QMI_MUX_HDR_SIZE + headroom + QMI_MESSAGE_HDR_SIZE + length;
 =

 	req->buf =3D malloc(req->len);
 =

-	req->client =3D client;
+	req->client =3D client_id;
 =

 	hdr =3D req->buf;
 =

 	hdr->frame =3D 0x01;
 	hdr->length =3D htole16(req->len - 1);
 	hdr->flags =3D 0x00;
-	hdr->service =3D service;
-	hdr->client =3D client;
+	hdr->service =3D type;
+	hdr->client =3D client_id;
 =

 	msg =3D req->buf + QMI_MUX_HDR_SIZE + headroom;
 =

@@ -232,7 +239,8 @@ static int __request_submit(struct qmi_device* device,
 	req->callback =3D func;
 	req->user_data =3D user_data;
 =

-	if (service =3D=3D QMI_SERVICE_CONTROL) {
+	if (!service) {
+		/* CTL service */
 		struct qmi_control_hdr* hdr;
 =

 		hdr =3D req->buf + QMI_MUX_HDR_SIZE;
@@ -1263,7 +1271,7 @@ bool qmi_device_discover(struct qmi_device *device, q=
mi_discover_func_t func,
 		return true;
 	}
 =

-	__request_submit(device, QMI_SERVICE_CONTROL, 0x00,
+	__request_submit(device, NULL,
 			QMI_CTL_GET_VERSION_INFO,
 			NULL, 0, discover_callback, data);
 =

@@ -1276,7 +1284,7 @@ static void release_client(struct qmi_device *device,
 {
 	unsigned char release_req[] =3D { 0x01, 0x02, 0x00, type, client_id };
 =

-	__request_submit(device, QMI_SERVICE_CONTROL, 0x00,
+	__request_submit(device, NULL,
 			QMI_CTL_RELEASE_CLIENT_ID,
 			release_req, sizeof(release_req),
 			func, user_data);
@@ -1367,7 +1375,7 @@ bool qmi_device_sync(struct qmi_device *device,
 	func_data->func =3D func;
 	func_data->user_data =3D user_data;
 =

-	__request_submit(device, QMI_SERVICE_CONTROL, 0x00,
+	__request_submit(device, NULL,
 			QMI_CTL_SYNC,
 			NULL, 0,
 			qmi_device_sync_callback, func_data);
@@ -1967,7 +1975,7 @@ static bool service_connect(struct service_connect_da=
ta *data)
 =

 	__debug_device(info->device, "service create [type=3D%d]", info->type);
 =

-	__request_submit(info->device, QMI_SERVICE_CONTROL, 0x00,
+	__request_submit(info->device, NULL,
 			QMI_CTL_GET_CLIENT_ID,
 			client_req, sizeof(client_req),
 			service_connect_callback, info);
@@ -2169,8 +2177,8 @@ uint16_t qmi_service_send(struct qmi_service *service,
 	data->user_data =3D user_data;
 	data->destroy =3D destroy;
 =

-	r =3D __request_submit(device, service->info->type,
-				service->info->client_id,
+	r =3D __request_submit(device,
+				service,
 				message,
 				param ? param->data : NULL,
 				param ? param->length : 0,
-- =

2.15.1


--===============6204063012927346440==--

