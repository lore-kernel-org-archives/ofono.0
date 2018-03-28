Content-Type: multipart/mixed; boundary="===============2074405286836192613=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC PATCH 24/30] qmi: convert version_list to struct list head
Date: Wed, 28 Mar 2018 21:00:10 +0200
Message-ID: <20180328190016.28509-25-jonas@southpole.se>
In-Reply-To: <20180328190016.28509-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2074405286836192613==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

...and rename to service_info.

As we intend to merge services and their info, we prepare by making sure
they share a common list structure and rename version_list to
service_info to make it clear that the struct is now more than just
version information.

Previoulsy, the version_list memory was allocated as a single chunk
whereas this patch allocates the service_info structs one-by-one.  This
shouldn't make any difference as this isn't performance critical in any
way.
---
 drivers/qmimodem/qmi.c | 72 ++++++++++++++++++++--------------------------=
----
 1 file changed, 29 insertions(+), 43 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index b6280c05..fb70861a 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -45,7 +45,8 @@
 typedef void (*qmi_message_func_t)(uint16_t message, uint16_t length,
 					const void *buffer, void *user_data);
 =

-struct qmi_version {
+struct qmi_service_info {
+	struct list_head node;
 	uint8_t type;
 	uint16_t major;
 	uint16_t minor;
@@ -70,8 +71,7 @@ struct qmi_device {
 	uint16_t control_major;
 	uint16_t control_minor;
 	char *version_str;
-	struct qmi_version *version_list;
-	uint8_t version_count;
+	struct list_head service_info;
 	struct list_head service_list;
 	unsigned int release_users;
 	qmi_shutdown_func_t shutdown_func;
@@ -86,7 +86,7 @@ struct qmi_service {
 	struct list_head node;
 	int ref_count;
 	struct qmi_device *device;
-	struct qmi_version *info;
+	struct qmi_service_info *info;
 	struct list_head notify_list;
 };
 =

@@ -891,6 +891,8 @@ struct qmi_device *qmi_device_new(int fd)
 	INIT_LIST_HEAD(&device->control_queue);
 	INIT_LIST_HEAD(&device->service_queue);
 =

+	INIT_LIST_HEAD(&device->service_info);
+
 	INIT_LIST_HEAD(&device->service_list);
 =

 	device->next_control_tid =3D 1;
@@ -913,6 +915,7 @@ void qmi_device_unref(struct qmi_device *device)
 {
 	struct qmi_request *req, *req_t;
 	struct qmi_service *service, *service_t;
+	struct qmi_service_info *info, *info_t;
 =

 	if (!device)
 		return;
@@ -968,7 +971,11 @@ void qmi_device_unref(struct qmi_device *device)
 	}
 =

 	g_free(device->version_str);
-	g_free(device->version_list);
+
+	list_for_each_entry_safe(info, info_t, &device->service_info, node) {
+		list_del(&info->node);
+		free(info);
+	}
 =

 	if (device->shutting_down)
 		device->destroyed =3D true;
@@ -1038,18 +1045,14 @@ static const void *tlv_get(const void *data, uint16=
_t size,
 bool qmi_device_get_service_version(struct qmi_device* device, uint8_t typ=
e,
 					uint16_t *major, uint16_t *minor)
 {
-	struct qmi_version* info;
-	int i;
+	struct qmi_service_info* info;
 =

-	for (i =3D 0, info =3D device->version_list;
-			i < device->version_count;
-			i++, info++) {
+	list_for_each_entry(info, &device->service_info, node)
 		if (info->type =3D=3D type) {
 			*major =3D info->major;
 			*minor =3D info->minor;
 			return true;
 		}
-	}
 =

 	return false;
 }
@@ -1059,16 +1062,11 @@ bool qmi_device_get_service_version(struct qmi_devi=
ce* device, uint8_t type,
  */
 bool qmi_device_has_service(struct qmi_device* device, uint8_t type)
 {
-	struct qmi_version* info;
-	int i;
+	struct qmi_service_info* info;
 =

-	for (i =3D 0, info =3D device->version_list;
-			i < device->version_count;
-			i++, info++) {
-		if (info->type =3D=3D type) {
+	list_for_each_entry(info, &device->service_info, node)
+		if (info->type =3D=3D type)
 			return true;
-		}
-	}
 =

 	return false;
 }
@@ -1105,13 +1103,9 @@ static void discover_callback(uint16_t message, uint=
16_t length,
 	const struct qmi_service_list *service_list;
 	const void *ptr;
 	uint16_t len;
-	struct qmi_version *list;
-	uint8_t count;
+	struct qmi_service_info *info;
 	unsigned int i;
 =

-	count =3D 0;
-	list =3D NULL;
-
 	result_code =3D tlv_get(buffer, length, 0x02, &len);
 	if (!result_code)
 		goto done;
@@ -1126,10 +1120,6 @@ static void discover_callback(uint16_t message, uint=
16_t length,
 	if (len < QMI_SERVICE_LIST_SIZE)
 		goto done;
 =

-	list =3D g_try_malloc(sizeof(struct qmi_version) * service_list->count);
-	if (!list)
-		goto done;
-
 	for (i =3D 0; i < service_list->count; i++) {
 		uint16_t major =3D
 			le16toh(service_list->services[i].major);
@@ -1151,12 +1141,15 @@ static void discover_callback(uint16_t message, uin=
t16_t length,
 			continue;
 		}
 =

-		list[count].type =3D type;
-		list[count].major =3D major;
-		list[count].minor =3D minor;
-		list[count].name =3D name;
+		info =3D calloc(1, sizeof(*info));
+		INIT_LIST_HEAD(&info->node);
 =

-		count++;
+		info->type =3D type;
+		info->major =3D major;
+		info->minor =3D minor;
+		info->name =3D name;
+
+		list_add_tail(&info->node, &device->service_info);
 	}
 =

 	ptr =3D tlv_get(buffer, length, 0x10, &len);
@@ -1166,9 +1159,6 @@ static void discover_callback(uint16_t message, uint1=
6_t length,
 	device->version_str =3D strndup(ptr + 1, *((uint8_t *) ptr));
 =

 done:
-	device->version_list =3D list;
-	device->version_count =3D count;
-
 	if (data->func)
 		data->func(data->user_data);
 =

@@ -1208,7 +1198,7 @@ bool qmi_device_discover(struct qmi_device *device, q=
mi_discover_func_t func,
 	data->user_data =3D user_data;
 	data->destroy =3D destroy;
 =

-	if (device->version_list) {
+	if (!list_empty(&device->service_info)) {
 		data->timeout =3D g_timeout_add_seconds(0, discover_reply, data);
 		return true;
 	}
@@ -1863,9 +1853,8 @@ static void service_create_callback(uint16_t message,=
 uint16_t length,
 	struct qmi_service *service =3D NULL;
 	const struct qmi_result_code *result_code;
 	const struct qmi_client_id *client_id;
-	struct qmi_version* info;
+	struct qmi_service_info* info;
 	uint16_t len;
-	int i;
 =

 	result_code =3D tlv_get(buffer, length, 0x02, &len);
 	if (!result_code)
@@ -1893,14 +1882,11 @@ static void service_create_callback(uint16_t messag=
e, uint16_t length,
 	service->ref_count =3D 1;
 	service->device =3D data->device;
 =

-	for (i =3D 0, info =3D device->version_list;
-			i < device->version_count;
-			i++, info++) {
+	list_for_each_entry(info, &device->service_info, node)
 		if (info->type =3D=3D data->type) {
 			service->info =3D info;
 			break;
 		}
-	}
 =

 	service->info->client_id =3D client_id->client;
 =

-- =

2.15.1


--===============2074405286836192613==--

