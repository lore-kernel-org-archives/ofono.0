Content-Type: multipart/mixed; boundary="===============4410423529475391808=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 1/4] qmi: add LTE atom driver
Date: Thu, 01 Mar 2018 11:48:01 +0100
Message-ID: <20180301104804.24058-2-jonas@southpole.se>
In-Reply-To: <20180301104804.24058-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4410423529475391808==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds an LTE atom for QMI modems.

This atom sets the APN that the LTE default bearer should use when
establishing its PDP context.  For the Quectel EC21 that I'm testing
with, this is effected by setting the APN on profile ID 1 from which the
default settings appear to be taken.  As I don't have any other QMI
modem to test with, I can not say for sure that all modems work in this
manner.

Once configured, the default profile settings are used when the
modem connects to the network; for this reason, the LTE atom needs
to be instantiated in post_sim, before the modem is set online.
---
 Makefile.am            |   1 +
 drivers/qmimodem/lte.c | 182 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 183 insertions(+)
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
index 00000000..f410c608
--- /dev/null
+++ b/drivers/qmimodem/lte.c
@@ -0,0 +1,182 @@
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
+	char* apn;
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
+		.index =3D 1,
+	};
+
+	DBG("LTE config with APN: %s", info->apn);
+
+	g_free(ldd->apn);
+
+	if (strlen(info->apn) > 0)
+		ldd->apn =3D g_strdup(info->apn);
+	else
+		ldd->apn =3D NULL;
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

+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void create_wds_cb(struct qmi_service *service, void *user_data)
+{
+	struct ofono_lte *lte =3D user_data;
+	struct lte_data *data =3D ofono_lte_get_data(lte);
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
+	g_free(ldd->apn);
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
-- =

2.14.1


--===============4410423529475391808==--

