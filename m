Content-Type: multipart/mixed; boundary="===============8115256168066968593=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v4 3/6] mbmmodem: add location-reporting driver implementation
Date: Tue, 22 Feb 2011 15:35:12 -0300
Message-ID: <1298399715-9617-4-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1298399715-9617-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8115256168066968593==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>

---
 Makefile.am                           |    3 +-
 drivers/mbmmodem/location-reporting.c |  247 +++++++++++++++++++++++++++++=
++++
 drivers/mbmmodem/mbmmodem.c           |    2 +
 drivers/mbmmodem/mbmmodem.h           |    3 +
 4 files changed, 254 insertions(+), 1 deletions(-)
 create mode 100644 drivers/mbmmodem/location-reporting.c

diff --git a/Makefile.am b/Makefile.am
index 48d84c8..9b6edf4 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -212,7 +212,8 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/mbmmodem/mbmmodem.h \
 			drivers/mbmmodem/mbmmodem.c \
 			drivers/mbmmodem/gprs-context.c \
-			drivers/mbmmodem/stk.c
+			drivers/mbmmodem/stk.c \
+			drivers/mbmmodem/location-reporting.c
 =

 builtin_modules +=3D hsomodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
diff --git a/drivers/mbmmodem/location-reporting.c b/drivers/mbmmodem/locat=
ion-reporting.c
new file mode 100644
index 0000000..7d3e212
--- /dev/null
+++ b/drivers/mbmmodem/location-reporting.c
@@ -0,0 +1,247 @@
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
+#include <unistd.h>
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/location-reporting.h>
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
+	GAtChat *data_chat;
+};
+
+static void mbm_e2gpsctl_disable_cb(gboolean ok, GAtResult *result,
+							gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	struct ofono_location_reporting *lr =3D cbd->user;
+	ofono_location_reporting_disable_cb_t cb =3D cbd->cb;
+	struct gps_data *gd =3D ofono_location_reporting_get_data(lr);
+
+	DBG("lr=3D%p, ok=3D%d", lr, ok);
+
+	if (!ok) {
+		struct ofono_error error;
+
+		decode_at_error(&error, g_at_result_final_response(result));
+		cb(&error, cbd->data);
+
+		return;
+	}
+
+	g_at_chat_unref(gd->data_chat);
+
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+}
+
+static void mbm_location_reporting_disable(struct ofono_location_reporting=
 *lr,
+				ofono_location_reporting_disable_cb_t cb,
+				void *data)
+{
+	struct gps_data *gd =3D ofono_location_reporting_get_data(lr);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	DBG("lr=3D%p", lr);
+
+	cbd->user =3D lr;
+
+	if (g_at_chat_send(gd->chat, "AT*E2GPSCTL=3D0,5,1", none_prefix,
+				mbm_e2gpsctl_disable_cb, cbd, g_free) > 0)
+		return;
+
+	CALLBACK_WITH_FAILURE(cb, data);
+	g_free(cbd);
+}
+
+static int mbm_create_data_chat(struct ofono_location_reporting *lr)
+{
+	struct gps_data *gd =3D ofono_location_reporting_get_data(lr);
+	struct ofono_modem *modem;
+	const char *gps_dev;
+	GAtSyntax *syntax;
+	GIOChannel *channel;
+	int fd;
+
+	modem =3D ofono_location_reporting_get_modem(lr);
+	gps_dev =3D ofono_modem_get_string(modem, "GPSDevice");
+
+	channel =3D g_at_tty_open(gps_dev, NULL);
+	if (channel =3D=3D NULL)
+		return -1;
+
+	syntax =3D g_at_syntax_new_gsm_permissive();
+	gd->data_chat =3D g_at_chat_new(channel, syntax);
+	fd =3D g_io_channel_unix_get_fd(channel);
+
+	g_at_syntax_unref(syntax);
+	g_io_channel_unref(channel);
+
+	if (gd->data_chat =3D=3D NULL)
+		return -1;
+
+	return fd;
+}
+
+static void mbm_e2gpsctl_enable_cb(gboolean ok, GAtResult *result,
+							 gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_location_reporting_enable_cb_t cb =3D cbd->cb;
+	struct ofono_location_reporting *lr =3D cbd->user;
+	struct gps_data *gd =3D ofono_location_reporting_get_data(lr);
+	struct ofono_error error;
+	int fd;
+
+	DBG("lr=3D%p ok=3D%d", lr, ok);
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		cb(&error, -1, cbd->data);
+
+		return;
+	}
+
+	fd =3D mbm_create_data_chat(lr);
+
+	if (fd < 0)
+		goto out;
+
+	if (g_at_chat_send(gd->data_chat, "AT*E2GPSNPD", NULL, NULL, NULL,
+								NULL) > 0) {
+		cb(&error, fd, cbd->data);
+
+		return;
+	}
+
+out:
+	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+}
+
+static void mbm_location_reporting_enable(struct ofono_location_reporting =
*lr,
+					ofono_location_reporting_enable_cb_t cb,
+					void *data)
+{
+	struct gps_data *gd =3D ofono_location_reporting_get_data(lr);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	DBG("lr=3D%p", lr);
+
+	if (cbd =3D=3D NULL)
+		goto out;
+
+	cbd->user =3D lr;
+
+	if (g_at_chat_send(gd->chat, "AT*E2GPSCTL=3D1,5,1", none_prefix,
+				mbm_e2gpsctl_enable_cb, cbd, g_free) > 0)
+		return;
+
+out:
+	CALLBACK_WITH_FAILURE(cb, -1, data);
+	g_free(cbd);
+}
+
+static void mbm_location_reporting_support_cb(gboolean ok, GAtResult *resu=
lt,
+							gpointer user_data)
+{
+	struct ofono_location_reporting *lr =3D user_data;
+
+	if (!ok) {
+		ofono_location_reporting_remove(lr);
+
+		return;
+	}
+
+	ofono_location_reporting_register(lr);
+}
+
+static int mbm_location_reporting_probe(struct ofono_location_reporting *l=
r,
+						unsigned int vendor, void *data)
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
+	ofono_location_reporting_set_data(lr, gd);
+
+	g_at_chat_send(gd->chat, "AT*E2GPSCTL=3D?", e2gpsctl_prefix,
+					mbm_location_reporting_support_cb,
+					lr, NULL);
+
+	return 0;
+}
+
+static void mbm_location_reporting_remove(struct ofono_location_reporting =
*lr)
+{
+	struct gps_data *gd =3D ofono_location_reporting_get_data(lr);
+
+	ofono_location_reporting_set_data(lr, NULL);
+
+	g_at_chat_unref(gd->chat);
+	g_free(gd);
+}
+
+static struct ofono_location_reporting_driver driver =3D {
+	.name			=3D "mbmmodem",
+	.type			=3D OFONO_LOCATION_REPORTING_TYPE_NMEA,
+	.probe			=3D mbm_location_reporting_probe,
+	.remove			=3D mbm_location_reporting_remove,
+	.enable			=3D mbm_location_reporting_enable,
+	.disable		=3D mbm_location_reporting_disable,
+};
+
+void mbm_location_reporting_init()
+{
+	ofono_location_reporting_driver_register(&driver);
+}
+
+void mbm_location_reporting_exit()
+{
+	ofono_location_reporting_driver_unregister(&driver);
+}
diff --git a/drivers/mbmmodem/mbmmodem.c b/drivers/mbmmodem/mbmmodem.c
index 03b61b3..9938350 100644
--- a/drivers/mbmmodem/mbmmodem.c
+++ b/drivers/mbmmodem/mbmmodem.c
@@ -36,12 +36,14 @@ static int mbmmodem_init(void)
 {
 	mbm_gprs_context_init();
 	mbm_stk_init();
+	mbm_location_reporting_init();
 =

 	return 0;
 }
 =

 static void mbmmodem_exit(void)
 {
+	mbm_location_reporting_exit();
 	mbm_stk_exit();
 	mbm_gprs_context_exit();
 }
diff --git a/drivers/mbmmodem/mbmmodem.h b/drivers/mbmmodem/mbmmodem.h
index 4c6f263..aaa911d 100644
--- a/drivers/mbmmodem/mbmmodem.h
+++ b/drivers/mbmmodem/mbmmodem.h
@@ -26,3 +26,6 @@ extern void mbm_gprs_context_exit(void);
 =

 extern void mbm_stk_init(void);
 extern void mbm_stk_exit(void);
+
+extern void mbm_location_reporting_init();
+extern void mbm_location_reporting_exit();
-- =

1.7.4.1


--===============8115256168066968593==--

