Content-Type: multipart/mixed; boundary="===============6794759406362530330=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC PATCH 17/30] qmi: switch service_list to list_head type
Date: Wed, 28 Mar 2018 21:00:03 +0200
Message-ID: <20180328190016.28509-18-jonas@southpole.se>
In-Reply-To: <20180328190016.28509-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6794759406362530330==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/qmimodem/qmi.c | 126 +++++++++++++++++++--------------------------=
----
 1 file changed, 49 insertions(+), 77 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index fcb9a5e4..a3a04768 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -64,7 +64,7 @@ struct qmi_device {
 	char *version_str;
 	struct qmi_version *version_list;
 	uint8_t version_count;
-	GHashTable *service_list;
+	struct list_head service_list;
 	unsigned int release_users;
 	qmi_shutdown_func_t shutdown_func;
 	void *shutdown_user_data;
@@ -75,6 +75,7 @@ struct qmi_device {
 };
 =

 struct qmi_service {
+	struct list_head node;
 	int ref_count;
 	struct qmi_device *device;
 	uint8_t type;
@@ -259,18 +260,6 @@ static void __notify_free(gpointer data, gpointer user=
_data)
 	g_free(notify);
 }
 =

-static gboolean __service_compare_shared(gpointer key, gpointer value,
-							gpointer user_data)
-{
-	struct qmi_service *service =3D value;
-	uint8_t type =3D GPOINTER_TO_UINT(user_data);
-
-	if (service->type =3D=3D type)
-		return TRUE;
-
-	return FALSE;
-}
-
 static void __hexdump(const char dir, const unsigned char *buf, size_t len,
 				qmi_debug_func_t function, void *user_data)
 {
@@ -702,10 +691,9 @@ static void wakeup_writer(struct qmi_device *device)
 				can_write_data, device, write_watch_destroy);
 }
 =

