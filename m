Content-Type: multipart/mixed; boundary="===============4077974354929259654=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 7/8] qmi: watch for automatic context activation
Date: Tue, 11 Apr 2017 10:18:17 +0200
Message-ID: <20170411081818.19544-8-jonas@southpole.se>
In-Reply-To: <20170411081818.19544-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4077974354929259654==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For LTE, a default bearer gets set up as soon as the modem registers to
the network.  The GPRS atom needs to detect the presence of this bearer
in order to set up the appropriate context atom.

This is all a bit confusing but it's a result of the way ofono is
currently architected.  The GPRS atom serves two purposes:  to "attach"
to the network, and to hold "online" (attached) state for the purpose
of communication with the connection manager (via DBus).  For LTE, there
is no concept of being "attached"; when the modem is online, a default
bearer is automatically set so "attached" becomes synonymous with
attached-and-context-activated.  Context activation thus becomes "attached"
in LTE, but this information still needs to be held in the GPRS atom
which otherwise has no purpose.
---
 drivers/qmimodem/gprs.c | 88 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index 05ad4bd..d4ced1c 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -29,13 +29,76 @@
 =

 #include "qmi.h"
 #include "nas.h"
+#include "wds.h"
 =

 #include "qmimodem.h"
 =

 struct gprs_data {
 	struct qmi_service *nas;
+	struct qmi_service *wds;
+	int default_bearer_cid;
 };
 =

+static void get_settings_cb(struct qmi_result *result, void *user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	struct gprs_data *data =3D ofono_gprs_get_data(gprs);
+	char* apn =3D NULL;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, NULL))
+		goto done;
+
+	apn =3D qmi_result_get_string(result, QMI_WDS_RESULT_APN);
+	if (apn) {
+		DBG("APN: %s", apn);
+	}
+
+done:
+	if (!apn)
+		apn =3D g_strdup("");
+
+	ofono_gprs_cid_activated(gprs, data->default_bearer_cid, apn);
+
+	g_free(apn);
+}
+
+static void pkt_status_notify(struct qmi_result *result, void *user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	struct gprs_data *data =3D ofono_gprs_get_data(gprs);
+	const struct qmi_wds_notify_conn_status *status;
+	uint16_t len;
+
+	DBG("");
+
+	status =3D qmi_result_get(result, QMI_WDS_NOTIFY_CONN_STATUS, &len);
+	if (!status)
+		return;
+
+	DBG("conn status %d", status->status);
+
+	switch (status->status) {
+	case QMI_WDS_CONN_STATUS_CONNECTED:
+		DBG("connection status connected");
+		if (!data->default_bearer_cid)
+			data->default_bearer_cid =3D 1;
+
+		if (qmi_service_send(data->wds, QMI_WDS_GET_SETTINGS, NULL,
+					get_settings_cb, gprs, NULL) > 0)
+			return;
+
+		ofono_gprs_cid_activated(gprs, data->default_bearer_cid, "");
+		break;
+	case QMI_WDS_CONN_STATUS_DISCONNECTED:
+		data->default_bearer_cid =3D 0;
+		DBG("connection status disconnected");
+		break;
+	}
+}
+
+
 static bool extract_ss_info(struct qmi_result *result, int *status)
 {
 	const struct qmi_nas_serving_system *ss;
@@ -159,6 +222,28 @@ static void qmi_attached_status(struct ofono_gprs *gpr=
s,
 	g_free(cbd);
 }
 =

+static void create_wds_cb(struct qmi_service *service, void *user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	struct gprs_data *data =3D ofono_gprs_get_data(gprs);
+
+	DBG("");
+
+	if (!service) {
+		ofono_error("Failed to request WDS service");
+		ofono_gprs_remove(gprs);
+		return;
+	}
+
+	data->wds =3D qmi_service_ref(service);
+
+	qmi_service_send(data->wds, QMI_WDS_GET_PKT_STATUS, NULL,
+					pkt_status_notify, gprs, NULL);
+
+	qmi_service_register(data->wds, QMI_WDS_PKT_STATUS_IND,
+					pkt_status_notify, gprs, NULL);
+}
+
 static void create_nas_cb(struct qmi_service *service, void *user_data)
 {
 	struct ofono_gprs *gprs =3D user_data;
@@ -202,6 +287,7 @@ static int qmi_gprs_probe(struct ofono_gprs *gprs,
 	ofono_gprs_set_data(gprs, data);
 =

 	qmi_service_create(device, QMI_SERVICE_NAS, create_nas_cb, gprs, NULL);
+	qmi_service_create(device, QMI_SERVICE_WDS, create_wds_cb, gprs, NULL);
 =

 	return 0;
 }
@@ -215,8 +301,10 @@ static void qmi_gprs_remove(struct ofono_gprs *gprs)
 	ofono_gprs_set_data(gprs, NULL);
 =

 	qmi_service_unregister_all(data->nas);
+	qmi_service_unregister_all(data->wds);
 =

 	qmi_service_unref(data->nas);
+	qmi_service_unref(data->wds);
 =

 	g_free(data);
 }
-- =

2.9.3


--===============4077974354929259654==--

