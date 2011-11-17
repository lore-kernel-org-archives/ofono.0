Content-Type: multipart/mixed; boundary="===============3176147082830139967=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2 5/6] cdmamodem: Add CDMA network-registration support
Date: Thu, 17 Nov 2011 17:21:03 +0100
Message-ID: <1321546864-368-6-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1321546864-368-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3176147082830139967==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                              |    6 +-
 drivers/cdmamodem/cdmamodem.c            |    2 +
 drivers/cdmamodem/cdmamodem.h            |    2 +
 drivers/cdmamodem/network-registration.c |  201 ++++++++++++++++++++++++++=
++++
 plugins/huaweicdma.c                     |    5 +-
 5 files changed, 213 insertions(+), 3 deletions(-)
 create mode 100644 drivers/cdmamodem/network-registration.c

diff --git a/Makefile.am b/Makefile.am
index 4c3ca84..6002eb0 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -269,11 +269,13 @@ endif
 =

 if CDMAMODEM
 builtin_modules +=3D cdmamodem
-builtin_sources +=3D drivers/cdmamodem/cdmamodem.h \
+builtin_sources +=3D drivers/atmodem/atutil.h \
+			drivers/cdmamodem/cdmamodem.h \
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
index 50908e3..1548102 100644
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
index 3554705..d496214 100644
--- a/drivers/cdmamodem/cdmamodem.h
+++ b/drivers/cdmamodem/cdmamodem.h
@@ -27,3 +27,5 @@ extern void cdma_devinfo_init(void);
 extern void cdma_devinfo_exit(void);
 extern void cdma_connman_init(void);
 extern void cdma_connman_exit(void);
