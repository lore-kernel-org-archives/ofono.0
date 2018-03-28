Content-Type: multipart/mixed; boundary="===============7002844726037787094=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC PATCH 20/30] qmi: reference version_info from device in services
Date: Wed, 28 Mar 2018 21:00:06 +0200
Message-ID: <20180328190016.28509-21-jonas@southpole.se>
In-Reply-To: <20180328190016.28509-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7002844726037787094==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The device struct already maintains version information, so let the
service instances reference that data directly instead of copying it.
---
 drivers/qmimodem/qmi.c | 44 +++++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index a65a4bf4..43c54482 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -78,9 +78,7 @@ struct qmi_service {
 	struct list_head node;
 	int ref_count;
 	struct qmi_device *device;
-	uint8_t type;
-	uint16_t major;
-	uint16_t minor;
+	struct qmi_version *info;
 	uint8_t client_id;
 	struct list_head notify_list;
 };
@@ -710,7 +708,7 @@ static void handle_indication(struct qmi_device *device,
 	result.length =3D length;
 =

 	list_for_each_entry(service, &device->service_list, node) {
-		if (client_id =3D=3D 0xff || service_type =3D=3D service->type)
+		if (client_id =3D=3D 0xff || service_type =3D=3D service->info->type)
 			service_notify(service, &result);
 	}
 }
@@ -1783,7 +1781,7 @@ static struct qmi_service* device_get_service(struct =
qmi_device* device,
 	struct qmi_service* service;
 =

 	list_for_each_entry(service, &device->service_list, node) {
-		if (service->type =3D=3D type)
+		if (service->info->type =3D=3D type)
 			return service;
 	}
 =

@@ -1793,8 +1791,6 @@ static struct qmi_service* device_get_service(struct =
qmi_device* device,
 struct service_create_data {
 	struct qmi_device *device;
 	uint8_t type;
-	uint16_t major;
-	uint16_t minor;
 	qmi_create_func_t func;
 	void *user_data;
 	qmi_destroy_func_t destroy;
@@ -1824,7 +1820,9 @@ static void service_create_callback(uint16_t message,=
 uint16_t length,
 	struct qmi_service *service =3D NULL;
 	const struct qmi_result_code *result_code;
 	const struct qmi_client_id *client_id;
+	struct qmi_version* info;
 	uint16_t len;
+	int i;
 =

 	result_code =3D tlv_get(buffer, length, 0x02, &len);
 	if (!result_code)
@@ -1852,14 +1850,19 @@ static void service_create_callback(uint16_t messag=
e, uint16_t length,
 	service->ref_count =3D 1;
 	service->device =3D data->device;
 =

-	service->type =3D data->type;
-	service->major =3D data->major;
-	service->minor =3D data->minor;
+	for (i =3D 0, info =3D device->version_list;
+			i < device->version_count;
+			i++, info++) {
+		if (info->type =3D=3D data->type) {
+			service->info =3D info;
+			break;
+		}
+	}
 =

 	service->client_id =3D client_id->client;
 =

 	__debug_device(device, "service created [client=3D%d,type=3D%d]",
-					service->client_id, service->type);
+					service->client_id, service->info->type);
 =

 	/* FIXME: maybe sort these by type...??? */
 	list_add_tail(&service->node, &device->service_list);
@@ -1877,7 +1880,6 @@ static bool service_create(struct qmi_device *device,
 {
 	struct service_create_data *data;
 	unsigned char client_req[] =3D { 0x01, 0x01, 0x00, type };
-	int i;
 =

 	data =3D g_try_new0(struct service_create_data, 1);
 	if (!data)
@@ -1891,14 +1893,6 @@ static bool service_create(struct qmi_device *device,
 =

 	__debug_device(device, "service create [type=3D%d]", type);
 =

-	for (i =3D 0; i < device->version_count; i++) {
-		if (device->version_list[i].type =3D=3D data->type) {
-			data->major =3D device->version_list[i].major;
-			data->minor =3D device->version_list[i].minor;
-			break;
-		}
-	}
-
 	__request_submit(device, QMI_SERVICE_CONTROL, 0x00,
 			QMI_CTL_GET_CLIENT_ID,
 			client_req, sizeof(client_req),
@@ -2028,7 +2022,7 @@ void qmi_service_unref(struct qmi_service *service)
 =

 	service->device->release_users++;
 =

-	release_client(service->device, service->type, service->client_id,
+	release_client(service->device, service->info->type, service->client_id,
 					service_release_callback, service);
 }
 =

@@ -2037,7 +2031,7 @@ const char *qmi_service_get_identifier(struct qmi_ser=
vice *service)
 	if (!service)
 		return NULL;
 =

-	return __service_type_to_string(service->type);
+	return __service_type_to_string(service->info->type);
 }
 =

 bool qmi_service_get_version(struct qmi_service *service,
@@ -2047,10 +2041,10 @@ bool qmi_service_get_version(struct qmi_service *se=
rvice,
 		return false;
 =

 	if (major)
-		*major =3D service->major;
+		*major =3D service->info->major;
 =

 	if (minor)
-		*minor =3D service->minor;
+		*minor =3D service->info->minor;
 =

 	return true;
 }
@@ -2125,7 +2119,7 @@ uint16_t qmi_service_send(struct qmi_service *service,
 	data->user_data =3D user_data;
 	data->destroy =3D destroy;
 =

-	r =3D __request_submit(device, service->type, service->client_id,
+	r =3D __request_submit(device, service->info->type, service->client_id,
 				message,
 				param ? param->data : NULL,
 				param ? param->length : 0,
-- =

2.15.1


--===============7002844726037787094==--

