Content-Type: multipart/mixed; boundary="===============5391887908731516337=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH QMI LTE v2 06/13] qmi: implement detach_shutdown method
Date: Fri, 14 Apr 2017 23:36:39 +0200
Message-ID: <20170414213646.32066-7-jonas@southpole.se>
In-Reply-To: <20170414213646.32066-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5391887908731516337==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The detach_shutdown method is invoked to unconditionally release
an active context.  For QMI, this is equivalent to a call to
deactivate_primary.

This patch makes the callback to deactivate_primary optional and
implements detach_shutdown to simply call that function.
---
 drivers/qmimodem/gprs-context.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-contex=
t.c
index 247ee9e..b72245c 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -304,14 +304,16 @@ static void stop_net_cb(struct qmi_result *result, vo=
id *user_data)
 	DBG("");
 =

 	if (qmi_result_set_error(result, NULL)) {
-		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		if (cb)
+			CALLBACK_WITH_FAILURE(cb, cbd->data);
 		return;
 	}
 =

 	data->active_context =3D 0;
 	data->pkt_handle =3D 0;
 =

-	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	if (cb)
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
 }
 =

 static void qmi_deactivate_primary(struct ofono_gprs_context *gc,
@@ -319,18 +321,19 @@ static void qmi_deactivate_primary(struct ofono_gprs_=
context *gc,
 				ofono_gprs_context_cb_t cb, void *user_data)
 {
 	struct gprs_context_data *data =3D ofono_gprs_context_get_data(gc);
-	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+	struct cb_data *cbd;
 	struct qmi_param *param;
 =

 	DBG("cid %u", cid);
 =

-	cbd->user =3D gc;
-
 	param =3D qmi_param_new_uint32(QMI_WDS_PARAM_PKT_HANDLE,
 						data->pkt_handle);
 	if (!param)
 		goto error;
 =

+	cbd =3D cb_data_new(cb, user_data);
+	cbd->user =3D gc;
+
 	if (qmi_service_send(data->wds, QMI_WDS_STOP_NET, param,
 					stop_net_cb, cbd, g_free) > 0)
 		return;
@@ -338,9 +341,16 @@ static void qmi_deactivate_primary(struct ofono_gprs_c=
ontext *gc,
 	qmi_param_free(param);
 =

 error:
-	CALLBACK_WITH_FAILURE(cb, cbd->data);
+	if (cb)
+		CALLBACK_WITH_FAILURE(cb, user_data);
+}
 =

-	g_free(cbd);
+static void qmi_gprs_context_detach_shutdown(struct ofono_gprs_context *gc,
+						unsigned int cid)
+{
+	DBG("");
+
+	qmi_deactivate_primary(gc, cid, NULL, NULL);
 }
 =

 static void create_wds_cb(struct qmi_service *service, void *user_data)
@@ -471,6 +481,7 @@ static struct ofono_gprs_context_driver driver =3D {
 	.activate_primary	=3D qmi_activate_primary,
 	.deactivate_primary	=3D qmi_deactivate_primary,
 	.read_settings		=3D qmi_gprs_read_settings,
+	.detach_shutdown	=3D qmi_gprs_context_detach_shutdown,
 };
 =

 void qmi_gprs_context_init(void)
-- =

2.9.3


--===============5391887908731516337==--

