Content-Type: multipart/mixed; boundary="===============9213259750665619723=="
MIME-Version: 1.0
From: Jarko Poutiainen <jarko.poutiainen@tieto.com>
Subject: [PATCH 5/9] atmodem: add gnss driver
Date: Tue, 08 Mar 2011 13:00:47 +0200
Message-ID: <1299582051-32701-6-git-send-email-jarko.poutiainen@tieto.com>
In-Reply-To: <1299582051-32701-1-git-send-email-jarko.poutiainen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9213259750665619723==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am               |    3 +-
 drivers/atmodem/atmodem.c |    2 +
 drivers/atmodem/atmodem.h |    3 +
 drivers/atmodem/gnss.c    |  278 +++++++++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 285 insertions(+), 1 deletions(-)
 create mode 100644 drivers/atmodem/gnss.c

diff --git a/Makefile.am b/Makefile.am
index 24742bb..3dae7f4 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -180,7 +180,8 @@ builtin_sources +=3D $(gatchat_sources) \
 				drivers/atmodem/atutil.c \
 				drivers/atmodem/gprs.c \
 				drivers/atmodem/gprs-context.c \
-				drivers/atmodem/sim-auth.c
+				drivers/atmodem/sim-auth.c \
+				drivers/atmodem/gnss.c
 =

 builtin_modules +=3D nwmodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
diff --git a/drivers/atmodem/atmodem.c b/drivers/atmodem/atmodem.c
index e140281..3093c23 100644
--- a/drivers/atmodem/atmodem.c
+++ b/drivers/atmodem/atmodem.c
@@ -52,6 +52,7 @@ static int atmodem_init(void)
 	at_gprs_init();
 	at_gprs_context_init();
 	at_sim_auth_init();
+	at_gnss_init();
 =

 	return 0;
 }
@@ -76,6 +77,7 @@ static void atmodem_exit(void)
 	at_call_volume_exit();
 	at_gprs_exit();
 	at_gprs_context_exit();
