Content-Type: multipart/mixed; boundary="===============1347665406826196692=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC PATCH 02/30] qmi: remove headroom parameter from req_alloc
Date: Wed, 28 Mar 2018 20:59:48 +0200
Message-ID: <20180328190016.28509-3-jonas@southpole.se>
In-Reply-To: <20180328190016.28509-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1347665406826196692==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The headroom can be established from the service type, so it's redundant
to pass it as a parameter.
---
 drivers/qmimodem/qmi.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 56a87224..4a3929ba 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -161,18 +161,24 @@ void qmi_free(void *ptr)
 =

 static struct qmi_request *__request_alloc(uint8_t service,
 				uint8_t client, uint16_t message,
-				uint16_t headroom, const void *data,
+				const void *data,
 				uint16_t length, qmi_message_func_t func,
 				void *user_data, void **head)
 {
 	struct qmi_request *req;
 	struct qmi_mux_hdr *hdr;
 	struct qmi_message_hdr *msg;
+	uint16_t headroom;
 =

 	req =3D g_try_new0(struct qmi_request, 1);
 	if (!req)
 		return NULL;
 =

+	if (service =3D=3D QMI_SERVICE_CONTROL)
+		headroom =3D QMI_CONTROL_HDR_SIZE;
+	else
+		headroom =3D QMI_SERVICE_HDR_SIZE;
+
 	req->len =3D QMI_MUX_HDR_SIZE + headroom + QMI_MESSAGE_HDR_SIZE + length;
 =

 	req->buf =3D g_try_malloc(req->len);
@@ -1251,7 +1257,7 @@ bool qmi_device_discover(struct qmi_device *device, q=
mi_discover_func_t func,
 	}
 =

 	req =3D __request_alloc(QMI_SERVICE_CONTROL, 0x00,
-			QMI_CTL_GET_VERSION_INFO, QMI_CONTROL_HDR_SIZE,
+			QMI_CTL_GET_VERSION_INFO,
 			NULL, 0, discover_callback, data, (void **) &hdr);
 	if (!req) {
 		g_free(data);
@@ -1282,7 +1288,7 @@ static void release_client(struct qmi_device *device,
 	struct qmi_control_hdr *hdr;
 =

 	req =3D __request_alloc(QMI_SERVICE_CONTROL, 0x00,
-			QMI_CTL_RELEASE_CLIENT_ID, QMI_CONTROL_HDR_SIZE,
+			QMI_CTL_RELEASE_CLIENT_ID,
 			release_req, sizeof(release_req),
 			func, user_data, (void **) &hdr);
 	if (!req) {
@@ -1387,7 +1393,7 @@ bool qmi_device_sync(struct qmi_device *device,
 	func_data->user_data =3D user_data;
 =

 	req =3D __request_alloc(QMI_SERVICE_CONTROL, 0x00,
-			QMI_CTL_SYNC, QMI_CONTROL_HDR_SIZE,
+			QMI_CTL_SYNC,
 			NULL, 0,
 			qmi_device_sync_callback, func_data, (void **) &hdr);
 =

@@ -2013,7 +2019,7 @@ static void service_create_discover(uint8_t count,
 	}
 =

 	req =3D __request_alloc(QMI_SERVICE_CONTROL, 0x00,
-			QMI_CTL_GET_CLIENT_ID, QMI_CONTROL_HDR_SIZE,
+			QMI_CTL_GET_CLIENT_ID,
 			client_req, sizeof(client_req),
 			service_create_callback, data, (void **) &hdr);
 	if (!req) {
@@ -2309,7 +2315,7 @@ uint16_t qmi_service_send(struct qmi_service *service,
 	data->destroy =3D destroy;
 =

 	req =3D __request_alloc(service->type, service->client_id,
-				message, QMI_SERVICE_HDR_SIZE,
+				message,
 				param ? param->data : NULL,
 				param ? param->length : 0,
 				service_send_callback, data, (void **) &hdr);
-- =

2.15.1


--===============1347665406826196692==--

