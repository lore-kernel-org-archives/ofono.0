Content-Type: multipart/mixed; boundary="===============3428399340219767643=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH QMI LTE v2 11/13] qmi: stop listening to packet service
 notifications
Date: Fri, 14 Apr 2017 23:36:44 +0200
Message-ID: <20170414213646.32066-12-jonas@southpole.se>
In-Reply-To: <20170414213646.32066-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3428399340219767643==
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
index 02b0671..b4c2823 100644
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
@@ -370,9 +343,6 @@ static void create_wds_cb(struct qmi_service *service, =
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


--===============3428399340219767643==--

