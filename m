Content-Type: multipart/mixed; boundary="===============7491760377304235077=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 5/6] qmi: make version_list private
Date: Tue, 03 Apr 2018 16:50:55 +0200
Message-ID: <20180403145056.25817-5-jonas@southpole.se>
In-Reply-To: <20180403145056.25817-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7491760377304235077==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/qmimodem/qmi.c | 47 +++++++++++++++++++++++++++++++---
 drivers/qmimodem/qmi.h | 14 ++++-------
 plugins/gobi.c         | 68 +++++++++++++++++++---------------------------=
----
 3 files changed, 74 insertions(+), 55 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 750f3b00..0ef84b50 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -47,6 +47,13 @@ struct discovery {
 	qmi_destroy_func_t destroy;
 };
 =

+struct qmi_version {
+	uint8_t type;
+	uint16_t major;
+	uint16_t minor;
+	const char *name;
+};
+
 struct qmi_device {
 	int ref_count;
 	int fd;
@@ -1102,6 +1109,41 @@ static const void *tlv_get(const void *data, uint16_=
t size,
 	return NULL;
 }
 =

+bool qmi_device_get_service_version(struct qmi_device* device, uint8_t typ=
e,
+					uint16_t *major, uint16_t *minor)
+{
+	struct qmi_version* info;
+	int i;
+
+	for (i =3D 0, info =3D device->version_list;
+			i < device->version_count;
+			i++, info++) {
+		if (info->type =3D=3D type) {
+			*major =3D info->major;
+			*minor =3D info->minor;
+			return true;
+		}
+	}
+
+	return false;
+}
+
+bool qmi_device_has_service(struct qmi_device* device, uint8_t type)
+{
+	struct qmi_version* info;
+	int i;
+
+	for (i =3D 0, info =3D device->version_list;
+			i < device->version_count;
+			i++, info++) {
+		if (info->type =3D=3D type) {
+			return true;
+		}
+	}
+
+	return false;
+}
+
 struct discover_data {
 	struct discovery super;
 	struct qmi_device *device;
@@ -1201,7 +1243,7 @@ done:
 	device->version_count =3D count;
 =

 	if (data->func)
-		data->func(count, list, data->user_data);
+		data->func(data->user_data);
 =

 	__qmi_device_discovery_complete(data->device, &data->super);
 }
@@ -1237,8 +1279,7 @@ static gboolean discover_reply(gpointer user_data)
 	}
 =

 	if (data->func)
-		data->func(device->version_count,
-				device->version_list, data->user_data);
+		data->func(data->user_data);
 =

 	__qmi_device_discovery_complete(data->device, &data->super);
 	__request_free(req, NULL);
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index e1801045..a5960e2a 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -61,13 +61,6 @@ enum qmi_device_expected_data_format {
 	QMI_DEVICE_EXPECTED_DATA_FORMAT_RAW_IP,
 };
 =

-struct qmi_version {
-	uint8_t type;
-	uint16_t major;
-	uint16_t minor;
-	const char *name;
-};
-
 void qmi_free(void *ptr);
 =

 typedef void (*qmi_destroy_func_t)(void *user_data);
@@ -78,8 +71,7 @@ struct qmi_device;
 typedef void (*qmi_debug_func_t)(const char *str, void *user_data);
 typedef void (*qmi_sync_func_t)(void *user_data);
 typedef void (*qmi_shutdown_func_t)(void *user_data);
-typedef void (*qmi_discover_func_t)(uint8_t count,
-			const struct qmi_version *list, void *user_data);
+typedef void (*qmi_discover_func_t)(void *user_data);
 =

 struct qmi_device *qmi_device_new(int fd);
 =

