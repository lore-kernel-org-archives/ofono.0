Content-Type: multipart/mixed; boundary="===============2947521690545258158=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH_v2 2/3] cdmamodem: Create network registration atom.
Date: Sat, 23 Jul 2011 06:09:29 +0200
Message-ID: <1311394170-7381-3-git-send-email-bertrand.aygon@intel.com>
In-Reply-To: <1311394170-7381-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2947521690545258158==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                              |    3 +-
 drivers/cdmamodem/cdmamodem.c            |    2 +
 drivers/cdmamodem/cdmamodem.h            |    5 +
 drivers/cdmamodem/network-registration.c |  139 ++++++++++++++++++++++++++=
++++
 4 files changed, 148 insertions(+), 1 deletions(-)
 create mode 100644 drivers/cdmamodem/network-registration.c

diff --git a/Makefile.am b/Makefile.am
index 837d374..e00f73b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -269,7 +269,8 @@ builtin_sources +=3D drivers/cdmamodem/cdmamodem.h \
 			drivers/cdmamodem/cdmamodem.c \
 			drivers/cdmamodem/voicecall.c \
 			drivers/cdmamodem/devinfo.c \
-			drivers/cdmamodem/connman.c
+			drivers/cdmamodem/connman.c \
+			drivers/cdmamodem/network-registration.c
 endif
 =

 builtin_modules +=3D g1
diff --git a/drivers/cdmamodem/cdmamodem.c b/drivers/cdmamodem/cdmamodem.c
index 1b19a4a..60d5315 100644
--- a/drivers/cdmamodem/cdmamodem.c
+++ b/drivers/cdmamodem/cdmamodem.c
@@ -37,6 +37,7 @@ static int cdmamodem_init(void)
 	cdma_voicecall_init();
 	cdma_devinfo_init();
 	cdma_connman_init();
+	cdma_netreg_init();
 =

 	return 0;
 }
@@ -46,6 +47,7 @@ static void cdmamodem_exit(void)
 	cdma_voicecall_exit();
 	cdma_devinfo_exit();
 	cdma_connman_exit();
+	cdma_netreg_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(cdmamodem, "CDMA AT modem driver", VERSION,
diff --git a/drivers/cdmamodem/cdmamodem.h b/drivers/cdmamodem/cdmamodem.h
index 90e2848..df69082 100644
--- a/drivers/cdmamodem/cdmamodem.h
+++ b/drivers/cdmamodem/cdmamodem.h
@@ -23,7 +23,12 @@
 =

 extern void cdma_voicecall_init(void);
 extern void cdma_voicecall_exit(void);
+
 extern void cdma_devinfo_init(void);
 extern void cdma_devinfo_exit(void);
+
 extern void cdma_connman_init(void);
 extern void cdma_connman_exit(void);
+
+extern void cdma_netreg_init(void);
+extern void cdma_netreg_exit(void);
diff --git a/drivers/cdmamodem/network-registration.c b/drivers/cdmamodem/n=
etwork-registration.c
new file mode 100644
index 0000000..7641e66
--- /dev/null
+++ b/drivers/cdmamodem/network-registration.c
@@ -0,0 +1,139 @@
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
+#define _GNU_SOURCE
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/cdma-netreg.h>
+
+#include "gatchat.h"
+#include "gatresult.h"
+
+#include "common.h"
+#include "cdmamodem.h"
+
+static const char *sysinfo_prefix[] =3D { "^SYSINFO:", NULL };
+
+struct netreg_data {
+	GAtChat *chat;
+	unsigned int vendor;
+};
+
+static void sysinfo_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_cdma_netreg *netreg =3D user_data;
+	gint service_state;
+	gint service_domain;
+	gint roaming_state;
+	int status;
+	GAtResultIter iter;
+
+	if (!ok)
+		return;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "^SYSINFO:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &service_state))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &service_domain))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &roaming_state))
+		return;
+
+	switch (service_state) {
+	case 0:
+	case 4:
+		status =3D NETWORK_REGISTRATION_STATUS_NOT_REGISTERED;
+		break;
+	case 2:
+		if (roaming_state)
+			status =3D NETWORK_REGISTRATION_STATUS_ROAMING;
+		else
+			status =3D NETWORK_REGISTRATION_STATUS_REGISTERED;
+		break;
+	default:
+		status =3D NETWORK_REGISTRATION_STATUS_UNKNOWN;
+		break;
+	}
+
+	ofono_cdma_netreg_register(netreg);
+
+	ofono_cdma_netreg_status_notify(netreg, status);
+}
+
+static int cdma_netreg_probe(struct ofono_cdma_netreg *netreg,
+				unsigned int vendor, void *data)
+{
+	GAtChat *chat =3D data;
+	struct netreg_data *nd;
+
+	nd =3D g_new0(struct netreg_data, 1);
+
+	nd->chat =3D g_at_chat_clone(chat);
+	nd->vendor =3D vendor;
+	ofono_cdma_netreg_set_data(netreg, nd);
+
+	g_at_chat_send(nd->chat, "AT^SYSINFO", sysinfo_prefix,
+			sysinfo_cb, netreg, NULL);
+
+	return 0;
+}
+
+static void cdma_netreg_remove(struct ofono_cdma_netreg *netreg)
+{
+	struct netreg_data *nd =3D ofono_cdma_netreg_get_data(netreg);
+
+	ofono_cdma_netreg_set_data(netreg, NULL);
+
+	g_at_chat_unref(nd->chat);
+	g_free(nd);
+}
+
+static struct ofono_cdma_netreg_driver driver =3D {
+	.name				=3D "cdmamodem",
+	.probe				=3D cdma_netreg_probe,
+	.remove				=3D cdma_netreg_remove,
+};
+
+void cdma_netreg_init(void)
+{
+	ofono_cdma_netreg_driver_register(&driver);
+}
+
+void cdma_netreg_exit(void)
+{
+	ofono_cdma_netreg_driver_unregister(&driver);
+}
-- =

1.7.4.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============2947521690545258158==--

