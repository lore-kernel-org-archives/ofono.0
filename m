Content-Type: multipart/mixed; boundary="===============0936550756150582153=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC PATCH 26/30] qmi: make all services unique instances backed by
 common description
Date: Wed, 28 Mar 2018 21:00:12 +0200
Message-ID: <20180328190016.28509-27-jonas@southpole.se>
In-Reply-To: <20180328190016.28509-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0936550756150582153==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch changes shared services from sharing the service instance
itself to sharing the underlying service description.

This allows each service instance to have callbacks and requests whose
lifetime are tied directly to the lifetime of the service instance
itself.  For example, already with this patch each service has its own
notify_list for callbacks from indications; when the service is
destroyed, the callbacks can be cancelled without affecting callbacks
registered by other users of the service.

This is the meat and potatoes patch of this series.  With this, services
can be safely used across unrelated modules without having to worry
about other users of the same service.  Other cleanups will follow on
this:  pending requests are still not tied to the service descriptor,
for example.
---
 drivers/qmimodem/qmi.c | 323 +++++++++++++++++++++++++++------------------=
----
 1 file changed, 180 insertions(+), 143 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 00b3ccbe..c87885cd 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -45,6 +45,27 @@
 typedef void (*qmi_message_func_t)(uint16_t message, uint16_t length,
 					const void *buffer, void *user_data);
 =

