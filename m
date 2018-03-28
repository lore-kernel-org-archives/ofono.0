Content-Type: multipart/mixed; boundary="===============3903624175014858447=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC PATCH 28/30] qmi: rename qmi_service_create/unref to open/close
Date: Wed, 28 Mar 2018 21:00:14 +0200
Message-ID: <20180328190016.28509-29-jonas@southpole.se>
In-Reply-To: <20180328190016.28509-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3903624175014858447==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Continuing the analogy to file descriptors, this patch renames the
qmi_service_create/unref pair to qmi_service_open/close.  This reflects
the design and usage pattern better.
---
 drivers/qmimodem/devinfo.c              |  4 ++--
 drivers/qmimodem/gprs-context.c         | 10 +++++-----
 drivers/qmimodem/gprs.c                 |  8 ++++----
 drivers/qmimodem/location-reporting.c   |  4 ++--
 drivers/qmimodem/lte.c                  |  4 ++--
 drivers/qmimodem/netmon.c               |  4 ++--
 drivers/qmimodem/network-registration.c |  4 ++--
 drivers/qmimodem/qmi.c                  | 18 ++----------------
 drivers/qmimodem/qmi.h                  |  8 ++------
 drivers/qmimodem/radio-settings.c       |  8 ++++----
 drivers/qmimodem/sim-legacy.c           |  4 ++--
 drivers/qmimodem/sim.c                  |  8 ++++----
 drivers/qmimodem/sms.c                  |  4 ++--
 drivers/qmimodem/ussd.c                 |  4 ++--
 drivers/qmimodem/voicecall.c            |  4 ++--
 plugins/gobi.c                          |  6 +++---
 16 files changed, 42 insertions(+), 60 deletions(-)

diff --git a/drivers/qmimodem/devinfo.c b/drivers/qmimodem/devinfo.c
index 9aa5dc9d..7d08b762 100644
--- a/drivers/qmimodem/devinfo.c
+++ b/drivers/qmimodem/devinfo.c
@@ -189,7 +189,7 @@ static int qmi_devinfo_probe(struct ofono_devinfo *devi=
nfo,
 =

 	ofono_devinfo_set_data(devinfo, data);
 =

-	qmi_service_create_shared(device, QMI_SERVICE_DMS,
+	qmi_service_open(device, QMI_SERVICE_DMS,
 					create_dms_cb, devinfo, NULL);
 =

 	return 0;
@@ -203,7 +203,7 @@ static void qmi_devinfo_remove(struct ofono_devinfo *de=
vinfo)
 =

 	ofono_devinfo_set_data(devinfo, NULL);
 =

-	qmi_service_unref(data->dms);
+	qmi_service_close(data->dms);
 =

 	g_free(data);
 }
diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-contex=
t.c
index 534dc996..12aca163 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -421,7 +421,7 @@ static void get_data_format_cb(struct qmi_result *resul=
t, void *user_data)
 	}
 =

 done:
-	qmi_service_create_shared(data->dev, QMI_SERVICE_WDS, create_wds_cb, gc,
+	qmi_service_open(data->dev, QMI_SERVICE_WDS, create_wds_cb, gc,
 									NULL);
 }
 =

@@ -444,7 +444,7 @@ static void create_wda_cb(struct qmi_service *service, =
void *user_data)
 		return;
 =

 error:
-	qmi_service_create_shared(data->dev, QMI_SERVICE_WDS, create_wds_cb, gc,
+	qmi_service_open(data->dev, QMI_SERVICE_WDS, create_wds_cb, gc,
 									NULL);
 }
 =

@@ -461,7 +461,7 @@ static int qmi_gprs_context_probe(struct ofono_gprs_con=
text *gc,
 	ofono_gprs_context_set_data(gc, data);
 	data->dev =3D device;
 =

-	qmi_service_create(device, QMI_SERVICE_WDA, create_wda_cb, gc, NULL);
+	qmi_service_open(device, QMI_SERVICE_WDA, create_wda_cb, gc, NULL);
 =

 	return 0;
 }
