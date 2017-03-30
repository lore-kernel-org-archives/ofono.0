Content-Type: multipart/mixed; boundary="===============3674498356388913409=="
MIME-Version: 1.0
From: Lukasz Nowak <lnowak.tyco@gmail.com>
Subject: [PATCH] qmimodem: include shutdown in callback cleanup queue
Date: Thu, 30 Mar 2017 13:51:48 +0100
Message-ID: <1490878308-10205-1-git-send-email-lnowak.tyco@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3674498356388913409==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lukasz Nowak <lnowak@tycoint.com>

Create a unified callback_data structure, used for all timeout callbacks.
This allows to maintain a single callback_queue, which cancels any active
timeouts, and frees callback data memory when a usb device is hot unplugged.
---
 drivers/qmimodem/qmi.c | 399 ++++++++++++++++++++++-----------------------=
----
 1 file changed, 178 insertions(+), 221 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 9b80455..6e2b55f 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -43,11 +43,6 @@
 typedef void (*qmi_message_func_t)(uint16_t message, uint16_t length,
 					const void *buffer, void *user_data);
 =

-struct discovery {
-	void *discover_data;
-	qmi_destroy_func_t destroy;
-};
-
 struct qmi_device {
 	int ref_count;
 	int fd;
@@ -58,7 +53,7 @@ struct qmi_device {
 	GQueue *req_queue;
 	GQueue *control_queue;
 	GQueue *service_queue;
-	GQueue *discovery_queue;
+	GQueue *callback_queue;
 	uint8_t next_control_tid;
 	uint16_t next_service_tid;
 	qmi_debug_func_t debug_func;
@@ -154,6 +149,89 @@ void qmi_free(void *ptr)
 	free(ptr);
 }
 =

+struct discover_data {
+	qmi_discover_func_t func;
+};
+
+struct shutdown_data {
+	qmi_shutdown_func_t func;
+};
+
+struct service_create_data {
+	bool shared;
+	uint8_t type;
+	uint16_t major;
+	uint16_t minor;
+	qmi_create_func_t func;
+};
+
+struct service_create_shared_data {
+	struct qmi_service *service;
+	qmi_create_func_t func;
+};
+
+struct callback_data {
+	struct qmi_device *device;
+	void *user_data;
+	qmi_destroy_func_t user_destroy;
+	qmi_destroy_func_t callback_destroy;
+	guint timeout;
+	union {
+		struct discover_data discover;
+		struct shutdown_data shutdown;
+		struct service_create_data service_create;
+		struct service_create_shared_data service_create_shared;
+	} data;
+};
+
+static void callback_data_free(struct callback_data *callback)
+{
+	if (callback->timeout) {
+		g_source_remove(callback->timeout);
+		callback->timeout =3D 0;
+	}
+
+	if (callback->callback_destroy)
+		callback->callback_destroy(callback);
+
+	if (callback->user_destroy)
+		callback->user_destroy(callback->user_data);
+
+	g_free(callback);
+}
+
+static void service_create_shared_free(gpointer user_data)
+{
+	struct callback_data *callback =3D user_data;
+
+	qmi_service_unref(callback->data.service_create_shared.service);
+}
+
+static void __callback_started(struct callback_data *callback)
+{
+	struct qmi_device *device =3D callback->device;
+
+	g_queue_push_tail(device->callback_queue, callback);
+}
+
+static void __callback_complete(struct callback_data *callback)
+{
+	struct qmi_device *device =3D callback->device;
+	GList *list;
+
+	list =3D g_queue_find(device->callback_queue, callback);
+	if (!list)
+		return;
+
+	g_queue_delete_link(device->callback_queue, list);
+	callback_data_free(callback);
+}
+
+static void __callback_free(gpointer data, gpointer user_data)
+{
+	callback_data_free(data);
+}
+
 static struct qmi_request *__request_alloc(uint8_t service,
 				uint8_t client, uint16_t message,
 				uint16_t headroom, const void *data,
@@ -219,24 +297,6 @@ static gint __request_compare(gconstpointer a, gconstp=
ointer b)
 	return req->tid - tid;
 }
 =

-static void __discovery_free(gpointer data, gpointer user_data)
-{
-	struct discovery *d =3D data;
-	qmi_destroy_func_t destroy =3D d->destroy;
-
-	destroy(d->discover_data);
-}
-
-static gint __discovery_compare(gconstpointer a, gconstpointer b)
-{
-	const struct discovery *d =3D a;
-
-	if (d->discover_data =3D=3D b)
-		return 0;
-
-	return 1;
-}
-
 static void __notify_free(gpointer data, gpointer user_data)
 {
 	struct qmi_notify *notify =3D data;
@@ -868,37 +928,6 @@ static void read_watch_destroy(gpointer user_data)
 	device->read_watch =3D 0;
 }
 =

-static void __qmi_device_discovery_started(struct qmi_device *device,
-						void *discover_data,
-						qmi_destroy_func_t destroy)
-{
-	struct discovery *d;
-
-	d =3D g_new0(struct discovery, 1);
-	d->discover_data =3D discover_data;
-	d->destroy =3D destroy;
-
-	g_queue_push_tail(device->discovery_queue, d);
-}
-
-static void __qmi_device_discovery_complete(struct qmi_device *device,
-						void *discover_data)
-{
-	GList *list;
-	struct discovery *d;
-
-	list =3D g_queue_find_custom(device->req_queue,
-				discover_data, __discovery_compare);
-	if (!list)
-		return;
-
-	d =3D list->data;
-	g_queue_delete_link(device->discovery_queue, list);
-
-	d->destroy(d->discover_data);
-	__discovery_free(d, NULL);
-}
-
 static void service_destroy(gpointer data)
 {
 	struct qmi_service *service =3D data;
@@ -952,7 +981,7 @@ struct qmi_device *qmi_device_new(int fd)
 	device->req_queue =3D g_queue_new();
 	device->control_queue =3D g_queue_new();
 	device->service_queue =3D g_queue_new();
-	device->discovery_queue =3D g_queue_new();
+	device->callback_queue =3D g_queue_new();
 =

 	device->service_list =3D g_hash_table_new_full(g_direct_hash,
 					g_direct_equal, NULL, service_destroy);
@@ -989,8 +1018,8 @@ void qmi_device_unref(struct qmi_device *device)
 	g_queue_foreach(device->req_queue, __request_free, NULL);
 	g_queue_free(device->req_queue);
 =

-	g_queue_foreach(device->discovery_queue, __discovery_free, NULL);
-	g_queue_free(device->discovery_queue);
+	g_queue_foreach(device->callback_queue, __callback_free, NULL);
+	g_queue_free(device->callback_queue);
 =

 	if (device->write_watch > 0)
 		g_source_remove(device->write_watch);
@@ -1051,34 +1080,12 @@ static const void *tlv_get(const void *data, uint16=
_t size,
 	return NULL;
 }
 =

-struct discover_data {
-	struct qmi_device *device;
-	qmi_discover_func_t func;
-	void *user_data;
-	qmi_destroy_func_t destroy;
-	guint timeout;
-};
-
-static void discover_data_free(gpointer user_data)
-{
-	struct discover_data *data =3D user_data;
-
-	if (data->timeout) {
-		g_source_remove(data->timeout);
-		data->timeout =3D 0;
-	}
-
-	if (data->destroy)
-		data->destroy(data->user_data);
-
-	g_free(data);
-}
-
 static void discover_callback(uint16_t message, uint16_t length,
 					const void *buffer, void *user_data)
 {
-	struct discover_data *data =3D user_data;
-	struct qmi_device *device =3D data->device;
+	struct callback_data *callback =3D user_data;
+	struct discover_data *data =3D &callback->data.discover;
+	struct qmi_device *device =3D callback->device;
 	const struct qmi_result_code *result_code;
 	const struct qmi_service_list *service_list;
 	const void *ptr;
@@ -1155,23 +1162,22 @@ done:
 	device->version_count =3D count;
 =

 	if (data->func)
-		data->func(count, list, data->user_data);
+		data->func(count, list, callback->user_data);
 =

-	__qmi_device_discovery_complete(data->device, data);
+	__callback_complete(callback);
 }
 =

 static gboolean discover_reply(gpointer user_data)
 {
-	struct discover_data *data =3D user_data;
-	struct qmi_device *device =3D data->device;
-
-	data->timeout =3D 0;
+	struct callback_data *callback =3D user_data;
+	struct discover_data *data =3D &callback->data.discover;
+	struct qmi_device *device =3D callback->device;
 =

 	if (data->func)
 		data->func(device->version_count,
-				device->version_list, data->user_data);
+				device->version_list, callback->user_data);
 =

-	__qmi_device_discovery_complete(data->device, data);
+	__callback_complete(callback);
 =

 	return FALSE;
 }
@@ -1179,7 +1185,7 @@ static gboolean discover_reply(gpointer user_data)
 bool qmi_device_discover(struct qmi_device *device, qmi_discover_func_t fu=
nc,
 				void *user_data, qmi_destroy_func_t destroy)
 {
-	struct discover_data *data;
+	struct callback_data *callback;
 	struct qmi_request *req;
 	struct qmi_control_hdr *hdr;
 =

@@ -1188,27 +1194,27 @@ bool qmi_device_discover(struct qmi_device *device,=
 qmi_discover_func_t func,
 =

 	__debug_device(device, "device %p discover", device);
 =

-	data =3D g_try_new0(struct discover_data, 1);
-	if (!data)
+	callback =3D g_try_new0(struct callback_data, 1);
+	if (!callback)
 		return false;
 =

-	data->device =3D device;
-	data->func =3D func;
-	data->user_data =3D user_data;
-	data->destroy =3D destroy;
+	callback->device =3D device;
+	callback->user_data =3D user_data;
+	callback->user_destroy =3D destroy;
+	callback->data.discover.func =3D func;
 =

 	if (device->version_list) {
-		data->timeout =3D g_timeout_add_seconds(0, discover_reply, data);
-		__qmi_device_discovery_started(device, data,
-							discover_data_free);
+		callback->timeout =3D g_timeout_add_seconds(0, discover_reply,
+								callback);
+		__callback_started(callback);
 		return true;
 	}
 =

 	req =3D __request_alloc(QMI_SERVICE_CONTROL, 0x00,
 			QMI_CTL_GET_VERSION_INFO, QMI_CONTROL_HDR_SIZE,
-			NULL, 0, discover_callback, data, (void **) &hdr);
+			NULL, 0, discover_callback, callback, (void **) &hdr);
 	if (!req) {
-		g_free(data);
+		g_free(callback);
 		return false;
 	}
 =

@@ -1220,8 +1226,8 @@ bool qmi_device_discover(struct qmi_device *device, q=
mi_discover_func_t func,
 =

 	__request_submit(device, req, hdr->transaction);
 =

-	data->timeout =3D g_timeout_add_seconds(5, discover_reply, data);
-	__qmi_device_discovery_started(device, data, discover_data_free);
+	callback->timeout =3D g_timeout_add_seconds(5, discover_reply, callback);
+	__callback_started(callback);
 =

 	return true;
 }
@@ -1252,39 +1258,34 @@ static void release_client(struct qmi_device *devic=
e,
 	__request_submit(device, req, hdr->transaction);
 }
 =

-struct shutdown_data {
-	struct qmi_device *device;
-	qmi_shutdown_func_t func;
-	void *user_data;
-	qmi_destroy_func_t destroy;
-};
-
 static gboolean shutdown_reply(gpointer user_data)
 {
-	struct shutdown_data *data =3D user_data;
+	struct callback_data *callback =3D user_data;
+	struct shutdown_data *data =3D &callback->data.shutdown;
 =

 	if (data->func)
-		data->func(data->user_data);
+		data->func(callback->user_data);
 =

-	g_free(data);
+	__callback_complete(callback);
 =

 	return FALSE;
 }
 =

 static gboolean shutdown_timeout(gpointer user_data)
 {
-	struct shutdown_data *data =3D user_data;
-	struct qmi_device *device =3D data->device;
+	struct callback_data *callback =3D user_data;
+	struct qmi_device *device =3D callback->device;
 =

 	if (device->release_users > 0)
 		return TRUE;
 =

-	return shutdown_reply(data);
+	return shutdown_reply(callback);
 }
 =

 bool qmi_device_shutdown(struct qmi_device *device, qmi_shutdown_func_t fu=
nc,
 				void *user_data, qmi_destroy_func_t destroy)
 {
+	struct callback_data *callback;
 	struct shutdown_data *data;
 =

 	if (!device)
@@ -1292,19 +1293,22 @@ bool qmi_device_shutdown(struct qmi_device *device,=
 qmi_shutdown_func_t func,
 =

 	__debug_device(device, "device %p shutdown", device);
 =

-	data =3D g_try_new0(struct shutdown_data, 1);
-	if (!data)
+	callback =3D g_try_new0(struct callback_data, 1);
+	if (!callback)
 		return false;
 =

-	data->device =3D device;
+	callback->device =3D device;
+	callback->user_data =3D user_data;
+	callback->user_destroy =3D destroy;
+	data =3D &callback->data.shutdown;
 	data->func =3D func;
-	data->user_data =3D user_data;
-	data->destroy =3D destroy;
 =

 	if (device->release_users > 0)
-		g_timeout_add_seconds(0, shutdown_timeout, data);
+		g_timeout_add_seconds(0, shutdown_timeout, callback);
 	else
-		g_timeout_add_seconds(0, shutdown_reply, data);
+		g_timeout_add_seconds(0, shutdown_reply, callback);
+
+	__callback_started(callback);
 =

 	return true;
 }
@@ -1771,41 +1775,13 @@ bool qmi_result_get_uint64(struct qmi_result *resul=
t, uint8_t type,
 	return true;
 }
 =

-struct service_create_data {
-	struct qmi_device *device;
-	bool shared;
-	uint8_t type;
-	uint16_t major;
-	uint16_t minor;
-	qmi_create_func_t func;
-	void *user_data;
-	qmi_destroy_func_t destroy;
-	guint timeout;
-};
-
-static void service_create_data_free(gpointer user_data)
-{
-	struct service_create_data *data =3D user_data;
-
-	if (data->timeout) {
-		g_source_remove(data->timeout);
-		data->timeout =3D 0;
-	}
-
-	if (data->destroy)
-		data->destroy(data->user_data);
-
-	g_free(data);
-}
-
 static gboolean service_create_reply(gpointer user_data)
 {
-	struct service_create_data *data =3D user_data;
+	struct callback_data *callback =3D user_data;
 =

-	data->timeout =3D 0;
-	data->func(NULL, data->user_data);
+	callback->data.service_create.func(NULL, callback->user_data);
 =

-	__qmi_device_discovery_complete(data->device, data);
+	__callback_complete(callback);
 =

 	return FALSE;
 }
@@ -1813,8 +1789,9 @@ static gboolean service_create_reply(gpointer user_da=
ta)
 static void service_create_callback(uint16_t message, uint16_t length,
 					const void *buffer, void *user_data)
 {
-	struct service_create_data *data =3D user_data;
-	struct qmi_device *device =3D data->device;
+	struct callback_data *callback =3D user_data;
+	struct service_create_data *data =3D &callback->data.service_create;
+	struct qmi_device *device =3D callback->device;
 	struct qmi_service *service =3D NULL;
 	const struct qmi_result_code *result_code;
 	const struct qmi_client_id *client_id;
@@ -1843,7 +1820,7 @@ static void service_create_callback(uint16_t message,=
 uint16_t length,
 		goto done;
 =

 	service->ref_count =3D 1;
-	service->device =3D data->device;
+	service->device =3D callback->device;
 	service->shared =3D data->shared;
 =

 	service->type =3D data->type;
@@ -1861,17 +1838,18 @@ static void service_create_callback(uint16_t messag=
e, uint16_t length,
 				GUINT_TO_POINTER(hash_id), service);
 =

 done:
-	data->func(service, data->user_data);
+	data->func(service, callback->user_data);
 	qmi_service_unref(service);
 =

-	__qmi_device_discovery_complete(data->device, data);
+	__callback_complete(callback);
 }
 =

 static void service_create_discover(uint8_t count,
 			const struct qmi_version *list, void *user_data)
 {
-	struct service_create_data *data =3D user_data;
-	struct qmi_device *device =3D data->device;
+	struct callback_data *callback =3D user_data;
+	struct service_create_data *data =3D &callback->data.service_create;
+	struct qmi_device *device =3D callback->device;
 	struct qmi_request *req;
 	struct qmi_control_hdr *hdr;
 	unsigned char client_req[] =3D { 0x01, 0x01, 0x00, data->type };
@@ -1890,15 +1868,14 @@ static void service_create_discover(uint8_t count,
 	req =3D __request_alloc(QMI_SERVICE_CONTROL, 0x00,
 			QMI_CTL_GET_CLIENT_ID, QMI_CONTROL_HDR_SIZE,
 			client_req, sizeof(client_req),
-			service_create_callback, data, (void **) &hdr);
+			service_create_callback, callback, (void **) &hdr);
 	if (!req) {
-		if (data->timeout > 0)
-			g_source_remove(data->timeout);
+		if (callback->timeout > 0)
+			g_source_remove(callback->timeout);
 =

-		data->timeout =3D g_timeout_add_seconds(0,
-						service_create_reply, data);
-		__qmi_device_discovery_started(device, data,
-						service_create_data_free);
+		callback->timeout =3D g_timeout_add_seconds(0,
+						service_create_reply, callback);
+		__callback_started(callback);
 		return;
 	}
 =

@@ -1915,36 +1892,39 @@ static bool service_create(struct qmi_device *devic=
e, bool shared,
 				uint8_t type, qmi_create_func_t func,
 				void *user_data, qmi_destroy_func_t destroy)
 {
+	struct callback_data *callback;
 	struct service_create_data *data;
 =

-	data =3D g_try_new0(struct service_create_data, 1);
-	if (!data)
+	callback =3D g_try_new0(struct callback_data, 1);
+	if (!callback)
 		return false;
 =

-	data->device =3D device;
+	callback->device =3D device;
+	callback->user_data =3D user_data;
+	callback->user_destroy =3D destroy;
+	data =3D &callback->data.service_create;
+	data->func =3D func;
 	data->shared =3D shared;
 	data->type =3D type;
-	data->func =3D func;
-	data->user_data =3D user_data;
-	data->destroy =3D destroy;
 =

 	if (device->version_list) {
 		service_create_discover(device->version_count,
-						device->version_list, data);
+						device->version_list, callback);
 		goto done;
 	}
 =

-	if (qmi_device_discover(device, service_create_discover, data, NULL))
+	if (qmi_device_discover(device, service_create_discover, callback,
+					NULL))
 		goto done;
 =

-	g_free(data);
+	g_free(callback);
 =

 	return false;
 =

 done:
-	data->timeout =3D g_timeout_add_seconds(8, service_create_reply, data);
-	__qmi_device_discovery_started(device, data,
-						service_create_data_free);
+	callback->timeout =3D g_timeout_add_seconds(8, service_create_reply,
+							callback);
+	__callback_started(callback);
 =

 	return true;
 }
@@ -1962,40 +1942,15 @@ bool qmi_service_create(struct qmi_device *device,
 	return service_create(device, false, type, func, user_data, destroy);
 }
 =

-struct service_create_shared_data {
-	struct qmi_service *service;
-	struct qmi_device *device;
-	qmi_create_func_t func;
-	void *user_data;
-	qmi_destroy_func_t destroy;
-	guint timeout;
-};
-
-static void service_create_shared_data_free(gpointer user_data)
-{
-	struct service_create_shared_data *data =3D user_data;
-
-	if (data->timeout) {
-		g_source_remove(data->timeout);
-		data->timeout =3D 0;
-	}
-
-	qmi_service_unref(data->service);
-
-	if (data->destroy)
-		data->destroy(data->user_data);
-
-	g_free(data);
-}
-
 static gboolean service_create_shared_reply(gpointer user_data)
 {
-	struct service_create_shared_data *data =3D user_data;
+	struct callback_data *callback =3D user_data;
+	struct service_create_shared_data *data =3D
+					&callback->data.service_create_shared;
 =

-	data->timeout =3D 0;
-	data->func(data->service, data->user_data);
+	data->func(data->service, callback->user_data);
 =

-	__qmi_device_discovery_complete(data->device, data);
+	__callback_complete(callback);
 =

 	return FALSE;
 }
@@ -2016,22 +1971,24 @@ bool qmi_service_create_shared(struct qmi_device *d=
evice,
 	service =3D g_hash_table_find(device->service_list,
 			__service_compare_shared, GUINT_TO_POINTER(type_val));
 	if (service) {
+		struct callback_data *callback;
 		struct service_create_shared_data *data;
 =

-		data =3D g_try_new0(struct service_create_shared_data, 1);
-		if (!data)
+		callback =3D g_try_new0(struct callback_data, 1);
+		if (!callback)
 			return false;
 =

+		callback->device =3D device;
+		callback->user_data =3D user_data;
+		callback->user_destroy =3D destroy;
+		callback->callback_destroy =3D service_create_shared_free;
+		data =3D &callback->data.service_create_shared;
 		data->service =3D qmi_service_ref(service);
-		data->device =3D device;
 		data->func =3D func;
-		data->user_data =3D user_data;
-		data->destroy =3D destroy;
 =

-		data->timeout =3D g_timeout_add(0,
-					service_create_shared_reply, data);
-		__qmi_device_discovery_started(device, data,
-					service_create_shared_data_free);
+		callback->timeout =3D g_timeout_add(0,
+					service_create_shared_reply, callback);
+		__callback_started(callback);
 =

 		return 0;
 	}
-- =

2.7.4


--===============3674498356388913409==--

