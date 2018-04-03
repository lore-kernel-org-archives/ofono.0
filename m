Content-Type: multipart/mixed; boundary="===============4816162036735212191=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 6/6] qmi: make services always shared
Date: Tue, 03 Apr 2018 16:50:56 +0200
Message-ID: <20180403145056.25817-6-jonas@southpole.se>
In-Reply-To: <20180403145056.25817-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4816162036735212191==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/qmimodem/qmi.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 0ef84b50..06a4cf4e 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -87,7 +87,6 @@ struct qmi_device {
 struct qmi_service {
 	int ref_count;
 	struct qmi_device *device;
-	bool shared;
 	uint8_t type;
 	uint16_t major;
 	uint16_t minor;
@@ -261,9 +260,6 @@ static gboolean __service_compare_shared(gpointer key, =
gpointer value,
 	struct qmi_service *service =3D value;
 	uint8_t type =3D GPOINTER_TO_UINT(user_data);
 =

-	if (!service->shared)
-		return FALSE;
-
 	if (service->type =3D=3D type)
 		return TRUE;
 =

@@ -1936,7 +1932,6 @@ bool qmi_result_get_uint64(struct qmi_result *result,=
 uint8_t type,
 struct service_create_data {
 	struct discovery super;
 	struct qmi_device *device;
-	bool shared;
 	uint8_t type;
 	uint16_t major;
 	uint16_t minor;
@@ -2007,7 +2002,6 @@ static void service_create_callback(uint16_t message,=
 uint16_t length,
 =

 	service->ref_count =3D 1;
 	service->device =3D data->device;
-	service->shared =3D data->shared;
 =

 	service->type =3D data->type;
 	service->major =3D data->major;
@@ -2030,7 +2024,7 @@ done:
 	__qmi_device_discovery_complete(data->device, &data->super);
 }
 =

-static bool service_create(struct qmi_device *device, bool shared,
+static bool service_create(struct qmi_device *device,
 				uint8_t type, qmi_create_func_t func,
 				void *user_data, qmi_destroy_func_t destroy)
 {
@@ -2048,7 +2042,6 @@ static bool service_create(struct qmi_device *device,=
 bool shared,
 =

 	data->super.destroy =3D service_create_data_free;
 	data->device =3D device;
-	data->shared =3D shared;
 	data->type =3D type;
 	data->func =3D func;
 	data->user_data =3D user_data;
@@ -2077,19 +2070,6 @@ static bool service_create(struct qmi_device *device=
, bool shared,
 	return true;
 }
 =

-bool qmi_service_create(struct qmi_device *device,
-				uint8_t type, qmi_create_func_t func,
-				void *user_data, qmi_destroy_func_t destroy)
-{
-	if (!device || !func)
-		return false;
-
-	if (type =3D=3D QMI_SERVICE_CONTROL)
-		return false;
-
-	return service_create(device, false, type, func, user_data, destroy);
-}
-
 struct service_create_shared_data {
 	struct discovery super;
 	struct qmi_service *service;
@@ -2165,7 +2145,15 @@ bool qmi_service_create_shared(struct qmi_device *de=
vice,
 		return 0;
 	}
 =

-	return service_create(device, true, type, func, user_data, destroy);
+	return service_create(device, type, func, user_data, destroy);
+}
+
+bool qmi_service_create(struct qmi_device *device,
+				uint8_t type, qmi_create_func_t func,
+				void *user_data, qmi_destroy_func_t destroy)
+{
+	return qmi_service_create_shared(device, type, func,
+						user_data, destroy);
 }
 =

 static void service_release_callback(uint16_t message, uint16_t length,
-- =

2.15.1


--===============4816162036735212191==--

