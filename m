Content-Type: multipart/mixed; boundary="===============6744619881247056052=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH v2 1/3] qmi: add LTE atom driver
Date: Fri, 02 Mar 2018 16:12:19 +0100
Message-ID: <20180302151221.18063-2-jonas@southpole.se>
In-Reply-To: <20180302151221.18063-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6744619881247056052==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds an LTE atom for QMI modems.

This atom sets the APN that the LTE default bearer should use when
establishing its PDP context.  This APN needs to be set on the 'default'
profile so the atom queries which profile is the default and resets
it before allowing the APN to be set.

Once configured, the default profile settings are used when the
modem connects to the network; for this reason, the LTE atom needs
to be instantiated in post_sim, before the modem is set online.
---
 Makefile.am                 |   1 +
 drivers/qmimodem/lte.c      | 266 ++++++++++++++++++++++++++++++++++++++++=
++++
 drivers/qmimodem/qmimodem.c |   2 +
 drivers/qmimodem/qmimodem.h |   3 +
 4 files changed, 272 insertions(+)
 create mode 100644 drivers/qmimodem/lte.c

diff --git a/Makefile.am b/Makefile.am
index d790a215..a921bd2b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -234,6 +234,7 @@ builtin_sources +=3D $(qmi_sources) \
 			drivers/qmimodem/ussd.c \
 			drivers/qmimodem/gprs.c \
 			drivers/qmimodem/gprs-context.c \
+			drivers/qmimodem/lte.c \
 			drivers/qmimodem/radio-settings.c \
 			drivers/qmimodem/location-reporting.c \
 			drivers/qmimodem/netmon.c
