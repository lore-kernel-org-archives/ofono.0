Content-Type: multipart/mixed; boundary="===============3833715707511489731=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH qmi lte v4 5/6] qmi: add LTE atom driver
Date: Tue, 18 Apr 2017 09:50:51 +0200
Message-ID: <20170418075052.23980-5-jonas@southpole.se>
In-Reply-To: <20170418075052.23980-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3833715707511489731==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds the boilerplate for an LTE atom for QMI modems.

This atom is supposed to set the APN that the default bearer uses
to connect to the network.  The part that is missing currently is
actually writing the APN into the modem's default profile.

In many cases, however, the network does not actually require a
correct APN in order to connect to the network so it's moot whether
or not this atom actually completes its task!  For now, thus, this
atom just emits a warning so that this can be fully implemented
when there's a network that cares about the APN to test against.

For completeness, what is supposed to happen is that this atom
is supposed to call "Modify Profile" on the "default" profile,
setting the APN.  The default profile should probably be queried
because it can be set to something other than profile number one (1).
Once configured, the default profile settings are used when the
modem connects to the network; for this reason, the LTE atom needs
to be instantiated in post_sim, before the modem is set online.
---
 Makefile.am                 |   1 +
 drivers/qmimodem/lte.c      | 143 ++++++++++++++++++++++++++++++++++++++++=
++++
 drivers/qmimodem/qmimodem.c |   2 +
 drivers/qmimodem/qmimodem.h |   3 +
 4 files changed, 149 insertions(+)
 create mode 100644 drivers/qmimodem/lte.c

diff --git a/Makefile.am b/Makefile.am
index c894496..60c205a 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -232,6 +232,7 @@ builtin_sources +=3D $(qmi_sources) \
 			drivers/qmimodem/ussd.c \
 			drivers/qmimodem/gprs.c \
 			drivers/qmimodem/gprs-context.c \
+			drivers/qmimodem/lte.c \
 			drivers/qmimodem/radio-settings.c \
 			drivers/qmimodem/location-reporting.c
 =

diff --git a/drivers/qmimodem/lte.c b/drivers/qmimodem/lte.c
new file mode 100644
index 0000000..e131b47
--- /dev/null
+++ b/drivers/qmimodem/lte.c
@@ -0,0 +1,143 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2017  Jonas Bonn. All rights reserved.
+ *  Copyright (C) 2017  South Pole Consulting AB. All rights reserved.
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
+static void qmimodem_lte_set_default_attach_info(const struct ofono_lte *l=
te,
+			const struct ofono_lte_default_attach_info *info,
+			ofono_lte_cb_t cb, void *data)
+{
+	struct lte_data *ldd =3D ofono_lte_get_data(lte);
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
+	/*
+	 * FIXME: The above is not sufficient.  The APN needs to be set
+	 * to the 'default' profile so that the modem uses it when
+	 * connecting the default bearer.
+	 */
+	ofono_warn("LTE APN needs to be written to default profile");
+
+	CALLBACK_WITH_SUCCESS(cb, data);
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
+	qmi_service_create(device, QMI_SERVICE_WDS,
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


--===============3833715707511489731==--

