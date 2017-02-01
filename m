Content-Type: multipart/mixed; boundary="===============2527281914168580292=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 2/2] qmimodem: change kernel driver data format if needed
Date: Wed, 01 Feb 2017 11:32:48 +0100
Message-ID: <20170201103248.26822-3-c.ronco@kerlink.fr>
In-Reply-To: <20170201103248.26822-1-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2527281914168580292==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

During gprs-context driver probe function, check kernel device driver
data format and modem low level data format.
If they are different, align kernel device driver data format on
modem low level data format.
If an error occurs during this process, continue probing without error.
This is inspired by what is done in qmicli and qmi-network (package
libqmi).
---
 Makefile.am                     |  3 +-
 drivers/qmimodem/gprs-context.c | 79 +++++++++++++++++++++++++++++++++++++=
++--
 drivers/qmimodem/qmi.h          |  1 +
 drivers/qmimodem/wda.h          | 25 +++++++++++++
 4 files changed, 104 insertions(+), 4 deletions(-)
 create mode 100644 drivers/qmimodem/wda.h

diff --git a/Makefile.am b/Makefile.am
index 560fc1cb..250ec30f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -216,7 +216,8 @@ qmi_sources =3D drivers/qmimodem/qmi.h drivers/qmimodem=
/qmi.c \
 					drivers/qmimodem/wms.h \
 					drivers/qmimodem/wds.h \
 					drivers/qmimodem/pds.h \
-					drivers/qmimodem/common.h
+					drivers/qmimodem/common.h \
+					drivers/qmimodem/wda.h
 =

 builtin_modules +=3D qmimodem
 builtin_sources +=3D $(qmi_sources) \
diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-contex=
t.c
index b7f29b60..da2be241 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -30,12 +30,15 @@
 #include <ofono/gprs-context.h>
 =

 #include "qmi.h"
+#include "wda.h"
 #include "wds.h"
 =

 #include "qmimodem.h"
 =

 struct gprs_context_data {
 	struct qmi_service *wds;
+	struct qmi_service *wda;
+	struct qmi_device *dev;
 	unsigned int active_context;
 	uint32_t pkt_handle;
 };
@@ -287,6 +290,69 @@ static void create_wds_cb(struct qmi_service *service,=
 void *user_data)
 					pkt_status_notify, gc, NULL);
 }
 =

+static void get_data_format_cb(struct qmi_result *result, void *user_data)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *data =3D ofono_gprs_context_get_data(gc);
+	uint32_t llproto;
+	enum qmi_device_expected_data_format expected_llproto;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, NULL))
+		goto done;
+
+	if (!qmi_result_get_uint32(result, QMI_WDA_LL_PROTOCOL, &llproto))
+		goto done;
+
+	expected_llproto =3D qmi_device_get_expected_data_format(data->dev);
+
+	if ((llproto =3D=3D QMI_WDA_DATA_LINK_PROTOCOL_802_3) &&
+			(expected_llproto =3D=3D
+				QMI_DEVICE_EXPECTED_DATA_FORMAT_RAW_IP)) {
+		if (!qmi_device_set_expected_data_format(data->dev,
+					QMI_DEVICE_EXPECTED_DATA_FORMAT_802_3))
+			DBG("Fail to set expected data to 802.3");
+		else
+			DBG("expected data set to 802.3");
+	} else if ((llproto =3D=3D QMI_WDA_DATA_LINK_PROTOCOL_RAW_IP) &&
+			(expected_llproto =3D=3D
+				QMI_DEVICE_EXPECTED_DATA_FORMAT_802_3)) {
+		if (!qmi_device_set_expected_data_format(data->dev,
+					QMI_DEVICE_EXPECTED_DATA_FORMAT_RAW_IP))
+			DBG("Fail to set expected data to raw-ip");
+		else
+			DBG("expected data set to raw-ip");
+	}
+
+done:
+	qmi_service_create(data->dev, QMI_SERVICE_WDS, create_wds_cb, gc,
+									NULL);
+}
+
+static void create_wda_cb(struct qmi_service *service, void *user_data)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *data =3D ofono_gprs_context_get_data(gc);
+
+	DBG("");
+
+	if (!service) {
+		DBG("Failed to request WDA service, continue initialization");
+		goto error;
+	}
+
+	data->wda =3D qmi_service_ref(service);
+
+	if (qmi_service_send(data->wda, QMI_WDA_GET_DATA_FORMAT, NULL,
+					get_data_format_cb, gc, NULL) > 0)
+		return;
+
+error:
+	qmi_service_create(data->dev, QMI_SERVICE_WDS, create_wds_cb, gc,
+									NULL);
+}
+
 static int qmi_gprs_context_probe(struct ofono_gprs_context *gc,
 					unsigned int vendor, void *user_data)
 {
@@ -298,8 +364,9 @@ static int qmi_gprs_context_probe(struct ofono_gprs_con=
text *gc,
 	data =3D g_new0(struct gprs_context_data, 1);
 =

 	ofono_gprs_context_set_data(gc, data);
+	data->dev =3D device;
 =

-	qmi_service_create(device, QMI_SERVICE_WDS, create_wds_cb, gc, NULL);
+	qmi_service_create(device, QMI_SERVICE_WDA, create_wda_cb, gc, NULL);
 =

 	return 0;
 }
@@ -312,9 +379,15 @@ static void qmi_gprs_context_remove(struct ofono_gprs_=
context *gc)
 =

 	ofono_gprs_context_set_data(gc, NULL);
 =

-	qmi_service_unregister_all(data->wds);
+	if (data->wds) {
+		qmi_service_unregister_all(data->wds);
+		qmi_service_unref(data->wds);
+	}
 =

-	qmi_service_unref(data->wds);
+	if (data->wda) {
+		qmi_service_unregister_all(data->wda);
+		qmi_service_unref(data->wda);
+	}
 =

 	g_free(data);
 }
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index ac19fe01..2233cdb0 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -42,6 +42,7 @@
 #define QMI_SERVICE_EFS		21	/* Embedded file system service */
 #define QMI_SERVICE_TS		23	/* Thermal sensors service */
 #define QMI_SERVICE_TMD		24	/* Thermal mitigation device service */
+#define QMI_SERVICE_WDA		26	/* Wireless data administrative service */
 #define QMI_SERVICE_PDC		36	/* Persistent device configuration service */
 #define QMI_SERVICE_CAT_OLD	224	/* Card application toolkit service */
 #define QMI_SERVICE_RMS		225	/* Remote management service */
diff --git a/drivers/qmimodem/wda.h b/drivers/qmimodem/wda.h
new file mode 100644
index 00000000..359f5b8e
--- /dev/null
+++ b/drivers/qmimodem/wda.h
@@ -0,0 +1,25 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2017  Kerlink SA. All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ */
+
+#define QMI_WDA_SET_DATA_FORMAT	32	/* Set data format */
+#define QMI_WDA_GET_DATA_FORMAT	33	/* Get data format */
+
+/* Get and set data format interface */
+#define QMI_WDA_LL_PROTOCOL	0x11	/* uint32_t */
+#define QMI_WDA_DATA_LINK_PROTOCOL_UNKNOWN	0
+#define QMI_WDA_DATA_LINK_PROTOCOL_802_3	1
+#define QMI_WDA_DATA_LINK_PROTOCOL_RAW_IP	2
-- =

2.11.0


--===============2527281914168580292==--

