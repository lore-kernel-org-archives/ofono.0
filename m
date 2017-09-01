Content-Type: multipart/mixed; boundary="===============4271698433449448863=="
MIME-Version: 1.0
From: Ankit Navik <ankit.p.navik@intel.com>
Subject: [PATCH 1/6] atmodem: Add lte atom driver
Date: Fri, 01 Sep 2017 11:23:00 +0530
Message-ID: <1504245182-17949-1-git-send-email-ankit.p.navik@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4271698433449448863==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Adds atmodem driver for setting the default APN command.
The default APN is manage by config storage.
---
 Makefile.am               |   3 +-
 drivers/atmodem/atmodem.c |   2 +
 drivers/atmodem/atmodem.h |   3 +
 drivers/atmodem/lte.c     | 142 ++++++++++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 149 insertions(+), 1 deletion(-)
 create mode 100644 drivers/atmodem/lte.c

diff --git a/Makefile.am b/Makefile.am
index 078e3f1..18a806b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -264,7 +264,8 @@ builtin_sources +=3D 	drivers/atmodem/atmodem.h \
 			drivers/atmodem/gprs.c \
 			drivers/atmodem/gprs-context.c \
 			drivers/atmodem/sim-auth.c \
-			drivers/atmodem/gnss.c
+			drivers/atmodem/gnss.c \
+			drivers/atmodem/lte.c
 =

 builtin_modules +=3D nwmodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
diff --git a/drivers/atmodem/atmodem.c b/drivers/atmodem/atmodem.c
index 3a55ac2..684b228 100644
--- a/drivers/atmodem/atmodem.c
+++ b/drivers/atmodem/atmodem.c
@@ -52,6 +52,7 @@ static int atmodem_init(void)
 	at_gprs_context_init();
 	at_sim_auth_init();
 	at_gnss_init();
+	at_lte_init();
 =

 	return 0;
 }
@@ -76,6 +77,7 @@ static void atmodem_exit(void)
 	at_gprs_exit();
 	at_gprs_context_exit();
 	at_gnss_exit();
+	at_lte_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(atmodem, "AT modem driver", VERSION,
diff --git a/drivers/atmodem/atmodem.h b/drivers/atmodem/atmodem.h
index 6be1fe5..b737066 100644
--- a/drivers/atmodem/atmodem.h
+++ b/drivers/atmodem/atmodem.h
@@ -74,3 +74,6 @@ extern void at_sim_auth_exit(void);
 =

 extern void at_gnss_init(void);
 extern void at_gnss_exit(void);
+
+extern void at_lte_init(void);
+extern void at_lte_exit(void);
diff --git a/drivers/atmodem/lte.c b/drivers/atmodem/lte.c
new file mode 100644
index 0000000..61a4cd2
--- /dev/null
+++ b/drivers/atmodem/lte.c
@@ -0,0 +1,142 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2017  Intel Corporation. All rights reserved.
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
+#include "atmodem.h"
+
+struct lte_driver_data {
+	GAtChat *chat;
+};
+
+static void at_lte_set_default_attach_info_cb(gboolean ok, GAtResult *resu=
lt,
+							gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_lte_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	DBG("ok %d", ok);
+
+	decode_at_error(&error, g_at_result_final_response(result));
+	cb(&error, cbd->data);
+}
+
+static void at_lte_set_default_attach_info(const struct ofono_lte *lte,
+			const struct ofono_lte_default_attach_info *info,
+			ofono_lte_cb_t cb, void *data)
+{
+	struct lte_driver_data *ldd =3D ofono_lte_get_data(lte);
+	char buf[32 + OFONO_GPRS_MAX_APN_LENGTH + 1];
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	DBG("LTE config with APN: %s", info->apn);
+
+	if (strlen(info->apn) > 0)
+		snprintf(buf, sizeof(buf), "AT+CGDCONT=3D0,\"IP\",\"%s\"",
+				info->apn);
+	else
+		snprintf(buf, sizeof(buf), "AT+CGDCONT=3D0,\"IP\"");
+
+	/* We can't do much in case of failure so don't check response. */
+	if (g_at_chat_send(ldd->chat, buf, NULL,
+			at_lte_set_default_attach_info_cb, cbd, g_free) > 0)
+		return;
+
+	CALLBACK_WITH_FAILURE(cb, data);
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
+static int at_lte_probe(struct ofono_lte *lte, void *data)
+{
+	GAtChat *chat =3D data;
+	struct lte_driver_data *ldd;
+
+	DBG("at lte probe");
+
+	ldd =3D g_try_new0(struct lte_driver_data, 1);
+	if (!ldd)
+		return -ENOMEM;
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
+static void at_lte_remove(struct ofono_lte *lte)
+{
+	struct lte_driver_data *ldd =3D ofono_lte_get_data(lte);
+
+	DBG("at lte remove");
+
+	g_at_chat_unref(ldd->chat);
+
+	ofono_lte_set_data(lte, NULL);
+
+	g_free(ldd);
+}
+
+static struct ofono_lte_driver driver =3D {
+	.name				=3D "atmodem",
+	.probe				=3D at_lte_probe,
+	.remove				=3D at_lte_remove,
+	.set_default_attach_info	=3D at_lte_set_default_attach_info,
+};
+
+void at_lte_init(void)
+{
+	ofono_lte_driver_register(&driver);
+}
+
+void at_lte_exit(void)
+{
+	ofono_lte_driver_unregister(&driver);
+}
-- =

1.9.1


--===============4271698433449448863==--

