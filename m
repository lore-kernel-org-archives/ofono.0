Content-Type: multipart/mixed; boundary="===============7973398660304884959=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 06/12] qmi: rename request_alloc to request_submit
Date: Thu, 29 Mar 2018 15:57:55 +0200
Message-ID: <20180329135801.5981-7-jonas@southpole.se>
In-Reply-To: <20180329135801.5981-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7973398660304884959==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Submission of the request is the fundamental operation; allocation is
just a detail.
---
 drivers/qmimodem/qmi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index c094b0f2..19a4b0ff 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -161,7 +161,7 @@ void qmi_free(void *ptr)
 =

 static void wakeup_writer(struct qmi_device *device);
 =

-static int __request_alloc(struct qmi_device* device,
+static int __request_submit(struct qmi_device* device,
 				uint8_t service,
 				uint8_t client, uint16_t message,
 				const void *data,
@@ -1268,7 +1268,7 @@ bool qmi_device_discover(struct qmi_device *device, q=
mi_discover_func_t func,
 		return true;
 	}
 =

-	__request_alloc(device, QMI_SERVICE_CONTROL, 0x00,
+	__request_submit(device, QMI_SERVICE_CONTROL, 0x00,
 			QMI_CTL_GET_VERSION_INFO,
 			NULL, 0, discover_callback, data, (void **) &hdr);
 =

@@ -1287,7 +1287,7 @@ static void release_client(struct qmi_device *device,
 	unsigned char release_req[] =3D { 0x01, 0x02, 0x00, type, client_id };
 	struct qmi_control_hdr *hdr;
 =

-	__request_alloc(device, QMI_SERVICE_CONTROL, 0x00,
+	__request_submit(device, QMI_SERVICE_CONTROL, 0x00,
 			QMI_CTL_RELEASE_CLIENT_ID,
 			release_req, sizeof(release_req),
 			func, user_data, (void **) &hdr);
@@ -1379,7 +1379,7 @@ bool qmi_device_sync(struct qmi_device *device,
 	func_data->func =3D func;
 	func_data->user_data =3D user_data;
 =

-	__request_alloc(device, QMI_SERVICE_CONTROL, 0x00,
+	__request_submit(device, QMI_SERVICE_CONTROL, 0x00,
 			QMI_CTL_SYNC,
 			NULL, 0,
 			qmi_device_sync_callback, func_data, (void **) &hdr);
@@ -1996,7 +1996,7 @@ static void service_create_discover(uint8_t count,
 		}
 	}
 =

-	__request_alloc(device, QMI_SERVICE_CONTROL, 0x00,
+	__request_submit(device, QMI_SERVICE_CONTROL, 0x00,
 			QMI_CTL_GET_CLIENT_ID,
 			client_req, sizeof(client_req),
 			service_create_callback, data, (void **) &hdr);
@@ -2274,7 +2274,7 @@ uint16_t qmi_service_send(struct qmi_service *service,
 	data->user_data =3D user_data;
 	data->destroy =3D destroy;
 =

-	__request_alloc(device, service->type, service->client_id,
+	__request_submit(device, service->type, service->client_id,
 				message,
 				param ? param->data : NULL,
 				param ? param->length : 0,
-- =

2.15.1


--===============7973398660304884959==--

