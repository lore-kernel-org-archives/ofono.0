Content-Type: multipart/mixed; boundary="===============7064847251278631483=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv8 5/6] plugins: Add provisioning plugin
Date: Fri, 30 Sep 2011 16:31:13 +0300
Message-ID: <1317389474-16566-6-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1317389474-16566-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7064847251278631483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/provision.c |  125 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 125 insertions(+), 0 deletions(-)
 create mode 100644 plugins/provision.c

diff --git a/plugins/provision.c b/plugins/provision.c
new file mode 100644
index 0000000..e00bab5
--- /dev/null
+++ b/plugins/provision.c
@@ -0,0 +1,125 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <sys/stat.h>
+#include <sys/mman.h>
+
+#include <errno.h>
+#include <fcntl.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <glib.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/types.h>
+#include <ofono/log.h>
+#include <ofono/plugin.h>
+#include <ofono/modem.h>
+#include <ofono/gprs-provision.h>
+
+#include "mbpi.h"
+
+static int provision_get_settings(const char *mcc, const char *mnc,
+				const char *spn,
+				struct ofono_gprs_provision_data **settings,
+				int *count)
+{
+	GSList *l;
+	GSList *apns;
+	GError *error =3D NULL;
+	int ap_count;
+	int i;
+
+	DBG("Provisioning for MCC %s, MNC %s, SPN '%s'", mcc, mnc, spn);
+
+	apns =3D mbpi_lookup(mcc, mnc, FALSE, &error);
+	if (apns =3D=3D NULL) {
+		if (error !=3D NULL) {
+			ofono_error("%s", error->message);
+			g_error_free(error);
+		}
+
+		return -ENOENT;
+	}
+
+	ap_count =3D g_slist_length(apns);
+
+	DBG("Found %d APs", ap_count);
+
+	*settings =3D g_try_malloc_n(ap_count,
+				sizeof(struct ofono_gprs_provision_data));
+	if (*settings =3D=3D NULL) {
+		ofono_error("Provisioning failed: %s", g_strerror(errno));
+
+		for (l =3D apns; l; l =3D l->next)
+			mbpi_ap_free(l->data);
+
+		g_slist_free(apns);
+
+		return -ENOMEM;
+	}
+
+	*count =3D ap_count;
+
+	for (l =3D apns, i =3D 0; l; l =3D l->next, i++) {
+		struct ofono_gprs_provision_data *ap =3D l->data;
+
+		DBG("Name: '%s'", ap->name);
+		DBG("APN: '%s'", ap->apn);
+		DBG("Type: %s", mbpi_ap_type(ap->type));
+		DBG("Username: '%s'", ap->username);
+		DBG("Password: '%s'", ap->password);
+
+		*(*settings + i) =3D *ap;
+
+		memset(*settings + i, 0,
+			sizeof(struct ofono_gprs_provision_data));
+		mbpi_ap_free(ap);
+	}
+
+	g_slist_free(apns);
+
+	return 0;
+}
+
+static struct ofono_gprs_provision_driver provision_driver =3D {
+	.name		=3D "Provisioning",
+	.get_settings	=3D provision_get_settings
+};
+
+static int provision_init(void)
+{
+	return ofono_gprs_provision_driver_register(&provision_driver);
+}
+
+static void provision_exit(void)
+{
+	ofono_gprs_provision_driver_unregister(&provision_driver);
+}
+
+OFONO_PLUGIN_DEFINE(provision, "Provisioning Plugin", VERSION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT,
+			provision_init, provision_exit)
-- =

1.7.4.1


--===============7064847251278631483==--

