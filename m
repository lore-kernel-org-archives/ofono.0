Content-Type: multipart/mixed; boundary="===============3385824973443654953=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH QMI LTE v2 09/13] qmi: activate default bearer context for LTE
 networks
Date: Fri, 14 Apr 2017 23:36:42 +0200
Message-ID: <20170414213646.32066-10-jonas@southpole.se>
In-Reply-To: <20170414213646.32066-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3385824973443654953==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When the modem attaches to an LTE network, a default bearer is
automatically negotiated using the "defalt profile" settings.  The
QMI modem, however, does not given any explicit indication that
the bearer exists; instead, we must assume its existence based on
the network registration state.

This patch extends the GPRS atom to signal the presence of a
default bearer when it detects network connectivity on an LTE
network.

The GPRS atom gets a new 'attached' property based on whether it has
been manually attached or automatically "attached" by virtue of
connecting to an LTE network.  Here we abuse the word "attach"
since attach'ing isn't really an LTE concept, but it fits with
the model that Ofono wants.
---
 drivers/qmimodem/gprs.c | 135 ++++++++++++++++++++++++++++++++++----------=
----
 1 file changed, 96 insertions(+), 39 deletions(-)

diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index 404c975..fdfd08c 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -23,6 +23,8 @@
 #include <config.h>
 #endif
 =

+#include <glib.h>	/* this include belongs in common.h */
+
 #include <ofono/log.h>
 #include <ofono/modem.h>
 #include <ofono/gprs.h>
@@ -30,16 +32,33 @@
 #include "qmi.h"
 #include "nas.h"
 =

+#include "src/common.h"
 #include "qmimodem.h"
 =

 struct gprs_data {
 	struct qmi_service *nas;
+	int attached;
 };
 =

-static bool extract_ss_info(struct qmi_result *result, int *status)
+static int rat_to_tech(uint8_t rat)
+{
+	switch (rat) {
+	case QMI_NAS_NETWORK_RAT_GSM:
+		return ACCESS_TECHNOLOGY_GSM;
+	case QMI_NAS_NETWORK_RAT_UMTS:
+		return ACCESS_TECHNOLOGY_UTRAN;
+	case QMI_NAS_NETWORK_RAT_LTE:
+		return ACCESS_TECHNOLOGY_EUTRAN;
+	}
+
+	return -1;
+}
+
+static bool extract_ss_info(struct qmi_result *result, int *status, int *t=
ech)
 {
 	const struct qmi_nas_serving_system *ss;
 	uint16_t len;
+	int i;
 =

 	DBG("");
 =

@@ -47,25 +66,72 @@ static bool extract_ss_info(struct qmi_result *result, =
int *status)
 	if (!ss)
 		return false;
 =

-	if (ss->ps_state =3D=3D QMI_NAS_ATTACH_STATE_ATTACHED)
-		*status =3D 0x01;
-	else
-		*status =3D 0x00;
+	/* FIXME: include ROAMING in status */
+	*status =3D ss->status;
+
+	*tech =3D -1;
+	for (i =3D 0; i < ss->radio_if_count; i++) {
+		DBG("radio in use %d", ss->radio_if[i]);
+
+		*tech =3D rat_to_tech(ss->radio_if[i]);
+	}
 =

 	return true;
 }
 =

-static void ss_info_notify(struct qmi_result *result, void *user_data)
+/*
+ * This method handles both Serving System Info requests and
+ * notifications.  The presence of a callback differentiates between
+ * the two and the result is handled slightly differently accordingly.
+ * If there's a callback, we invoke it; otherwise we send a notification
+ * to ofono about relevant state changes.
+ */
+static void handle_ss_info(struct qmi_result* result, void *user_data)
 {
-	struct ofono_gprs *gprs =3D user_data;
+	struct cb_data *cbd =3D user_data;
+	struct ofono_gprs* gprs =3D cbd->user;
+	struct gprs_data *data =3D ofono_gprs_get_data(gprs);
+	ofono_gprs_status_cb_t cb =3D cbd->cb;
 	int status;
+	int tech;
 =

 	DBG("");
 =

-	if (!extract_ss_info(result, &status))
-		return;
+	if (cb && qmi_result_set_error(result, NULL))
+			goto error;
+
+	if (!extract_ss_info(result, &status, &tech))
+		goto error;
+
+	/* FIXME: what about ROAMING status? */
+
+	if (status =3D=3D QMI_NAS_REGISTRATION_STATE_REGISTERED) {
+		if (tech =3D=3D ACCESS_TECHNOLOGY_EUTRAN && !data->attached) {
+			/* On LTE we are effectively always attached; and
+			 * the default bearer is established as soon as the
+			 * network is joined.
+			 */
+			data->attached =3D 1;
+			/* FIXME: query default profile number and APN
+			 * instead of assuming profile 1
+			 */
+			ofono_gprs_cid_activated(gprs, 1, "");
+		}
+	}
+
+	if (!data->attached)
+		status =3D NETWORK_REGISTRATION_STATUS_NOT_REGISTERED;
+
+	if (cb)
+		CALLBACK_WITH_SUCCESS(cb, status, cbd->data);
+	else
+		ofono_gprs_status_notify(gprs, status);
+
+	return;
 =

-	ofono_gprs_status_notify(gprs, status);
+error:
+	if (cb)
+		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
 }
 =

 static void attach_detach_cb(struct qmi_result *result, void *user_data)
