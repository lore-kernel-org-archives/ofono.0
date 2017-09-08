Content-Type: multipart/mixed; boundary="===============7219653945770298653=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 5/7] Add Quectel location-reporting
Date: Fri, 08 Sep 2017 04:40:38 +0200
Message-ID: <20170908024040.31418-5-jonas@southpole.se>
In-Reply-To: <20170908024040.31418-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7219653945770298653==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This adds Quectel-specific functionality for initializing and getting
the GPS/NMEA file descriptor.  This is common to both AT and QMI modems
as the GPS functionality needs to be set up via AT commands in both
cases.
---
 Makefile.am                               |   6 +
 drivers/quectelmodem/location-reporting.c | 227 ++++++++++++++++++++++++++=
++++
 drivers/quectelmodem/quectelmodem.c       |  50 +++++++
 drivers/quectelmodem/quectelmodem.h       |  25 ++++
 4 files changed, 308 insertions(+)
 create mode 100644 drivers/quectelmodem/location-reporting.c
 create mode 100644 drivers/quectelmodem/quectelmodem.c
 create mode 100644 drivers/quectelmodem/quectelmodem.h

diff --git a/Makefile.am b/Makefile.am
index 4b68beb..4941b4c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -319,6 +319,12 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/mbmmodem/stk.c \
 			drivers/mbmmodem/location-reporting.c
 =

+builtin_modules +=3D quectelmodem
+builtin_sources +=3D drivers/atmodem/atutil.h \
+			drivers/quectelmodem/quectelmodem.h \
+			drivers/quectelmodem/quectelmodem.c \
+			drivers/quectelmodem/location-reporting.c
+
 builtin_modules +=3D telitmodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/telitmodem/telitmodem.h \
diff --git a/drivers/quectelmodem/location-reporting.c b/drivers/quectelmod=
em/location-reporting.c
new file mode 100644
index 0000000..2ed19cd
--- /dev/null
+++ b/drivers/quectelmodem/location-reporting.c
@@ -0,0 +1,227 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2014  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2017 Jonas Bonn. All rights reserved.
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
+#include "quectelmodem.h"
+
+static const char *none_prefix[] =3D { NULL };
+
+struct gps_data {
+	GAtChat *chat;
+};
+
+static void quectel_gps_disable_cb(gboolean ok, GAtResult *result,
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
+static void quectel_location_reporting_disable(
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
+	if (g_at_chat_send(gd->chat, "AT+QGPSEND", none_prefix,
+				quectel_gps_disable_cb, cbd, g_free) > 0)
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
+static void quectel_gps_enable_cb(gboolean ok, GAtResult *result,
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
+		g_free(cbd);
+		return;
+	}
+
+	fd =3D enable_data_stream(lr);
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
+static void quectel_location_reporting_enable(
+				struct ofono_location_reporting *lr,
+				ofono_location_reporting_enable_cb_t cb,
+				void *data)
+{
+	struct gps_data *gd =3D ofono_location_reporting_get_data(lr);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	DBG("lr=3D%p", lr);
+
+	cbd->user =3D lr;
+
+	if (g_at_chat_send(gd->chat, "AT+QGPS=3D1", none_prefix,
+				quectel_gps_enable_cb, cbd, NULL) > 0)
+		return;
+
+	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
+	g_free(cbd);
+}
+
+static int quectel_location_reporting_probe(
+					struct ofono_location_reporting *lr,
+					unsigned int vendor, void *data)
+{
+	GAtChat *chat =3D data;
+	struct gps_data *gd;
+
+	DBG("");
+
+	gd =3D g_try_new0(struct gps_data, 1);
+	if (gd =3D=3D NULL)
+		return -ENOMEM;
+
+	gd->chat =3D g_at_chat_clone(chat);
+
+	ofono_location_reporting_set_data(lr, gd);
+
+	ofono_location_reporting_register(lr);
+
+	return 0;
+}
+
+static void quectel_location_reporting_remove(
+					struct ofono_location_reporting *lr)
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
+	.name			=3D "quectelmodem",
+	.type			=3D OFONO_LOCATION_REPORTING_TYPE_NMEA,
+	.probe			=3D quectel_location_reporting_probe,
+	.remove			=3D quectel_location_reporting_remove,
+	.enable			=3D quectel_location_reporting_enable,
+	.disable		=3D quectel_location_reporting_disable,
+};
+
+void quectel_location_reporting_init()
+{
+	ofono_location_reporting_driver_register(&driver);
+}
+
+void quectel_location_reporting_exit()
+{
+	ofono_location_reporting_driver_unregister(&driver);
+}
diff --git a/drivers/quectelmodem/quectelmodem.c b/drivers/quectelmodem/que=
ctelmodem.c
new file mode 100644
index 0000000..66cc3f2
--- /dev/null
+++ b/drivers/quectelmodem/quectelmodem.c
@@ -0,0 +1,50 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2017 Jonas Bonn. All rights reserved.
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
+#include "quectelmodem.h"
+
+static int quectelmodem_init(void)
+{
+	quectel_location_reporting_init();
+
+	return 0;
+}
+
+static void quectelmodem_exit(void)
+{
+	quectel_location_reporting_exit();
+}
+
+OFONO_PLUGIN_DEFINE(quectelmodem, "Quectel modem driver", VERSION,
+			OFONO_PLUGIN_PRIORITY_DEFAULT,
+			quectelmodem_init, quectelmodem_exit)
diff --git a/drivers/quectelmodem/quectelmodem.h b/drivers/quectelmodem/que=
ctelmodem.h
new file mode 100644
index 0000000..8a4a9e9
--- /dev/null
+++ b/drivers/quectelmodem/quectelmodem.h
@@ -0,0 +1,25 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2017 Jonas Bonn. All rights reserved.
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
+extern void quectel_location_reporting_init();
+extern void quectel_location_reporting_exit();
-- =

2.9.3


--===============7219653945770298653==--

