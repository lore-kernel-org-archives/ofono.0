Content-Type: multipart/mixed; boundary="===============4328227935356296400=="
MIME-Version: 1.0
From: Vincent Cesson <vincent.cesson@smile.fr>
Subject: [PATCH] drivers: Add gemaltomodem driver to handle GNSS
Date: Wed, 18 Jan 2017 12:32:04 +0100
Message-ID: <1484739124-1117-1-git-send-email-vincent.cesson@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4328227935356296400==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a new location-reporting driver for Gemalto Cinterion modems based
on telit implementation + use it in gemalto plugin. It supports
activation of GNSS engine (Request) with command AT^SGPSC. This driver
is tested on PHS8. NMEA frames are accessible on /dev/ttyUSB1.
---
 Makefile.am                               |   6 +
 drivers/gemaltomodem/gemaltomodem.c       |  49 ++++++
 drivers/gemaltomodem/gemaltomodem.h       |  25 ++++
 drivers/gemaltomodem/location-reporting.c | 237 ++++++++++++++++++++++++++=
++++
 plugins/gemalto.c                         |   7 +-
 5 files changed, 321 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gemaltomodem/gemaltomodem.c
 create mode 100644 drivers/gemaltomodem/gemaltomodem.h
 create mode 100644 drivers/gemaltomodem/location-reporting.c

diff --git a/Makefile.am b/Makefile.am
index a87c892..f76971e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -388,6 +388,12 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/ubloxmodem/lte.c
 =

 =

+builtin_modules +=3D gemaltomodem
+builtin_sources +=3D drivers/atmodem/atutil.h \
+			drivers/gemaltomodem/gemaltomodem.h \
+			drivers/gemaltomodem/gemaltomodem.c \
+			drivers/gemaltomodem/location-reporting.c
+
 =

 if PHONESIM
 builtin_modules +=3D phonesim
