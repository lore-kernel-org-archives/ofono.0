Content-Type: multipart/mixed; boundary="===============1895234833337668719=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v9 1/4] huaweicdma: create a dedicated netreg atom.
Date: Mon, 08 Aug 2011 14:13:17 +0200
Message-ID: <1312805600-20043-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1312805600-20043-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1895234833337668719==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Bertrand Aygon <bertrand.aygon@intel.com>

---
 Makefile.am                                    |    3 +-
 drivers/huaweicdmamodem/huaweicdmamodem.c      |    3 +
 drivers/huaweicdmamodem/huaweicdmamodem.h      |    3 +
 drivers/huaweicdmamodem/network-registration.c |  171 ++++++++++++++++++++=
++++
 4 files changed, 179 insertions(+), 1 deletions(-)
 create mode 100644 drivers/huaweicdmamodem/network-registration.c

diff --git a/Makefile.am b/Makefile.am
index 62174db..e11f627 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -283,7 +283,8 @@ builtin_sources +=3D drivers/cdmamodem/cdmamodem.h \
 =

 builtin_modules +=3D huaweicdmamodem
 builtin_sources +=3D drivers/huaweicdmamodem/huaweicdmamodem.h \
-			drivers/huaweicdmamodem/huaweicdmamodem.c
+			drivers/huaweicdmamodem/huaweicdmamodem.c \
+			drivers/huaweicdmamodem/network-registration.c
 =

 endif
 =

diff --git a/drivers/huaweicdmamodem/huaweicdmamodem.c b/drivers/huaweicdma=
modem/huaweicdmamodem.c
index d9e7943..4e9c400 100644
--- a/drivers/huaweicdmamodem/huaweicdmamodem.c
+++ b/drivers/huaweicdmamodem/huaweicdmamodem.c
@@ -30,11 +30,14 @@
 =

 static int huaweicdmamodem_init(void)
 {
+	huaweicdma_netreg_init();
+
 	return 0;
 }
 =

 static void huaweicdmamodem_exit(void)
 {
+	huaweicdma_netreg_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(huaweicdmamodem, "Huawei CDMA modem driver", VERSION,
diff --git a/drivers/huaweicdmamodem/huaweicdmamodem.h b/drivers/huaweicdma=
modem/huaweicdmamodem.h
index d11ddd9..799d3a8 100644
--- a/drivers/huaweicdmamodem/huaweicdmamodem.h
+++ b/drivers/huaweicdmamodem/huaweicdmamodem.h
@@ -18,3 +18,6 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
  *
  */
+
+extern void huaweicdma_netreg_init(void);
+extern void huaweicdma_netreg_exit(void);
diff --git a/drivers/huaweicdmamodem/network-registration.c b/drivers/huawe=
icdmamodem/network-registration.c
new file mode 100644
index 0000000..e430c41
--- /dev/null
+++ b/drivers/huaweicdmamodem/network-registration.c
@@ -0,0 +1,171 @@
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
+#include "huaweicdmamodem.h"
+
+static const char *sysinfo_prefix[] =3D { "^SYSINFO:", NULL };
+
+static int parse_sysinfo(GAtResult *result, gint *status)
+{
+	GAtResultIter iter;
+	gint srv_status;
+	gint srv_domain;
+	gint roaming_status;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "^SYSINFO:"))
+		return -1;
+
+	if (!g_at_result_iter_next_number(&iter, &srv_status))
+		return -1;
+
+	if (!g_at_result_iter_next_number(&iter, &srv_domain))
+		return -1;
+
+	if (!g_at_result_iter_next_number(&iter, &roaming_status))
+		return -1;
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
+	return 0;
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
+	status =3D CDMA_NETWORK_REGISTRATION_STATUS_NOT_REGISTERED;
+
+	if (parse_sysinfo(result, &status) < 0)
+		ofono_error("Invalid SYSINFO values");
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
+	ofono_cdma_netreg_register(netreg);
+}
+
+static int huaweicdma_netreg_probe(struct ofono_cdma_netreg *netreg,
+				unsigned int vendor, void *data)
+{
+	GAtChat *chat =3D g_at_chat_clone(data);
+
+	ofono_cdma_netreg_set_data(netreg, chat);
+
+	g_at_chat_send(chat, "AT^SYSINFO", sysinfo_prefix,
+				probe_cb, netreg, NULL);
+
+	return 0;
+}
+
+static void huaweicdma_netreg_remove(struct ofono_cdma_netreg *netreg)
+{
+	GAtChat *chat =3D ofono_cdma_netreg_get_data(netreg);
+
+	ofono_cdma_netreg_set_data(netreg, NULL);
+
+	g_at_chat_unref(chat);
+}
+
+static struct ofono_cdma_netreg_driver driver =3D {
+	.name	=3D "huaweicdmamodem",
+	.probe	=3D huaweicdma_netreg_probe,
+	.remove	=3D huaweicdma_netreg_remove,
+};
+
+void huaweicdma_netreg_init(void)
+{
+	ofono_cdma_netreg_driver_register(&driver);
+}
+
+void huaweicdma_netreg_exit(void)
+{
+	ofono_cdma_netreg_driver_unregister(&driver);
+}
-- =

1.7.1


--===============1895234833337668719==--

