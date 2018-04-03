Content-Type: multipart/mixed; boundary="===============6960861682872010305=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 1/6] qmi: unify common request header setup
Date: Tue, 03 Apr 2018 16:50:51 +0200
Message-ID: <20180403145056.25817-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6960861682872010305==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The service and control requests differ slightly in their headers, but
this difference is minor enough that we can handle it directly in the
request submission routine.  This patch unifies the header setup for the
two request types.
---
 drivers/qmimodem/qmi.c | 68 +++++++++++++++++++++++-----------------------=
----
 1 file changed, 31 insertions(+), 37 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index b60e0c0b..436f96a0 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -701,10 +701,30 @@ static void wakeup_writer(struct qmi_device *device)
 				can_write_data, device, write_watch_destroy);
 }
 =

-static void __request_submit(struct qmi_device *device,
-				struct qmi_request *req, uint16_t transaction)
+static void __request_submit(struct qmi_device *device, struct qmi_request=
 *req)
 {
-	req->tid =3D transaction;
+	struct qmi_mux_hdr *mux;
+
+	mux =3D req->buf;
+
+	if (mux->service =3D=3D QMI_SERVICE_CONTROL) {
+		struct qmi_control_hdr* hdr;
+
+		hdr =3D req->buf + QMI_MUX_HDR_SIZE;
+		hdr->type =3D 0x00;
+		hdr->transaction =3D device->next_control_tid++;
+		if (device->next_control_tid =3D=3D 0)
+			device->next_control_tid =3D 1;
+		req->tid =3D hdr->transaction;
+	} else {
+		struct qmi_service_hdr* hdr;
+		hdr =3D req->buf + QMI_MUX_HDR_SIZE;
+		hdr->type =3D 0x00;
+		hdr->transaction =3D device->next_service_tid++;
+		if (device->next_service_tid < 256)
+			device->next_service_tid =3D 256;
+		req->tid =3D hdr->transaction;
+	}
 =

 	g_queue_push_tail(device->req_queue, req);
 =

@@ -967,6 +987,9 @@ struct qmi_device *qmi_device_new(int fd)
 	device->service_list =3D g_hash_table_new_full(g_direct_hash,
 					g_direct_equal, NULL, service_destroy);
 =

+	device->next_control_tid =3D 1;
+	device->next_service_tid =3D 256;
+
 	return device;
 }
 =

@@ -1264,14 +1287,9 @@ bool qmi_device_discover(struct qmi_device *device, =
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

-	__request_submit(device, req, hdr->transaction);
+	__request_submit(device, req);
 =

 	data->timeout =3D g_timeout_add_seconds(5, discover_reply, data);
 	__qmi_device_discovery_started(device, &data->super);
@@ -1296,13 +1314,7 @@ static void release_client(struct qmi_device *device,
 		return;
 	}
 =

-	if (device->next_control_tid < 1)
-		device->next_control_tid =3D 1;
-
-	hdr->type =3D 0x00;
-	hdr->transaction =3D device->next_control_tid++;
-
-	__request_submit(device, req, hdr->transaction);
+	__request_submit(device, req);
 }
 =

 static void shutdown_destroy(gpointer user_data)
@@ -1397,13 +1409,7 @@ bool qmi_device_sync(struct qmi_device *device,
 			NULL, 0,
 			qmi_device_sync_callback, func_data, (void **) &hdr);
 =

-	if (device->next_control_tid < 1)
-		device->next_control_tid =3D 1;
-
-	hdr->type =3D 0x00;
-	hdr->transaction =3D device->next_control_tid++;
-
-	__request_submit(device, req, hdr->transaction);
+	__request_submit(device, req);
 =

 	return true;
 }
@@ -2032,13 +2038,7 @@ static void service_create_discover(uint8_t count,
 		return;
 	}
 =

-	if (device->next_control_tid < 1)
-		device->next_control_tid =3D 1;
-
-	hdr->type =3D 0x00;
-	hdr->transaction =3D device->next_control_tid++;
-
-	__request_submit(device, req, hdr->transaction);
+	__request_submit(device, req);
 }
 =

 static bool service_create(struct qmi_device *device, bool shared,
@@ -2327,13 +2327,7 @@ uint16_t qmi_service_send(struct qmi_service *servic=
e,
 =

 	qmi_param_free(param);
 =

-	if (device->next_service_tid < 256)
-		device->next_service_tid =3D 256;
-
-	hdr->type =3D 0x00;
-	hdr->transaction =3D device->next_service_tid++;
-
-	__request_submit(device, req, hdr->transaction);
+	__request_submit(device, req);
 =

 	return hdr->transaction;
 }
-- =

2.15.1


--===============6960861682872010305==--

