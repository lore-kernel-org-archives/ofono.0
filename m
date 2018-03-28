Content-Type: multipart/mixed; boundary="===============2745836678385566413=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC PATCH 14/30] qmi: absorb service_create_discover into
 service_create
Date: Wed, 28 Mar 2018 21:00:00 +0200
Message-ID: <20180328190016.28509-15-jonas@southpole.se>
In-Reply-To: <20180328190016.28509-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2745836678385566413==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/qmimodem/qmi.c | 42 ++++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 3eb9e8c3..5af35a23 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1974,35 +1974,13 @@ done:
 	__qmi_device_discovery_complete(data->device, &data->super);
 }
 =

-static void service_create_discover(uint8_t count,
-			const struct qmi_version *list, void *user_data)
-{
-	struct service_create_data *data =3D user_data;
-	struct qmi_device *device =3D data->device;
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
-	__request_submit(device, QMI_SERVICE_CONTROL, 0x00,
-			QMI_CTL_GET_CLIENT_ID,
-			client_req, sizeof(client_req),
-			service_create_callback, data);
-}
-
 static bool service_create(struct qmi_device *device, bool shared,
 				uint8_t type, qmi_create_func_t func,
 				void *user_data, qmi_destroy_func_t destroy)
 {
 	struct service_create_data *data;
+	unsigned char client_req[] =3D { 0x01, 0x01, 0x00, type };
+	int i;
 =

 	data =3D g_try_new0(struct service_create_data, 1);
 	if (!data)
@@ -2016,8 +1994,20 @@ static bool service_create(struct qmi_device *device=
, bool shared,
 	data->user_data =3D user_data;
 	data->destroy =3D destroy;
 =

-	service_create_discover(device->version_count,
-					device->version_list, data);
+	__debug_device(device, "service create [type=3D%d]", type);
+
+	for (i =3D 0; i < device->version_count; i++) {
+		if (device->version_list[i].type =3D=3D data->type) {
+			data->major =3D device->version_list[i].major;
+			data->minor =3D device->version_list[i].minor;
+			break;
+		}
+	}
+
+	__request_submit(device, QMI_SERVICE_CONTROL, 0x00,
+			QMI_CTL_GET_CLIENT_ID,
+			client_req, sizeof(client_req),
+			service_create_callback, data);
 =

 	data->timeout =3D g_timeout_add_seconds(8, service_create_reply, data);
 	__qmi_device_discovery_started(device, &data->super);
-- =

2.15.1


--===============2745836678385566413==--

