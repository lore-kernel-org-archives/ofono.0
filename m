Content-Type: multipart/mixed; boundary="===============6826634107604594758=="
MIME-Version: 1.0
From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH v2 1/3] drivers: gemalto: add gprs-context driver
Date: Tue, 18 Aug 2020 23:43:45 +0300
Message-ID: <20200818204347.29516-2-geomatsi@gmail.com>
In-Reply-To: <20200818204347.29516-1-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6826634107604594758==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some gemalto modems provide USB ethernet interfaces for data path.
Implement gprs-context driver for such modems to send data via
USB ethernet rather than fallback to PPP.

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---
 Makefile.am                         |   3 +-
 drivers/gemaltomodem/gemaltomodem.c |   4 +-
 drivers/gemaltomodem/gemaltomodem.h |   3 +
 drivers/gemaltomodem/gprs-context.c | 278 ++++++++++++++++++++++++++++
 4 files changed, 286 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gemaltomodem/gprs-context.c

diff --git a/Makefile.am b/Makefile.am
index fbb0eff4..67c3bcbf 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -482,7 +482,8 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/gemaltomodem/gemaltomodem.h \
 			drivers/gemaltomodem/gemaltomodem.c \
 			drivers/gemaltomodem/location-reporting.c \
-			drivers/gemaltomodem/voicecall.c
+			drivers/gemaltomodem/voicecall.c \
+			drivers/gemaltomodem/gprs-context.c
 =

 builtin_modules +=3D xmm7modem
 builtin_sources +=3D drivers/atmodem/atutil.h \
