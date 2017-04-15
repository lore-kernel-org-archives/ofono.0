Content-Type: multipart/mixed; boundary="===============1624930095016624344=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH qmi lte v3 2/6] qmi: implement detach_shutdown method
Date: Sat, 15 Apr 2017 17:34:42 +0200
Message-ID: <20170415153446.31803-4-jonas@southpole.se>
In-Reply-To: <20170415153446.31803-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1624930095016624344==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The detach_shutdown method is invoked to unconditionally release
an active context.  For QMI, this is equivalent to a call to
deactivate_primary.

This patch makes the callback to deactivate_primary optional and
implements detach_shutdown to simply call it.  When there is no
callback, the stop_net callback notifies ofono about the context
release via an asynchronous ofono_gprs_context_deactivated() call.
---
 drivers/qmimodem/gprs-context.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-contex=
t.c
index 3743bb2..2085898 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -309,14 +309,19 @@ static void stop_net_cb(struct qmi_result *result, vo=
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

-	data->active_context =3D 0;
 	data->pkt_handle =3D 0;
 =

-	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	if (cb)
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	else
+		ofono_gprs_context_deactivated(gc, data->active_context); =

+
+	data->active_context =3D 0;
 }
 =

 static void qmi_deactivate_primary(struct ofono_gprs_context *gc,
@@ -343,11 +348,20 @@ static void qmi_deactivate_primary(struct ofono_gprs_=
context *gc,
 	qmi_param_free(param);
 =

 error:
-	CALLBACK_WITH_FAILURE(cb, cbd->data);
+	if (cb)
+		CALLBACK_WITH_FAILURE(cb, user_data);
 =

 	g_free(cbd);
 }
 =

+static void qmi_gprs_context_detach_shutdown(struct ofono_gprs_context *gc,
+						unsigned int cid)
+{
+	DBG("");
+
+	qmi_deactivate_primary(gc, cid, NULL, NULL);
+}
+
 static void create_wds_cb(struct qmi_service *service, void *user_data)
 {
 	struct ofono_gprs_context *gc =3D user_data;
@@ -476,6 +490,7 @@ static struct ofono_gprs_context_driver driver =3D {
 	.activate_primary	=3D qmi_activate_primary,
 	.deactivate_primary	=3D qmi_deactivate_primary,
 	.read_settings		=3D qmi_gprs_read_settings,
+	.detach_shutdown	=3D qmi_gprs_context_detach_shutdown,
 };
 =

 void qmi_gprs_context_init(void)
-- =

2.9.3


--===============1624930095016624344==--

