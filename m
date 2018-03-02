Content-Type: multipart/mixed; boundary="===============1932082368720933686=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH v2 3/3] qmimodem: get LTE default bearer APN from modem
Date: Fri, 02 Mar 2018 16:12:21 +0100
Message-ID: <20180302151221.18063-4-jonas@southpole.se>
In-Reply-To: <20180302151221.18063-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1932082368720933686==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When an LTE modem registers with the network, a default bearer is
automatically established.  The APN used for this bearer is taken from
whatever default settings the modem has.

The LTE atom takes cares of setting up the default context/profile with
the APN to use.  From there, a default bearer will be established when
the modem registers with the network.  This results in a call to 'Get
LTE Attach Parameters' which tells us what APN the gateway negotiated
with us.

If we can't get the APN, we do what the AT driver does:  pretend the
bearer wasn't established.  This is a reasonable fallback, currently,
because connman can't handle zero-length APN's anyway; the previous
approach of setting the APN to 'automatic' breaks connman badly when it
needs to switch between LTE and non-LTE networks.
---
 drivers/qmimodem/gprs.c | 162 ++++++++++++++++++++++++++++++++++++++++++++=
+---
 1 file changed, 153 insertions(+), 9 deletions(-)

diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index a80d55fe..115305df 100644
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
@@ -64,8 +68,124 @@ static bool extract_ss_info(struct qmi_result *result, =
int *status, int *tech)
 	return true;
 }
 =

+static void get_lte_attach_param_cb(struct qmi_result *result, void *user_=
data)
+{
+	struct ofono_gprs* gprs =3D user_data;
+	struct gprs_data *data =3D ofono_gprs_get_data(gprs);
+	char* apn =3D NULL;
+	uint16_t error;
+	uint8_t iptype;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, &error)) {
+		ofono_error("Failed to query LTE attach params: %hd", error);
+		goto noapn;
+	}
+
+	/* APN */
+	apn =3D qmi_result_get_string(result, 0x10);
+	if (!apn) {
+		DBG("Default profile has no APN setting");
+		goto noapn;
+	}
+
+	if (qmi_result_get_uint8(result, 0x11, &iptype)) {
+		ofono_info("LTE attach IP type: %hhd", iptype);
+	}
+
+	ofono_gprs_cid_activated(gprs, data->last_auto_context_id, apn);
+
+	return;
+
+noapn:
+	data->last_auto_context_id =3D 0;
+	ofono_error("LTE bearer established but APN not set");
+}
+
+static void get_default_profile_cb(struct qmi_result *result, void *user_d=
ata)
+{
+	struct ofono_gprs* gprs =3D user_data;
+	struct gprs_data *data =3D ofono_gprs_get_data(gprs);
+	uint16_t error;
+	uint8_t index;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, &error)) {
+		ofono_error("Get default profile error: %hd", error);
+		goto error;
+	}
+
+	/* Profile index */
+	if (!qmi_result_get_uint8(result, 0x01, &index)) {
+		ofono_error("Failed query default profile");
+		goto error;
+	}
+
+	DBG("Default profile index: %hhd", index);
+
+	data->last_auto_context_id =3D index;
+
+	/* Get LTE Attach Parameters */
+	if (qmi_service_send(data->wds, 0x85, NULL,
+				get_lte_attach_param_cb, gprs, NULL) > 0)
+		return;
+
+error:
+	data->last_auto_context_id =3D 0;
+	ofono_error("LTE bearer established but APN not set");
+}
+
+/*
+ * Query the settings in effect on the default bearer.  These may be
+ * implicit or may even be something other than requested as the gateway
+ * is allowed to override whatever was requested by the user.
+ */
+static void get_lte_attach_params(struct ofono_gprs* gprs)
+{
+	struct gprs_data *data =3D ofono_gprs_get_data(gprs);
+	struct {
+		uint8_t type;
+		uint8_t family;
+	} __attribute((packed)) p =3D {
+		.type =3D 0,   /* 3GPP */
+		.family =3D 0, /* embedded */
+	};
+	struct qmi_param* param;
+
+	DBG("");
+
+	if (data->last_auto_context_id !=3D 0)
+		return; /* Established or in progress */
+
+	/* Set query in progress */
+	data->last_auto_context_id =3D -1;
+
+	/* First we query the default profile in order to find out which
+	 * context the modem has activated.
+	 */
+	param =3D qmi_param_new();
+	if (!param)
+		goto error;
+
+	/* Profile type */
+	qmi_param_append(param, 0x1, sizeof(p), &p);
+
+	/* Get default profile */
+	if (qmi_service_send(data->wds, 0x49, param,
+				get_default_profile_cb, gprs, NULL) > 0)
+		return;
+
+	qmi_param_free(param);
+
+error:
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

@@ -74,17 +194,20 @@ static int handle_ss_info(struct qmi_result *result, s=
truct ofono_gprs *gprs)
 	if (!extract_ss_info(result, &status, &tech))
 		return -1;
 =

-	if (status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTERED)
+	if (status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTERED) {
 		if (tech =3D=3D ACCESS_TECHNOLOGY_EUTRAN) {
 			/* On LTE we are effectively always attached; and
 			 * the default bearer is established as soon as the
-			 * network is joined.
-			 */
-			/* FIXME: query default profile number and APN
-			 * instead of assuming profile 1 and ""
+			 * network is joined.  We just need to query the
+			 * parameters in effect on the default bearer and
+			 * let the ofono core know about the activated
+			 * context.
 			 */
-			ofono_gprs_cid_activated(gprs, 1 , "automatic");
+			get_lte_attach_params(gprs);
 		}
+	} else {
+		data->last_auto_context_id =3D 0;
+	}
 =

 	return status;
 }
@@ -198,7 +321,7 @@ static void qmi_attached_status(struct ofono_gprs *gprs,
 	g_free(cbd);
 }
 =

-static void create_nas_cb(struct qmi_service *service, void *user_data)
+static void create_wds_cb(struct qmi_service *service, void *user_data)
 {
 	struct ofono_gprs *gprs =3D user_data;
 	struct gprs_data *data =3D ofono_gprs_get_data(gprs);
@@ -206,12 +329,12 @@ static void create_nas_cb(struct qmi_service *service=
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
@@ -228,6 +351,25 @@ static void create_nas_cb(struct qmi_service *service,=
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
@@ -240,6 +382,8 @@ static int qmi_gprs_probe(struct ofono_gprs *gprs,
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


--===============1932082368720933686==--

