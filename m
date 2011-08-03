Content-Type: multipart/mixed; boundary="===============6018345839734612864=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH_v5 7/8] huaweicdmamodem: create a huawei cdma driver.
Date: Wed, 03 Aug 2011 15:50:51 +0200
Message-ID: <1312379452-821-8-git-send-email-bertrand.aygon@intel.com>
In-Reply-To: <1312379452-821-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6018345839734612864==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                                    |    6 +
 drivers/huaweicdmamodem/huaweicdmamodem.c      |   45 +++++++
 drivers/huaweicdmamodem/huaweicdmamodem.h      |   23 ++++
 drivers/huaweicdmamodem/network-registration.c |  159 ++++++++++++++++++++=
++++
 4 files changed, 233 insertions(+), 0 deletions(-)
 create mode 100644 drivers/huaweicdmamodem/huaweicdmamodem.c
 create mode 100644 drivers/huaweicdmamodem/huaweicdmamodem.h
 create mode 100644 drivers/huaweicdmamodem/network-registration.c

diff --git a/Makefile.am b/Makefile.am
index 56c1d6a..afa5e6f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -276,6 +276,12 @@ builtin_sources +=3D drivers/cdmamodem/cdmamodem.h \
 			drivers/cdmamodem/voicecall.c \
 			drivers/cdmamodem/devinfo.c \
 			drivers/cdmamodem/connman.c
+
+builtin_modules +=3D huaweicdmamodem
+builtin_sources +=3D drivers/huaweicdmamodem/huaweicdmamodem.h \
+			drivers/huaweicdmamodem/huaweicdmamodem.c \
+			drivers/huaweicdmamodem/network-registration.c
+
 endif
 =

 builtin_modules +=3D g1
diff --git a/drivers/huaweicdmamodem/huaweicdmamodem.c b/drivers/huaweicdma=
modem/huaweicdmamodem.c
new file mode 100644
index 0000000..4e9c400
--- /dev/null
+++ b/drivers/huaweicdmamodem/huaweicdmamodem.c
@@ -0,0 +1,45 @@
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
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+
+#include "huaweicdmamodem.h"
+
+static int huaweicdmamodem_init(void)
+{
+	huaweicdma_netreg_init();
+
+	return 0;
+}
+
+static void huaweicdmamodem_exit(void)
+{
+	huaweicdma_netreg_exit();
+}
+
+OFONO_PLUGIN_DEFINE(huaweicdmamodem, "Huawei CDMA modem driver", VERSION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT,
+			huaweicdmamodem_init, huaweicdmamodem_exit)
diff --git a/drivers/huaweicdmamodem/huaweicdmamodem.h b/drivers/huaweicdma=
modem/huaweicdmamodem.h
new file mode 100644
index 0000000..799d3a8
--- /dev/null
+++ b/drivers/huaweicdmamodem/huaweicdmamodem.h
@@ -0,0 +1,23 @@
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
+extern void huaweicdma_netreg_init(void);
+extern void huaweicdma_netreg_exit(void);
diff --git a/drivers/huaweicdmamodem/network-registration.c b/drivers/huawe=
icdmamodem/network-registration.c
new file mode 100644
index 0000000..e4c5c41
--- /dev/null
+++ b/drivers/huaweicdmamodem/network-registration.c
@@ -0,0 +1,159 @@
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
+struct huaweicdma_netreg_data {
+	GAtChat *chat;
+};
+
+static void sysinfo_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_cdma_netreg *netreg =3D user_data;
+	gint srv_status;
+	gint srv_domain;
+	gint roaming_status;
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
+	if (!g_at_result_iter_next_number(&iter, &srv_status))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &srv_domain))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &roaming_status))
+		return;
+
+	DBG("%d, %d, %d", srv_status, srv_domain, roaming_status);
+
+	switch (srv_status) {
+	case 1:	/* Restricted service */
+	case 2:	/* Service valid */
+	case 3:	/* Restricted region service */
+		status =3D CDMA_NETWORK_REGISTRATION_STATUS_REGISTERED;
+		break;
+	case 0:	/* No service */
+	case 4:	/* Not registered */
+	default:
+		status =3D CDMA_NETWORK_REGISTRATION_STATUS_NOT_REGISTERED;
+		break;
+	}
+
+	switch (srv_domain) {
+	case 0: /* No service */
+	case 255: /* CDMA not supported */
+		status =3D CDMA_NETWORK_REGISTRATION_STATUS_NOT_REGISTERED;
+		break;
+	case 1: /* Only CS */
+	case 2: /* Only PS */
+	case 3: /* CS + PS */
+	case 4: /* CS registered, PS in searching state */
+		break;
+	}
+	=

+	if (status =3D=3D CDMA_NETWORK_REGISTRATION_STATUS_REGISTERED
+				&& roaming_status)
+		status =3D CDMA_NETWORK_REGISTRATION_STATUS_ROAMING;
+
+	ofono_cdma_netreg_status_notify(netreg, status);
+}
+
+
+static void mode_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_cdma_netreg *netreg =3D user_data;
+	struct huaweicdma_netreg_data *nd =3D ofono_cdma_netreg_get_data(netreg);
+
+	g_at_chat_send(nd->chat, "AT^SYSINFO", sysinfo_prefix, sysinfo_cb,
+				netreg, NULL);
+}
+
+static int huaweicdma_netreg_probe(struct ofono_cdma_netreg *netreg,
+				unsigned int vendor, void *data)
+{
+	GAtChat *chat =3D data;
+	struct huaweicdma_netreg_data *nd;
+
+	nd =3D g_try_new0(struct huaweicdma_netreg_data, 1);
+
+	nd->chat =3D g_at_chat_clone(chat);
+	ofono_cdma_netreg_set_data(netreg, nd);
+
+	g_at_chat_register(nd->chat, "^MODE:",
+				mode_notify, FALSE, netreg, NULL);
+
+	ofono_cdma_netreg_register(netreg);
+
+	g_at_chat_send(nd->chat, "AT^SYSINFO", sysinfo_prefix, sysinfo_cb,
+				netreg, NULL);
+
+	return 0;
+}
+
+static void huaweicdma_netreg_remove(struct ofono_cdma_netreg *netreg)
+{
+	struct huaweicdma_netreg_data *nd =3D ofono_cdma_netreg_get_data(netreg);
+
+	ofono_cdma_netreg_set_data(netreg, NULL);
+
+	g_at_chat_unref(nd->chat);
+	g_free(nd);
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

--===============6018345839734612864==--

