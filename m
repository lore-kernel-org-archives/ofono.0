Content-Type: multipart/mixed; boundary="===============2501266830992698361=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC PATCH 18/30] qmi: switch notify_list to list_head type
Date: Wed, 28 Mar 2018 21:00:04 +0200
Message-ID: <20180328190016.28509-19-jonas@southpole.se>
In-Reply-To: <20180328190016.28509-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2501266830992698361==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/qmimodem/qmi.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index a3a04768..75c68434 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -82,7 +82,7 @@ struct qmi_service {
 	uint16_t major;
 	uint16_t minor;
 	uint8_t client_id;
-	GList *notify_list;
+	struct list_head notify_list;
 };
 =

 struct qmi_param {
@@ -109,6 +109,7 @@ struct qmi_request {
 };
 =

 struct qmi_notify {
+	struct list_head node;
 	uint16_t message;
 	qmi_result_func_t callback;
 	void *user_data;
@@ -250,16 +251,6 @@ static struct qmi_request* __request_find_by_tid(struc=
t list_head *queue,
 	return NULL;
 }
 =

-static void __notify_free(gpointer data, gpointer user_data)
-{
-	struct qmi_notify *notify =3D data;
-
-	if (notify->destroy)
-		notify->destroy(notify->user_data);
-
-	g_free(notify);
-}
-
 static void __hexdump(const char dir, const unsigned char *buf, size_t len,
 				qmi_debug_func_t function, void *user_data)
 {
@@ -694,12 +685,9 @@ static void wakeup_writer(struct qmi_device *device)
 static void service_notify(struct qmi_service* service,
 				struct qmi_result* result)
 {
-	GList *list;
-
-	for (list =3D g_list_first(service->notify_list); list;
-						list =3D g_list_next(list)) {
-		struct qmi_notify *notify =3D list->data;
+	struct qmi_notify *notify;
 =

+	list_for_each_entry(notify, &service->notify_list, node) {
 		if (notify->message =3D=3D result->message)
 			notify->callback(result, notify->user_data);
 	}
@@ -1860,6 +1848,7 @@ static void service_create_callback(uint16_t message,=
 uint16_t length,
 		goto done;
 =

 	INIT_LIST_HEAD(&service->node);
+	INIT_LIST_HEAD(&service->notify_list);
 	service->ref_count =3D 1;
 	service->device =3D data->device;
 =

@@ -2205,25 +2194,31 @@ bool qmi_service_register(struct qmi_service *servi=
ce,
 	if (!notify)
 		return false;
 =

+	INIT_LIST_HEAD(&notify->node);
 	notify->message =3D message;
 	notify->callback =3D func;
 	notify->user_data =3D user_data;
 	notify->destroy =3D destroy;
 =

-	service->notify_list =3D g_list_append(service->notify_list, notify);
+	list_add_tail(&notify->node, &service->notify_list);
 =

 	return true;
 }
 =

 bool qmi_service_unregister_all(struct qmi_service *service)
 {
+	struct qmi_notify *notify, *notify_t;
+
 	if (!service)
 		return false;
 =

-	g_list_foreach(service->notify_list, __notify_free, NULL);
-	g_list_free(service->notify_list);
-
-	service->notify_list =3D NULL;
+	list_for_each_entry_safe(notify, notify_t,
+				&service->notify_list, node) {
+		list_del(&notify->node);
+		if (notify->destroy)
+			notify->destroy(notify->user_data);
+		g_free(notify);
+	}
 =

 	return true;
 }
-- =

2.15.1


--===============2501266830992698361==--

