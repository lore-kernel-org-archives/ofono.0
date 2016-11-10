Content-Type: multipart/mixed; boundary="===============4958496458566852728=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH 7/9] ubloxmodem: add lte atom driver
Date: Thu, 10 Nov 2016 17:55:54 +0100
Message-ID: <1478796956-22500-8-git-send-email-dragos@endocode.com>
In-Reply-To: <1478796956-22500-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4958496458566852728==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Adds U-Blox Toby L2 driver for setting the default APN via the
+UCGDFLT command. Currently only IPv4 is supported. APN is
not stored to modem's non-volatile memory. oFono will manage this
default APN via it's config storage.

When receiving an empty default APN, the value is reset.
---
 drivers/ubloxmodem/lte.c        | 154 ++++++++++++++++++++++++++++++++++++=
++++
 drivers/ubloxmodem/ubloxmodem.c |   3 +
 drivers/ubloxmodem/ubloxmodem.h |   5 ++
 3 files changed, 162 insertions(+)
 create mode 100644 drivers/ubloxmodem/lte.c

diff --git a/drivers/ubloxmodem/lte.c b/drivers/ubloxmodem/lte.c
new file mode 100644
index 0000000..43c02d4
--- /dev/null
+++ b/drivers/ubloxmodem/lte.c
@@ -0,0 +1,154 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2016  Endocode AG. All rights reserved.
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
+#include "gatchat.h"
+#include "gatresult.h"
+
+#include "ubloxmodem.h"
+
+static const char *ucgdflt_prefix[] =3D { "+UCGDFLT:", NULL };
+
+struct lte_driver_data {
+	GAtChat *chat;
+};
+
+static void ucgdflt_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_lte_cb_t cb =3D cbd->cb;
+
+	DBG("ok %d", ok);
+
+	if (!ok) {
+		struct ofono_error error;
+
+		decode_at_error(&error, g_at_result_final_response(result));
+		cb(&error, cbd->data);
+	} else {
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	}
+
+	g_free(cbd);
+
+	return;
+}
+
+static int ublox_lte_set_default_attach_info(const struct ofono_lte *lte,
+				struct ofono_lte_default_attach_info *info,
+				ofono_lte_cb_t cb, void *data)
+{
+	struct lte_driver_data *ldd =3D ofono_lte_get_data(lte);
+	char buf[32 + OFONO_GPRS_MAX_APN_LENGTH + 1];
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	DBG("LTE config with APN: %s", info->apn);
+
+	if (strlen(info->apn) > 0)
+		snprintf(buf, sizeof(buf), "AT+UCGDFLT=3D0,\"IP\",\"%s\"",
+				info->apn);
+	else
+		snprintf(buf, sizeof(buf), "AT+UCGDFLT=3D0");
+
+	/* We can't do much in case of failure so don't check response. */
+	if (g_at_chat_send(ldd->chat, buf, ucgdflt_prefix,
+				ucgdflt_cb, cbd, NULL) =3D=3D 0) {
+		g_free(cbd);
+		CALLBACK_WITH_FAILURE(cb, data);
+	}
+
+	return 0;
+}
+
+static gboolean lte_delayed_register(gpointer user_data)
+{
+	struct ofono_lte *lte =3D user_data;
+
+	ofono_lte_register(lte);
+
+	return FALSE;
+}
+
+static int ublox_lte_probe(struct ofono_lte *lte, void *data)
+{
+	GAtChat *chat =3D data;
+	struct lte_driver_data *ldd;
+
+	DBG("ublox lte probe");
+
+	ldd =3D g_try_new0(struct lte_driver_data, 1);
+	if (!ldd) {
+		return -ENOMEM;
+	}
+
+	ldd->chat =3D g_at_chat_clone(chat);
+
+	ofono_lte_set_data(lte, ldd);
+
+	g_idle_add(lte_delayed_register, lte);
+
+	return 0;
+}
+
+static void ublox_lte_remove(struct ofono_lte *lte)
+{
+	struct lte_driver_data *ldd =3D ofono_lte_get_data(lte);
+
+	DBG("ublox lte remove");
+
+	g_at_chat_unref(ldd->chat);
+
+	ofono_lte_set_data(lte, NULL);
+
+	g_free(ldd);
+}
+
+static struct ofono_lte_driver driver =3D {
+	.name				=3D UBLOXMODEM,
+	.probe				=3D ublox_lte_probe,
+	.remove				=3D ublox_lte_remove,
+	.set_default_attach_info	=3D ublox_lte_set_default_attach_info,
+};
+
+void ublox_lte_init(void)
+{
+	ofono_lte_driver_register(&driver);
+}
+
+void ublox_lte_exit(void)
+{
+	ofono_lte_driver_unregister(&driver);
+}
diff --git a/drivers/ubloxmodem/ubloxmodem.c b/drivers/ubloxmodem/ubloxmode=
m.c
index 7fc671e..93cb928 100644
--- a/drivers/ubloxmodem/ubloxmodem.c
+++ b/drivers/ubloxmodem/ubloxmodem.c
@@ -29,12 +29,14 @@
 #define OFONO_API_SUBJECT_TO_CHANGE
 #include <ofono/plugin.h>
 #include <ofono/types.h>
+#include <ofono/modem.h>
 =

 #include "ubloxmodem.h"
 =

 static int ubloxmodem_init(void)
 {
 	ublox_gprs_context_init();
+	ublox_lte_init();
 =

 	return 0;
 }
@@ -42,6 +44,7 @@ static int ubloxmodem_init(void)
 static void ubloxmodem_exit(void)
 {
 	ublox_gprs_context_exit();
+	ublox_lte_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(ubloxmodem, "U-Blox Toby L2 high speed modem driver",
diff --git a/drivers/ubloxmodem/ubloxmodem.h b/drivers/ubloxmodem/ubloxmode=
m.h
index 0c8a621..cf66412 100644
--- a/drivers/ubloxmodem/ubloxmodem.h
+++ b/drivers/ubloxmodem/ubloxmodem.h
@@ -21,5 +21,10 @@
 =

 #include <drivers/atmodem/atutil.h>
 =

+#define UBLOXMODEM "ubloxmodem"
+
 extern void ublox_gprs_context_init(void);
 extern void ublox_gprs_context_exit(void);
+
+extern void ublox_lte_init(void);
+extern void ublox_lte_exit(void);
-- =

2.7.4


--===============4958496458566852728==--

