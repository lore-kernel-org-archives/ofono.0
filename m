Content-Type: multipart/mixed; boundary="===============1382817640390553144=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 4/4] qmimodem: get LTE default bearer APN from modem
Date: Thu, 01 Mar 2018 11:48:04 +0100
Message-ID: <20180301104804.24058-5-jonas@southpole.se>
In-Reply-To: <20180301104804.24058-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1382817640390553144==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When an LTE modem registers with the network, a default bearer is
automatically established.  The APN used for this bearer is taken from
whatever default settings the modem has.

In order to properly set up the ofono context, we need to find out what
APN the modem has used when negotiating this bearer.  Ideally, we would
want to query the 'current settings', but those aren't available until
start_net has been called and that's done in the gprs-context atom.  As
such, we query the 'default settings' here under the assumption that
that's what the modem will have used.

If we can't get the APN, we do what the AT driver does:  pretend the
bearer wasn't established.  This is a reasonable fallback, currently,
because connman can't handle zero-length APN's anyway; the previous
approach of setting the APN to 'automatic' breaks connman badly when it
needs to switch between LTE and non-LTE networks.
---
 drivers/qmimodem/gprs.c | 90 ++++++++++++++++++++++++++++++++++++++++++++-=
----
 1 file changed, 82 insertions(+), 8 deletions(-)

diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index a80d55fe..567e8925 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -29,12 +29,16 @@
 =

 #include "qmi.h"
 #include "nas.h"
+#include "wds.h"
 =

 #include "src/common.h"
 #include "qmimodem.h"
 =

 struct gprs_data {
+	struct qmi_device* dev;
 	struct qmi_service *nas;
+	struct qmi_service *wds;
+	unsigned int last_auto_context_id;
 };
 =

 static bool extract_ss_info(struct qmi_result *result, int *status, int *t=
ech)
@@ -64,8 +68,57 @@ static bool extract_ss_info(struct qmi_result *result, i=
nt *status, int *tech)
 	return true;
 }
 =

+static void get_default_settings_cb(struct qmi_result *result, void *user_=
data)
+{
+	struct ofono_gprs* gprs =3D user_data;
+	struct gprs_data *data =3D ofono_gprs_get_data(gprs);
+	char* apn =3D NULL;
+	uint16_t error;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, &error)) {
+		ofono_error("Failed to query default settings: %hd", error);
+		goto error;
+	}
+
+	apn =3D qmi_result_get_string(result, QMI_WDS_RESULT_APN);
+	if (!apn) {
+		DBG("Default profile has no APN setting");
+	}
+
+error:
+	if (apn) {
+		if (!data->last_auto_context_id) {
+			data->last_auto_context_id =3D 1;
+			ofono_gprs_cid_activated(gprs, 1, apn);
+		}
+	} else {
+		ofono_warn("LTE context activated but APN missing");
+	}
+}
+
+/*
+ * When an LTE default bearer is established, we need to callback into the
+ * ofono core to let it know; at this point, we are interested in the
+ * finding out what APN is in use so we try to query that first
+ */
+static void get_cid_and_apn(struct ofono_gprs* gprs)
+{
+	struct gprs_data *data =3D ofono_gprs_get_data(gprs);
+
+	DBG("");
+
+	if (qmi_service_send(data->wds, 0x2c, NULL,
+				get_default_settings_cb, gprs, NULL) > 0)
+		return;
+
+	ofono_warn("Unable to query LTE APN... will not activate context");
+}
+
 static int handle_ss_info(struct qmi_result *result, struct ofono_gprs *gp=
rs)
 {
+	struct gprs_data *data =3D ofono_gprs_get_data(gprs);
 	int status;
 	int tech;
 =

@@ -74,17 +127,17 @@ static int handle_ss_info(struct qmi_result *result, s=
truct ofono_gprs *gprs)
 	if (!extract_ss_info(result, &status, &tech))
 		return -1;
 =

-	if (status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTERED)
+	if (status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTERED) {
 		if (tech =3D=3D ACCESS_TECHNOLOGY_EUTRAN) {
 			/* On LTE we are effectively always attached; and
 			 * the default bearer is established as soon as the
 			 * network is joined.
 			 */
-			/* FIXME: query default profile number and APN
-			 * instead of assuming profile 1 and ""
-			 */
-			ofono_gprs_cid_activated(gprs, 1 , "automatic");
+			get_cid_and_apn(gprs);
 		}
+	} else {
+		data->last_auto_context_id =3D 0;
+	}
 =

 	return status;
 }
@@ -198,7 +251,7 @@ static void qmi_attached_status(struct ofono_gprs *gprs,
 	g_free(cbd);
 }
 =

-static void create_nas_cb(struct qmi_service *service, void *user_data)
+static void create_wds_cb(struct qmi_service *service, void *user_data)
 {
 	struct ofono_gprs *gprs =3D user_data;
 	struct gprs_data *data =3D ofono_gprs_get_data(gprs);
@@ -206,12 +259,12 @@ static void create_nas_cb(struct qmi_service *service=
, void *user_data)
 	DBG("");
 =

 	if (!service) {
-		ofono_error("Failed to request NAS service");
+		ofono_error("Failed to request WDS service");
 		ofono_gprs_remove(gprs);
 		return;
 	}
 =

-	data->nas =3D qmi_service_ref(service);
+	data->wds =3D qmi_service_ref(service);
 =

 	/*
 	 * First get the SS info - the modem may already be connected,
@@ -228,6 +281,25 @@ static void create_nas_cb(struct qmi_service *service,=
 void *user_data)
 	ofono_gprs_register(gprs);
 }
 =

+static void create_nas_cb(struct qmi_service *service, void *user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	struct gprs_data *data =3D ofono_gprs_get_data(gprs);
+
+	DBG("");
+
+	if (!service) {
+		ofono_error("Failed to request NAS service");
+		ofono_gprs_remove(gprs);
+		return;
+	}
+
+	data->nas =3D qmi_service_ref(service);
+
+	qmi_service_create_shared(data->dev, QMI_SERVICE_WDS,
+						create_wds_cb, gprs, NULL);
+}
+
 static int qmi_gprs_probe(struct ofono_gprs *gprs,
 				unsigned int vendor, void *user_data)
 {
@@ -240,6 +312,8 @@ static int qmi_gprs_probe(struct ofono_gprs *gprs,
 =

 	ofono_gprs_set_data(gprs, data);
 =

+	data->dev =3D device;
+
 	qmi_service_create_shared(device, QMI_SERVICE_NAS,
 						create_nas_cb, gprs, NULL);
 =

-- =

2.14.1


--===============1382817640390553144==--

