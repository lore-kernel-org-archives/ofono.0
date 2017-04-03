Content-Type: multipart/mixed; boundary="===============0846122358861981479=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH] qmi: Optimize structure allocations
Date: Mon, 03 Apr 2017 13:13:59 -0500
Message-ID: <20170403181359.23143-1-denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0846122358861981479==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

struct discovery was allocated for every discovery procedure that was
kicked off, which itself allocated a structure.  This patch uses a
class/subclass concept to only allocate a single structure per discovery
procedure.
---
 drivers/qmimodem/qmi.c | 64 ++++++++++++++++------------------------------=
----
 1 file changed, 20 insertions(+), 44 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index a0d79e1..cda7f32 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -44,7 +44,6 @@ typedef void (*qmi_message_func_t)(uint16_t message, uint=
16_t length,
 					const void *buffer, void *user_data);
 =

 struct discovery {
-	void *discover_data;
 	qmi_destroy_func_t destroy;
 };
 =

@@ -224,17 +223,7 @@ static void __discovery_free(gpointer data, gpointer u=
ser_data)
 	struct discovery *d =3D data;
 	qmi_destroy_func_t destroy =3D d->destroy;
 =

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
+	destroy(d);
 }
 =

 static void __notify_free(gpointer data, gpointer user_data)
@@ -883,32 +872,17 @@ static void read_watch_destroy(gpointer user_data)
 }
 =

 static void __qmi_device_discovery_started(struct qmi_device *device,
-						void *discover_data,
-						qmi_destroy_func_t destroy)
+						struct discovery *d)
 {
-	struct discovery *d;
-
-	d =3D g_new0(struct discovery, 1);
-	d->discover_data =3D discover_data;
-	d->destroy =3D destroy;
-
 	g_queue_push_tail(device->discovery_queue, d);
 }
 =

 static void __qmi_device_discovery_complete(struct qmi_device *device,
-						void *discover_data)
+						struct discovery *d)
 {
-	GList *list;
-	struct discovery *d;
-
-	list =3D g_queue_find_custom(device->discovery_queue,
-				discover_data, __discovery_compare);
-	if (!list)
+	if (g_queue_remove(device->discovery_queue, d) !=3D TRUE)
 		return;
 =

-	d =3D list->data;
-	g_queue_delete_link(device->discovery_queue, list);
-
 	__discovery_free(d, NULL);
 }
 =

@@ -1065,6 +1039,7 @@ static const void *tlv_get(const void *data, uint16_t=
 size,
 }
 =

 struct discover_data {
+	struct discovery super;
 	struct qmi_device *device;
 	qmi_discover_func_t func;
 	void *user_data;
@@ -1170,7 +1145,7 @@ done:
 	if (data->func)
 		data->func(count, list, data->user_data);
 =

-	__qmi_device_discovery_complete(data->device, data);
+	__qmi_device_discovery_complete(data->device, &data->super);
 }
 =

 static gboolean discover_reply(gpointer user_data)
@@ -1184,7 +1159,7 @@ static gboolean discover_reply(gpointer user_data)
 		data->func(device->version_count,
 				device->version_list, data->user_data);
 =

-	__qmi_device_discovery_complete(data->device, data);
+	__qmi_device_discovery_complete(data->device, &data->super);
 =

 	return FALSE;
 }