@@ -96,6 +88,10 @@ bool qmi_device_discover(struct qmi_device *device, qmi_=
discover_func_t func,
 bool qmi_device_shutdown(struct qmi_device *device, qmi_shutdown_func_t fu=
nc,
 				void *user_data, qmi_destroy_func_t destroy);
 =

+bool qmi_device_has_service(struct qmi_device* device, uint8_t type);
+bool qmi_device_get_service_version(struct qmi_device* device, uint8_t typ=
e,
+					uint16_t *major, uint16_t *minor);
+
 bool qmi_device_sync(struct qmi_device *device,
 		     qmi_sync_func_t func, void *user_data);
 bool qmi_device_is_sync_supported(struct qmi_device *device);
diff --git a/plugins/gobi.c b/plugins/gobi.c
index dc466a86..85218913 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -264,56 +264,38 @@ static void create_shared_dms(void *user_data)
 				  create_dms_cb, modem, NULL);
 }
 =

-static void discover_cb(uint8_t count, const struct qmi_version *list,
-							void *user_data)
+static void discover_cb(void *user_data)
 {
 	struct ofono_modem *modem =3D user_data;
 	struct gobi_data *data =3D ofono_modem_get_data(modem);
-	uint8_t i;
+	uint16_t major, minor;
 =

 	DBG("");
 =

-	for (i =3D 0; i < count; i++) {
-		DBG("%s %d.%d - %d", list[i].name, list[i].major, list[i].minor,
-				list[i].type);
-
-		switch (list[i].type) {
-		case QMI_SERVICE_DMS:
-			data->features |=3D GOBI_DMS;
-			break;
-		case QMI_SERVICE_NAS:
-			data->features |=3D GOBI_NAS;
-			break;
-		case QMI_SERVICE_WMS:
-			data->features |=3D GOBI_WMS;
-			break;
-		case QMI_SERVICE_WDS:
-			data->features |=3D GOBI_WDS;
-			break;
-		case QMI_SERVICE_WDA:
-			data->features |=3D GOBI_WDA;
-			break;
-		case QMI_SERVICE_PDS:
-			data->features |=3D GOBI_PDS;
-			break;
-		case QMI_SERVICE_PBM:
-			data->features |=3D GOBI_PBM;
-			break;
-		case QMI_SERVICE_UIM:
-			data->features |=3D GOBI_UIM;
-			break;
-		case QMI_SERVICE_CAT:
-			data->features |=3D GOBI_CAT;
-			break;
-		case QMI_SERVICE_CAT_OLD:
-			if (list[i].major > 0)
-				data->features |=3D GOBI_CAT_OLD;
-			break;
-		case QMI_SERVICE_VOICE:
+	if (qmi_device_has_service(data->device, QMI_SERVICE_DMS))
+		data->features |=3D GOBI_DMS;
+	if (qmi_device_has_service(data->device, QMI_SERVICE_NAS))
+		data->features |=3D GOBI_NAS;
+	if (qmi_device_has_service(data->device, QMI_SERVICE_WMS))
+		data->features |=3D GOBI_WMS;
+	if (qmi_device_has_service(data->device, QMI_SERVICE_WDS))
+		data->features |=3D GOBI_WDS;
+	if (qmi_device_has_service(data->device, QMI_SERVICE_WDA))
+		data->features |=3D GOBI_WDA;
+	if (qmi_device_has_service(data->device, QMI_SERVICE_PDS))
+		data->features |=3D GOBI_PDS;
+	if (qmi_device_has_service(data->device, QMI_SERVICE_PBM))
+		data->features |=3D GOBI_PBM;
+	if (qmi_device_has_service(data->device, QMI_SERVICE_UIM))
+		data->features |=3D GOBI_UIM;
+	if (qmi_device_has_service(data->device, QMI_SERVICE_CAT))
+		data->features |=3D GOBI_CAT;
+	if (qmi_device_get_service_version(data->device,
+				QMI_SERVICE_CAT_OLD, &major, &minor))
+		if (major > 0)
+			data->features |=3D GOBI_CAT_OLD;
+	if (qmi_device_has_service(data->device, QMI_SERVICE_VOICE))
 			data->features |=3D GOBI_VOICE;
-			break;
-		}
-	}
 =

 	if (!(data->features & GOBI_DMS)) {
 		if (++data->discover_attempts < 3) {
-- =

2.15.1


--===============7491760377304235077==--

