Content-Type: multipart/mixed; boundary="===============4265048513211550562=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 7/9] infineon: Plugin for infineon modems
Date: Tue, 13 Oct 2015 18:07:56 +0200
Message-ID: <1444752478-18198-8-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1444752478-18198-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4265048513211550562==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Plugin for infineon modems, which is a variant of the ril modem.
---
 plugins/infineon.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 77 insertions(+)
 create mode 100644 plugins/infineon.c

diff --git a/plugins/infineon.c b/plugins/infineon.c
new file mode 100644
index 0000000..a90aacc
--- /dev/null
+++ b/plugins/infineon.c
@@ -0,0 +1,77 @@
+/*
+ *
+ *  oFono - Open Source Telephony - RIL-based devices: infineon modems
+ *
+ *  Copyright (C) 2014  Canonical Ltd.
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
+#define OFONO_API_SUBJECT_TO_CHANGE
+
+#include <ofono/plugin.h>
+#include <ofono/log.h>
+#include <ofono/modem.h>
+
+#include "ofono.h"
+
+#include "drivers/rilmodem/vendor.h"
+#include "ril.h"
+
+static int inf_probe(struct ofono_modem *modem)
+{
+	return ril_create(modem, OFONO_RIL_VENDOR_INFINEON);
+}
+
+static struct ofono_modem_driver infineon_driver =3D {
+	.name =3D "infineon",
+	.probe =3D inf_probe,
+	.remove =3D ril_remove,
+	.enable =3D ril_enable,
+	.disable =3D ril_disable,
+	.pre_sim =3D ril_pre_sim,
+	.post_sim =3D ril_post_sim,
+	.post_online =3D ril_post_online,
+	.set_online =3D ril_set_online,
+};
+
+/*
+ * This plugin is a device plugin for infineon modems that use RIL interfa=
ce.
+ * The plugin 'rildev' is used to determine which RIL plugin should be loa=
ded
+ * based upon an environment variable.
+ */
+static int inf_init(void)
+{
+	int retval =3D 0;
+
+	retval =3D ofono_modem_driver_register(&infineon_driver);
+	if (retval !=3D 0)
+		DBG("ofono_modem_driver_register returned: %d", retval);
+
+	return retval;
+}
+
+static void inf_exit(void)
+{
+	DBG("");
+	ofono_modem_driver_unregister(&infineon_driver);
+}
+
+OFONO_PLUGIN_DEFINE(infineon, "Infineon modem driver", VERSION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT, inf_init, inf_exit)
-- =

2.1.4


--===============4265048513211550562==--

