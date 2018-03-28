Content-Type: multipart/mixed; boundary="===============7986576377497961432=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC PATCH 22/30] qmi: move client_id to qmi_version
Date: Wed, 28 Mar 2018 21:00:08 +0200
Message-ID: <20180328190016.28509-23-jonas@southpole.se>
In-Reply-To: <20180328190016.28509-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7986576377497961432==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Given that services are always shared now, there will ever only be one
instance of a service of a given type and therefore only one client_id
per service type.  As such, we can move  the client_id in to the service
description proper.

Calling the service description qmi_version is a bit confusing and, as
such, the struct will be renamed later.  For now, the target is to try
to unify the version_list and the service_list as they currently
describe pretty much the same thing; the services from the service list
are already set up to point to a struct in version_list for a subset of
their data.
---
 drivers/qmimodem/qmi.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 76af132b..5178228b 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -50,6 +50,7 @@ struct qmi_version {
 	uint16_t major;
 	uint16_t minor;
 	const char *name;
+	uint8_t client_id;
 };
 =

 struct qmi_device {
@@ -86,7 +87,6 @@ struct qmi_service {
 	int ref_count;
 	struct qmi_device *device;
 	struct qmi_version *info;
-	uint8_t client_id;
 	struct list_head notify_list;
 };
 =

@@ -1902,10 +1902,10 @@ static void service_create_callback(uint16_t messag=
e, uint16_t length,
 		}
 	}
 =

-	service->client_id =3D client_id->client;
+	service->info->client_id =3D client_id->client;
 =

 	__debug_device(device, "service created [client=3D%d,type=3D%d]",
-					service->client_id, service->info->type);
+					service->info->client_id, service->info->type);
 =

 	/* FIXME: maybe sort these by type...??? */
 	list_add_tail(&service->node, &device->service_list);
@@ -2032,6 +2032,8 @@ static void service_release_callback(uint16_t message=
, uint16_t length,
 	if (service->device)
 		service->device->release_users--;
 =

+	service->info->client_id =3D 0;
+
 	g_free(service);
 }
 =

@@ -2065,7 +2067,8 @@ void qmi_service_unref(struct qmi_service *service)
 =

 	service->device->release_users++;
 =

-	release_client(service->device, service->info->type, service->client_id,
+	release_client(service->device, service->info->type,
+					service->info->client_id,
 					service_release_callback, service);
 }
 =

@@ -2147,7 +2150,7 @@ uint16_t qmi_service_send(struct qmi_service *service,
 	if (!service)
 		return 0;
 =

-	if (!service->client_id)
+	if (!service->info->client_id)
 		return 0;
 =

 	device =3D service->device;
@@ -2162,7 +2165,8 @@ uint16_t qmi_service_send(struct qmi_service *service,
 	data->user_data =3D user_data;
 	data->destroy =3D destroy;
 =

-	r =3D __request_submit(device, service->info->type, service->client_id,
+	r =3D __request_submit(device, service->info->type,
+				service->info->client_id,
 				message,
 				param ? param->data : NULL,
 				param ? param->length : 0,
@@ -2184,7 +2188,7 @@ bool qmi_service_cancel_all(struct qmi_service *servi=
ce)
 	if (!service)
 		return false;
 =

-	if (!service->client_id)
+	if (!service->info->client_id)
 		return false;
 =

 	device =3D service->device;
@@ -2192,7 +2196,7 @@ bool qmi_service_cancel_all(struct qmi_service *servi=
ce)
 		return false;
 =

 	list_for_each_entry_safe(req, req_t, &device->req_queue, node) {
-		if (req->client =3D=3D service->client_id) {
+		if (req->client =3D=3D service->info->client_id) {
 			list_del(&req->node);
 =

 			service_send_free(req->user_data);
@@ -2203,7 +2207,7 @@ bool qmi_service_cancel_all(struct qmi_service *servi=
ce)
 	}
 =

 	list_for_each_entry_safe(req, req_t, &device->service_queue, node) {
-		if (req->client =3D=3D service->client_id) {
+		if (req->client =3D=3D service->info->client_id) {
 			list_del(&req->node);
 =

 			service_send_free(req->user_data);
-- =

2.15.1


--===============7986576377497961432==--

