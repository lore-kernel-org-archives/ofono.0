Content-Type: multipart/mixed; boundary="===============1175031688708952694=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 6/8] qmi: add LTE atom driver
Date: Tue, 11 Apr 2017 10:18:16 +0200
Message-ID: <20170411081818.19544-7-jonas@southpole.se>
In-Reply-To: <20170411081818.19544-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1175031688708952694==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When the LTE atom detects that the modem is registered to an LTE network,
the driver will be asked to activate the default bearer.  For QMI modems,
this means that the "Start Network" method needs to be called with the
default APN.
---
 Makefile.am                 |   1 +
 drivers/qmimodem/lte.c      | 219 ++++++++++++++++++++++++++++++++++++++++=
++++
 drivers/qmimodem/qmimodem.c |   2 +
 drivers/qmimodem/qmimodem.h |   3 +
 4 files changed, 225 insertions(+)
 create mode 100644 drivers/qmimodem/lte.c

diff --git a/Makefile.am b/Makefile.am
index b232f97..a7767f9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -231,6 +231,7 @@ builtin_sources +=3D $(qmi_sources) \
 			drivers/qmimodem/ussd.c \
 			drivers/qmimodem/gprs.c \
 			drivers/qmimodem/gprs-context.c \
+			drivers/qmimodem/lte.c \
 			drivers/qmimodem/radio-settings.c \
 			drivers/qmimodem/location-reporting.c
 =