@@ -1205,6 +1180,7 @@ bool qmi_device_discover(struct qmi_device *device, q=
mi_discover_func_t func,
 	if (!data)
 		return false;
 =

+	data->super.destroy =3D discover_data_free;
 	data->device =3D device;
 	data->func =3D func;
 	data->user_data =3D user_data;
@@ -1212,8 +1188,7 @@ bool qmi_device_discover(struct qmi_device *device, q=
mi_discover_func_t func,
 =

 	if (device->version_list) {
 		data->timeout =3D g_timeout_add_seconds(0, discover_reply, data);
-		__qmi_device_discovery_started(device, data,
-							discover_data_free);
+		__qmi_device_discovery_started(device, &data->super);
 		return true;
 	}
 =

@@ -1234,7 +1209,7 @@ bool qmi_device_discover(struct qmi_device *device, q=
mi_discover_func_t func,
 	__request_submit(device, req, hdr->transaction);
 =

 	data->timeout =3D g_timeout_add_seconds(5, discover_reply, data);
-	__qmi_device_discovery_started(device, data, discover_data_free);
+	__qmi_device_discovery_started(device, &data->super);
 =

 	return true;
 }
@@ -1785,6 +1760,7 @@ bool qmi_result_get_uint64(struct qmi_result *result,=
 uint8_t type,
 }
 =

 struct service_create_data {
+	struct discovery super;
 	struct qmi_device *device;
 	bool shared;
 	uint8_t type;
@@ -1818,7 +1794,7 @@ static gboolean service_create_reply(gpointer user_da=
ta)
 	data->timeout =3D 0;
 	data->func(NULL, data->user_data);
 =

-	__qmi_device_discovery_complete(data->device, data);
+	__qmi_device_discovery_complete(data->device, &data->super);
 =

 	return FALSE;
 }
@@ -1877,7 +1853,7 @@ done:
 	data->func(service, data->user_data);
 	qmi_service_unref(service);
 =

-	__qmi_device_discovery_complete(data->device, data);
+	__qmi_device_discovery_complete(data->device, &data->super);
 }
 =

 static void service_create_discover(uint8_t count,
@@ -1910,8 +1886,7 @@ static void service_create_discover(uint8_t count,
 =

 		data->timeout =3D g_timeout_add_seconds(0,
 						service_create_reply, data);
-		__qmi_device_discovery_started(device, data,
-						service_create_data_free);
+		__qmi_device_discovery_started(device, &data->super);
 		return;
 	}
 =

@@ -1934,6 +1909,7 @@ static bool service_create(struct qmi_device *device,=
 bool shared,
 	if (!data)
 		return false;
 =

+	data->super.destroy =3D service_create_data_free;
 	data->device =3D device;
 	data->shared =3D shared;
 	data->type =3D type;
@@ -1956,8 +1932,7 @@ static bool service_create(struct qmi_device *device,=
 bool shared,
 =

 done:
 	data->timeout =3D g_timeout_add_seconds(8, service_create_reply, data);
-	__qmi_device_discovery_started(device, data,
-						service_create_data_free);
+	__qmi_device_discovery_started(device, &data->super);
 =

 	return true;
 }
@@ -1976,6 +1951,7 @@ bool qmi_service_create(struct qmi_device *device,
 }
 =

 struct service_create_shared_data {
+	struct discovery super;
 	struct qmi_service *service;
 	struct qmi_device *device;
 	qmi_create_func_t func;
@@ -2008,7 +1984,7 @@ static gboolean service_create_shared_reply(gpointer =
user_data)
 	data->timeout =3D 0;
 	data->func(data->service, data->user_data);
 =

-	__qmi_device_discovery_complete(data->device, data);
+	__qmi_device_discovery_complete(data->device, &data->super);
 =

 	return FALSE;
 }
@@ -2035,6 +2011,7 @@ bool qmi_service_create_shared(struct qmi_device *dev=
ice,
 		if (!data)
 			return false;
 =

+		data->super.destroy =3D service_create_shared_data_free;
 		data->service =3D qmi_service_ref(service);
 		data->device =3D device;
 		data->func =3D func;
@@ -2043,8 +2020,7 @@ bool qmi_service_create_shared(struct qmi_device *dev=
ice,
 =

 		data->timeout =3D g_timeout_add(0,
 					service_create_shared_reply, data);
-		__qmi_device_discovery_started(device, data,
-					service_create_shared_data_free);
+		__qmi_device_discovery_started(device, &data->super);
 =

 		return 0;
 	}
-- =

2.10.2


--===============0846122358861981479==--