diff --git a/drivers/qmimodem/lte.c b/drivers/qmimodem/lte.c
new file mode 100644
index 00000000..3cf90be6
--- /dev/null
+++ b/drivers/qmimodem/lte.c
@@ -0,0 +1,266 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2018  Jonas Bonn. All rights reserved.
+ *  Copyright (C) 2018  Norrbonn AB. All rights reserved.
+ *  Copyright (C) 2018  Data Respons ASA. All rights reserved.
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
+	uint8_t default_profile;
+};
+
+static void modify_profile_cb(struct qmi_result *result, void *user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_lte_cb_t cb =3D cbd->cb;
+	uint16_t error;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, &error)) {
+		DBG("Failed to modify profile: %d", error);
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+		return;
+	}
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+}
+
+static void qmimodem_lte_set_default_attach_info(const struct ofono_lte *l=
te,
+			const struct ofono_lte_default_attach_info *info,
+			ofono_lte_cb_t cb, void *data)
+{
+	struct lte_data *ldd =3D ofono_lte_get_data(lte);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	struct qmi_param* param;
+	struct {
+		uint8_t type;
+		uint8_t index;
+	} __attribute__((packed)) p =3D {
+		.type =3D 0, /* 3GPP */
+	};
+
+	DBG("");
+
+	p.index =3D ldd->default_profile;
+
+	param =3D qmi_param_new();
+	if (!param)
+		goto error;
+
+	/* Profile selector */
+	qmi_param_append(param, 0x01, sizeof(p), &p);
+
+	/* WDS APN Name */
+	qmi_param_append(param, QMI_WDS_PARAM_APN,
+				strlen(info->apn), info->apn);
+
+	/* Modify profile */
+	if (qmi_service_send(ldd->wds, 0x28, param,
+					modify_profile_cb, cbd, g_free) > 0)
+		return;
+
+	qmi_param_free(param);
+
+error:	=

+	CALLBACK_WITH_FAILURE(cb, cbd->data);
+}
+
+static void reset_profile_cb(struct qmi_result *result, void *user_data)
+{
+	struct ofono_lte *lte =3D user_data;
+	uint16_t error;
+
+	DBG("");
+
+	if (qmi_result_set_error(result, &error)) {
+		ofono_error("Reset profile error: %hd", error);
+	}
+
+	ofono_lte_register(lte);
+}
+
+static void get_default_profile_cb(struct qmi_result *result, void *user_d=
ata)
+{
+	struct ofono_lte *lte =3D user_data;
+	struct lte_data *ldd =3D ofono_lte_get_data(lte);
+	uint16_t error;
+	uint8_t index;
+	struct qmi_param* param;
+	struct {
+		uint8_t type;
+		uint8_t index;
+	} __attribute__((packed)) p =3D {
+		.type =3D 0, /* 3GPP */
+	};
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
+	ldd->default_profile =3D index;
+
+	p.index =3D index;
+
+	param =3D qmi_param_new();
+	if (!param)
+		goto error;
+
+	/* Profile selector */
+	qmi_param_append(param, 0x01, sizeof(p), &p);
+
+	/* Reset profile */
+	if (qmi_service_send(ldd->wds, 0x4b, param,
+				reset_profile_cb, lte, NULL) > 0)
+		return;
+
+	qmi_param_free(param);
+
+error:
+	ofono_error("Failed to reset profile %hhd", index);
+	ofono_lte_register(lte);
+}
+
+
+static void create_wds_cb(struct qmi_service *service, void *user_data)
+{
+	struct ofono_lte *lte =3D user_data;
+	struct lte_data *ldd =3D ofono_lte_get_data(lte);
+	struct qmi_param* param;
+	struct {
+		uint8_t type;
+		uint8_t family;
+	} __attribute((packed)) p =3D {
+		.type =3D 0,   /* 3GPP */
+		.family =3D 0, /* embedded */
+	};
+
+	DBG("");
+
+	if (!service) {
+		ofono_error("Failed to request WDS service");
+		ofono_lte_remove(lte);
+		return;
+	}
+
+	ldd->wds =3D qmi_service_ref(service);
+
+	/* Query the default profile */
+	param =3D qmi_param_new();
+	if (!param)
+		goto error;
+
+	/* Profile type */
+	qmi_param_append(param, 0x1, sizeof(p), &p);
+
+	/* Get default profile */
+	if (qmi_service_send(ldd->wds, 0x49, param,
+				get_default_profile_cb, lte, NULL) > 0)
+		return;
+
+	qmi_param_free(param);
+
+error:
+	ofono_error("Failed to query default profile");
+	ofono_lte_register(lte);
+}
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
+	qmi_service_create_shared(device, QMI_SERVICE_WDS,
+					create_wds_cb, lte, NULL);
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
+	g_free(ldd);
+}
+
+static struct ofono_lte_driver driver =3D {
+	.name				=3D "qmimodem",
+	.probe				=3D qmimodem_lte_probe,
+	.remove				=3D qmimodem_lte_remove,
+	.set_default_attach_info	=3D qmimodem_lte_set_default_attach_info,
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
index b10ce28c..11e68f2e 100644
--- a/drivers/qmimodem/qmimodem.c
+++ b/drivers/qmimodem/qmimodem.c
@@ -39,6 +39,7 @@ static int qmimodem_init(void)
 	qmi_ussd_init();
 	qmi_gprs_init();
 	qmi_gprs_context_init();
+	qmi_lte_init();
 	qmi_radio_settings_init();
 	qmi_location_reporting_init();
 	qmi_netmon_init();
@@ -51,6 +52,7 @@ static void qmimodem_exit(void)
 	qmi_netmon_exit();
 	qmi_location_reporting_exit();
 	qmi_radio_settings_exit();
+	qmi_lte_exit();
 	qmi_gprs_context_exit();
 	qmi_gprs_exit();
 	qmi_ussd_exit();
diff --git a/drivers/qmimodem/qmimodem.h b/drivers/qmimodem/qmimodem.h
index 4b0fad3f..eeb1375a 100644
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

2.14.1


--===============6744619881247056052==--