+extern void cdma_netreg_init(void);
+extern void cdma_netreg_exit(void);
diff --git a/drivers/cdmamodem/network-registration.c b/drivers/cdmamodem/n=
etwork-registration.c
new file mode 100644
index 0000000..a34db91
--- /dev/null
+++ b/drivers/cdmamodem/network-registration.c
@@ -0,0 +1,201 @@
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
+#include <glib.h>
+#include <errno.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/cdma-netreg.h>
+
+#include "gatchat.h"
+
+#include "cdmamodem.h"
+#include <drivers/atmodem/vendor.h>
+
+static const char *sysinfo_prefix[] =3D { "^SYSINFO:", NULL };
+
+static gboolean parse_sysinfo(GAtResult *result, gint *status)
+{
+	GAtResultIter iter;
+	gint srv_status;
+	gint srv_domain;
+	gint roaming_status;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "^SYSINFO:"))
+		return FALSE;
+
+	if (!g_at_result_iter_next_number(&iter, &srv_status))
+		return FALSE;
+
+	if (!g_at_result_iter_next_number(&iter, &srv_domain))
+		return FALSE;
+
+	if (!g_at_result_iter_next_number(&iter, &roaming_status))
+		return FALSE;
+
+	DBG("%d, %d, %d", srv_status, srv_domain, roaming_status);
+
+	switch (srv_status) {
+	case 1:	/* Restricted service */
+	case 2:	/* Service valid */
+	case 3:	/* Restricted region service */
+		if (roaming_status)
+			*status =3D CDMA_NETWORK_REGISTRATION_STATUS_ROAMING;
+		else
+			*status =3D CDMA_NETWORK_REGISTRATION_STATUS_REGISTERED;
+		break;
+	case 0:	/* No service */
+	case 4:	/* Not registered */
+	default:
+		*status =3D CDMA_NETWORK_REGISTRATION_STATUS_NOT_REGISTERED;
+		break;
+	}
+
+	switch (srv_domain) {
+	case 0: /* No service */
+	case 255: /* CDMA not supported */
+		*status =3D CDMA_NETWORK_REGISTRATION_STATUS_NOT_REGISTERED;
+		break;
+	case 1: /* Only CS */
+	case 2: /* Only PS */
+	case 3: /* CS  PS */
+	case 4: /* CS registered, PS in searching state */
+		break;
+	}
+
+	return TRUE;
+}
+
+static void sysinfo_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_cdma_netreg *netreg =3D user_data;
+	int status;
+
+	if (!ok)
+		return;
+
+	if (parse_sysinfo(result, &status) =3D=3D FALSE) {
+		ofono_error("Invalid SYSINFO values");
+		return;
+	}
+
+	ofono_cdma_netreg_status_notify(netreg, status);
+}
+
+static void mode_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_cdma_netreg *netreg =3D user_data;
+	GAtChat *chat =3D ofono_cdma_netreg_get_data(netreg);
+
+	g_at_chat_send(chat, "AT^SYSINFO", sysinfo_prefix,
+				sysinfo_cb, netreg, NULL);
+}
+
+static void rssilvl_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_cdma_netreg *netreg =3D user_data;
+	int strength;
+	GAtResultIter iter;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "^RSSILVL:"))
+		goto error;
+
+	if (!g_at_result_iter_next_number(&iter, &strength))
+		goto error;
+
+	if (strength =3D=3D 99)
+		strength =3D 100;
+
+	ofono_cdma_netreg_strength_notify(netreg, strength);
+
+	return;
+
+error:
+	ofono_error("Invalid RSSILVL value");
+}
+
+static void probe_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_cdma_netreg *netreg =3D user_data;
+	GAtChat *chat =3D ofono_cdma_netreg_get_data(netreg);
+
+	if (!ok) {
+		ofono_cdma_netreg_remove(netreg);
+		return;
+	}
+
+	g_at_chat_register(chat, "^MODE:",
+				mode_notify, FALSE, netreg, NULL);
+
+	g_at_chat_register(chat, "^RSSILVL:",
+				rssilvl_notify, FALSE, netreg, NULL);
+
+	ofono_cdma_netreg_register(netreg);
+}
+
+static int cdma_netreg_probe(struct ofono_cdma_netreg *netreg,
+				unsigned int vendor, void *data)
+{
+	GAtChat *chat =3D g_at_chat_clone(data);
+
+	ofono_cdma_netreg_set_data(netreg, chat);
+
+	if (vendor =3D=3D OFONO_VENDOR_HUAWEI)
+		g_at_chat_send(chat, "AT^SYSINFO", sysinfo_prefix,
+				probe_cb, netreg, NULL);
+
+	return 0;
+}
+
+static void cdma_netreg_remove(struct ofono_cdma_netreg *netreg)
+{
+	GAtChat *chat =3D ofono_cdma_netreg_get_data(netreg);
+
+	ofono_cdma_netreg_set_data(netreg, NULL);
+
+	g_at_chat_unref(chat);
+}
+
+static struct ofono_cdma_netreg_driver driver =3D {
+	.name	=3D "cdmamodem",
+	.probe	=3D cdma_netreg_probe,
+	.remove	=3D cdma_netreg_remove,
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
diff --git a/plugins/huaweicdma.c b/plugins/huaweicdma.c
index 4c83114..5618417 100644
--- a/plugins/huaweicdma.c
+++ b/plugins/huaweicdma.c
@@ -38,6 +38,8 @@
 #include <ofono/cdma-connman.h>
 #include <ofono/log.h>
 =

+#include <drivers/atmodem/vendor.h>
+
 struct huaweicdma_data {
 	GAtChat *modem;
 	GAtChat *pcui;
@@ -211,7 +213,8 @@ static void huaweicdma_post_online(struct ofono_modem *=
modem)
 =

 	DBG("%p", modem);
 =

-	ofono_cdma_netreg_create(modem, 0, "huaweicdmamodem", data->modem);
+	ofono_cdma_netreg_create(modem, OFONO_VENDOR_HUAWEI, "cdmamodem",
+					data->modem);
 =

 	ofono_cdma_connman_create(modem, 0, "cdmamodem", data->modem);
 }
-- =

1.7.1


--===============3176147082830139967==--

