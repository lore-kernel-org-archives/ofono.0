Content-Type: multipart/mixed; boundary="===============6094717315652672004=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC PATCH 27/30] qmi: drop qmi_service_ref function
Date: Wed, 28 Mar 2018 21:00:13 +0200
Message-ID: <20180328190016.28509-28-jonas@southpole.se>
In-Reply-To: <20180328190016.28509-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6094717315652672004==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Services no longer need to be referenced.  qmi_service_create returns an
instance that is not shared with anyone else.
---
 drivers/qmimodem/devinfo.c              | 2 +-
 drivers/qmimodem/gprs-context.c         | 4 ++--
 drivers/qmimodem/gprs.c                 | 4 ++--
 drivers/qmimodem/location-reporting.c   | 2 +-
 drivers/qmimodem/lte.c                  | 2 +-
 drivers/qmimodem/netmon.c               | 2 +-
 drivers/qmimodem/network-registration.c | 2 +-
 drivers/qmimodem/qmi.c                  | 5 -----
 drivers/qmimodem/qmi.h                  | 1 -
 drivers/qmimodem/radio-settings.c       | 4 ++--
 drivers/qmimodem/sim-legacy.c           | 2 +-
 drivers/qmimodem/sim.c                  | 4 ++--
 drivers/qmimodem/sms.c                  | 2 +-
 drivers/qmimodem/ussd.c                 | 2 +-
 drivers/qmimodem/voicecall.c            | 2 +-
 plugins/gobi.c                          | 2 +-
 16 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/qmimodem/devinfo.c b/drivers/qmimodem/devinfo.c
index f5028657..9aa5dc9d 100644
--- a/drivers/qmimodem/devinfo.c
+++ b/drivers/qmimodem/devinfo.c
@@ -172,7 +172,7 @@ static void create_dms_cb(struct qmi_service *service, =
void *user_data)
 		return;
 	}
 =

-	data->dms =3D qmi_service_ref(service);
+	data->dms =3D service;
 =

 	ofono_devinfo_register(devinfo);
 }
diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-contex=
t.c
index 9a22b89f..534dc996 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -379,7 +379,7 @@ static void create_wds_cb(struct qmi_service *service, =
void *user_data)
 		return;
 	}
 =

-	data->wds =3D qmi_service_ref(service);
+	data->wds =3D service;
 =

 	qmi_service_register(data->wds, QMI_WDS_PKT_STATUS_IND,
 					pkt_status_notify, gc, NULL);
@@ -437,7 +437,7 @@ static void create_wda_cb(struct qmi_service *service, =
void *user_data)
 		goto error;
 	}
 =

-	data->wda =3D qmi_service_ref(service);
+	data->wda =3D service;
 =

 	if (qmi_service_send(data->wda, QMI_WDA_GET_DATA_FORMAT, NULL,
 					get_data_format_cb, gc, NULL) > 0)
diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index db07f310..a684f5f1 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -334,7 +334,7 @@ static void create_wds_cb(struct qmi_service *service, =
void *user_data)
 		return;
 	}
 =

-	data->wds =3D qmi_service_ref(service);
+	data->wds =3D service;
 =

 	/*
 	 * First get the SS info - the modem may already be connected,
@@ -364,7 +364,7 @@ static void create_nas_cb(struct qmi_service *service, =
void *user_data)
 		return;
 	}
 =

-	data->nas =3D qmi_service_ref(service);
+	data->nas =3D service;
 =

 	qmi_service_create_shared(data->dev, QMI_SERVICE_WDS,
 						create_wds_cb, gprs, NULL);
diff --git a/drivers/qmimodem/location-reporting.c b/drivers/qmimodem/locat=
ion-reporting.c
index e4ce2331..ed1ec891 100644
--- a/drivers/qmimodem/location-reporting.c
+++ b/drivers/qmimodem/location-reporting.c
@@ -219,7 +219,7 @@ static void create_pds_cb(struct qmi_service *service, =
void *user_data)
 		return;
 	}
 =

-	data->pds =3D qmi_service_ref(service);
+	data->pds =3D service;
 =

 	qmi_service_register(data->pds, QMI_PDS_EVENT,
 					event_notify, lr, NULL);
diff --git a/drivers/qmimodem/lte.c b/drivers/qmimodem/lte.c
index 841e7751..135d74ad 100644
--- a/drivers/qmimodem/lte.c
+++ b/drivers/qmimodem/lte.c
@@ -190,7 +190,7 @@ static void create_wds_cb(struct qmi_service *service, =
void *user_data)
 		return;
 	}
 =

-	ldd->wds =3D qmi_service_ref(service);
+	ldd->wds =3D service;
 =

 	/* Query the default profile */
 	param =3D qmi_param_new();
diff --git a/drivers/qmimodem/netmon.c b/drivers/qmimodem/netmon.c
index 6ef5d09c..0165bbc5 100644
--- a/drivers/qmimodem/netmon.c
+++ b/drivers/qmimodem/netmon.c
@@ -230,7 +230,7 @@ static void create_nas_cb(struct qmi_service *service, =
void *user_data)
 		return;
 	}
 =

-	nmd->nas =3D qmi_service_ref(service);
+	nmd->nas =3D service;
 =

 	ofono_netmon_register(netmon);
 }
diff --git a/drivers/qmimodem/network-registration.c b/drivers/qmimodem/net=
work-registration.c
index 6c1f50ba..cab312cd 100644
--- a/drivers/qmimodem/network-registration.c
+++ b/drivers/qmimodem/network-registration.c
@@ -543,7 +543,7 @@ static void create_nas_cb(struct qmi_service *service, =
void *user_data)
 		return;
 	}
 =

