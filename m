Content-Type: multipart/mixed; boundary="===============8197419380307497469=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: [PATCH][v2 3/4] qmi: implement the control sync command
Date: Tue, 05 Dec 2017 18:52:36 +0100
Message-ID: <20171205175237.17399-3-lynxis@fe80.eu>
In-Reply-To: <20171205175237.17399-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8197419380307497469==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The sync command resets the QMI interface state. It will flushs all
previous assigned sessions and transactions.
---
 drivers/qmimodem/qmi.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 drivers/qmimodem/qmi.h |  6 ++++-
 2 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 0269f7729be0..8bb71b0513ed 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1342,6 +1342,65 @@ bool qmi_device_shutdown(struct qmi_device *device, =
qmi_shutdown_func_t func,
 	return true;
 }
 =

+struct sync_data {
+	qmi_sync_func_t func;
+	void *user_data;
+};
+
+static void qmi_device_sync_callback(uint16_t message, uint16_t length,
+				     const void *buffer, void *user_data)
+{
+	struct sync_data *data =3D user_data;
+
+	if (data->func)
+		data->func(data->user_data);
+
+	g_free(data);
+}
+
+/* sync will release all previous clients */
+bool qmi_device_sync(struct qmi_device *device,
+		     qmi_sync_func_t func, void *user_data)
+{
+	struct qmi_request *req;
+	struct qmi_control_hdr *hdr;
+	struct sync_data *func_data;
+
+	if (!device)
+		return false;
+
+	__debug_device(device, "Sending sync to reset QMI");
+
+	func_data =3D g_new0(struct sync_data, 1);
+	func_data->func =3D func;
+	func_data->user_data =3D user_data;
+
+	req =3D __request_alloc(QMI_SERVICE_CONTROL, 0x00,
+			QMI_CTL_SYNC, QMI_CONTROL_HDR_SIZE,
+			NULL, 0,
+			qmi_device_sync_callback, func_data, (void **) &hdr);
+
+	if (device->next_control_tid < 1)
+		device->next_control_tid =3D 1;
+
+	hdr->type =3D 0x00;
+	hdr->transaction =3D device->next_control_tid++;
+
+	__request_submit(device, req, hdr->transaction);
+
+	return true;
+}
+
+/* if the device support the QMI call SYNC over the CTL interface */
+bool qmi_device_is_sync_supported(struct qmi_device *device)
+{
+	if (device =3D=3D NULL)
+		return false;
+
+	return (device->control_major > 1 ||
+		(device->control_major =3D=3D 1 && device->control_minor >=3D 5));
+}
+
 static bool get_device_file_name(struct qmi_device *device,
 					char *file_name, int size)
 {
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index b4955b40b1fb..40d398229af8 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -76,7 +76,7 @@ typedef void (*qmi_destroy_func_t)(void *user_data);
 struct qmi_device;
 =

 typedef void (*qmi_debug_func_t)(const char *str, void *user_data);
-
+typedef void (*qmi_sync_func_t)(void *user_data);
 typedef void (*qmi_shutdown_func_t)(void *user_data);
 typedef void (*qmi_discover_func_t)(uint8_t count,
 			const struct qmi_version *list, void *user_data);
@@ -96,6 +96,10 @@ bool qmi_device_discover(struct qmi_device *device, qmi_=
discover_func_t func,
 bool qmi_device_shutdown(struct qmi_device *device, qmi_shutdown_func_t fu=
nc,
 				void *user_data, qmi_destroy_func_t destroy);
 =

+bool qmi_device_sync(struct qmi_device *device,
+		     qmi_sync_func_t func, void *user_data);
+bool qmi_device_is_sync_supported(struct qmi_device *device);
+
 enum qmi_device_expected_data_format qmi_device_get_expected_data_format(
 						struct qmi_device *device);
 bool qmi_device_set_expected_data_format(struct qmi_device *device,
-- =

2.15.1


--===============8197419380307497469==--