+/*
+ * Service description:  an instance of a service that the device provides.
+ * These are referenced by service descriptors (see struct qmi_service bel=
ow)
+ * that provide their own private state over top of the shared description.
+ * The description exists in 3 states:
+ * i)  client_id =3D 0 and services list is empty:  service not 'connected'
+ *     and no client_id has been claimed
+ * ii) client_id =3D0 and services list has entries:  service is 'connecti=
ng',
+ *     attempting to get a client ID for use with requests.  In this state,
+ *     the services list contains struct service_connect_data objects which
+ *     are incomplete service objects for which the service_create callback
+ *     has not yet been invoked.  Once the connection is established (get
+ *     client ID returns), then the callbacks will be invoked  and the
+ *     temporary structs replaced with proper service objects.
+ * iii) client_id !=3D 0:  there are service descriptors in the services l=
ist
+ *      and these are ready for use.
+ * When the last service description is removed from the services list, th=
en
+ * the client ID will be released by the description.
+ * The behaviour and terminology are loosely based on file descriptions and
+ * file descriptors as seen in Linux and other UNIX OS.
+ */
 struct qmi_service_info {
 	struct list_head node;
 	struct qmi_device *device;
@@ -53,6 +74,7 @@ struct qmi_service_info {
 	uint16_t minor;
 	const char *name;
 	uint8_t client_id;
+	struct list_head services;
 };
 =

 struct qmi_device {
@@ -73,7 +95,6 @@ struct qmi_device {
 	uint16_t control_minor;
 	char *version_str;
 	struct list_head service_info;
-	struct list_head service_list;
 	unsigned int release_users;
 	qmi_shutdown_func_t shutdown_func;
 	void *shutdown_user_data;
@@ -83,9 +104,11 @@ struct qmi_device {
 	bool destroyed : 1;
 };
 =

+/* Service descriptor: an instance of a service backed by a shared service
+ * description (see above)
+ */
 struct qmi_service {
 	struct list_head node;
-	int ref_count;
 	struct qmi_service_info *info;
 	struct list_head notify_list;
 };
@@ -702,6 +725,7 @@ static void handle_indication(struct qmi_device *device,
 			uint8_t service_type, uint8_t client_id,
 			uint16_t message, uint16_t length, const void *data)
 {
+	struct qmi_service_info *info;
 	struct qmi_service *service;
 	struct qmi_result result;
 =

@@ -714,10 +738,10 @@ static void handle_indication(struct qmi_device *devi=
ce,
 	result.data =3D data;
 	result.length =3D length;
 =

-	list_for_each_entry(service, &device->service_list, node) {
-		if (client_id =3D=3D 0xff || service_type =3D=3D service->info->type)
-			service_notify(service, &result);
-	}
+	list_for_each_entry(info, &device->service_info, node)
+		if (client_id =3D=3D 0xff || service_type =3D=3D info->type)
+			list_for_each_entry(service, &info->services, node)
+				service_notify(service, &result);
 }
 =

 static void handle_packet(struct qmi_device *device,
@@ -893,8 +917,6 @@ struct qmi_device *qmi_device_new(int fd)
 =

 	INIT_LIST_HEAD(&device->service_info);
 =

-	INIT_LIST_HEAD(&device->service_list);
-
 	device->next_control_tid =3D 1;
 	device->next_service_tid =3D 256;
 =

@@ -911,6 +933,32 @@ struct qmi_device *qmi_device_ref(struct qmi_device *d=
evice)
 	return device;
 }
 =

+static void service_connect_data_free(gpointer user_data);
+
+struct service_connect_data {
+	struct list_head node;
+	struct qmi_service *service;
+	qmi_create_func_t func;
+	void * user_data;
+	qmi_destroy_func_t destroy;
+	guint timeout;
+};
+
+static void service_connect_data_free(gpointer user_data)
+{
+	struct service_connect_data *data =3D user_data;
+
+	if (data->timeout) {
+		g_source_remove(data->timeout);
+		data->timeout =3D 0;
+	}
+
+	if (data->destroy)
+		data->destroy(data->user_data);
+
+	g_free(data);
+}
+
 void qmi_device_unref(struct qmi_device *device)
 {
 	struct qmi_request *req, *req_t;
@@ -964,15 +1012,25 @@ void qmi_device_unref(struct qmi_device *device)
 	if (device->shutdown_source)
 		g_source_remove(device->shutdown_source);
 =

-	list_for_each_entry_safe(service, service_t,
-					&device->service_list, node) {
-		list_del(&service->node);
-		g_free(service);
-	}
-
 	g_free(device->version_str);
 =

 	list_for_each_entry_safe(info, info_t, &device->service_info, node) {
+		if (!info->client_id) {
+			/* Entries in service list are connect_data structs */
+			struct service_connect_data *data, *data_t;
+			list_for_each_entry_safe(data, data_t,
+						&info->services, node) {
+				list_del(&data->node);
+				service_connect_data_free(data);
+			}
+		} else {
+			list_for_each_entry_safe(service, service_t,
+						&info->services, node) {
+				list_del(&service->node);
+				g_free(service);
+			}
+		}
+
 		list_del(&info->node);
 		free(info);
 	}
@@ -1143,7 +1201,9 @@ static void discover_callback(uint16_t message, uint1=
6_t length,
 =

 		info =3D calloc(1, sizeof(*info));
 		INIT_LIST_HEAD(&info->node);
+		INIT_LIST_HEAD(&info->services);
 =

+		info->device =3D device;
 		info->type =3D type;
 		info->major =3D major;
 		info->minor =3D minor;
@@ -1808,53 +1868,30 @@ bool qmi_result_get_uint64(struct qmi_result *resul=
t, uint8_t type,
 	return true;
 }
 =

-static struct qmi_service* device_get_service(struct qmi_device* device,
-							uint8_t type)
+static struct qmi_service_info* device_get_service_info(
+					struct qmi_device* device,
+					uint8_t type)
 {
-	struct qmi_service* service;
+	struct qmi_service_info* info;
 =

-	list_for_each_entry(service, &device->service_list, node) {
-		if (service->info->type =3D=3D type)
-			return service;
+	list_for_each_entry(info, &device->service_info, node) {
+		if (info->type =3D=3D type)
+			return info;
 	}
 =

 	return NULL;
 }
 =

-struct service_create_data {
-	struct qmi_device *device;
-	uint8_t type;
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
-static void service_create_callback(uint16_t message, uint16_t length,
+static void service_connect_callback(uint16_t message, uint16_t length,
 					const void *buffer, void *user_data)
 {
-	struct service_create_data *data =3D user_data;
-	struct qmi_device *device =3D data->device;
-	struct qmi_service *service =3D NULL;
+	struct qmi_service_info* info =3D user_data;
 	const struct qmi_result_code *result_code;
 	const struct qmi_client_id *client_id;
-	struct qmi_service_info* info;
 	uint16_t len;
+	struct service_connect_data *data, *data_t;
+	LIST_HEAD(cdlist);
+	uint8_t cid =3D 0;
 =

 	result_code =3D tlv_get(buffer, length, 0x02, &len);
 	if (!result_code)
@@ -1867,102 +1904,91 @@ static void service_create_callback(uint16_t messa=
ge, uint16_t length,
 	if (!client_id)
 		goto done;
 =

-	if (len !=3D QMI_CLIENT_ID_SIZE)
-		goto done;
+	cid =3D client_id->client;
 =

-	if (client_id->service !=3D data->type)
+	if (len !=3D QMI_CLIENT_ID_SIZE) {
+		cid =3D 0;
 		goto done;
+	}
 =

-	service =3D g_try_new0(struct qmi_service, 1);
-	if (!service)
+	if (client_id->service !=3D info->type) {
+		cid =3D 0;
 		goto done;
+	}
 =

-	INIT_LIST_HEAD(&service->node);
-	INIT_LIST_HEAD(&service->notify_list);
-	service->ref_count =3D 1;
-
-	list_for_each_entry(info, &device->service_info, node)
-		if (info->type =3D=3D data->type) {
-			service->info =3D info;
-			break;
-		}
+	info->client_id =3D cid;
 =

-	service->info->device =3D data->device;
-	service->info->client_id =3D client_id->client;
+	__debug_device(info->device, "service created [client=3D%d,type=3D%d]",
+					info->client_id, info->type);
 =

-	__debug_device(device, "service created [client=3D%d,type=3D%d]",
-					service->info->client_id, service->info->type);
+done:
+	/* Move the connect_data list over to a temporary location
+	 * so that we can fill up the info->services list properly with
+	 * service objects.
+	 */
+	/* Set up a temporary list to move the services to, clear the
+	 * connect_data list, and then move the services back to the
+	 * info node where they belong now that we are connected
+	 */
+	INIT_LIST_HEAD(&cdlist);
 =

-	/* FIXME: maybe sort these by type...??? */
-	list_add_tail(&service->node, &device->service_list);
+	list_for_each_entry_safe(data, data_t, &info->services, node) {
+		list_move(&data->node, &cdlist);
+	}
 =

-done:
-	data->func(service, data->user_data);
-	qmi_service_unref(service);
+	list_for_each_entry_safe(data, data_t, &cdlist, node) {
+		if (!cid) {
+			data->func(NULL, data->user_data);
+			g_free(data->service);
+		} else {
+			list_add_tail(&data->service->node, &info->services);
+			data->func(data->service, data->user_data);
+		}
 =

-	service_create_data_free(data);
+		list_del(&data->node);
+		service_connect_data_free(data);
+	}
 }
 =

-static bool service_create(struct qmi_device *device,
-				uint8_t type, qmi_create_func_t func,
-				void *user_data, qmi_destroy_func_t destroy)
+static bool service_connect(struct service_connect_data *data)
 {
-	struct service_create_data *data;
-	unsigned char client_req[] =3D { 0x01, 0x01, 0x00, type };
-
-	data =3D g_try_new0(struct service_create_data, 1);
-	if (!data)
-		return false;
+	struct qmi_service_info* info =3D data->service->info;
+	unsigned char client_req[] =3D { 0x01, 0x01, 0x00, info->type };
 =

-	data->device =3D device;
-	data->type =3D type;
-	data->func =3D func;
-	data->user_data =3D user_data;
-	data->destroy =3D destroy;
+	if (!list_empty(&info->services))
+		/* Already connecting: while connection is in progress,
+		 * the 'info->services' list contains service_connect_data
+		 * structs instead of service structs.  If the list is
+		 * not empty, then connection is already in progess so
+		 * the data is just appended to the list and the callback
+		 * will be invoked when connection is complete.
+		 */
+		goto done;
 =

-	__debug_device(device, "service create [type=3D%d]", type);
+	__debug_device(info->device, "service create [type=3D%d]", info->type);
 =

-	__request_submit(device, QMI_SERVICE_CONTROL, 0x00,
+	__request_submit(info->device, QMI_SERVICE_CONTROL, 0x00,
 			QMI_CTL_GET_CLIENT_ID,
 			client_req, sizeof(client_req),
-			service_create_callback, data);
+			service_connect_callback, info);
 =

+done:
+	list_add_tail(&data->node, &info->services);
 	return true;
 }
 =

-struct service_create_shared_data {
-	struct qmi_service *service;
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
+	struct service_connect_data *data =3D user_data;
+	struct qmi_service_info *info =3D data->service->info;
 =

 	data->timeout =3D 0;
+
+	list_add_tail(&data->service->node, &info->services);
+
 	data->func(data->service, data->user_data);
 =

-	service_create_shared_data_free(data);
+	service_connect_data_free(data);
 =

 	return FALSE;
 }
@@ -1971,8 +1997,9 @@ bool qmi_service_create_shared(struct qmi_device *dev=
ice,
 				uint8_t type, qmi_create_func_t func,
 				void *user_data, qmi_destroy_func_t destroy)
 {
-	struct service_create_shared_data *data;
+	struct qmi_service_info *info;
 	struct qmi_service *service;
+	struct service_connect_data *data;
 =

 	if (!device || !func)
 		return false;
@@ -1980,19 +2007,25 @@ bool qmi_service_create_shared(struct qmi_device *d=
evice,
 	if (type =3D=3D QMI_SERVICE_CONTROL)
 		return false;
 =

-	service =3D device_get_service(device, type);
-	if (!service)
-		return service_create(device, type, func, user_data, destroy);
-
-	data =3D g_try_new0(struct service_create_shared_data, 1);
-	if (!data)
+	info =3D device_get_service_info(device, type);
+	if (!info)
 		return false;
 =

-	data->service =3D qmi_service_ref(service);
+	service =3D calloc(1, sizeof(*service));
+	INIT_LIST_HEAD(&service->node);
+	INIT_LIST_HEAD(&service->notify_list);
+	service->info =3D info;
+
+	data =3D calloc(1, sizeof(*data));
+	INIT_LIST_HEAD(&data->node);
+	data->service =3D service;
 	data->func =3D func;
 	data->user_data =3D user_data;
 	data->destroy =3D destroy;
 =

+	if (!info->client_id)
+		return service_connect(data);
+
 	/* FIXME: There's a little window here where we might leak
 	 * data... we'll leave it for now because the correct fix
 	 * is a rework of the way services are shared.
@@ -2013,33 +2046,30 @@ bool qmi_service_create(struct qmi_device *device,
 static void service_release_callback(uint16_t message, uint16_t length,
 					const void *buffer, void *user_data)
 {
-	struct qmi_service *service =3D user_data;
-
-	if (service->info->device)
-		service->info->device->release_users--;
-
-	service->info->client_id =3D 0;
+	struct qmi_service_info *info =3D user_data;
 =

-	g_free(service);
+	info->device->release_users--;
 }
 =

 struct qmi_service *qmi_service_ref(struct qmi_service *service)
 {
-	if (!service)
-		return NULL;
-
-	__sync_fetch_and_add(&service->ref_count, 1);
-
 	return service;
 }
 =

+/*
+ * FIXME: we want to rename this to qmi_service_destroy because the 'creat=
e'
+ * function returns an instance and this effectively destroys it... refere=
nce
+ * counting is no longer relevant as these service objects are no longer m=
eant
+ * to be shared between unrelated entities.
+ */
 void qmi_service_unref(struct qmi_service *service)
 {
+	struct qmi_service_info *info;
+
 	if (!service)
                 return;
 =

-	if (__sync_sub_and_fetch(&service->ref_count, 1))
-		return;
+	info =3D service->info;
 =

 	if (!service->info->device) {
 		g_free(service);
@@ -2050,12 +2080,19 @@ void qmi_service_unref(struct qmi_service *service)
 	qmi_service_unregister_all(service);
 =

 	list_del(&service->node);
+	g_free(service);
+
+	if (list_empty(&info->services)) {
+		/* No more service instances that refer to this
+		 * service description so we can release the client ID
+		 */
+		info->device->release_users++;
 =

-	service->info->device->release_users++;
+		info->client_id =3D 0;
 =

-	release_client(service->info->device, service->info->type,
-					service->info->client_id,
-					service_release_callback, service);
+		release_client(info->device, info->type, info->client_id,
+					service_release_callback, info);
+	}
 }
 =

 const char *qmi_service_get_identifier(struct qmi_service *service)
-- =

2.15.1


--===============0936550756150582153==--

