Content-Type: multipart/mixed; boundary="===============7810289595410029272=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH] qmi: remove request when it timeouts
Date: Fri, 27 Oct 2017 16:37:17 +0200
Message-ID: <1509115037-18275-2-git-send-email-c.ronco@kerlink.fr>
In-Reply-To: <1509115037-18275-1-git-send-email-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7810289595410029272==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When modem does not answer or answers slowly to a discovery request,
a timeout occurs.
In timeout callback, request should be removed from queues to avoid
treating answer if it arrives later.
---
 drivers/qmimodem/qmi.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index c538cb9..a0632ca 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1073,6 +1073,7 @@ struct discover_data {
 	qmi_discover_func_t func;
 	void *user_data;
 	qmi_destroy_func_t destroy;
+	uint8_t tid;
 	guint timeout;
 };
 =

@@ -1181,14 +1182,38 @@ static gboolean discover_reply(gpointer user_data)
 {
 	struct discover_data *data =3D user_data;
 	struct qmi_device *device =3D data->device;
+	unsigned int tid =3D data->tid;
+	GList *list;
+	struct qmi_request *req =3D NULL;
 =

 	data->timeout =3D 0;
 =

+	/* remove request from queues */
+	if (tid !=3D 0) {
+		list =3D g_queue_find_custom(device->req_queue,
+				GUINT_TO_POINTER(tid), __request_compare);
+
+		if (list) {
+			req =3D list->data;
+			g_queue_delete_link(device->req_queue, list);
+		} else {
+			list =3D g_queue_find_custom(device->control_queue,
+				GUINT_TO_POINTER(tid), __request_compare);
+
+			if (list) {
+				req =3D list->data;
+				g_queue_delete_link(device->control_queue,
+								list);
+			}
+		}
+	}
+
 	if (data->func)
 		data->func(device->version_count,
 				device->version_list, data->user_data);
 =

 	__qmi_device_discovery_complete(data->device, &data->super);
+	__request_free(req, NULL);
 =

 	return FALSE;
 }
@@ -1234,6 +1259,7 @@ bool qmi_device_discover(struct qmi_device *device, q=
mi_discover_func_t func,
 =

 	hdr->type =3D 0x00;
 	hdr->transaction =3D device->next_control_tid++;
+	data->tid =3D hdr->transaction;
 =

 	__request_submit(device, req, hdr->transaction);
 =

-- =

2.7.4


--===============7810289595410029272==--

