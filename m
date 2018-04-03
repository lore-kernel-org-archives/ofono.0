Content-Type: multipart/mixed; boundary="===============1413070164490453990=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 4/6] qmi: assume version_list is up to date
Date: Tue, 03 Apr 2018 16:50:54 +0200
Message-ID: <20180403145056.25817-4-jonas@southpole.se>
In-Reply-To: <20180403145056.25817-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1413070164490453990==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The way things are currently coded, the gobi plugin calls
qmi_device_discover and does nothing else until it succeeds.  As such,
we can safely assume that the version_list is set up when we go to
create a service.
---
 drivers/qmimodem/qmi.c | 56 +++++++++++++++++-----------------------------=
----
 1 file changed, 19 insertions(+), 37 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 08d437c1..750f3b00 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1989,43 +1989,22 @@ done:
 	__qmi_device_discovery_complete(data->device, &data->super);
 }
 =

-static void service_create_discover(uint8_t count,
-			const struct qmi_version *list, void *user_data)
-{
-	struct service_create_data *data =3D user_data;
-	struct qmi_device *device =3D data->device;
-	struct qmi_request *req;
-	unsigned char client_req[] =3D { 0x01, 0x01, 0x00, data->type };
-	unsigned int i;
-
-	__debug_device(device, "service create [type=3D%d]", data->type);
-
-	for (i =3D 0; i < count; i++) {
-		if (list[i].type =3D=3D data->type) {
-			data->major =3D list[i].major;
-			data->minor =3D list[i].minor;
-			break;
-		}
-	}
-
-	req =3D __request_alloc(QMI_SERVICE_CONTROL, 0x00,
-			QMI_CTL_GET_CLIENT_ID,
-			client_req, sizeof(client_req),
-			service_create_callback, data);
-
-	__request_submit(device, req);
-}
-
 static bool service_create(struct qmi_device *device, bool shared,
 				uint8_t type, qmi_create_func_t func,
 				void *user_data, qmi_destroy_func_t destroy)
 {
 	struct service_create_data *data;
+	unsigned char client_req[] =3D { 0x01, 0x01, 0x00, type };
+	struct qmi_request *req;
+	int i;
 =

 	data =3D g_try_new0(struct service_create_data, 1);
 	if (!data)
 		return false;
 =

+	if (!device->version_list)
+		return false;
+
 	data->super.destroy =3D service_create_data_free;
 	data->device =3D device;
 	data->shared =3D shared;
@@ -2034,20 +2013,23 @@ static bool service_create(struct qmi_device *devic=
e, bool shared,
 	data->user_data =3D user_data;
 	data->destroy =3D destroy;
 =

-	if (device->version_list) {
-		service_create_discover(device->version_count,
-						device->version_list, data);
-		goto done;
-	}
+	__debug_device(device, "service create [type=3D%d]", type);
 =

-	if (qmi_device_discover(device, service_create_discover, data, NULL))
-		goto done;
+	for (i =3D 0; i < device->version_count; i++) {
+		if (device->version_list[i].type =3D=3D data->type) {
+			data->major =3D device->version_list[i].major;
+			data->minor =3D device->version_list[i].minor;
+			break;
+		}
+	}
 =

-	g_free(data);
+	req =3D __request_alloc(QMI_SERVICE_CONTROL, 0x00,
+			QMI_CTL_GET_CLIENT_ID,
+			client_req, sizeof(client_req),
+			service_create_callback, data);
 =

-	return false;
+	__request_submit(device, req);
 =

-done:
 	data->timeout =3D g_timeout_add_seconds(8, service_create_reply, data);
 	__qmi_device_discovery_started(device, &data->super);
 =

-- =

2.15.1


--===============1413070164490453990==--

