Content-Type: multipart/mixed; boundary="===============6263316472363041335=="
MIME-Version: 1.0
From: Lukasz Nowak <lnowak.tyco@gmail.com>
Subject: [PATCH v2] qmimodem: add protection against modem_unregister
Date: Tue, 28 Mar 2017 16:47:46 +0100
Message-ID: <1490716066-26812-1-git-send-email-lnowak.tyco@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6263316472363041335==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Lukasz Nowak <lnowak@tycoint.com>

The qmimodem driver sets up numerous timeouts, passing internal
data structures to them as user_data. If a physical modem device
is removed, udev will call modem_unregister, which in turn will
call gobi_remove(). That function calls qmi_device_unref() which
frees all internal data structure memory inside qmidriver.

If a timeout is in progress while the usb device is removed,
the callback function will operate on already freed memory,
causing unpredicatble results. In some cases nothing bad will
happen, in others - segfault.

In order to solve this problem, store all created timeouts in
a list, and when the driver data is freed in qmi_device_unref()
remove all active timeout sources.
---
 drivers/qmimodem/qmi.c | 60 +++++++++++++++++++++++++++++++++++++++++++++-=
----
 1 file changed, 54 insertions(+), 6 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 39fbb19..b9260b1 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -64,6 +64,7 @@ struct qmi_device {
 	uint8_t version_count;
 	GHashTable *service_list;
 	unsigned int release_users;
+	GList *timeout_list;
 };
 =

 struct qmi_service {
@@ -914,6 +915,11 @@ struct qmi_device *qmi_device_ref(struct qmi_device *d=
evice)
 	return device;
 }
 =