@@ -100,6 +166,8 @@ static void qmi_set_attached(struct ofono_gprs *gprs, i=
nt attached,
 =

 	DBG("attached %d", attached);
 =

+	data->attached =3D attached;
+
 	if (attached)
 		action =3D QMI_NAS_ATTACH_ACTION_ATTACH;
 	else
@@ -117,51 +185,36 @@ static void qmi_set_attached(struct ofono_gprs *gprs,=
 int attached,
 	qmi_param_free(param);
 =

 error:
-	CALLBACK_WITH_FAILURE(cb, cbd->data);
-}
-
-static void get_ss_info_cb(struct qmi_result *result, void *user_data)
-{
-	struct cb_data *cbd =3D user_data;
-	ofono_gprs_status_cb_t cb =3D cbd->cb;
-	int status;
-
-	DBG("");
-
-	if (qmi_result_set_error(result, NULL)) {
-		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
-		return;
-	}
-
-	if (!extract_ss_info(result, &status)) {
-		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
-		return;
-	}
-
-	CALLBACK_WITH_SUCCESS(cb, status, cbd->data);
+	CALLBACK_WITH_FAILURE(cb, user_data);
 }
 =

 static void qmi_attached_status(struct ofono_gprs *gprs,
 				ofono_gprs_status_cb_t cb, void *user_data)
 {
 	struct gprs_data *data =3D ofono_gprs_get_data(gprs);
-	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+	struct cb_data *cbd;
 =

 	DBG("");
 =

+	if (!data->attached) {
+		CALLBACK_WITH_SUCCESS(cb,
+			NETWORK_REGISTRATION_STATUS_NOT_REGISTERED, user_data);
+	}
+
+	cbd =3D cb_data_new(cb, user_data);
+	cbd->user =3D gprs;
 	if (qmi_service_send(data->nas, QMI_NAS_GET_SS_INFO, NULL,
-					get_ss_info_cb, cbd, g_free) > 0)
+					handle_ss_info, cbd, g_free) > 0)
 		return;
 =

-	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
-
-	g_free(cbd);
+	CALLBACK_WITH_FAILURE(cb, -1, user_data);
 }
 =

 static void create_nas_cb(struct qmi_service *service, void *user_data)
 {
 	struct ofono_gprs *gprs =3D user_data;
 	struct gprs_data *data =3D ofono_gprs_get_data(gprs);
+	struct cb_data *cbd;
 =

 	DBG("");
 =

@@ -177,11 +230,15 @@ static void create_nas_cb(struct qmi_service *service=
, void *user_data)
 	 * First get the SS info - the modem may already be connected,
 	 * and the state-change notification may never arrive
 	 */
+	cbd =3D cb_data_new(NULL, NULL);
+	cbd->user =3D gprs;
 	qmi_service_send(data->nas, QMI_NAS_GET_SS_INFO, NULL,
-					ss_info_notify, gprs, NULL);
+					handle_ss_info, cbd, g_free);
 =

+	cbd =3D cb_data_new(NULL, NULL);
+	cbd->user =3D gprs;
 	qmi_service_register(data->nas, QMI_NAS_SS_INFO_IND,
-					ss_info_notify, gprs, NULL);
+					handle_ss_info, cbd, g_free);
 =

 	ofono_gprs_set_cid_range(gprs, 1, 1);
 =

-- =

2.9.3


--===============3385824973443654953==--

