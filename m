Content-Type: multipart/mixed; boundary="===============1836684740862175277=="
MIME-Version: 1.0
From: Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>
Subject: [PATCH v2 5/9] mbmmodem: add gps atom
Date: Tue, 11 Jan 2011 00:23:54 -0300
Message-ID: <1294716238-21218-6-git-send-email-rafael.zurita@profusion.mobi>
In-Reply-To: <1294716238-21218-1-git-send-email-rafael.zurita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1836684740862175277==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                 |    3 +-
 drivers/mbmmodem/gps.c      |  229 +++++++++++++++++++++++++++++++++++++++=
++++
 drivers/mbmmodem/mbmmodem.c |    2 +
 drivers/mbmmodem/mbmmodem.h |    3 +
 4 files changed, 236 insertions(+), 1 deletions(-)
 create mode 100644 drivers/mbmmodem/gps.c

diff --git a/Makefile.am b/Makefile.am
index d5029d5..a41b629 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -205,7 +205,8 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/mbmmodem/mbmmodem.h \
 			drivers/mbmmodem/mbmmodem.c \
 			drivers/mbmmodem/gprs-context.c \
-			drivers/mbmmodem/stk.c
+			drivers/mbmmodem/stk.c \
+			drivers/mbmmodem/gps.c
 =

 builtin_modules +=3D hsomodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