@@ -476,12 +476,12 @@ static void qmi_gprs_context_remove(struct ofono_gprs=
_context *gc)
 =

 	if (data->wds) {
 		qmi_service_unregister_all(data->wds);
-		qmi_service_unref(data->wds);
+		qmi_service_close(data->wds);
 	}
 =

 	if (data->wda) {
 		qmi_service_unregister_all(data->wda);
-		qmi_service_unref(data->wda);
+		qmi_service_close(data->wda);
 	}
 =

 	g_free(data);
diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index a684f5f1..0e4342ca 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -366,7 +366,7 @@ static void create_nas_cb(struct qmi_service *service, =
void *user_data)
 =

 	data->nas =3D service;
 =

-	qmi_service_create_shared(data->dev, QMI_SERVICE_WDS,
+	qmi_service_open(data->dev, QMI_SERVICE_WDS,
 						create_wds_cb, gprs, NULL);
 }
 =

@@ -384,7 +384,7 @@ static int qmi_gprs_probe(struct ofono_gprs *gprs,
 =

 	data->dev =3D device;
 =

-	qmi_service_create_shared(device, QMI_SERVICE_NAS,
+	qmi_service_open(device, QMI_SERVICE_NAS,
 						create_nas_cb, gprs, NULL);
 =

 	return 0;
@@ -399,11 +399,11 @@ static void qmi_gprs_remove(struct ofono_gprs *gprs)
 	ofono_gprs_set_data(gprs, NULL);
 =

 	qmi_service_unregister_all(data->wds);
-	qmi_service_unref(data->wds);
+	qmi_service_close(data->wds);
 =

 	qmi_service_unregister_all(data->nas);
 =

-	qmi_service_unref(data->nas);
+	qmi_service_close(data->nas);
 =

 	g_free(data);
 }
diff --git a/drivers/qmimodem/location-reporting.c b/drivers/qmimodem/locat=
ion-reporting.c
index ed1ec891..c6bb48c1 100644
--- a/drivers/qmimodem/location-reporting.c
+++ b/drivers/qmimodem/location-reporting.c
@@ -258,7 +258,7 @@ static int qmi_location_reporting_probe(struct ofono_lo=
cation_reporting *lr,
 =

 	ofono_location_reporting_set_data(lr, data);
 =

-	qmi_service_create(device, QMI_SERVICE_PDS, create_pds_cb, lr, NULL);
+	qmi_service_open(device, QMI_SERVICE_PDS, create_pds_cb, lr, NULL);
 =

 	return 0;
 }
@@ -273,7 +273,7 @@ static void qmi_location_reporting_remove(struct ofono_=
location_reporting *lr)
 =

 	qmi_service_unregister_all(data->pds);
 =

-	qmi_service_unref(data->pds);
+	qmi_service_close(data->pds);
 =

 	g_free(data);
 }