diff --git a/drivers/qmimodem/lte.c b/drivers/qmimodem/lte.c
new file mode 100644
index 0000000..71a323f
--- /dev/null
+++ b/drivers/qmimodem/lte.c
@@ -0,0 +1,219 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2016  Endocode AG. All rights reserved.
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
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+
+#include <glib.h>
+
+#include <ofono/modem.h>
+#include <ofono/gprs-context.h>
+#include <ofono/log.h>
+#include <ofono/lte.h>
+
+#include "qmi.h"
+#include "wds.h"
+
+#include "qmimodem.h"
+
+struct lte_data {
+	struct qmi_service *wds;
+	char* apn;
+	uint32_t default_bearer_handle;
+};
+
+static void start_net_cb(struct qmi_result *result, void *user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_lte_cb_t cb =3D cbd->cb;
+	const struct ofono_lte *lte =3D cbd->user;
+	struct lte_data *ldd =3D ofono_lte_get_data(lte);
+
+	uint32_t handle;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, NULL)) {
+		goto error;
+	}
+
+	if (!qmi_result_get_uint32(result,
+				QMI_WDS_RESULT_PKT_HANDLE, &handle)) {
+		goto error;
+	}
+
+	DBG("packet handle 0x%08x", handle);
+
+	ldd->default_bearer_handle =3D handle;
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+
+	g_free(cbd);
+
+	return;
+
+error:
+	ldd->default_bearer_handle =3D 0;
+
+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+
+	g_free(cbd);
+}
+
+static void qmi_lte_activate_default_bearer(struct ofono_lte *lte,
+			ofono_lte_cb_t cb, void * data)
+{
+	struct lte_data *ldd =3D ofono_lte_get_data(lte);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	struct qmi_param *param =3D NULL;
+
+	DBG("");
+
+	cbd->user =3D lte;
+
+	if (ldd->apn) {
+		param =3D qmi_param_new();
+		qmi_param_append(param, QMI_WDS_PARAM_APN,
+					strlen(ldd->apn), ldd->apn);
+		DBG("Default APN: %s", ldd->apn);
+	}
+
+	if (qmi_service_send(ldd->wds, QMI_WDS_START_NET, param,
+					start_net_cb, cbd, NULL) > 0)
+		return;
+
+	qmi_param_free(param);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void qmimodem_lte_set_default_attach_info(const struct ofono_lte *l=
te,
+			const struct ofono_lte_default_attach_info *info,
+			ofono_lte_cb_t cb, void *data)
+{
+	struct lte_data *ldd =3D ofono_lte_get_data(lte);
+
+	DBG("LTE config with APN: %s", info->apn);
+
+	if (ldd->apn)
+		g_free(ldd->apn);
+
+	if (strlen(info->apn) > 0)
+		ldd->apn =3D g_strdup(info->apn);
+	else
+		ldd->apn =3D NULL;
+
+	CALLBACK_WITH_SUCCESS(cb, data);
+}
+
+static void create_wds_cb(struct qmi_service *service, void *user_data)
+{
+	struct ofono_lte *lte =3D user_data;
+	struct lte_data *data =3D ofono_lte_get_data(lte);
+//	struct qmi_param *param;
+
+	DBG("");
+
+	if (!service) {
+		ofono_error("Failed to request WDS service");
+		ofono_lte_remove(lte);
+		return;
+	}
+
+	data->wds =3D qmi_service_ref(service);
+
+	ofono_lte_register(lte);
+}
+
+#if 0
+static gboolean lte_delayed_register(gpointer user_data)
+{
+	struct ofono_lte *lte =3D user_data;
+
+	qmi_service_create(device, QMI_SERVICE_WDS,
+					create_wds_cb, lte, NULL);
+
+	return FALSE;
+}
+#endif
+
+static int qmimodem_lte_probe(struct ofono_lte *lte, void *data)
+{
+	struct qmi_device *device =3D data;
+	struct lte_data *ldd;
+
+	DBG("qmimodem lte probe");
+
+	ldd =3D g_try_new0(struct lte_data, 1);
+	if (!ldd)
+		return -ENOMEM;
+
+	ofono_lte_set_data(lte, ldd);
+
+	qmi_service_create(device, QMI_SERVICE_WDS,
+					create_wds_cb, lte, NULL);
+
+//	g_idle_add(lte_delayed_register, lte);
+
+	return 0;
+}
+
+static void qmimodem_lte_remove(struct ofono_lte *lte)
+{
+	struct lte_data *ldd =3D ofono_lte_get_data(lte);
+
+	DBG("");
+
+	ofono_lte_set_data(lte, NULL);
+
+	qmi_service_unregister_all(ldd->wds);
+
+	qmi_service_unref(ldd->wds);
+
+	if (ldd->apn)
+		g_free(ldd->apn);
+
+	g_free(ldd);
+}
+
+static struct ofono_lte_driver driver =3D {
+	.name				=3D "qmimodem",
+	.probe				=3D qmimodem_lte_probe,
+	.remove				=3D qmimodem_lte_remove,
+	.set_default_attach_info	=3D qmimodem_lte_set_default_attach_info,
+	.activate_default_bearer	=3D qmi_lte_activate_default_bearer,
+};
+
+void qmi_lte_init(void)
+{
+	ofono_lte_driver_register(&driver);
+}
+
+void qmi_lte_exit(void)
+{
+	ofono_lte_driver_unregister(&driver);
+}
diff --git a/drivers/qmimodem/qmimodem.c b/drivers/qmimodem/qmimodem.c
index 959a901..2ce5c02 100644
--- a/drivers/qmimodem/qmimodem.c
+++ b/drivers/qmimodem/qmimodem.c
@@ -39,6 +39,7 @@ static int qmimodem_init(void)
 	qmi_ussd_init();
 	qmi_gprs_init();
 	qmi_gprs_context_init();
+	qmi_lte_init();
 	qmi_radio_settings_init();
 	qmi_location_reporting_init();
 =

@@ -49,6 +50,7 @@ static void qmimodem_exit(void)
 {
 	qmi_location_reporting_exit();
 	qmi_radio_settings_exit();
+	qmi_lte_exit();
 	qmi_gprs_context_exit();
 	qmi_gprs_exit();
 	qmi_ussd_exit();
diff --git a/drivers/qmimodem/qmimodem.h b/drivers/qmimodem/qmimodem.h
index 1fc8682..4667334 100644
--- a/drivers/qmimodem/qmimodem.h
+++ b/drivers/qmimodem/qmimodem.h
@@ -48,6 +48,9 @@ extern void qmi_gprs_exit(void);
 extern void qmi_gprs_context_init(void);
 extern void qmi_gprs_context_exit(void);
 =

+extern void qmi_lte_init(void);
+extern void qmi_lte_exit(void);
+
 extern void qmi_radio_settings_init(void);
 extern void qmi_radio_settings_exit(void);
 =

-- =

2.9.3


--===============1175031688708952694==--

