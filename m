Content-Type: multipart/mixed; boundary="===============5206120805913819774=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC PATCH 11/30] qmi: remove unused qmi_service_unregister
Date: Wed, 28 Mar 2018 20:59:57 +0200
Message-ID: <20180328190016.28509-12-jonas@southpole.se>
In-Reply-To: <20180328190016.28509-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5206120805913819774==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Nothing in the codebase saves the notify ID when calling
qmi_service_register.  Nothing, therefore ever calls
qmi_service_unregister, either.
---
 drivers/qmimodem/qmi.c | 43 +++----------------------------------------
 drivers/qmimodem/qmi.h |  3 +--
 2 files changed, 4 insertions(+), 42 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 6cc858be..5ed41e0a 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -85,7 +85,6 @@ struct qmi_service {
 	uint16_t major;
 	uint16_t minor;
 	uint8_t client_id;
-	uint16_t next_notify_id;
 	GList *notify_list;
 };
 =

@@ -112,7 +111,6 @@ struct qmi_request {
 };
 =

 struct qmi_notify {
-	uint16_t id;
 	uint16_t message;
 	qmi_result_func_t callback;
 	void *user_data;
@@ -266,14 +264,6 @@ static void __notify_free(gpointer data, gpointer user=
_data)
 	g_free(notify);
 }
 =

-static gint __notify_compare(gconstpointer a, gconstpointer b)
-{
-	const struct qmi_notify *notify =3D a;
-	uint16_t id =3D GPOINTER_TO_UINT(b);
-
-	return notify->id - id;
-}
-
 static gboolean __service_compare_shared(gpointer key, gpointer value,
 							gpointer user_data)
 {
@@ -2338,23 +2328,19 @@ bool qmi_service_cancel_all(struct qmi_service *ser=
vice)
 	return true;
 }
 =

-uint16_t qmi_service_register(struct qmi_service *service,
+bool qmi_service_register(struct qmi_service *service,
 				uint16_t message, qmi_result_func_t func,
 				void *user_data, qmi_destroy_func_t destroy)
 {
 	struct qmi_notify *notify;
 =

 	if (!service || !func)
-		return 0;
+		return false;
 =

 	notify =3D g_try_new0(struct qmi_notify, 1);
 	if (!notify)
-		return 0;
-
-	if (service->next_notify_id < 1)
-		service->next_notify_id =3D 1;
+		return false;
 =

-	notify->id =3D service->next_notify_id++;
 	notify->message =3D message;
 	notify->callback =3D func;
 	notify->user_data =3D user_data;
@@ -2362,29 +2348,6 @@ uint16_t qmi_service_register(struct qmi_service *se=
rvice,
 =

 	service->notify_list =3D g_list_append(service->notify_list, notify);
 =

-	return notify->id;
-}
-
-bool qmi_service_unregister(struct qmi_service *service, uint16_t id)
-{
-	unsigned int nid =3D id;
-	struct qmi_notify *notify;
-	GList *list;
-
-	if (!service || !id)
-		return false;
-
-	list =3D g_list_find_custom(service->notify_list,
-				GUINT_TO_POINTER(nid), __notify_compare);
-	if (!list)
-		return false;
-
-	notify =3D list->data;
-
-	service->notify_list =3D g_list_delete_link(service->notify_list, list);
-
-	__notify_free(notify, NULL);
-
 	return true;
 }
 =

diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index bb8eb4a0..2c0d5aff 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -172,8 +172,7 @@ uint16_t qmi_service_send(struct qmi_service *service,
 				void *user_data, qmi_destroy_func_t destroy);
 bool qmi_service_cancel_all(struct qmi_service *service);
 =

-uint16_t qmi_service_register(struct qmi_service *service,
+bool qmi_service_register(struct qmi_service *service,
 				uint16_t message, qmi_result_func_t func,
 				void *user_data, qmi_destroy_func_t destroy);
-bool qmi_service_unregister(struct qmi_service *service, uint16_t id);
 bool qmi_service_unregister_all(struct qmi_service *service);
-- =

2.15.1


--===============5206120805913819774==--

