Content-Type: multipart/mixed; boundary="===============8779398294131611154=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2 04/12] providers: Add cdma provider name plugin
Date: Thu, 08 Dec 2011 15:49:55 +0100
Message-ID: <1323355803-22096-5-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1323355803-22096-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8779398294131611154==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/providers.c |   79 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 79 insertions(+), 0 deletions(-)
 create mode 100644 plugins/providers.c

diff --git a/plugins/providers.c b/plugins/providers.c
new file mode 100644
index 0000000..f267db9
--- /dev/null
+++ b/plugins/providers.c
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
+#include <ofono/cdma-providers.h>
+
+#include "mbpi.h"
+
+static int providers_get_name(const char *sid, char **name)
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
+static struct ofono_cdma_providers_driver providers_driver =3D {
+	.name =3D "Mobile providers",
+	.get_provider_name =3D providers_get_name
+};
+
+static int providers_init(void)
+{
+	return ofono_cdma_providers_driver_register(&providers_driver);
+}
+
+static void providers_exit(void)
+{
+	ofono_cdma_providers_driver_unregister(&providers_driver);
+}
+
+OFONO_PLUGIN_DEFINE(providers, "Mobile providers Plugin", VERSION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT,
+			providers_init, providers_exit)
-- =

1.7.1


--===============8779398294131611154==--

