Content-Type: multipart/mixed; boundary="===============7650628115310583953=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 2/2] qmimodem: Add read_imsi to qmimodem sim driver
Date: Mon, 09 Jan 2017 09:34:07 +0100
Message-ID: <20170109083407.3980-3-c.ronco@kerlink.fr>
In-Reply-To: <20170109083407.3980-1-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7650628115310583953==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add read_imsi feature to qmimodem sim driver.
This is based on DMS service.
On MC7430, this is mandatory to be able to use this driver for GPRS
connection because reading IMSI via EF reads fails.
---
 drivers/qmimodem/sim.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++=
----
 1 file changed, 77 insertions(+), 6 deletions(-)

diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
index 197da509..db012bcf 100644
--- a/drivers/qmimodem/sim.c
+++ b/drivers/qmimodem/sim.c
@@ -30,6 +30,7 @@
 #include <ofono/sim.h>
 =

 #include "qmi.h"
+#include "dms.h"
 #include "uim.h"
 =

 #include "qmimodem.h"
@@ -39,6 +40,8 @@
 #define EF_STATUS_VALID 1
 =

 struct sim_data {
+	struct qmi_device *qmi_dev;
+	struct qmi_service *dms;
 	struct qmi_service *uim;
 	uint32_t event_mask;
 	uint8_t card_state;
@@ -295,6 +298,47 @@ error:
 	g_free(cbd);
 }
 =

+static void get_imsi_cb(struct qmi_result *result, void *user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_sim_imsi_cb_t cb =3D cbd->cb;
+	char *str;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, NULL)) {
+		CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+		return;
+	}
+
+	str =3D qmi_result_get_string(result, QMI_DMS_RESULT_IMSI);
+	if (!str) {
+		CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+		return;
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, str, cbd->data);
+
+	qmi_free(str);
+}
+
+static void qmi_read_imsi(struct ofono_sim *sim,
+				ofono_sim_imsi_cb_t cb, void *user_data)
+{
+	struct sim_data *data =3D ofono_sim_get_data(sim);
+	struct cb_data *cbd =3D cb_data_new(cb, user_data);
+
+	DBG("");
+
+	if (qmi_service_send(data->dms, QMI_DMS_GET_IMSI, NULL,
+					get_imsi_cb, cbd, g_free) > 0)
+		return;
+
+	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+
+	g_free(cbd);
+}
+
 static void qmi_query_passwd_state(struct ofono_sim *sim,
 				ofono_sim_passwd_cb_t cb, void *user_data)
 {
@@ -465,11 +509,28 @@ static void create_uim_cb(struct qmi_service *service=
, void *user_data)
 		return;
 =

 error:
-	qmi_service_unref(data->uim);
-
 	ofono_sim_remove(sim);
 }
 =

+static void create_dms_cb(struct qmi_service *service, void *user_data)
+{
+	struct ofono_sim *sim =3D user_data;
+	struct sim_data *data =3D ofono_sim_get_data(sim);
+
+	DBG("");
+
+	if (!service) {
+		ofono_error("Failed to request DMS service");
+		ofono_sim_remove(sim);
+		return;
+	}
+
+	data->dms =3D qmi_service_ref(service);
+
+	qmi_service_create(data->qmi_dev, QMI_SERVICE_UIM, create_uim_cb, sim,
+					NULL);
+}
+
 static int qmi_sim_probe(struct ofono_sim *sim,
 				unsigned int vendor, void *user_data)
 {
@@ -486,9 +547,12 @@ static int qmi_sim_probe(struct ofono_sim *sim,
 	for (i =3D 0; i < OFONO_SIM_PASSWORD_INVALID; i++)
 		data->retries[i] =3D -1;
 =

+	data->qmi_dev =3D device;
+
 	ofono_sim_set_data(sim, data);
 =

-	qmi_service_create(device, QMI_SERVICE_UIM, create_uim_cb, sim, NULL);
+	qmi_service_create_shared(device, QMI_SERVICE_DMS,
+						create_dms_cb, sim, NULL);
 =

 	return 0;
 }
@@ -501,9 +565,15 @@ static void qmi_sim_remove(struct ofono_sim *sim)
 =

 	ofono_sim_set_data(sim, NULL);
 =

-	qmi_service_unregister_all(data->uim);
-
-	qmi_service_unref(data->uim);
+	if (data->uim) {
+		qmi_service_unregister_all(data->uim);
+		qmi_service_unref(data->uim);
+		data->uim =3D NULL;
+	}
+	if (data->dms) {
+		qmi_service_unregister_all(data->dms);
+		qmi_service_unref(data->dms);
+	}
 =

 	g_free(data);
 }
@@ -516,6 +586,7 @@ static struct ofono_sim_driver driver =3D {
 	.read_file_transparent	=3D qmi_read_transparent,
 	.read_file_linear	=3D qmi_read_record,
 	.read_file_cyclic	=3D qmi_read_record,
+	.read_imsi		=3D qmi_read_imsi,
 	.query_passwd_state	=3D qmi_query_passwd_state,
 	.query_pin_retries	=3D qmi_query_pin_retries,
 };
-- =

2.11.0


--===============7650628115310583953==--