diff --git a/drivers/mbmmodem/gps.c b/drivers/mbmmodem/gps.c
new file mode 100644
index 0000000..0495642
--- /dev/null
+++ b/drivers/mbmmodem/gps.c
@@ -0,0 +1,229 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2010 ProFUSION embedded systems.
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
+#include <ofono/gps.h>
+
+#include "gatchat.h"
+#include "gatresult.h"
+#include "gattty.h"
+
+#include "mbmmodem.h"
+
+static const char *none_prefix[] =3D { NULL };
+static const char *e2gpsctl_prefix[] =3D { "*E2GPSCTL:", NULL };
+
+struct gps_data {
+	GAtChat *chat;
+};
+
+struct e2gpsnpd_data {
+	GIOChannel *channel;
+	GAtChat *chat;
+};
+
+static void mbm_e2gpsctl_disable_cb(gboolean ok, GAtResult *result,
+							gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_gps_disable_cb_t cb =3D cbd->cb;
+	struct ofono_error error;
+
+	decode_at_error(&error, g_at_result_final_response(result));
+	cb(&error, cbd->data);
+}
+
+static void mbm_gps_disable(struct ofono_gps *g,
+				ofono_gps_disable_cb_t cb,
+				void *data)
+{
+	struct gps_data *gd =3D ofono_gps_get_data(g);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	if (g_at_chat_send(gd->chat, "AT*E2GPSCTL=3D0,5,1", none_prefix,
+				mbm_e2gpsctl_disable_cb, cbd, g_free) > 0)
+		return;
+
+	/* error */
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+}
+
+static void mbm_gps_send_e2gpsnpd_cb(gboolean ok, GAtResult *result,
+							gpointer user_data)
+{
+	struct e2gpsnpd_data *e2d =3D user_data;
+
+	g_io_channel_unref(e2d->channel);
+	g_at_chat_unref(e2d->chat);
+}
+
+static void mbm_gps_send_e2gpsnpd(const char *gps_dev)
+{
+	GAtSyntax *syntax;
+	struct e2gpsnpd_data *e2d;
+
+	e2d =3D g_try_new0(struct e2gpsnpd_data, 1);
+	if (e2d =3D=3D NULL)
+		return;
+
+	e2d->channel =3D g_at_tty_open(gps_dev, NULL);
+	if (e2d->channel =3D=3D NULL)
+		return;
+
+	syntax =3D g_at_syntax_new_gsm_permissive();
+	e2d->chat =3D g_at_chat_new(e2d->channel, syntax);
+	g_at_syntax_unref(syntax);
+
+	if (e2d->chat =3D=3D NULL)
+		return;
+
+	if (g_at_chat_send(e2d->chat, "AT*E2GPSNPD", none_prefix,
+				 mbm_gps_send_e2gpsnpd_cb, e2d, g_free) > 0)
+		return;
+
+	g_io_channel_unref(e2d->channel);
+	g_at_chat_unref(e2d->chat);
+	g_free(e2d);
+}
+
+static void mbm_e2gpsctl_enable_cb(gboolean ok, GAtResult *result,
+							 gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	struct ofono_gps *gps =3D cbd->user;
+	ofono_gps_enable_cb_t cb =3D cbd->cb;
+	struct ofono_modem *modem;
+	const char *gps_dev;
+
+	if (!ok) {
+		struct ofono_error error;
+
+		decode_at_error(&error, g_at_result_final_response(result));
+		cb(&error, OFONO_GPS_DEVICE_TYPE_NMEA, NULL, cbd->data);
+		return;
+	}
+
+	modem =3D ofono_gps_get_modem(gps);
+	gps_dev =3D ofono_modem_get_string(modem, "GPSDevice");
+
+	/* NMEA stream is sent to gps_dev */
+	mbm_gps_send_e2gpsnpd(gps_dev);
+
+	CALLBACK_WITH_SUCCESS(cb, OFONO_GPS_DEVICE_TYPE_NMEA, gps_dev,
+								cbd->data);
+}
+
+static void mbm_gps_enable(struct ofono_gps *g,
+				ofono_gps_enable_cb_t cb,
+				void *data)
+{
+	struct gps_data *gd =3D ofono_gps_get_data(g);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	if (cbd =3D=3D NULL)
+		goto error;
+
+	cbd->user =3D g;
+
+	if (g_at_chat_send(gd->chat, "AT*E2GPSCTL=3D1,5,1", none_prefix,
+				mbm_e2gpsctl_enable_cb, cbd, g_free) > 0)
+		return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, OFONO_GPS_DEVICE_TYPE_NMEA, NULL, data);
+	g_free(cbd);
+}
+
+static void mbm_gps_support_cb(gboolean ok, GAtResult *result,
+							gpointer user_data)
+{
+	struct ofono_gps *gps =3D user_data;
+
+	if (!ok) {
+		ofono_gps_remove(gps);
+		return;
+	}
+
+	ofono_gps_register(gps);
+}
+
+static int mbm_gps_probe(struct ofono_gps *g,
+					unsigned int vendor, void *data)
+{
+	GAtChat *chat =3D data;
+	struct gps_data *gd;
+
+	gd =3D g_try_new0(struct gps_data, 1);
+	if (gd =3D=3D NULL)
+		return -ENOMEM;
+
+	gd->chat =3D g_at_chat_clone(chat);
+
+	ofono_gps_set_data(g, gd);
+
+	g_at_chat_send(gd->chat, "AT*E2GPSCTL=3D?", e2gpsctl_prefix,
+					mbm_gps_support_cb, g, NULL);
+
+	return 0;
+}
+
+static void mbm_gps_remove(struct ofono_gps *g)
+{
+	struct gps_data *gd =3D ofono_gps_get_data(g);
+
+	ofono_gps_set_data(g, NULL);
+
+	g_at_chat_unref(gd->chat);
+	g_free(gd);
+}
+
+static struct ofono_gps_driver driver =3D {
+	.name			=3D "mbmmodem",
+	.probe			=3D mbm_gps_probe,
+	.remove			=3D mbm_gps_remove,
+	.enable			=3D mbm_gps_enable,
+	.disable		=3D mbm_gps_disable,
+};
+
+void mbm_gps_init()
+{
+	ofono_gps_driver_register(&driver);
+}
+
+void mbm_gps_exit()
+{
+	ofono_gps_driver_unregister(&driver);
+}
diff --git a/drivers/mbmmodem/mbmmodem.c b/drivers/mbmmodem/mbmmodem.c
index 03b61b3..ea56cd4 100644
--- a/drivers/mbmmodem/mbmmodem.c
+++ b/drivers/mbmmodem/mbmmodem.c
@@ -36,12 +36,14 @@ static int mbmmodem_init(void)
 {
 	mbm_gprs_context_init();
 	mbm_stk_init();
+	mbm_gps_init();
 =

 	return 0;
 }
 =

 static void mbmmodem_exit(void)
 {
+	mbm_gps_exit();
 	mbm_stk_exit();
 	mbm_gprs_context_exit();
 }
diff --git a/drivers/mbmmodem/mbmmodem.h b/drivers/mbmmodem/mbmmodem.h
index 65786d7..d1e96fa 100644
--- a/drivers/mbmmodem/mbmmodem.h
+++ b/drivers/mbmmodem/mbmmodem.h
@@ -26,3 +26,6 @@ extern void mbm_gprs_context_exit();
 =

 extern void mbm_stk_init();
 extern void mbm_stk_exit();
+
+extern void mbm_gps_init();
+extern void mbm_gps_exit();
-- =

1.7.2.3


--===============1836684740862175277==--

