Content-Type: multipart/mixed; boundary="===============4847038864581320729=="
MIME-Version: 1.0
From: Lukasz Nowak <lnowak.tyco@gmail.com>
Subject: [PATCH v5 1/2] qmimodem: add protection against modem_unregister
Date: Mon, 27 Mar 2017 09:56:17 +0100
Message-ID: <1490604978-10639-2-git-send-email-lnowak.tyco@gmail.com>
In-Reply-To: <1490604978-10639-1-git-send-email-lnowak.tyco@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4847038864581320729==
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

In order to solve this problem, add calls to qmi_device_ref
before setting up each timeout. Then inside callbacks, check
if this is the last reference (i.e. gobi_remove() has been called).
If that happens, do not operate on memory, just clean-up and exit.
---
 drivers/qmimodem/qmi.c | 39 +++++++++++++++++++++++++++++++++------
 drivers/qmimodem/qmi.h |  2 +-
 2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 8a9a88d..db36ddf 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -912,13 +912,17 @@ struct qmi_device *qmi_device_ref(struct qmi_device *=
device)
 	return device;
 }
 =

-void qmi_device_unref(struct qmi_device *device)
+/*
+ * Return TRUE if this was the last reference of the device and all
+ * data structures have been freed.
+ */
+bool qmi_device_unref(struct qmi_device *device)
 {
 	if (!device)
-		return;
+		return FALSE;
 =

 	if (__sync_sub_and_fetch(&device->ref_count, 1))
-		return;
+		return FALSE;
 =

 	__debug_device(device, "device %p free", device);
 =

@@ -946,6 +950,8 @@ void qmi_device_unref(struct qmi_device *device)
 	g_free(device->version_list);
 =

 	g_free(device);
+
+	return TRUE;
 }
 =

 void qmi_device_set_debug(struct qmi_device *device,
@@ -1013,6 +1019,9 @@ static void discover_callback(uint16_t message, uint1=
6_t length,
 =

 	g_source_remove(data->timeout);
 =

+	if (qmi_device_unref(device))
+		goto error;
+
 	count =3D 0;
 	list =3D NULL;
 =

@@ -1083,6 +1092,7 @@ done:
 	if (data->func)
 		data->func(count, list, data->user_data);
 =

+error:
 	if (data->destroy)
 		data->destroy(data->user_data);
 =

@@ -1096,7 +1106,7 @@ static gboolean discover_reply(gpointer user_data)
 =

 	data->timeout =3D 0;
 =

-	if (data->func)
+	if (!qmi_device_unref(data->device) && data->func)
 		data->func(device->version_count,
 				device->version_list, data->user_data);
 =

@@ -1130,6 +1140,7 @@ bool qmi_device_discover(struct qmi_device *device, q=
mi_discover_func_t func,
 	data->destroy =3D destroy;
 =

 	if (device->version_list) {
+		qmi_device_ref(device);
 		g_timeout_add_seconds(0, discover_reply, data);
 		return true;
 	}
@@ -1150,6 +1161,7 @@ bool qmi_device_discover(struct qmi_device *device, q=
mi_discover_func_t func,
 =

 	__request_submit(device, req, hdr->transaction);
 =

+	qmi_device_ref(device);
 	data->timeout =3D g_timeout_add_seconds(5, discover_reply, data);
 =

 	return true;
@@ -1192,7 +1204,7 @@ static gboolean shutdown_reply(gpointer user_data)
 {
 	struct shutdown_data *data =3D user_data;
 =

-	if (data->func)
+	if (!qmi_device_unref(data->device) && data->func)
 		data->func(data->user_data);
 =

 	g_free(data);
@@ -1205,6 +1217,12 @@ static gboolean shutdown_timeout(gpointer user_data)
 	struct shutdown_data *data =3D user_data;
 	struct qmi_device *device =3D data->device;
 =

+	if (qmi_device_unref(data->device)) {
+		g_free(data);
+		return FALSE;
+	}
+
+	qmi_device_ref(device);
 	if (device->release_users > 0)
 		return TRUE;
 =

@@ -1230,6 +1248,7 @@ bool qmi_device_shutdown(struct qmi_device *device, q=
mi_shutdown_func_t func,
 	data->user_data =3D user_data;
 	data->destroy =3D destroy;
 =

+	qmi_device_ref(device);
 	if (device->release_users > 0)
 		g_timeout_add_seconds(0, shutdown_timeout, data);
 	else
@@ -1716,7 +1735,8 @@ static gboolean service_create_reply(gpointer user_da=
ta)
 {
 	struct service_create_data *data =3D user_data;
 =

-	data->func(NULL, data->user_data);
+	if (!qmi_device_unref(data->device))
+		data->func(NULL, data->user_data);
 =

 	if (data->destroy)
 		data->destroy(data->user_data);
@@ -1739,6 +1759,9 @@ static void service_create_callback(uint16_t message,=
 uint16_t length,
 =

 	g_source_remove(data->timeout);
 =

+	if (qmi_device_unref(data->device))
+		goto error;
+
 	result_code =3D tlv_get(buffer, length, 0x02, &len);
 	if (!result_code)
 		goto done;
@@ -1781,6 +1804,7 @@ static void service_create_callback(uint16_t message,=
 uint16_t length,
 done:
 	data->func(service, data->user_data);
 =

+error:
 	qmi_service_unref(service);
 =

 	if (data->destroy)
@@ -1816,6 +1840,8 @@ static void service_create_discover(uint8_t count,
 	if (!req) {
 		if (data->timeout > 0)
 			g_source_remove(data->timeout);
+		else
+			qmi_device_ref(device);
 =

 		g_timeout_add_seconds(0, service_create_reply, data);
 		return;
@@ -1861,6 +1887,7 @@ static bool service_create(struct qmi_device *device,=
 bool shared,
 	return false;
 =

 done:
+	qmi_device_ref(device);
 	data->timeout =3D g_timeout_add_seconds(8, service_create_reply, data);
 =

 	return true;
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 2233cdb..22cdcac 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -77,7 +77,7 @@ typedef void (*qmi_discover_func_t)(uint8_t count,
 struct qmi_device *qmi_device_new(int fd);
 =

 struct qmi_device *qmi_device_ref(struct qmi_device *device);
-void qmi_device_unref(struct qmi_device *device);
+bool qmi_device_unref(struct qmi_device *device);
 =

 void qmi_device_set_debug(struct qmi_device *device,
 				qmi_debug_func_t func, void *user_data);
-- =

2.7.4


--===============4847038864581320729==--

