Content-Type: multipart/mixed; boundary="===============0467959457280779123=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC PATCH 16/30] qmi: make services always shared
Date: Wed, 28 Mar 2018 21:00:02 +0200
Message-ID: <20180328190016.28509-17-jonas@southpole.se>
In-Reply-To: <20180328190016.28509-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0467959457280779123==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/qmimodem/qmi.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index f212aa96..fcb9a5e4 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -77,7 +77,6 @@ struct qmi_device {
 struct qmi_service {
 	int ref_count;
 	struct qmi_device *device;
-	bool shared;
 	uint8_t type;
 	uint16_t major;
 	uint16_t minor;
@@ -266,9 +265,6 @@ static gboolean __service_compare_shared(gpointer key, =
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

@@ -1824,7 +1820,6 @@ bool qmi_result_get_uint64(struct qmi_result *result,=
 uint8_t type,
 =

 struct service_create_data {
 	struct qmi_device *device;
-	bool shared;
 	uint8_t type;
 	uint16_t major;
 	uint16_t minor;
@@ -1883,7 +1878,6 @@ static void service_create_callback(uint16_t message,=
 uint16_t length,
 =

 	service->ref_count =3D 1;
 	service->device =3D data->device;
-	service->shared =3D data->shared;
 =

 	service->type =3D data->type;
 	service->major =3D data->major;
@@ -1906,7 +1900,7 @@ done:
 	service_create_data_free(data);
 }
 =

-static bool service_create(struct qmi_device *device, bool shared,
+static bool service_create(struct qmi_device *device,
 				uint8_t type, qmi_create_func_t func,
 				void *user_data, qmi_destroy_func_t destroy)
 {
@@ -1919,7 +1913,6 @@ static bool service_create(struct qmi_device *device,=
 bool shared,
 		return false;
 =

 	data->device =3D device;
-	data->shared =3D shared;
 	data->type =3D type;
 	data->func =3D func;
 	data->user_data =3D user_data;
@@ -1943,19 +1936,6 @@ static bool service_create(struct qmi_device *device=
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
 	struct qmi_service *service;
 	struct qmi_device *device;
@@ -2032,7 +2012,15 @@ bool qmi_service_create_shared(struct qmi_device *de=
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


--===============0467959457280779123==--