diff --git a/drivers/gemaltomodem/gemaltomodem.c b/drivers/gemaltomodem/gem=
altomodem.c
index 4818ac66..4b20dd1b 100644
--- a/drivers/gemaltomodem/gemaltomodem.c
+++ b/drivers/gemaltomodem/gemaltomodem.c
@@ -36,6 +36,7 @@
 static int gemaltomodem_init(void)
 {
 	gemalto_location_reporting_init();
+	gemalto_gprs_context_init();
 	gemalto_voicecall_init();
 =

 	return 0;
@@ -43,8 +44,9 @@ static int gemaltomodem_init(void)
 =

 static void gemaltomodem_exit(void)
 {
-	gemalto_voicecall_exit();
 	gemalto_location_reporting_exit();
+	gemalto_gprs_context_exit();
+	gemalto_voicecall_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(gemaltomodem, "Gemalto modem driver", VERSION,
diff --git a/drivers/gemaltomodem/gemaltomodem.h b/drivers/gemaltomodem/gem=
altomodem.h
index 27b1460e..dc0d346b 100644
--- a/drivers/gemaltomodem/gemaltomodem.h
+++ b/drivers/gemaltomodem/gemaltomodem.h
@@ -27,3 +27,6 @@ extern void gemalto_location_reporting_exit();
 =

 extern void gemalto_voicecall_init();
 extern void gemalto_voicecall_exit();
+
+extern void gemalto_gprs_context_init();
+extern void gemalto_gprs_context_exit();
diff --git a/drivers/gemaltomodem/gprs-context.c b/drivers/gemaltomodem/gpr=
s-context.c
new file mode 100644
index 00000000..73cf81a8
--- /dev/null
+++ b/drivers/gemaltomodem/gprs-context.c
@@ -0,0 +1,278 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2020 Sergey Matyukevich. All rights reserved.
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
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+#include <sys/stat.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/gprs-context.h>
+
+#include "gatchat.h"
+#include "gatresult.h"
+#include "gattty.h"
+
+#include "gemaltomodem.h"
+
+static const char *none_prefix[] =3D { NULL };
+
+struct gprs_context_data {
+	GAtChat *chat;
+	unsigned int active_context;
+	ofono_gprs_context_cb_t cb;
+	void *cb_data;
+};
+
+static void cgact_enable_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	struct ofono_modem *modem;
+	const char *interface;
+	char buf[64];
+
+	DBG("ok %d", ok);
+
+	if (!ok) {
+		struct ofono_error error;
+
+		gcd->active_context =3D 0;
+
+		decode_at_error(&error, g_at_result_final_response(result));
+		gcd->cb(&error, gcd->cb_data);
+
+		return;
+	}
+
+	snprintf(buf, sizeof(buf), "AT^SWWAN=3D1,%u", gcd->active_context);
+	g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL);
+
+	modem =3D ofono_gprs_context_get_modem(gc);
+	interface =3D ofono_modem_get_string(modem, "NetworkInterface");
+	ofono_gprs_context_set_interface(gc, interface);
+
+	/* Use DHCP */
+	ofono_gprs_context_set_ipv4_address(gc, NULL, 0);
+
+	CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
+}
+
+static void cgdcont_enable_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	char buf[64];
+
+	DBG("ok %d", ok);
+
+	if (!ok) {
+		struct ofono_error error;
+
+		gcd->active_context =3D 0;
+
+		decode_at_error(&error, g_at_result_final_response(result));
+		gcd->cb(&error, gcd->cb_data);
+
+		return;
+	}
+
+	snprintf(buf, sizeof(buf), "AT+CGACT=3D1,%u", gcd->active_context);
+
+	if (g_at_chat_send(gcd->chat, buf, none_prefix,
+				cgact_enable_cb, gc, NULL) =3D=3D 0)
+		goto error;
+
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
+}
+
+static void gemalto_gprs_activate_primary(struct ofono_gprs_context *gc,
+				const struct ofono_gprs_primary_context *ctx,
+				ofono_gprs_context_cb_t cb, void *data)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	char buf[OFONO_GPRS_MAX_APN_LENGTH + 128];
+	int len =3D 0;
+
+	DBG("cid %u", ctx->cid);
+
+	/* IPv6 support not implemented */
+	if (ctx->proto !=3D OFONO_GPRS_PROTO_IP)
+		goto error;
+
+	gcd->active_context =3D ctx->cid;
+	gcd->cb_data =3D data;
+	gcd->cb =3D cb;
+
+	len =3D snprintf(buf, sizeof(buf), "AT+CGDCONT=3D%u,\"IP\"", ctx->cid);
+
+	if (ctx->apn)
+		snprintf(buf + len, sizeof(buf) - len - 3, ",\"%s\"", ctx->apn);
+
+	if (g_at_chat_send(gcd->chat, buf, none_prefix,
+				cgdcont_enable_cb, gc, NULL) =3D=3D 0)
+		goto error;
+
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void cgact_disable_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	char buf[64];
+
+	DBG("ok %d", ok);
+
+	if (!ok) {
+		CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
+		return;
+	}
+
+	snprintf(buf, sizeof(buf), "AT^SWWAN=3D0,%u", gcd->active_context);
+	g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL);
+
+	gcd->active_context =3D 0;
+
+	CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
+}
+
+static void gemalto_gprs_deactivate_primary(struct ofono_gprs_context *gc,
+						unsigned int cid,
+						ofono_gprs_context_cb_t cb,
+						void *data)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	char buf[64];
+
+	DBG("cid %u", cid);
+
+	gcd->cb =3D cb;
+	gcd->cb_data =3D data;
+
+	snprintf(buf, sizeof(buf), "AT+CGACT=3D0,%u", cid);
+
+	if (g_at_chat_send(gcd->chat, buf, none_prefix,
+				cgact_disable_cb, gc, NULL) =3D=3D 0)
+		goto error;
+
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, data);
+
+}
+
+static void cgev_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	GAtResultIter iter;
+	const char *event;
+	gint cid;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CGEV:"))
+		return;
+
+	if (!g_at_result_iter_next_unquoted_string(&iter, &event))
+		return;
+
+	if (g_str_has_prefix(event, "NW PDN DEACT"))
+		sscanf(event, "%*s %*s %*s %u", &cid);
+	else if (g_str_has_prefix(event, "NW DEACT"))
+		sscanf(event, "%*s %*s %u", &cid);
+	else
+		return;
+
+	DBG("cid %d, active cid: %d", cid, gcd->active_context);
+
+	if ((unsigned int) cid !=3D gcd->active_context)
+		return;
+
+	ofono_gprs_context_deactivated(gc, gcd->active_context);
+	gcd->active_context =3D 0;
+}
+
+static int gemalto_gprs_context_probe(struct ofono_gprs_context *gc,
+					unsigned int vendor, void *data)
+{
+	GAtChat *chat =3D data;
+	struct gprs_context_data *gcd;
+
+	DBG("");
+
+	gcd =3D g_new0(struct gprs_context_data, 1);
+
+	gcd->chat =3D g_at_chat_clone(chat);
+
+	ofono_gprs_context_set_data(gc, gcd);
+	g_at_chat_register(chat, "+CGEV:", cgev_notify, FALSE, gc, NULL);
+
+	return 0;
+}
+
+static void gemalto_gprs_context_remove(struct ofono_gprs_context *gc)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+
+	DBG("");
+
+	ofono_gprs_context_set_data(gc, NULL);
+	g_at_chat_unref(gcd->chat);
+	g_free(gcd);
+}
+
+static const struct ofono_gprs_context_driver driver =3D {
+	.name			=3D "gemaltomodem",
+	.probe			=3D gemalto_gprs_context_probe,
+	.remove			=3D gemalto_gprs_context_remove,
+	.activate_primary	=3D gemalto_gprs_activate_primary,
+	.deactivate_primary	=3D gemalto_gprs_deactivate_primary,
+};
+
+void gemalto_gprs_context_init(void)
+{
+	ofono_gprs_context_driver_register(&driver);
+}
+
+void gemalto_gprs_context_exit(void)
+{
+	ofono_gprs_context_driver_unregister(&driver);
+}
-- =

2.28.0

--===============6826634107604594758==--

