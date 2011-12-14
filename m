Content-Type: multipart/mixed; boundary="===============8953003670127680358=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v3 04/10] cdma-provision: Add cdma provisioning plugin
Date: Wed, 14 Dec 2011 18:56:06 +0100
Message-ID: <1323885372-3574-5-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1323885372-3574-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8953003670127680358==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/cdma-provision.c |   79 ++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 79 insertions(+), 0 deletions(-)
 create mode 100644 plugins/cdma-provision.c

diff --git a/plugins/cdma-provision.c b/plugins/cdma-provision.c
new file mode 100644
index 0000000..1ac7be7
--- /dev/null
+++ b/plugins/cdma-provision.c
@@ -0,0 +1,79 @@
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
+#include <errno.h>
+#include <string.h>
+
+#include <glib.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/types.h>
+#include <ofono/log.h>
+#include <ofono/plugin.h>
+#include <ofono/modem.h>
+#include <ofono/gprs-provision.h>
+#include <ofono/cdma-provision.h>
+
+#include "mbpi.h"
+
+static int cdma_provision_get_provider_name(const char *sid, char **name)
+{
+	GError *error =3D NULL;
+
+	DBG("Search provider name for SID %s", sid);
+
+	*name =3D mbpi_lookup_cdma_provider_name(sid, &error);
+	if (*name =3D=3D NULL) {
+		if (error !=3D NULL) {
+			ofono_error("%s", error->message);
+			g_error_free(error);
+		}
+
+		return -ENOENT;
+	}
+
+	DBG("Found provider name: %s", *name);
+
+	return 0;
+}
+
+static struct ofono_cdma_provision_driver provision_driver =3D {
+	.name =3D "CDMA provisioning",
+	.get_provider_name =3D cdma_provision_get_provider_name
+};
+
+static int cdma_provision_init(void)
+{
+	return ofono_cdma_provision_driver_register(&provision_driver);
+}
+
+static void cdma_provision_exit(void)
+{
+	ofono_cdma_provision_driver_unregister(&provision_driver);
+}
+
+OFONO_PLUGIN_DEFINE(cdma_provision, "CDMA provisioning Plugin", VERSION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT,
+			cdma_provision_init, cdma_provision_exit)
-- =

1.7.1


--===============8953003670127680358==--

