Content-Type: multipart/mixed; boundary="===============1133620775062985448=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC PATCH 25/30] qmi: move service device to service_info
Date: Wed, 28 Mar 2018 21:00:11 +0200
Message-ID: <20180328190016.28509-26-jonas@southpole.se>
In-Reply-To: <20180328190016.28509-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1133620775062985448==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/qmimodem/qmi.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index fb70861a..00b3ccbe 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -47,6 +47,7 @@ typedef void (*qmi_message_func_t)(uint16_t message, uint=
16_t length,
 =

 struct qmi_service_info {
 	struct list_head node;
+	struct qmi_device *device;
 	uint8_t type;
 	uint16_t major;
 	uint16_t minor;
@@ -85,7 +86,6 @@ struct qmi_device {
 struct qmi_service {
 	struct list_head node;
 	int ref_count;
-	struct qmi_device *device;
 	struct qmi_service_info *info;
 	struct list_head notify_list;
 };
@@ -1880,7 +1880,6 @@ static void service_create_callback(uint16_t message,=
 uint16_t length,
 	INIT_LIST_HEAD(&service->node);
 	INIT_LIST_HEAD(&service->notify_list);
 	service->ref_count =3D 1;
-	service->device =3D data->device;
 =

 	list_for_each_entry(info, &device->service_info, node)
 		if (info->type =3D=3D data->type) {
@@ -1888,6 +1887,7 @@ static void service_create_callback(uint16_t message,=
 uint16_t length,
 			break;
 		}
 =

+	service->info->device =3D data->device;
 	service->info->client_id =3D client_id->client;
 =

 	__debug_device(device, "service created [client=3D%d,type=3D%d]",
@@ -2015,8 +2015,8 @@ static void service_release_callback(uint16_t message=
, uint16_t length,
 {
 	struct qmi_service *service =3D user_data;
 =

-	if (service->device)
-		service->device->release_users--;
+	if (service->info->device)
+		service->info->device->release_users--;
 =

 	service->info->client_id =3D 0;
 =

@@ -2041,7 +2041,7 @@ void qmi_service_unref(struct qmi_service *service)
 	if (__sync_sub_and_fetch(&service->ref_count, 1))
 		return;
 =

-	if (!service->device) {
+	if (!service->info->device) {
 		g_free(service);
 		return;
 	}
@@ -2051,9 +2051,9 @@ void qmi_service_unref(struct qmi_service *service)
 =

 	list_del(&service->node);
 =

-	service->device->release_users++;
+	service->info->device->release_users++;
 =

-	release_client(service->device, service->info->type,
+	release_client(service->info->device, service->info->type,
 					service->info->client_id,
 					service_release_callback, service);
 }
@@ -2139,7 +2139,7 @@ uint16_t qmi_service_send(struct qmi_service *service,
 	if (!service->info->client_id)
 		return 0;
 =

-	device =3D service->device;
+	device =3D service->info->device;
 	if (!device)
 		return 0;
 =

@@ -2177,7 +2177,7 @@ bool qmi_service_cancel_all(struct qmi_service *servi=
ce)
 	if (!service->info->client_id)
 		return false;
 =

-	device =3D service->device;
+	device =3D service->info->device;
 	if (!device)
 		return false;
 =

-- =

2.15.1


--===============1133620775062985448==--

