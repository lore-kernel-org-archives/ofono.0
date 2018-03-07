Content-Type: multipart/mixed; boundary="===============4644434838588989840=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 3/3] qmimodem: release WDS service handle in LTE atom
Date: Wed, 07 Mar 2018 15:55:11 +0100
Message-ID: <20180307145511.21142-4-jonas@southpole.se>
In-Reply-To: <20180307145511.21142-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4644434838588989840==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The LTE atom is created at post-sim and the GPRS atom is created at
post-online.  When the modem is set offline, the GPRS atom is destroyed
and releases it's hold on the WDS service; but the LTE atom is not
destroyed until the modem is disabled, so the WDS service isn't
destroyed.  Due to this, any requests that the GPRS atom had in flight
won't be cancelled and the callbacks may be invoked on the now defunct
object resulting in a segfault.

The LTE atom doesn't really need a long-term lease on the WDS service;
it only needs it briefly when setting up the default context.  As such,
the LTE atom can just create the service handle when the APN is set and
release it when done.

This patch reworks the LTE atom so that the WDS service handle is
obtained when actually setting the APN and released afterwards.  With
this, only atoms that belong to the post-online state have long-term
references to the WDS service and will all releases these references
together when going offline.

Theoretically there's still a small window where problems may arise but
it's small enough that it should not be a problem in practice.  A more
correct fix probably involves reworking the internals of the QMI
dispatch mechanism.
---
 drivers/qmimodem/lte.c | 143 ++++++++++++++++++++++++++++++++-------------=
----
 1 file changed, 93 insertions(+), 50 deletions(-)

diff --git a/drivers/qmimodem/lte.c b/drivers/qmimodem/lte.c
index 9a149289..425e73f0 100644
--- a/drivers/qmimodem/lte.c
+++ b/drivers/qmimodem/lte.c
@@ -43,34 +43,44 @@
 #include "qmimodem.h"
 =

 struct lte_data {
+	struct qmi_device *device;
+};
+
+struct info {
 	struct qmi_service *wds;
 	uint8_t default_profile;
+	char *apn;
+	ofono_lte_cb_t cb;
+	void *cb_data;
 };
 =

 static void modify_profile_cb(struct qmi_result *result, void *user_data)
 {
-	struct cb_data *cbd =3D user_data;
-	ofono_lte_cb_t cb =3D cbd->cb;
+	struct info *info =3D user_data;
 	uint16_t error;
 =

 	DBG("");
 =

 	if (qmi_result_set_error(result, &error)) {
 		DBG("Failed to modify profile: %d", error);
-		CALLBACK_WITH_FAILURE(cb, cbd->data);
-		return;
+		CALLBACK_WITH_FAILURE(info->cb, info->cb_data);
+		goto out;
 	}
 =

-	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	CALLBACK_WITH_SUCCESS(info->cb, info->cb_data);
+
+out:
+	qmi_service_unref(info->wds);
+
+	g_free(info->apn);
+	g_free(info);
 }
 =

