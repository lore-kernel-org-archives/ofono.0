Content-Type: multipart/mixed; boundary="===============8524870453045594701=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH qmi lte v3 5/6] qmi: stop listening to packet service
 notifications
Date: Sat, 15 Apr 2017 17:34:45 +0200
Message-ID: <20170415153446.31803-7-jonas@southpole.se>
In-Reply-To: <20170415153446.31803-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8524870453045594701==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The packet service status notification tells whether there is _any_
active and enabled context.  Using this to decide whether to
release any given context makes no sense.

It might make sense to monitor this status in the GPRS atom, but
not here in the gprs-context atom.
---
 drivers/qmimodem/gprs-context.c | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-contex=
t.c
index 2085898..5b1d778 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -44,33 +44,6 @@ struct gprs_context_data {
 	uint32_t pkt_handle;
 };
 =

-static void pkt_status_notify(struct qmi_result *result, void *user_data)
-{
-	struct ofono_gprs_context *gc =3D user_data;
-	struct gprs_context_data *data =3D ofono_gprs_context_get_data(gc);
-	const struct qmi_wds_notify_conn_status *status;
-	uint16_t len;
-	uint8_t ip_family;
-
-	DBG("");
-
-	status =3D qmi_result_get(result, QMI_WDS_NOTIFY_CONN_STATUS, &len);
-	if (!status)
-		return;
-
-	DBG("conn status %d", status->status);
-
-	if (qmi_result_get_uint8(result, QMI_WDS_NOTIFY_IP_FAMILY, &ip_family))
-		DBG("ip family %d", ip_family);
-
-	switch (status->status) {
-	case QMI_WDS_CONN_STATUS_DISCONNECTED:
-		ofono_gprs_context_deactivated(gc, data->active_context);
-		data->active_context =3D 0;
-		break;
-	}
-}
-
 static void get_settings_cb(struct qmi_result *result, void *user_data)
 {
 	struct cb_data *cbd =3D user_data;
@@ -376,9 +349,6 @@ static void create_wds_cb(struct qmi_service *service, =
void *user_data)
 	}
 =

 	data->wds =3D qmi_service_ref(service);
-
-	qmi_service_register(data->wds, QMI_WDS_PKT_STATUS_IND,
-					pkt_status_notify, gc, NULL);
 }
 =

 static void get_data_format_cb(struct qmi_result *result, void *user_data)
-- =

2.9.3


--===============8524870453045594701==--