+static void timeout_remove(gpointer data)
+{
+	g_source_remove(GPOINTER_TO_UINT(data));
+}
+
 void qmi_device_unref(struct qmi_device *device)
 {
 	if (!device)
@@ -939,6 +945,8 @@ void qmi_device_unref(struct qmi_device *device)
 	if (device->read_watch > 0)
 		g_source_remove(device->read_watch);
 =

+	g_list_free_full(device->timeout_list, timeout_remove);
+
 	if (device->close_on_unref)
 		close(device->fd);
 =

@@ -1014,6 +1022,8 @@ static void discover_callback(uint16_t message, uint1=
6_t length,
 	unsigned int i;
 =

 	g_source_remove(data->timeout);
+	device->timeout_list =3D g_list_remove(device->timeout_list,
+					GUINT_TO_POINTER(data->timeout));
 =

 	count =3D 0;
 	list =3D NULL;
@@ -1096,6 +1106,8 @@ static gboolean discover_reply(gpointer user_data)
 	struct discover_data *data =3D user_data;
 	struct qmi_device *device =3D data->device;
 =

+	device->timeout_list =3D g_list_remove(device->timeout_list,
+					GUINT_TO_POINTER(data->timeout));
 	data->timeout =3D 0;
 =

 	if (data->func)
@@ -1132,7 +1144,9 @@ bool qmi_device_discover(struct qmi_device *device, q=
mi_discover_func_t func,
 	data->destroy =3D destroy;
 =

 	if (device->version_list) {
-		g_timeout_add_seconds(0, discover_reply, data);
+		data->timeout =3D g_timeout_add_seconds(0, discover_reply, data);
+		device->timeout_list =3D g_list_append(device->timeout_list,
+					GUINT_TO_POINTER(data->timeout));
 		return true;
 	}
 =

@@ -1153,6 +1167,8 @@ bool qmi_device_discover(struct qmi_device *device, q=
mi_discover_func_t func,
 	__request_submit(device, req, hdr->transaction);
 =

 	data->timeout =3D g_timeout_add_seconds(5, discover_reply, data);
+	device->timeout_list =3D g_list_append(device->timeout_list,
+					GUINT_TO_POINTER(data->timeout));
 =

 	return true;
 }
@@ -1188,11 +1204,16 @@ struct shutdown_data {
 	qmi_shutdown_func_t func;
 	void *user_data;
 	qmi_destroy_func_t destroy;
+	guint timeout;
 };
 =

 static gboolean shutdown_reply(gpointer user_data)
 {
 	struct shutdown_data *data =3D user_data;
+	struct qmi_device *device =3D data->device;
+
+	device->timeout_list =3D g_list_remove(device->timeout_list,
+					GUINT_TO_POINTER(data->timeout));
 =

 	if (data->func)
 		data->func(data->user_data);
@@ -1233,9 +1254,13 @@ bool qmi_device_shutdown(struct qmi_device *device, =
qmi_shutdown_func_t func,
 	data->destroy =3D destroy;
 =

 	if (device->release_users > 0)
-		g_timeout_add_seconds(0, shutdown_timeout, data);
+		data->timeout =3D g_timeout_add_seconds(0, shutdown_timeout,
+							data);
 	else
-		g_timeout_add_seconds(0, shutdown_reply, data);
+		data->timeout =3D g_timeout_add_seconds(0, shutdown_reply, data);
+
+	device->timeout_list =3D g_list_append(device->timeout_list,
+					GUINT_TO_POINTER(data->timeout));
 =

 	return true;
 }
@@ -1717,6 +1742,10 @@ struct service_create_data {
 static gboolean service_create_reply(gpointer user_data)
 {
 	struct service_create_data *data =3D user_data;
+	struct qmi_device *device =3D data->device;
+
+	device->timeout_list =3D g_list_remove(device->timeout_list,
+					GUINT_TO_POINTER(data->timeout));
 =

 	data->func(NULL, data->user_data);
 =

@@ -1740,6 +1769,8 @@ static void service_create_callback(uint16_t message,=
 uint16_t length,
 	unsigned int hash_id;
 =

 	g_source_remove(data->timeout);
+	device->timeout_list =3D g_list_remove(device->timeout_list,
+					GUINT_TO_POINTER(data->timeout));
 =

 	result_code =3D tlv_get(buffer, length, 0x02, &len);
 	if (!result_code)
@@ -1816,10 +1847,17 @@ static void service_create_discover(uint8_t count,
 			client_req, sizeof(client_req),
 			service_create_callback, data, (void **) &hdr);
 	if (!req) {
-		if (data->timeout > 0)
+		if (data->timeout > 0) {
 			g_source_remove(data->timeout);
+			device->timeout_list =3D
+				g_list_remove(device->timeout_list,
+					GUINT_TO_POINTER(data->timeout));
+		}
 =

-		g_timeout_add_seconds(0, service_create_reply, data);
+		data->timeout =3D g_timeout_add_seconds(0, service_create_reply,
+							data);
+		device->timeout_list =3D g_list_append(device->timeout_list,
+					GUINT_TO_POINTER(data->timeout));
 		return;
 	}
 =

@@ -1864,6 +1902,8 @@ static bool service_create(struct qmi_device *device,=
 bool shared,
 =

 done:
 	data->timeout =3D g_timeout_add_seconds(8, service_create_reply, data);
+	device->timeout_list =3D g_list_append(device->timeout_list,
+					GUINT_TO_POINTER(data->timeout));
 =

 	return true;
 }
@@ -1886,11 +1926,16 @@ struct service_create_shared_data {
 	qmi_create_func_t func;
 	void *user_data;
 	qmi_destroy_func_t destroy;
+	guint timeout;
 };
 =

 static gboolean service_create_shared_reply(gpointer user_data)
 {
 	struct service_create_shared_data *data =3D user_data;
+	struct qmi_device *device =3D data->service->device;
+
+	device->timeout_list =3D g_list_remove(device->timeout_list,
+					GUINT_TO_POINTER(data->timeout));
 =

 	data->func(data->service, data->user_data);
 =

@@ -1932,7 +1977,10 @@ bool qmi_service_create_shared(struct qmi_device *de=
vice,
 		data->user_data =3D user_data;
 		data->destroy =3D destroy;
 =

-		g_timeout_add(0, service_create_shared_reply, data);
+		data->timeout =3D g_timeout_add(0, service_create_shared_reply,
+						data);
+		device->timeout_list =3D g_list_append(device->timeout_list,
+					GUINT_TO_POINTER(data->timeout));
 =

 		return 0;
 	}
-- =

2.7.4


--===============6263316472363041335==--

