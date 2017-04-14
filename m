Content-Type: multipart/mixed; boundary="===============9177487051025890352=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH QMI LTE v2 10/13] qmi: use destroy callback for
 activate_primary
Date: Fri, 14 Apr 2017 23:36:43 +0200
Message-ID: <20170414213646.32066-11-jonas@southpole.se>
In-Reply-To: <20170414213646.32066-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9177487051025890352==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/qmimodem/gprs-context.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-contex=
t.c
index 1708ce0..02b0671 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -230,15 +230,13 @@ static void qmi_activate_primary(struct ofono_gprs_co=
ntext *gc,
 				ofono_gprs_context_cb_t cb, void *user_data)
 {
 	struct gprs_context_data *data =3D ofono_gprs_context_get_data(gc);
-	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+	struct cb_data *cbd;
 	struct qmi_param *param;
 	uint8_t ip_family;
 	uint8_t auth;
 =

 	DBG("cid %u", ctx->cid);
 =

-	cbd->user =3D gc;
-
 	data->active_context =3D ctx->cid;
 =

 	switch (ctx->proto) {
@@ -284,6 +282,9 @@ static void qmi_activate_primary(struct ofono_gprs_cont=
ext *gc,
 		qmi_param_append(param, QMI_WDS_PARAM_PASSWORD,
 					strlen(ctx->password), ctx->password);
 =

+	cbd =3D cb_data_new(cb, user_data);
+	cbd->user =3D gc;
+
 	if (qmi_service_send(data->wds, QMI_WDS_START_NET, param,
 					start_net_cb, cbd, g_free) > 0)
 		return;
@@ -293,9 +294,7 @@ static void qmi_activate_primary(struct ofono_gprs_cont=
ext *gc,
 error:
 	data->active_context =3D 0;
 =

-	CALLBACK_WITH_FAILURE(cb, cbd->data);
-
-	g_free(cbd);
+	CALLBACK_WITH_FAILURE(cb, user_data);
 }
 =

 static void stop_net_cb(struct qmi_result *result, void *user_data)
-- =

2.9.3


--===============9177487051025890352==--