-static void qmimodem_lte_set_default_attach_info(const struct ofono_lte *l=
te,
-			const struct ofono_lte_default_attach_info *info,
-			ofono_lte_cb_t cb, void *data)
+static void reset_profile_cb(struct qmi_result *result, void *user_data)
 {
-	struct lte_data *ldd =3D ofono_lte_get_data(lte);
-	struct cb_data *cbd =3D cb_data_new(cb, data);
-	struct qmi_param* param;
+	struct info *info =3D user_data;
+	uint16_t error;
+	struct qmi_param *param;
 	struct {
 		uint8_t type;
 		uint8_t index;
@@ -80,7 +90,12 @@ static void qmimodem_lte_set_default_attach_info(const s=
truct ofono_lte *lte,
 =

 	DBG("");
 =

-	p.index =3D ldd->default_profile;
+	if (qmi_result_set_error(result, &error)) {
+		ofono_error("Reset profile error: %hd", error);
+		goto error;
+	}
+
+	p.index =3D info->default_profile;
 =

 	param =3D qmi_param_new();
 	if (!param)
@@ -94,33 +109,24 @@ static void qmimodem_lte_set_default_attach_info(const=
 struct ofono_lte *lte,
 				strlen(info->apn), info->apn);
 =

 	/* Modify profile */
-	if (qmi_service_send(ldd->wds, 0x28, param,
-					modify_profile_cb, cbd, g_free) > 0)
+	if (qmi_service_send(info->wds, 0x28, param,
+					modify_profile_cb, info, NULL) > 0)
 		return;
 =

 	qmi_param_free(param);
 =

 error:
-	CALLBACK_WITH_FAILURE(cb, cbd->data);
-}
-
-static void reset_profile_cb(struct qmi_result *result, void *user_data)
-{
-	struct ofono_lte *lte =3D user_data;
-	uint16_t error;
-
-	DBG("");
+	CALLBACK_WITH_FAILURE(info->cb, info->cb_data);
 =

-	if (qmi_result_set_error(result, &error))
-		ofono_error("Reset profile error: %hd", error);
-
-	ofono_lte_register(lte);
+	qmi_service_unref(info->wds);
+	g_free(info->apn);
+	g_free(info);
 }
 =

+
 static void get_default_profile_cb(struct qmi_result *result, void *user_d=
ata)
 {
-	struct ofono_lte *lte =3D user_data;
-	struct lte_data *ldd =3D ofono_lte_get_data(lte);
+	struct info *info =3D user_data;
 	uint16_t error;
 	uint8_t index;
 	struct qmi_param *param;
@@ -146,9 +152,9 @@ static void get_default_profile_cb(struct qmi_result *r=
esult, void *user_data)
 =

 	DBG("Default profile index: %hhd", index);
 =

-	ldd->default_profile =3D index;
+	info->default_profile =3D index;
 =

-	p.index =3D index;
+	p.index =3D info->default_profile;
 =

 	param =3D qmi_param_new();
 	if (!param)
@@ -158,21 +164,24 @@ static void get_default_profile_cb(struct qmi_result =
*result, void *user_data)
 	qmi_param_append(param, 0x01, sizeof(p), &p);
 =

 	/* Reset profile */
-	if (qmi_service_send(ldd->wds, 0x4b, param,
-				reset_profile_cb, lte, NULL) > 0)
+	if (qmi_service_send(info->wds, 0x4b, param,
+				reset_profile_cb, info, NULL) > 0)
 		return;
 =

+	ofono_error("Failed to reset profile %hhd", index);
 	qmi_param_free(param);
 =

 error:
-	ofono_error("Failed to reset profile %hhd", index);
-	ofono_lte_remove(lte);
+	CALLBACK_WITH_FAILURE(info->cb, info->cb_data);
+
+	qmi_service_unref(info->wds);
+	g_free(info->apn);
+	g_free(info);
 }
 =

 static void create_wds_cb(struct qmi_service *service, void *user_data)
 {
-	struct ofono_lte *lte =3D user_data;
-	struct lte_data *ldd =3D ofono_lte_get_data(lte);
+	struct info *info =3D user_data;
 	struct qmi_param *param;
 	struct {
 		uint8_t type;
@@ -186,11 +195,10 @@ static void create_wds_cb(struct qmi_service *service=
, void *user_data)
 =

 	if (!service) {
 		ofono_error("Failed to request WDS service");
-		ofono_lte_remove(lte);
-		return;
+		goto error;
 	}
 =

-	ldd->wds =3D qmi_service_ref(service);
+	info->wds =3D qmi_service_ref(service);
 =

 	/* Query the default profile */
 	param =3D qmi_param_new();
@@ -201,15 +209,53 @@ static void create_wds_cb(struct qmi_service *service=
, void *user_data)
 	qmi_param_append(param, 0x1, sizeof(p), &p);
 =

 	/* Get default profile */
-	if (qmi_service_send(ldd->wds, 0x49, param,
-				get_default_profile_cb, lte, NULL) > 0)
+	if (qmi_service_send(info->wds, 0x49, param,
+				get_default_profile_cb, info, NULL) > 0)
 		return;
 =

+	ofono_error("Failed to query default profile");
+
 	qmi_param_free(param);
 =

 error:
-	ofono_error("Failed to query default profile");
+	CALLBACK_WITH_FAILURE(info->cb, info->cb_data);
+
+	qmi_service_unref(info->wds);
+	g_free(info->apn);
+	g_free(info);
+}
+
+
+static void qmimodem_lte_set_default_attach_info(const struct ofono_lte *l=
te,
+			const struct ofono_lte_default_attach_info *attach_info,
+			ofono_lte_cb_t cb, void *data)
+{
+	struct lte_data *ldd =3D ofono_lte_get_data(lte);
+	struct info *info;
+
+	info =3D g_try_new0(struct info, 1);
+
+	info->cb =3D cb;
+	info->cb_data =3D data;
+	info->apn =3D strdup(attach_info->apn);
+
+	if (qmi_service_create_shared(ldd->device, QMI_SERVICE_WDS,
+					create_wds_cb, info, NULL) > 0)
+		return;
+
+	g_free(info->apn);
+	g_free(info);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static gboolean lte_delayed_register(gpointer user_data)
+{
+	struct ofono_lte *lte =3D user_data;
+
 	ofono_lte_register(lte);
+
+	return FALSE;
 }
 =

 static int qmimodem_lte_probe(struct ofono_lte *lte, void *data)
@@ -217,16 +263,17 @@ static int qmimodem_lte_probe(struct ofono_lte *lte, =
void *data)
 	struct qmi_device *device =3D data;
 	struct lte_data *ldd;
 =

-	DBG("qmimodem lte probe");
+	DBG("");
 =

 	ldd =3D g_try_new0(struct lte_data, 1);
 	if (!ldd)
 		return -ENOMEM;
 =

+	ldd->device =3D device;
+
 	ofono_lte_set_data(lte, ldd);
 =

-	qmi_service_create_shared(device, QMI_SERVICE_WDS,
-					create_wds_cb, lte, NULL);
+	g_idle_add(lte_delayed_register, lte);
 =

 	return 0;
 }
@@ -239,10 +286,6 @@ static void qmimodem_lte_remove(struct ofono_lte *lte)
 =

 	ofono_lte_set_data(lte, NULL);
 =

-	qmi_service_unregister_all(ldd->wds);
-
-	qmi_service_unref(ldd->wds);
-
 	g_free(ldd);
 }
 =

-- =

2.14.1


--===============4644434838588989840==--