diff --git a/drivers/gemaltomodem/gemaltomodem.c b/drivers/gemaltomodem/gem=
altomodem.c
new file mode 100644
index 0000000..91cf238
--- /dev/null
+++ b/drivers/gemaltomodem/gemaltomodem.c
@@ -0,0 +1,49 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2017 Vincent Cesson. All rights reserved.
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
+#include <glib.h>
+#include <gatchat.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/types.h>
+
+#include "gemaltomodem.h"
+
+static int gemaltomodem_init(void)
+{
+	gemalto_location_reporting_init();
+
+	return 0;
+}
+
+static void gemaltomodem_exit(void)
+{
+	gemalto_location_reporting_exit();
+}
+
+OFONO_PLUGIN_DEFINE(gemaltomodem, "Gemalto modem driver", VERSION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT,
+			gemaltomodem_init, gemaltomodem_exit)
diff --git a/drivers/gemaltomodem/gemaltomodem.h b/drivers/gemaltomodem/gem=
altomodem.h
new file mode 100644
index 0000000..7ea1e8f
--- /dev/null
+++ b/drivers/gemaltomodem/gemaltomodem.h
@@ -0,0 +1,25 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2017 Vincent Cesson. All rights reserved.
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
+#include <drivers/atmodem/atutil.h>
+
+extern void gemalto_location_reporting_init();
+extern void gemalto_location_reporting_exit();
diff --git a/drivers/gemaltomodem/location-reporting.c b/drivers/gemaltomod=
em/location-reporting.c
new file mode 100644
index 0000000..bcfe00e
--- /dev/null
+++ b/drivers/gemaltomodem/location-reporting.c
@@ -0,0 +1,237 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2017 Vincent Cesson. All rights reserved.
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
+#include "gemaltomodem.h"
+
+static const char *sgpsc_prefix[] =3D { "^SGPSC:", NULL };
+
+struct gps_data {
+	GAtChat *chat;
+};
+
+static void gemalto_gps_disable_cb(gboolean ok, GAtResult *result,
+							gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	struct ofono_location_reporting *lr =3D cbd->user;
+	ofono_location_reporting_disable_cb_t cb =3D cbd->cb;
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
+	CALLBACK_WITH_SUCCESS(cb, cbd->data);
+}
+
+static void gemalto_location_reporting_disable(
+				struct ofono_location_reporting *lr,
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
+	if (g_at_chat_send(gd->chat, "AT^SGPSC=3D\"Engine\",0", sgpsc_prefix,
+				gemalto_gps_disable_cb, cbd, g_free) > 0)
+		return;
+
+	CALLBACK_WITH_FAILURE(cb, data);
+
+	g_free(cbd);
+}
+
+static int enable_data_stream(struct ofono_location_reporting *lr)
+{
+	struct ofono_modem *modem;
+	const char *gps_dev;
+	GHashTable *options;
+	GIOChannel *channel;
+	int fd;
+
+	modem =3D ofono_location_reporting_get_modem(lr);
+	gps_dev =3D ofono_modem_get_string(modem, "GPS");
+
+	options =3D g_hash_table_new(g_str_hash, g_str_equal);
+	if (options =3D=3D NULL)
+		return -1;
+
+	g_hash_table_insert(options, "Baud", "115200");
+
+	channel =3D g_at_tty_open(gps_dev, options);
+
+	g_hash_table_destroy(options);
+
+	if (channel =3D=3D NULL)
+		return -1;
+
+	fd =3D g_io_channel_unix_get_fd(channel);
+
+	g_io_channel_set_close_on_unref(channel, FALSE);
+	g_io_channel_unref(channel);
+
+	return fd;
+}
+
+static void gemalto_sgpsc_cb(gboolean ok, GAtResult *result,
+					gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_location_reporting_enable_cb_t cb =3D cbd->cb;
+	struct ofono_location_reporting *lr =3D cbd->user;
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
+	fd =3D enable_data_stream(lr);
+
+	if (fd < 0) {
+		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+
+		return;
+	}
+
+	cb(&error, fd, cbd->data);
+	close(fd);
+}
+
+static void gemalto_location_reporting_enable(struct ofono_location_report=
ing *lr,
+					ofono_location_reporting_enable_cb_t cb,
+					void *data)
+{
+	struct gps_data *gd =3D ofono_location_reporting_get_data(lr);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	DBG("lr=3D%p", lr);
+
+	cbd->user =3D lr;
+
+	if (g_at_chat_send(gd->chat, "AT^SGPSC=3D\"Engine\",2", sgpsc_prefix,
+				gemalto_sgpsc_cb, cbd, NULL) > 0)
+		return;
+
+	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+	g_free(cbd);
+}
+
+static void gemalto_location_reporting_support_cb(gboolean ok, GAtResult *=
result,
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
+static int gemalto_location_reporting_probe(struct ofono_location_reportin=
g *lr,
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
+	g_at_chat_send(gd->chat, "AT^SGPSC=3D?", sgpsc_prefix,
+					gemalto_location_reporting_support_cb,
+					lr, NULL);
+
+	return 0;
+}
+
+static void gemalto_location_reporting_remove(struct ofono_location_report=
ing *lr)
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
+	.name			=3D "gemaltomodem",
+	.type			=3D OFONO_LOCATION_REPORTING_TYPE_NMEA,
+	.probe			=3D gemalto_location_reporting_probe,
+	.remove			=3D gemalto_location_reporting_remove,
+	.enable			=3D gemalto_location_reporting_enable,
+	.disable		=3D gemalto_location_reporting_disable,
+};
+
+void gemalto_location_reporting_init()
+{
+	ofono_location_reporting_driver_register(&driver);
+}
+
+void gemalto_location_reporting_exit()
+{
+	ofono_location_reporting_driver_unregister(&driver);
+}
diff --git a/plugins/gemalto.c b/plugins/gemalto.c
index bebb068..ffe6814 100644
--- a/plugins/gemalto.c
+++ b/plugins/gemalto.c
@@ -46,14 +46,14 @@
 #include <ofono/sms.h>
 #include <ofono/ussd.h>
 #include <ofono/voicecall.h>
-
-#include <drivers/atmodem/atutil.h>
-
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
+#include <ofono/location-reporting.h>
 =

+#include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>
 =

+
 struct gemalto_data {
 	GAtChat *app;
 	GAtChat *mdm;
@@ -194,6 +194,7 @@ static void gemalto_pre_sim(struct ofono_modem *modem)
 	ofono_devinfo_create(modem, 0, "atmodem", data->app);
 	sim =3D ofono_sim_create(modem, 0, "atmodem", data->app);
 	ofono_voicecall_create(modem, 0, "atmodem", data->app);
+	ofono_location_reporting_create(modem, 0, "gemaltomodem", data->app);
 =

 	if (sim)
 		ofono_sim_inserted_notify(sim, TRUE);
-- =

1.9.1


--===============4328227935356296400==--

