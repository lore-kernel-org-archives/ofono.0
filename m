Content-Type: multipart/mixed; boundary="===============4585470055054773886=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH qmi lte v4 4/6] qmi: activate default bearer context for LTE
 networks
Date: Tue, 18 Apr 2017 09:50:50 +0200
Message-ID: <20170418075052.23980-4-jonas@southpole.se>
In-Reply-To: <20170418075052.23980-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4585470055054773886==
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
 drivers/qmimodem/gprs.c | 102 +++++++++++++++++++++++++++++++++++++++-----=
----
 1 file changed, 83 insertions(+), 19 deletions(-)

diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index 05ad4bd..c5bdf5e 100644
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
@@ -30,16 +32,20 @@
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
+static bool extract_ss_info(struct qmi_result *result, int *status, int *t=
ech)
 {
 	const struct qmi_nas_serving_system *ss;
+	uint8_t roaming;
 	uint16_t len;
+	int i;
 =

 	DBG("");
 =

@@ -47,25 +53,71 @@ static bool extract_ss_info(struct qmi_result *result, =
int *status)
 	if (!ss)
 		return false;
 =

-	if (ss->ps_state =3D=3D QMI_NAS_ATTACH_STATE_ATTACHED)
-		*status =3D 0x01;
-	else
-		*status =3D 0x00;
+	*status =3D ss->status;
+
+	*tech =3D -1;
+	for (i =3D 0; i < ss->radio_if_count; i++) {
+		DBG("radio in use %d", ss->radio_if[i]);
+
+		*tech =3D qmi_nas_rat_to_tech(ss->radio_if[i]);
+	}
+
+	if (qmi_result_get_uint8(result, QMI_NAS_RESULT_ROAMING_STATUS,
+								&roaming)) {
+		if (ss->status =3D=3D 1 && roaming =3D=3D 0)
+			*status =3D NETWORK_REGISTRATION_STATUS_ROAMING;
+	}
 =

 	return true;
 }
 =

-static void ss_info_notify(struct qmi_result *result, void *user_data)
+static int handle_ss_info(struct qmi_result* result, struct ofono_gprs* gp=
rs)
 {
-	struct ofono_gprs *gprs =3D user_data;
+	struct gprs_data *data =3D ofono_gprs_get_data(gprs);
 	int status;
+	int tech;
 =

 	DBG("");
 =

-	if (!extract_ss_info(result, &status))
-		return;
+	if (!extract_ss_info(result, &status, &tech))
+		return -1;
+
+	switch (status) {
+	case NETWORK_REGISTRATION_STATUS_REGISTERED:
+	case NETWORK_REGISTRATION_STATUS_ROAMING:
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
+		break;
+	default:
+		break;
+	}
 =

-	ofono_gprs_status_notify(gprs, status);
+	if (!data->attached)
+		status =3D NETWORK_REGISTRATION_STATUS_NOT_REGISTERED;
+
+	return status;
+}
+
+static void ss_info_notify(struct qmi_result* result, void *user_data)
+{
+	struct ofono_gprs* gprs =3D user_data;
+	int status;
+
+	DBG("");
+
+	status =3D handle_ss_info(result, gprs);
+
+	if (status >=3D 0)
+		ofono_gprs_status_notify(gprs, status);
 }
 =

 static void attach_detach_cb(struct qmi_result *result, void *user_data)
@@ -100,6 +152,8 @@ static void qmi_set_attached(struct ofono_gprs *gprs, i=
nt attached,
 =

 	DBG("attached %d", attached);
 =

+	data->attached =3D attached;
+
 	if (attached)
 		action =3D QMI_NAS_ATTACH_ACTION_ATTACH;
 	else
@@ -121,25 +175,29 @@ error:
 	g_free(cbd);
 }
 =

-static void get_ss_info_cb(struct qmi_result *result, void *user_data)
+static void get_ss_info_cb(struct qmi_result* result, void *user_data)
 {
 	struct cb_data *cbd =3D user_data;
+	struct ofono_gprs* gprs =3D cbd->user;
 	ofono_gprs_status_cb_t cb =3D cbd->cb;
 	int status;
 =

 	DBG("");
 =

-	if (qmi_result_set_error(result, NULL)) {
-		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
-		return;
-	}
+	if (qmi_result_set_error(result, NULL))
+		goto error;
 =

-	if (!extract_ss_info(result, &status)) {
-		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
-		return;
-	}
+	status =3D handle_ss_info(result, gprs);
+
+	if (status < 0)
+		goto error;
 =

 	CALLBACK_WITH_SUCCESS(cb, status, cbd->data);
+
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
 }
 =

 static void qmi_attached_status(struct ofono_gprs *gprs,
@@ -150,6 +208,12 @@ static void qmi_attached_status(struct ofono_gprs *gpr=
s,
 =

 	DBG("");
 =

+	if (!data->attached) {
+		CALLBACK_WITH_SUCCESS(cb,
+			NETWORK_REGISTRATION_STATUS_NOT_REGISTERED, user_data);
+	}
+
+	cbd->user =3D gprs;
 	if (qmi_service_send(data->nas, QMI_NAS_GET_SS_INFO, NULL,
 					get_ss_info_cb, cbd, g_free) > 0)
 		return;
-- =

2.9.3


--===============4585470055054773886==--