-	data->nas =3D qmi_service_ref(service);
+	data->nas =3D service;
 =

 	param =3D qmi_param_new();
 	if (!param)
diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index c87885cd..204e189e 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -2051,11 +2051,6 @@ static void service_release_callback(uint16_t messag=
e, uint16_t length,
 	info->device->release_users--;
 }
 =

-struct qmi_service *qmi_service_ref(struct qmi_service *service)
-{
-	return service;
-}
-
 /*
  * FIXME: we want to rename this to qmi_service_destroy because the 'creat=
e'
  * function returns an instance and this effectively destroys it... refere=
nce
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 9cbf0a72..c8cec5c6 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -155,7 +155,6 @@ bool qmi_service_create_shared(struct qmi_device *devic=
e,
 				uint8_t type, qmi_create_func_t func,
 				void *user_data, qmi_destroy_func_t destroy);
 =

-struct qmi_service *qmi_service_ref(struct qmi_service *service);
 void qmi_service_unref(struct qmi_service *service);
 =

 const char *qmi_service_get_identifier(struct qmi_service *service);
diff --git a/drivers/qmimodem/radio-settings.c b/drivers/qmimodem/radio-set=
tings.c
index 36ad25cf..0cc95828 100644
--- a/drivers/qmimodem/radio-settings.c
+++ b/drivers/qmimodem/radio-settings.c
@@ -222,7 +222,7 @@ static void create_dms_cb(struct qmi_service *service, =
void *user_data)
 	if (!service)
 		return;
 =

-	data->dms =3D qmi_service_ref(service);
+	data->dms =3D service;
 }
 =

 static void create_nas_cb(struct qmi_service *service, void *user_data)
@@ -244,7 +244,7 @@ static void create_nas_cb(struct qmi_service *service, =
void *user_data)
 		return;
 	}
 =

-	data->nas =3D qmi_service_ref(service);
+	data->nas =3D service;
 =

 	ofono_radio_settings_register(rs);
 }
diff --git a/drivers/qmimodem/sim-legacy.c b/drivers/qmimodem/sim-legacy.c
index 318b1aed..55fbadc1 100644
--- a/drivers/qmimodem/sim-legacy.c
+++ b/drivers/qmimodem/sim-legacy.c
@@ -319,7 +319,7 @@ static void create_dms_cb(struct qmi_service *service, =
void *user_data)
 		return;
 	}
 =

-	data->dms =3D qmi_service_ref(service);
+	data->dms =3D service;
 =

 	qmi_service_register(data->dms, QMI_DMS_EVENT,
 					event_notify, sim, NULL);
diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
index 1d9befc9..15d224fd 100644
--- a/drivers/qmimodem/sim.c
+++ b/drivers/qmimodem/sim.c
@@ -818,7 +818,7 @@ static void create_uim_cb(struct qmi_service *service, =
void *user_data)
 		goto error;
 	}
 =

-	data->uim =3D qmi_service_ref(service);
+	data->uim =3D service;
 =

 	param =3D qmi_param_new_uint32(QMI_UIM_PARAM_EVENT_MASK, mask);
 	if (!param)
@@ -845,7 +845,7 @@ static void create_dms_cb(struct qmi_service *service, =
void *user_data)
 		return;
 	}
 =

-	data->dms =3D qmi_service_ref(service);
+	data->dms =3D service;
 =

 	qmi_service_create(data->qmi_dev, QMI_SERVICE_UIM, create_uim_cb, sim,
 					NULL);
diff --git a/drivers/qmimodem/sms.c b/drivers/qmimodem/sms.c
index 7e6baec5..8893480b 100644
--- a/drivers/qmimodem/sms.c
+++ b/drivers/qmimodem/sms.c
@@ -522,7 +522,7 @@ static void create_wms_cb(struct qmi_service *service, =
void *user_data)
 		return;
 	}
 =

-	data->wms =3D qmi_service_ref(service);
+	data->wms =3D service;
 =

 	qmi_service_register(data->wms, QMI_WMS_EVENT,
 					event_notify, sms, NULL);
diff --git a/drivers/qmimodem/ussd.c b/drivers/qmimodem/ussd.c
index 174e354d..d62eddd9 100644
--- a/drivers/qmimodem/ussd.c
+++ b/drivers/qmimodem/ussd.c
@@ -140,7 +140,7 @@ static void create_voice_cb(struct qmi_service *service=
, void *user_data)
 		return;
 	}
 =

-	data->voice =3D qmi_service_ref(service);
+	data->voice =3D service;
 =

 	qmi_service_register(data->voice, QMI_VOICE_ASYNC_ORIG_USSD,
 					async_orig_ind, ussd, NULL);
diff --git a/drivers/qmimodem/voicecall.c b/drivers/qmimodem/voicecall.c
index 29166b08..d8c63171 100644
--- a/drivers/qmimodem/voicecall.c
+++ b/drivers/qmimodem/voicecall.c
@@ -56,7 +56,7 @@ static void create_voice_cb(struct qmi_service *service, =
void *user_data)
 		return;
 	}
 =

-	data->voice =3D qmi_service_ref(service);
+	data->voice =3D service;
 =

 	ofono_voicecall_register(vc);
 }
diff --git a/plugins/gobi.c b/plugins/gobi.c
index 85218913..adac5c89 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -245,7 +245,7 @@ static void create_dms_cb(struct qmi_service *service, =
void *user_data)
 	if (!service)
 		goto error;
 =

-	data->dms =3D qmi_service_ref(service);
+	data->dms =3D service;
 =

 	if (qmi_service_send(data->dms, QMI_DMS_GET_CAPS, NULL,
 					get_caps_cb, modem, NULL) > 0)
-- =

2.15.1


--===============6094717315652672004==--

