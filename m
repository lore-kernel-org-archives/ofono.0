Content-Type: multipart/mixed; boundary="===============6583831071196749891=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC PATCH 03/30] qmi: unify common request header setup
Date: Wed, 28 Mar 2018 20:59:49 +0200
Message-ID: <20180328190016.28509-4-jonas@southpole.se>
In-Reply-To: <20180328190016.28509-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6583831071196749891==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The service and control requests differ slightly in their headers, but
this difference is minor enough that we can handle it in a common
request allocation routine.  This patch unifies the header setup for the
two request types.
---
 drivers/qmimodem/qmi.c | 62 ++++++++++++++++++++++------------------------=
----
 1 file changed, 27 insertions(+), 35 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 4a3929ba..0c95dd18 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -159,7 +159,8 @@ void qmi_free(void *ptr)
 	free(ptr);
 }
 =

-static struct qmi_request *__request_alloc(uint8_t service,
+static struct qmi_request *__request_alloc(struct qmi_device* device,
+				uint8_t service,
 				uint8_t client, uint16_t message,
 				const void *data,
 				uint16_t length, qmi_message_func_t func,
@@ -211,6 +212,23 @@ static struct qmi_request *__request_alloc(uint8_t ser=
vice,
 =

 	*head =3D req->buf + QMI_MUX_HDR_SIZE;
 =

+	if (service =3D=3D QMI_SERVICE_CONTROL) {
+		struct qmi_control_hdr* hdr;
+
+		hdr =3D req->buf + QMI_MUX_HDR_SIZE;
+		hdr->type =3D 0x00;
+		hdr->transaction =3D device->next_control_tid++;
+		if (device->next_control_tid =3D=3D 0)
+			device->next_control_tid =3D 1;
+	} else {
+		struct qmi_service_hdr* hdr;
+		hdr =3D req->buf + QMI_MUX_HDR_SIZE;
+		hdr->type =3D 0x00;
+		hdr->transaction =3D device->next_service_tid++;
+		if (device->next_service_tid < 256)
+			device->next_service_tid =3D 256;
+	}
+
 	return req;
 }
 =

@@ -967,6 +985,9 @@ struct qmi_device *qmi_device_new(int fd)
 	device->service_list =3D g_hash_table_new_full(g_direct_hash,
 					g_direct_equal, NULL, service_destroy);
 =

+	device->next_control_tid =3D 1;
+	device->next_service_tid =3D 256;
+
 	return device;
 }
 =

@@ -1256,7 +1277,7 @@ bool qmi_device_discover(struct qmi_device *device, q=
mi_discover_func_t func,
 		return true;
 	}
 =

-	req =3D __request_alloc(QMI_SERVICE_CONTROL, 0x00,
+	req =3D __request_alloc(device, QMI_SERVICE_CONTROL, 0x00,
 			QMI_CTL_GET_VERSION_INFO,
 			NULL, 0, discover_callback, data, (void **) &hdr);
 	if (!req) {
@@ -1264,11 +1285,6 @@ bool qmi_device_discover(struct qmi_device *device, =
qmi_discover_func_t func,
 		return false;
 	}
 =

-	if (device->next_control_tid < 1)
-		device->next_control_tid =3D 1;
-
-	hdr->type =3D 0x00;
-	hdr->transaction =3D device->next_control_tid++;
 	data->tid =3D hdr->transaction;
 =

 	__request_submit(device, req, hdr->transaction);
@@ -1287,7 +1303,7 @@ static void release_client(struct qmi_device *device,
 	struct qmi_request *req;
 	struct qmi_control_hdr *hdr;
 =

-	req =3D __request_alloc(QMI_SERVICE_CONTROL, 0x00,
+	req =3D __request_alloc(device, QMI_SERVICE_CONTROL, 0x00,
 			QMI_CTL_RELEASE_CLIENT_ID,
 			release_req, sizeof(release_req),
 			func, user_data, (void **) &hdr);
@@ -1296,12 +1312,6 @@ static void release_client(struct qmi_device *device,
 		return;
 	}
 =

-	if (device->next_control_tid < 1)
-		device->next_control_tid =3D 1;
-
-	hdr->type =3D 0x00;
-	hdr->transaction =3D device->next_control_tid++;
-
 	__request_submit(device, req, hdr->transaction);
 }
 =

@@ -1392,17 +1402,11 @@ bool qmi_device_sync(struct qmi_device *device,
 	func_data->func =3D func;
 	func_data->user_data =3D user_data;
 =

-	req =3D __request_alloc(QMI_SERVICE_CONTROL, 0x00,
+	req =3D __request_alloc(device, QMI_SERVICE_CONTROL, 0x00,
 			QMI_CTL_SYNC,
 			NULL, 0,
 			qmi_device_sync_callback, func_data, (void **) &hdr);
 =

-	if (device->next_control_tid < 1)
-		device->next_control_tid =3D 1;
-
-	hdr->type =3D 0x00;
-	hdr->transaction =3D device->next_control_tid++;
-
 	__request_submit(device, req, hdr->transaction);
 =

 	return true;
@@ -2018,7 +2022,7 @@ static void service_create_discover(uint8_t count,
 		}
 	}
 =

-	req =3D __request_alloc(QMI_SERVICE_CONTROL, 0x00,
+	req =3D __request_alloc(device, QMI_SERVICE_CONTROL, 0x00,
 			QMI_CTL_GET_CLIENT_ID,
 			client_req, sizeof(client_req),
 			service_create_callback, data, (void **) &hdr);
@@ -2032,12 +2036,6 @@ static void service_create_discover(uint8_t count,
 		return;
 	}
 =

-	if (device->next_control_tid < 1)
-		device->next_control_tid =3D 1;
-
-	hdr->type =3D 0x00;
-	hdr->transaction =3D device->next_control_tid++;
-
 	__request_submit(device, req, hdr->transaction);
 }
 =

@@ -2314,7 +2312,7 @@ uint16_t qmi_service_send(struct qmi_service *service,
 	data->user_data =3D user_data;
 	data->destroy =3D destroy;
 =

-	req =3D __request_alloc(service->type, service->client_id,
+	req =3D __request_alloc(device, service->type, service->client_id,
 				message,
 				param ? param->data : NULL,
 				param ? param->length : 0,
@@ -2327,12 +2325,6 @@ uint16_t qmi_service_send(struct qmi_service *servic=
e,
 		return 0;
 	}
 =

-	if (device->next_service_tid < 256)
-		device->next_service_tid =3D 256;
-
-	hdr->type =3D 0x00;
-	hdr->transaction =3D device->next_service_tid++;
-
 	__request_submit(device, req, hdr->transaction);
 =

 	return hdr->transaction;
-- =

2.15.1


--===============6583831071196749891==--