-static void service_notify(gpointer key, gpointer value, gpointer user_dat=
a)
+static void service_notify(struct qmi_service* service,
+				struct qmi_result* result)
 {
-	struct qmi_service *service =3D value;
-	struct qmi_result *result =3D user_data;
 	GList *list;
 =

 	for (list =3D g_list_first(service->notify_list); list;
@@ -723,7 +711,6 @@ static void handle_indication(struct qmi_device *device,
 {
 	struct qmi_service *service;
 	struct qmi_result result;
-	unsigned int hash_id;
 =

 	if (service_type =3D=3D QMI_SERVICE_CONTROL)
 		return;
@@ -734,20 +721,10 @@ static void handle_indication(struct qmi_device *devi=
ce,
 	result.data =3D data;
 	result.length =3D length;
 =

-	if (client_id =3D=3D 0xff) {
-		g_hash_table_foreach(device->service_list,
-						service_notify, &result);
-		return;
+	list_for_each_entry(service, &device->service_list, node) {
+		if (client_id =3D=3D 0xff || service_type =3D=3D service->type)
+			service_notify(service, &result);
 	}
-
-	hash_id =3D service_type | (client_id << 8);
-
-	service =3D g_hash_table_lookup(device->service_list,
-					GUINT_TO_POINTER(hash_id));
-	if (!service)
-		return;
-
-	service_notify(NULL, service, &result);
 }
 =

 static void handle_packet(struct qmi_device *device,
@@ -877,16 +854,6 @@ static void read_watch_destroy(gpointer user_data)
 	device->read_watch =3D 0;
 }
 =

-static void service_destroy(gpointer data)
-{
-	struct qmi_service *service =3D data;
-
-	if (!service->device)
-		return;
-
-	service->device =3D NULL;
-}
-
 struct qmi_device *qmi_device_new(int fd)
 {
 	struct qmi_device *device;
@@ -931,8 +898,7 @@ struct qmi_device *qmi_device_new(int fd)
 	INIT_LIST_HEAD(&device->control_queue);
 	INIT_LIST_HEAD(&device->service_queue);
 =

-	device->service_list =3D g_hash_table_new_full(g_direct_hash,
-					g_direct_equal, NULL, service_destroy);
+	INIT_LIST_HEAD(&device->service_list);
 =

 	device->next_control_tid =3D 1;
 	device->next_service_tid =3D 256;
@@ -953,6 +919,7 @@ struct qmi_device *qmi_device_ref(struct qmi_device *de=
vice)
 void qmi_device_unref(struct qmi_device *device)
 {
 	struct qmi_request *req, *req_t;
+	struct qmi_service *service, *service_t;
 =

 	if (!device)
 		return;
@@ -1001,7 +968,11 @@ void qmi_device_unref(struct qmi_device *device)
 	if (device->shutdown_source)
 		g_source_remove(device->shutdown_source);
 =

-	g_hash_table_destroy(device->service_list);
+	list_for_each_entry_safe(service, service_t,
+					&device->service_list, node) {
+		list_del(&service->node);
+		g_free(service);
+	}
 =

 	g_free(device->version_str);
 	g_free(device->version_list);
@@ -1818,6 +1789,19 @@ bool qmi_result_get_uint64(struct qmi_result *result=
, uint8_t type,
 	return true;
 }
 =

+static struct qmi_service* device_get_service(struct qmi_device* device,
+							uint8_t type)
+{
+	struct qmi_service* service;
+
+	list_for_each_entry(service, &device->service_list, node) {
+		if (service->type =3D=3D type)
+			return service;
+	}
+
+	return NULL;
+}
+
 struct service_create_data {
 	struct qmi_device *device;
 	uint8_t type;
@@ -1853,7 +1837,6 @@ static void service_create_callback(uint16_t message,=
 uint16_t length,
 	const struct qmi_result_code *result_code;
 	const struct qmi_client_id *client_id;
 	uint16_t len;
-	unsigned int hash_id;
 =

 	result_code =3D tlv_get(buffer, length, 0x02, &len);
 	if (!result_code)
@@ -1876,6 +1859,7 @@ static void service_create_callback(uint16_t message,=
 uint16_t length,
 	if (!service)
 		goto done;
 =

+	INIT_LIST_HEAD(&service->node);
 	service->ref_count =3D 1;
 	service->device =3D data->device;
 =

@@ -1888,10 +1872,8 @@ static void service_create_callback(uint16_t message=
, uint16_t length,
 	__debug_device(device, "service created [client=3D%d,type=3D%d]",
 					service->client_id, service->type);
 =

-	hash_id =3D service->type | (service->client_id << 8);
-
-	g_hash_table_replace(device->service_list,
-				GUINT_TO_POINTER(hash_id), service);
+	/* FIXME: maybe sort these by type...??? */
+	list_add_tail(&service->node, &device->service_list);
 =

 done:
 	data->func(service, data->user_data);
@@ -1978,8 +1960,8 @@ bool qmi_service_create_shared(struct qmi_device *dev=
ice,
 				uint8_t type, qmi_create_func_t func,
 				void *user_data, qmi_destroy_func_t destroy)
 {
+	struct service_create_shared_data *data;
 	struct qmi_service *service;
-	unsigned int type_val =3D type;
 =

 	if (!device || !func)
 		return false;
@@ -1987,32 +1969,27 @@ bool qmi_service_create_shared(struct qmi_device *d=
evice,
 	if (type =3D=3D QMI_SERVICE_CONTROL)
 		return false;
 =

-	service =3D g_hash_table_find(device->service_list,
-			__service_compare_shared, GUINT_TO_POINTER(type_val));
-	if (service) {
-		struct service_create_shared_data *data;
-
-		data =3D g_try_new0(struct service_create_shared_data, 1);
-		if (!data)
-			return false;
+	service =3D device_get_service(device, type);
+	if (!service)
+		return service_create(device, type, func, user_data, destroy);
 =

-		data->service =3D qmi_service_ref(service);
-		data->device =3D device;
-		data->func =3D func;
-		data->user_data =3D user_data;
-		data->destroy =3D destroy;
+	data =3D g_try_new0(struct service_create_shared_data, 1);
+	if (!data)
+		return false;
 =

-		/* FIXME: There's a little window here where we might leak
-		 * data... we'll leave it for now because the correct fix
-		 * is a rework of the way services are shared.
-		 */
-		data->timeout =3D g_timeout_add(0,
-					service_create_shared_reply, data);
+	data->service =3D qmi_service_ref(service);
+	data->device =3D device;
+	data->func =3D func;
+	data->user_data =3D user_data;
+	data->destroy =3D destroy;
 =

-		return 0;
-	}
+	/* FIXME: There's a little window here where we might leak
+	 * data... we'll leave it for now because the correct fix
+	 * is a rework of the way services are shared.
+	 */
+	data->timeout =3D g_timeout_add(0, service_create_shared_reply, data);
 =

-	return service_create(device, type, func, user_data, destroy);
+	return true;
 }
 =

 bool qmi_service_create(struct qmi_device *device,
@@ -2046,8 +2023,6 @@ struct qmi_service *qmi_service_ref(struct qmi_servic=
e *service)
 =

 void qmi_service_unref(struct qmi_service *service)
 {
-	unsigned int hash_id;
-
 	if (!service)
                 return;
 =

@@ -2062,10 +2037,7 @@ void qmi_service_unref(struct qmi_service *service)
 	qmi_service_cancel_all(service);
 	qmi_service_unregister_all(service);
 =

-	hash_id =3D service->type | (service->client_id << 8);
-
-	g_hash_table_steal(service->device->service_list,
-					GUINT_TO_POINTER(hash_id));
+	list_del(&service->node);
 =

 	service->device->release_users++;
 =

-- =

2.15.1


--===============6794759406362530330==--