+	at_gnss_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(atmodem, "AT modem driver", VERSION,
diff --git a/drivers/atmodem/atmodem.h b/drivers/atmodem/atmodem.h
index 1b7cf67..1a73b84 100644
--- a/drivers/atmodem/atmodem.h
+++ b/drivers/atmodem/atmodem.h
@@ -74,3 +74,6 @@ extern void at_gprs_context_exit(void);
 =

 extern void at_sim_auth_init(void);
 extern void at_sim_auth_exit(void);
+
+extern void at_gnss_init(void);
+extern void at_gnss_exit(void);
diff --git a/drivers/atmodem/gnss.c b/drivers/atmodem/gnss.c
new file mode 100644
index 0000000..b8fe116
--- /dev/null
+++ b/drivers/atmodem/gnss.c
@@ -0,0 +1,278 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2011 ST-Ericsson AB.
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
+#include <errno.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/gnss.h>
+
+#include "gatchat.h"
+#include "gatresult.h"
+
+#include "atmodem.h"
+#include "vendor.h"
+
+struct gnss_data {
+	GAtChat *chat;
+	unsigned int vendor;
+};
+
+static const char *none_prefix[] =3D { NULL };
+static const char *cpos_prefix[] =3D { "+CPOS:", NULL };
+static const char *cposr_prefix[] =3D { "+CPOSR:", NULL };
+
+static void gnsspr_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_gnss_position_report_cb_t cb =3D cbd->cb;
+
+	DBG("");
+
+	if (ok)
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	else
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+}
+
+static void at_gnss_position_reporting(struct ofono_gnss *gnss,
+					ofono_bool_t enable,
+					ofono_gnss_position_report_cb_t cb,
+					void *data)
+{
+	struct gnss_data *ad =3D ofono_gnss_get_data(gnss);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	DBG("");
+
+	if (enable) {
+		g_at_chat_send(ad->chat, "AT+CPOSR=3D1",
+				cposr_prefix, gnsspr_cb, cbd, g_free);
+
+		if (ad->vendor =3D=3D OFONO_VENDOR_STE)
+			g_at_chat_send(ad->chat, "AT*EPOSADRR=3D1",
+					NULL, NULL, NULL, NULL);
+	} else {
+		g_at_chat_send(ad->chat, "AT+CPOSR=3D0",
+				cposr_prefix, gnsspr_cb, cbd, g_free);
+
+		if (ad->vendor =3D=3D OFONO_VENDOR_STE)
+			g_at_chat_send(ad->chat, "AT*EPOSADRR=3D0",
+					NULL, NULL, NULL, NULL);
+	}
+}
+
+static void gnssse_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_gnss_send_element_cb_t cb =3D cbd->cb;
+
+	DBG("");
+
+	if (ok)
+		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+	else
+		CALLBACK_WITH_FAILURE(cb, cbd->data);
+}
+
+static void at_gnss_send_element(struct ofono_gnss *gnss,
+				const char *xml,
+				ofono_gnss_send_element_cb_t cb, void *data)
+{
+	struct gnss_data *ad =3D ofono_gnss_get_data(gnss);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	char *buf =3D g_try_new(char, strlen(xml) + 10);
+	int len;
+
+	DBG("");
+
+	if (buf =3D=3D NULL)
+		goto error;
+
+	len =3D sprintf(buf, "AT+CPOS\r");
+	len +=3D sprintf(buf + len, "%s", xml);
+
+	if (g_at_chat_send(ad->chat, buf, cpos_prefix,
+					gnssse_cb, cbd, g_free) > 0) {
+		g_free(buf);
+		return;
+	}
+error:
+	g_free(buf);
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static gboolean gnss_parse_report(GAtResult *result, const char *prefix,
+					const char **xml)
+{
+	GAtResultIter iter;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, prefix))
+		return FALSE;
+
+	if (!g_at_result_iter_next_unquoted_string(&iter, xml))
+		return FALSE;
+
+	return TRUE;
+}
+
+static void gnss_report(GAtResult *result, gpointer user_data)
+{
+	struct ofono_gnss *gnss =3D user_data;
+	const char *xml;
+
+	DBG("");
+
+	xml =3D NULL;
+	if (!gnss_parse_report(result, "+CPOSR:", &xml)) {
+		ofono_error("Unable to parse CPOSR notification");
+		return;
+	}
+
+	if (xml =3D=3D NULL) {
+		ofono_error("Unable to parse CPOSR notification");
+		return;
+	}
+
+	ofono_gnss_receive_request(gnss, xml);
+}
+
+static void at_gnssreset_cb(GAtResult *result, gpointer user_data)
+{
+	struct ofono_gnss *gnss =3D user_data;
+
+	DBG("");
+
+	ofono_gnss_receive_reset(gnss);
+}
+
+static void at_gnss_not_supported(struct ofono_gnss *gnss)
+{
+	ofono_error("gnss not supported by this modem.");
+
+	ofono_gnss_remove(gnss);
+}
+
+static void at_gnsscposr_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
+{
+	struct ofono_gnss *gnss =3D user_data;
+	struct gnss_data *ad =3D ofono_gnss_get_data(gnss);
+
+	DBG("");
+
+	if (!ok) {
+		at_gnss_not_supported(gnss);
+		return;
+	}
+
+	g_at_chat_register(ad->chat, "+CPOSR:", gnss_report,
+				FALSE, gnss, NULL);
+
+	if (ad->vendor =3D=3D OFONO_VENDOR_STE)
+		g_at_chat_register(ad->chat, "*EPOSADRR:", at_gnssreset_cb,
+					FALSE, gnss, NULL);
+
+	ofono_gnss_register(gnss);
+}
+
+static void at_gnsscpos_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
+{
+	struct ofono_gnss *gnss =3D user_data;
+	struct gnss_data *ad =3D ofono_gnss_get_data(gnss);
+
+	DBG("");
+
+	if (!ok) {
+		at_gnss_not_supported(gnss);
+		return;
+	}
+
+	g_at_chat_send(ad->chat, "AT+CPOSR=3D?",
+			none_prefix, at_gnsscposr_cb, gnss, NULL);
+}
+
+static int at_gnss_probe(struct ofono_gnss *gnss, unsigned int vendor,
+				void *user)
+{
+	GAtChat *chat =3D user;
+	struct gnss_data *gd;
+
+	DBG("");
+
+	gd =3D g_try_new0(struct gnss_data, 1);
+	if (gd =3D=3D NULL)
+		return -ENOMEM;
+
+	gd->chat =3D g_at_chat_clone(chat);
+	gd->vendor =3D vendor;
+
+	ofono_gnss_set_data(gnss, gd);
+
+	g_at_chat_send(gd->chat, "AT+CPOS=3D?",
+			none_prefix, at_gnsscpos_cb, gnss, NULL);
+
+	return 0;
+}
+
+static void at_gnss_remove(struct ofono_gnss *gnss)
+{
+	struct gnss_data *gd =3D ofono_gnss_get_data(gnss);
+
+	DBG("");
+
+	ofono_gnss_set_data(gnss, NULL);
+
+	g_at_chat_unref(gd->chat);
+	g_free(gd);
+}
+
+static struct ofono_gnss_driver driver =3D {
+	.name			=3D "atmodem",
+	.probe			=3D at_gnss_probe,
+	.remove			=3D at_gnss_remove,
+	.send_element		=3D at_gnss_send_element,
+	.position_reporting	=3D at_gnss_position_reporting,
+};
+
+void at_gnss_init(void)
+{
+	ofono_gnss_driver_register(&driver);
+}
+
+void at_gnss_exit(void)
+{
+	ofono_gnss_driver_unregister(&driver);
+}
-- =

1.7.0.4


--===============9213259750665619723==--