diff --git a/drivers/qmimodem/lte.c b/drivers/qmimodem/lte.c
index 135d74ad..ebd49cad 100644
--- a/drivers/qmimodem/lte.c
+++ b/drivers/qmimodem/lte.c
@@ -226,7 +226,7 @@ static int qmimodem_lte_probe(struct ofono_lte *lte,
 =

 	ofono_lte_set_data(lte, ldd);
 =

-	qmi_service_create_shared(device, QMI_SERVICE_WDS,
+	qmi_service_open(device, QMI_SERVICE_WDS,
 					create_wds_cb, lte, NULL);
 =

 	return 0;
@@ -242,7 +242,7 @@ static void qmimodem_lte_remove(struct ofono_lte *lte)
 =

 	qmi_service_unregister_all(ldd->wds);
 =

-	qmi_service_unref(ldd->wds);
+	qmi_service_close(ldd->wds);
 =

 	g_free(ldd);
 }
diff --git a/drivers/qmimodem/netmon.c b/drivers/qmimodem/netmon.c
index 0165bbc5..8520b2fa 100644
--- a/drivers/qmimodem/netmon.c
+++ b/drivers/qmimodem/netmon.c
@@ -247,7 +247,7 @@ static int qmi_netmon_probe(struct ofono_netmon *netmon,
 =

 	ofono_netmon_set_data(netmon, nmd);
 =

-	qmi_service_create_shared(device, QMI_SERVICE_NAS,
+	qmi_service_open(device, QMI_SERVICE_NAS,
 					create_nas_cb, netmon, NULL);
 =

 	return 0;
@@ -263,7 +263,7 @@ static void qmi_netmon_remove(struct ofono_netmon *netm=
on)
 =

 	qmi_service_unregister_all(nmd->nas);
 =

-	qmi_service_unref(nmd->nas);
+	qmi_service_close(nmd->nas);
 =

 	g_free(nmd);
 }
diff --git a/drivers/qmimodem/network-registration.c b/drivers/qmimodem/net=
work-registration.c
index cab312cd..b80e9522 100644
--- a/drivers/qmimodem/network-registration.c
+++ b/drivers/qmimodem/network-registration.c
@@ -583,7 +583,7 @@ static int qmi_netreg_probe(struct ofono_netreg *netreg,
 =

 	ofono_netreg_set_data(netreg, data);
 =

-	qmi_service_create_shared(device, QMI_SERVICE_NAS,
+	qmi_service_open(device, QMI_SERVICE_NAS,
 					create_nas_cb, netreg, NULL);
 =

 	return 0;
@@ -599,7 +599,7 @@ static void qmi_netreg_remove(struct ofono_netreg *netr=
eg)
 =

 	qmi_service_unregister_all(data->nas);
 =

-	qmi_service_unref(data->nas);
+	qmi_service_close(data->nas);
 =

 	g_free(data);
 }
diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 204e189e..8c1696bf 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -1993,7 +1993,7 @@ static gboolean service_create_shared_reply(gpointer =
user_data)
 	return FALSE;
 }
 =

-bool qmi_service_create_shared(struct qmi_device *device,
+bool qmi_service_open(struct qmi_device *device,
 				uint8_t type, qmi_create_func_t func,
 				void *user_data, qmi_destroy_func_t destroy)
 {
@@ -2035,14 +2035,6 @@ bool qmi_service_create_shared(struct qmi_device *de=
vice,
 	return true;
 }
 =

-bool qmi_service_create(struct qmi_device *device,
-				uint8_t type, qmi_create_func_t func,
-				void *user_data, qmi_destroy_func_t destroy)
-{
-	return qmi_service_create_shared(device, type, func,
-						user_data, destroy);
-}
-
 static void service_release_callback(uint16_t message, uint16_t length,
 					const void *buffer, void *user_data)
 {
@@ -2051,13 +2043,7 @@ static void service_release_callback(uint16_t messag=
e, uint16_t length,
 	info->device->release_users--;
 }
 =

-/*
- * FIXME: we want to rename this to qmi_service_destroy because the 'creat=
e'
- * function returns an instance and this effectively destroys it... refere=
nce
- * counting is no longer relevant as these service objects are no longer m=
eant
- * to be shared between unrelated entities.
- */
-void qmi_service_unref(struct qmi_service *service)
+void qmi_service_close(struct qmi_service *service)
 {
 	struct qmi_service_info *info;
 =

diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index c8cec5c6..de47837e 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -148,14 +148,10 @@ typedef void (*qmi_result_func_t)(struct qmi_result *=
result, void *user_data);
 =

 typedef void (*qmi_create_func_t)(struct qmi_service *service, void *user_=
data);
 =

-bool qmi_service_create(struct qmi_device *device,
+bool qmi_service_open(struct qmi_device *device,
 				uint8_t type, qmi_create_func_t func,
 				void *user_data, qmi_destroy_func_t destroy);
-bool qmi_service_create_shared(struct qmi_device *device,
-				uint8_t type, qmi_create_func_t func,
-				void *user_data, qmi_destroy_func_t destroy);
-
-void qmi_service_unref(struct qmi_service *service);
+void qmi_service_close(struct qmi_service *service);
 =

 const char *qmi_service_get_identifier(struct qmi_service *service);
 bool qmi_service_get_version(struct qmi_service *service,
diff --git a/drivers/qmimodem/radio-settings.c b/drivers/qmimodem/radio-set=
tings.c
index 0cc95828..87fadfea 100644
--- a/drivers/qmimodem/radio-settings.c
+++ b/drivers/qmimodem/radio-settings.c
@@ -261,9 +261,9 @@ static int qmi_radio_settings_probe(struct ofono_radio_=
settings *rs,
 =

 	ofono_radio_settings_set_data(rs, data);
 =

-	qmi_service_create_shared(device, QMI_SERVICE_DMS,
+	qmi_service_open(device, QMI_SERVICE_DMS,
 						create_dms_cb, rs, NULL);
-	qmi_service_create_shared(device, QMI_SERVICE_NAS,
+	qmi_service_open(device, QMI_SERVICE_NAS,
 						create_nas_cb, rs, NULL);
 =

 	return 0;
@@ -278,11 +278,11 @@ static void qmi_radio_settings_remove(struct ofono_ra=
dio_settings *rs)
 	ofono_radio_settings_set_data(rs, NULL);
 =

 	qmi_service_unregister_all(data->dms);
-	qmi_service_unref(data->dms);
+	qmi_service_close(data->dms);
 =

 	qmi_service_unregister_all(data->nas);
 =

-	qmi_service_unref(data->nas);
+	qmi_service_close(data->nas);
 =

 	g_free(data);
 }
diff --git a/drivers/qmimodem/sim-legacy.c b/drivers/qmimodem/sim-legacy.c
index 55fbadc1..fbb3d3c0 100644
--- a/drivers/qmimodem/sim-legacy.c
+++ b/drivers/qmimodem/sim-legacy.c
@@ -358,7 +358,7 @@ static int qmi_sim_probe(struct ofono_sim *sim,
 =

 	ofono_sim_set_data(sim, data);
 =

-	qmi_service_create_shared(device, QMI_SERVICE_DMS,
+	qmi_service_open(device, QMI_SERVICE_DMS,
 						create_dms_cb, sim, NULL);
 =

 	return 0;
@@ -374,7 +374,7 @@ static void qmi_sim_remove(struct ofono_sim *sim)
 =

 	qmi_service_unregister_all(data->dms);
 =

-	qmi_service_unref(data->dms);
+	qmi_service_close(data->dms);
 =

 	g_free(data);
 }
diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
index 15d224fd..a8b168d7 100644
--- a/drivers/qmimodem/sim.c
+++ b/drivers/qmimodem/sim.c
@@ -847,7 +847,7 @@ static void create_dms_cb(struct qmi_service *service, =
void *user_data)
 =

 	data->dms =3D service;
 =

-	qmi_service_create(data->qmi_dev, QMI_SERVICE_UIM, create_uim_cb, sim,
+	qmi_service_open(data->qmi_dev, QMI_SERVICE_UIM, create_uim_cb, sim,
 					NULL);
 }
 =

@@ -865,7 +865,7 @@ static int qmi_sim_probe(struct ofono_sim *sim,
 =

 	ofono_sim_set_data(sim, data);
 =

-	qmi_service_create_shared(device, QMI_SERVICE_DMS,
+	qmi_service_open(device, QMI_SERVICE_DMS,
 						create_dms_cb, sim, NULL);
 =

 	return 0;
@@ -884,12 +884,12 @@ static void qmi_sim_remove(struct ofono_sim *sim)
 =

 	if (data->uim) {
 		qmi_service_unregister_all(data->uim);
-		qmi_service_unref(data->uim);
+		qmi_service_close(data->uim);
 		data->uim =3D NULL;
 	}
 	if (data->dms) {
 		qmi_service_unregister_all(data->dms);
-		qmi_service_unref(data->dms);
+		qmi_service_close(data->dms);
 	}
 =

 	g_free(data);
diff --git a/drivers/qmimodem/sms.c b/drivers/qmimodem/sms.c
index 8893480b..a6d88ca5 100644
--- a/drivers/qmimodem/sms.c
+++ b/drivers/qmimodem/sms.c
@@ -551,7 +551,7 @@ static int qmi_sms_probe(struct ofono_sms *sms,
 =

 	ofono_sms_set_data(sms, data);
 =

-	qmi_service_create(device, QMI_SERVICE_WMS, create_wms_cb, sms, NULL);
+	qmi_service_open(device, QMI_SERVICE_WMS, create_wms_cb, sms, NULL);
 =

 	return 0;
 }
@@ -566,7 +566,7 @@ static void qmi_sms_remove(struct ofono_sms *sms)
 =

 	qmi_service_unregister_all(data->wms);
 =

-	qmi_service_unref(data->wms);
+	qmi_service_close(data->wms);
 =

 	g_free(data);
 }
diff --git a/drivers/qmimodem/ussd.c b/drivers/qmimodem/ussd.c
index d62eddd9..df0649ff 100644
--- a/drivers/qmimodem/ussd.c
+++ b/drivers/qmimodem/ussd.c
@@ -160,7 +160,7 @@ static int qmi_ussd_probe(struct ofono_ussd *ussd,
 =

 	ofono_ussd_set_data(ussd, data);
 =

-	qmi_service_create_shared(device, QMI_SERVICE_VOICE,
+	qmi_service_open(device, QMI_SERVICE_VOICE,
 						create_voice_cb, ussd, NULL);
 =

 	return 0;
@@ -174,7 +174,7 @@ static void qmi_ussd_remove(struct ofono_ussd *ussd)
 =

 	ofono_ussd_set_data(ussd, NULL);
 =

-	qmi_service_unref(data->voice);
+	qmi_service_close(data->voice);
 =

 	g_free(data);
 }
diff --git a/drivers/qmimodem/voicecall.c b/drivers/qmimodem/voicecall.c
index d8c63171..db827f25 100644
--- a/drivers/qmimodem/voicecall.c
+++ b/drivers/qmimodem/voicecall.c
@@ -73,7 +73,7 @@ static int qmi_voicecall_probe(struct ofono_voicecall *vc,
 =

 	ofono_voicecall_set_data(vc, data);
 =

-	qmi_service_create(device, QMI_SERVICE_VOICE,
+	qmi_service_open(device, QMI_SERVICE_VOICE,
 					create_voice_cb, vc, NULL);
 =

 	return 0;
@@ -90,7 +90,7 @@ static void qmi_voicecall_remove(struct ofono_voicecall *=
vc)
 =

 	qmi_service_unregister_all(data->voice);
 =

-	qmi_service_unref(data->voice);
+	qmi_service_close(data->voice);
 =

 	g_free(data);
 }
diff --git a/plugins/gobi.c b/plugins/gobi.c
index adac5c89..84ef7432 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -104,7 +104,7 @@ static void gobi_remove(struct ofono_modem *modem)
 =

 	ofono_modem_set_data(modem, NULL);
 =

-	qmi_service_unref(data->dms);
+	qmi_service_close(data->dms);
 =

 	qmi_device_unref(data->device);
 =

@@ -132,7 +132,7 @@ static void shutdown_device(struct ofono_modem *modem)
 =

 	DBG("%p", modem);
 =

-	qmi_service_unref(data->dms);
+	qmi_service_close(data->dms);
 	data->dms =3D NULL;
 =

 	qmi_device_shutdown(data->device, shutdown_cb, modem, NULL);
@@ -260,7 +260,7 @@ static void create_shared_dms(void *user_data)
 	struct ofono_modem *modem =3D user_data;
 	struct gobi_data *data =3D ofono_modem_get_data(modem);
 =

-	qmi_service_create_shared(data->device, QMI_SERVICE_DMS,
+	qmi_service_open(data->device, QMI_SERVICE_DMS,
 				  create_dms_cb, modem, NULL);
 }
 =

-- =

2.15.1


--===============3903624175014858447==--

