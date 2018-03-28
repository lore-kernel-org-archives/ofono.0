Content-Type: multipart/mixed; boundary="===============5187547810416556483=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC PATCH 15/30] qmi: drop discovery_queue
Date: Wed, 28 Mar 2018 21:00:01 +0200
Message-ID: <20180328190016.28509-16-jonas@southpole.se>
In-Reply-To: <20180328190016.28509-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5187547810416556483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The discovery queue mechanism provides a form of timeout handling so
that device discovery and service creation operations return in bounded
time.  For the modem I have available, these operations never time out
and the "failure" paths are never exercised.

A better way to handle this would be to put proper timeout handling into
the QMI protocol handling itself.  This will be done in a later patch,
but for now we drop this pessimistic timeout handling altogether in
order to simplify the code and thereby facilitate further cleanups.
---
 drivers/qmimodem/qmi.c | 87 +++++-----------------------------------------=
----
 1 file changed, 8 insertions(+), 79 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 5af35a23..f212aa96 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -45,10 +45,6 @@
 typedef void (*qmi_message_func_t)(uint16_t message, uint16_t length,
 					const void *buffer, void *user_data);
 =

-struct discovery {
-	qmi_destroy_func_t destroy;
-};
-
 struct qmi_device {
 	int ref_count;
 	int fd;
@@ -59,7 +55,6 @@ struct qmi_device {
 	struct list_head req_queue;
 	struct list_head control_queue;
 	struct list_head service_queue;
-	GQueue *discovery_queue;
 	uint8_t next_control_tid;
 	uint16_t next_service_tid;
 	qmi_debug_func_t debug_func;
@@ -255,14 +250,6 @@ static struct qmi_request* __request_find_by_tid(struc=
t list_head *queue,
 	return NULL;
 }
 =

-static void __discovery_free(gpointer data, gpointer user_data)
-{
-	struct discovery *d =3D data;
-	qmi_destroy_func_t destroy =3D d->destroy;
-
-	destroy(d);
-}
-
 static void __notify_free(gpointer data, gpointer user_data)
 {
 	struct qmi_notify *notify =3D data;
@@ -894,21 +881,6 @@ static void read_watch_destroy(gpointer user_data)
 	device->read_watch =3D 0;
 }
 =

-static void __qmi_device_discovery_started(struct qmi_device *device,
-						struct discovery *d)
-{
-	g_queue_push_tail(device->discovery_queue, d);
-}
-
-static void __qmi_device_discovery_complete(struct qmi_device *device,
-						struct discovery *d)
-{
-	if (g_queue_remove(device->discovery_queue, d) !=3D TRUE)
-		return;
-
-	__discovery_free(d, NULL);
-}
-
 static void service_destroy(gpointer data)
 {
 	struct qmi_service *service =3D data;
@@ -962,7 +934,6 @@ struct qmi_device *qmi_device_new(int fd)
 	INIT_LIST_HEAD(&device->req_queue);
 	INIT_LIST_HEAD(&device->control_queue);
 	INIT_LIST_HEAD(&device->service_queue);
-	device->discovery_queue =3D g_queue_new();
 =

 	device->service_list =3D g_hash_table_new_full(g_direct_hash,
 					g_direct_equal, NULL, service_destroy);
@@ -1022,9 +993,6 @@ void qmi_device_unref(struct qmi_device *device)
 		g_free(req);
 	}
 =

-	g_queue_foreach(device->discovery_queue, __discovery_free, NULL);
-	g_queue_free(device->discovery_queue);
-
 	if (device->write_watch > 0)
 		g_source_remove(device->write_watch);
 =

@@ -1108,12 +1076,10 @@ static const void *tlv_get(const void *data, uint16=
_t size,
 }
 =

 struct discover_data {
-	struct discovery super;
 	struct qmi_device *device;
 	qmi_discover_func_t func;
 	void *user_data;
 	qmi_destroy_func_t destroy;
-	uint8_t tid;
 	guint timeout;
 };
 =

@@ -1208,33 +1174,21 @@ done:
 	if (data->func)
 		data->func(count, list, data->user_data);
 =

-	__qmi_device_discovery_complete(data->device, &data->super);
+	discover_data_free(data);
 }
 =

 static gboolean discover_reply(gpointer user_data)
 {
 	struct discover_data *data =3D user_data;
 	struct qmi_device *device =3D data->device;
-	unsigned int tid =3D data->tid;
-	struct qmi_request *req =3D NULL;
 =

 	data->timeout =3D 0;
 =

-	/* remove request from queues */
-	if (tid !=3D 0) {
-		req =3D __request_find_by_tid(&device->req_queue, tid);
-		if (!req) =

-			req =3D __request_find_by_tid(&device->control_queue,tid);
-
-		list_del(&req->node);
-	}
-
 	if (data->func)
 		data->func(device->version_count,
 				device->version_list, data->user_data);
 =

-	__qmi_device_discovery_complete(data->device, &data->super);
-	__request_free(req, NULL);
+	discover_data_free(data);
 =

 	return FALSE;
 }
@@ -1253,7 +1207,6 @@ bool qmi_device_discover(struct qmi_device *device, q=
mi_discover_func_t func,
 	if (!data)
 		return false;
 =

-	data->super.destroy =3D discover_data_free;
 	data->device =3D device;
 	data->func =3D func;
 	data->user_data =3D user_data;
@@ -1261,7 +1214,6 @@ bool qmi_device_discover(struct qmi_device *device, q=
mi_discover_func_t func,
 =

 	if (device->version_list) {
 		data->timeout =3D g_timeout_add_seconds(0, discover_reply, data);
-		__qmi_device_discovery_started(device, &data->super);
 		return true;
 	}
 =

@@ -1269,13 +1221,6 @@ bool qmi_device_discover(struct qmi_device *device, =
qmi_discover_func_t func,
 			QMI_CTL_GET_VERSION_INFO,
 			NULL, 0, discover_callback, data);
 =

-	data->tid =3D device->next_control_tid - 1;
-	if (data->tid =3D=3D 0)
-		data->tid =3D 255;
-
-	data->timeout =3D g_timeout_add_seconds(5, discover_reply, data);
-	__qmi_device_discovery_started(device, &data->super);
-
 	return true;
 }
 =

@@ -1878,7 +1823,6 @@ bool qmi_result_get_uint64(struct qmi_result *result,=
 uint8_t type,
 }
 =

 struct service_create_data {
-	struct discovery super;
 	struct qmi_device *device;
 	bool shared;
 	uint8_t type;
@@ -1905,18 +1849,6 @@ static void service_create_data_free(gpointer user_d=
ata)
 	g_free(data);
 }
 =

-static gboolean service_create_reply(gpointer user_data)
-{
-	struct service_create_data *data =3D user_data;
-
-	data->timeout =3D 0;
-	data->func(NULL, data->user_data);
-
-	__qmi_device_discovery_complete(data->device, &data->super);
-
-	return FALSE;
-}
-
 static void service_create_callback(uint16_t message, uint16_t length,
 					const void *buffer, void *user_data)
 {
@@ -1971,7 +1903,7 @@ done:
 	data->func(service, data->user_data);
 	qmi_service_unref(service);
 =

-	__qmi_device_discovery_complete(data->device, &data->super);
+	service_create_data_free(data);
 }
 =

 static bool service_create(struct qmi_device *device, bool shared,
@@ -1986,7 +1918,6 @@ static bool service_create(struct qmi_device *device,=
 bool shared,
 	if (!data)
 		return false;
 =

-	data->super.destroy =3D service_create_data_free;
 	data->device =3D device;
 	data->shared =3D shared;
 	data->type =3D type;
@@ -2009,9 +1940,6 @@ static bool service_create(struct qmi_device *device,=
 bool shared,
 			client_req, sizeof(client_req),
 			service_create_callback, data);
 =

-	data->timeout =3D g_timeout_add_seconds(8, service_create_reply, data);
-	__qmi_device_discovery_started(device, &data->super);
-
 	return true;
 }
 =

@@ -2029,7 +1957,6 @@ bool qmi_service_create(struct qmi_device *device,
 }
 =

 struct service_create_shared_data {
-	struct discovery super;
 	struct qmi_service *service;
 	struct qmi_device *device;
 	qmi_create_func_t func;
@@ -2062,7 +1989,7 @@ static gboolean service_create_shared_reply(gpointer =
user_data)
 	data->timeout =3D 0;
 	data->func(data->service, data->user_data);
 =

-	__qmi_device_discovery_complete(data->device, &data->super);
+	service_create_shared_data_free(data);
 =

 	return FALSE;
 }
@@ -2089,16 +2016,18 @@ bool qmi_service_create_shared(struct qmi_device *d=
evice,
 		if (!data)
 			return false;
 =

-		data->super.destroy =3D service_create_shared_data_free;
 		data->service =3D qmi_service_ref(service);
 		data->device =3D device;
 		data->func =3D func;
 		data->user_data =3D user_data;
 		data->destroy =3D destroy;
 =

+		/* FIXME: There's a little window here where we might leak
+		 * data... we'll leave it for now because the correct fix
+		 * is a rework of the way services are shared.
+		 */
 		data->timeout =3D g_timeout_add(0,
 					service_create_shared_reply, data);
-		__qmi_device_discovery_started(device, &data->super);
 =

 		return 0;
 	}
-- =

2.15.1


--===============5187547810416556483==--

