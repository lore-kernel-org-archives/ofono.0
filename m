Content-Type: multipart/mixed; boundary="===============3863049818852391496=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH 1/2] Add network time support
Date: Tue, 18 May 2010 19:36:31 +0300
Message-ID: <1274200592-9464-2-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1274200592-9464-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3863049818852391496==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Adding a new notify function in the netreg atom for notifying a
received Network Identification and Timezone (NITZ) indication. This
data is consumed via a nettime plugin, of which there is also an
example.
---
 Makefile.am               |   10 ++--
 include/netreg.h          |    2 +
 include/nettime.h         |   52 +++++++++++++++++++
 include/types.h           |   11 ++++
 plugins/example_nettime.c |   84 +++++++++++++++++++++++++++++++
 src/modem.c               |    1 +
 src/nettime.c             |  121 +++++++++++++++++++++++++++++++++++++++++=
++++
 src/network.c             |   11 ++++
 src/ofono.h               |    8 +++
 9 files changed, 296 insertions(+), 4 deletions(-)
 create mode 100644 include/nettime.h
 create mode 100644 plugins/example_nettime.c
 create mode 100644 src/nettime.c

diff --git a/Makefile.am b/Makefile.am
index 7fd862f..ed13346 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -12,7 +12,8 @@ include_HEADERS =3D include/log.h include/plugin.h includ=
e/history.h \
 			include/netreg.h include/voicecall.h include/devinfo.h \
 			include/cbs.h include/call-volume.h \
 			include/gprs.h include/gprs-context.h \
-			include/radio-settings.h include/stk.h
+			include/radio-settings.h include/stk.h \
+			include/nettime.h
 =

 nodist_include_HEADERS =3D include/version.h
 =

@@ -242,8 +243,8 @@ builtin_sources +=3D plugins/ste.c
 endif
 =

 if MAINTAINER_MODE
-builtin_modules +=3D example_history
-builtin_sources +=3D plugins/example_history.c
+builtin_modules +=3D example_history example_nettime
+builtin_sources +=3D plugins/example_history.c plugins/example_nettime.c
 endif
 =

 sbin_PROGRAMS =3D src/ofonod
@@ -260,7 +261,8 @@ src_ofonod_SOURCES =3D $(gdbus_sources) $(builtin_sourc=
es) \
 			src/simutil.h src/simutil.c src/storage.h \
 			src/storage.c src/cbs.c src/watch.c src/call-volume.c \
 			src/gprs.c src/idmap.h src/idmap.c \
-			src/radio-settings.c src/stkutil.h src/stkutil.c
+			src/radio-settings.c src/stkutil.h src/stkutil.c \
+			src/nettime.c
 =

 src_ofonod_LDADD =3D $(builtin_libadd) @GLIB_LIBS@ @DBUS_LIBS@ @CAPNG_LIBS=
@ -ldl
 =

diff --git a/include/netreg.h b/include/netreg.h
index 0079477..8860960 100644
--- a/include/netreg.h
+++ b/include/netreg.h
@@ -93,6 +93,8 @@ struct ofono_netreg_driver {
 void ofono_netreg_strength_notify(struct ofono_netreg *netreg, int strengt=
h);
 void ofono_netreg_status_notify(struct ofono_netreg *netreg, int status,
 					int lac, int ci, int tech);
+void ofono_netreg_time_notify(struct ofono_netreg *netreg,
+				struct ofono_network_time *info);
 =

 int ofono_netreg_driver_register(const struct ofono_netreg_driver *d);
 void ofono_netreg_driver_unregister(const struct ofono_netreg_driver *d);
diff --git a/include/nettime.h b/include/nettime.h
new file mode 100644
index 0000000..0f23cc7
--- /dev/null
+++ b/include/nettime.h
@@ -0,0 +1,52 @@
+/*
+ *
+ *  oFono - Open Telephony stack for Linux
+ *
+ *  Copyright (C) 2010  Nokia Corporation and/or its subsidiary(-ies).
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
+#ifndef __OFONO_NETTIME_H
+#define __OFONO_NETTIME_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+struct ofono_network_time;
+
+struct ofono_nettime_context {
+	struct ofono_nettime_driver *driver;
+	struct ofono_modem *modem;
+	void *data;
+};
+
+struct ofono_nettime_driver {
+	const char *name;
+	int (*probe)(struct ofono_nettime_context *context);
+	void (*remove)(struct ofono_nettime_context *context);
+	void (*info_received)(struct ofono_nettime_context *context,
+				struct ofono_network_time *info);
+};
+
+int ofono_nettime_driver_register(const struct ofono_nettime_driver *drive=
r);
+void ofono_nettime_driver_unregister(const struct ofono_nettime_driver *dr=
iver);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __OFONO_NETTIME_H */
diff --git a/include/types.h b/include/types.h
index 7b08b8c..2b154f0 100644
--- a/include/types.h
+++ b/include/types.h
@@ -92,6 +92,17 @@ struct ofono_call {
 	int clip_validity;
 };
 =

+struct ofono_network_time {
+	int sec;	/* Seconds [0..59], -1 if unavailable */
+	int min;	/* Minutes [0..59], -1 if unavailable */
+	int hour;	/* Hours [0..23], -1 if unavailable */
+	int mday;	/* Day of month [1..31], -1 if unavailable */
+	int mon;	/* Month [1..12], -1 if unavailable */
+	int year;	/* Current year, -1 if unavailable */
+	int dst;	/* Current adjustment, in seconds */
+	int utcoff;	/* Offset from UTC in seconds */
+};
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/plugins/example_nettime.c b/plugins/example_nettime.c
new file mode 100644
index 0000000..60045be
--- /dev/null
+++ b/plugins/example_nettime.c
@@ -0,0 +1,84 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010  Nokia Corporation and/or its subsidiary(-ies).
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
+#include <glib.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/log.h>
+#include <ofono/nettime.h>
+#include <ofono/types.h>
+
+#include "common.h"
+
+static int example_nettime_probe(struct ofono_nettime_context *context)
+{
+	ofono_debug("Example Network Time Probe for modem: %p",
+			context->modem);
+	return 0;
+}
+
+static void example_nettime_remove(struct ofono_nettime_context *context)
+{
+	ofono_debug("Example Network Time Remove for modem: %p",
+			context->modem);
+}
+
+static void example_nettime_info_received(struct ofono_nettime_context *co=
ntext,
+						struct ofono_network_time *info)
+{
+	if (!info)
+		return;
+
+	ofono_debug("Received a network time notification on modem: %p",
+			context->modem);
+	ofono_debug("Time: %04d-%02d-%02d %02d:%02d:%02d%c%02d:%02d (DST=3D%d)",
+			info->year, info->mon, info->mday, info->hour,
+			info->min, info->sec, info->utcoff > 0 ? '+' : '-',
+			info->utcoff / 3600, (info->utcoff % 3600) / 60,
+			info->dst / 3600);
+}
+
+static struct ofono_nettime_driver example_driver =3D {
+	.name		=3D "Example Network Time",
+	.probe		=3D example_nettime_probe,
+	.remove		=3D example_nettime_remove,
+	.info_received	=3D example_nettime_info_received,
+};
+
+static int example_nettime_init(void)
+{
+	return ofono_nettime_driver_register(&example_driver);
+}
+
+static void example_nettime_exit(void)
+{
+	ofono_nettime_driver_unregister(&example_driver);
+}
+
+OFONO_PLUGIN_DEFINE(example_nettime, "Example Network Time Plugin",
+			VERSION, OFONO_PLUGIN_PRIORITY_DEFAULT,
+			example_nettime_init, example_nettime_exit)
diff --git a/src/modem.c b/src/modem.c
index 0d0cb2a..bf77eb9 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -1147,6 +1147,7 @@ static void modem_sim_ready(void *user, enum ofono_si=
m_state new_state)
 			modem->driver->post_sim(modem);
 =

 		__ofono_history_probe_drivers(modem);
+		__ofono_nettime_probe_drivers(modem);
 	}
 }
 =

diff --git a/src/nettime.c b/src/nettime.c
new file mode 100644
index 0000000..b17e375
--- /dev/null
+++ b/src/nettime.c
@@ -0,0 +1,121 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010  Nokia Corporation and/or its subsidiary(-ies).
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
+#include <stdio.h>
+
+#include <glib.h>
+
+#include "ofono.h"
+
+static GSList *nettime_drivers =3D NULL;
+
+static struct ofono_nettime_context *nettime_context_create(
+					struct ofono_modem *modem,
+					struct ofono_nettime_driver *driver)
+{
+	struct ofono_nettime_context *context;
+
+	if (driver->probe =3D=3D NULL)
+		return NULL;
+
+	context =3D g_try_new0(struct ofono_nettime_context, 1);
+
+	if (context =3D=3D NULL)
+		return NULL;
+
+	context->driver =3D driver;
+	context->modem =3D modem;
+
+	if (driver->probe(context) < 0) {
+		g_free(context);
+		return NULL;
+	}
+
+	return context;
+}
+
+static void context_remove(struct ofono_atom *atom)
+{
+	struct ofono_nettime_context *context =3D __ofono_atom_get_data(atom);
+
+	if (context->driver->remove)
+		context->driver->remove(context);
+
+	g_free(context);
+}
+
+void __ofono_nettime_probe_drivers(struct ofono_modem *modem)
+{
+	struct ofono_nettime_driver *driver;
+	struct ofono_nettime_context *context;
+	GSList *l;
+
+	for (l =3D nettime_drivers; l; l =3D l->next) {
+		driver =3D l->data;
+
+		context =3D nettime_context_create(modem, driver);
+
+		if (!context)
+			continue;
+
+		__ofono_modem_add_atom(modem, OFONO_ATOM_TYPE_NETTIME,
+						context_remove, context);
+	}
+}
+
+static void nettime_info_received(struct ofono_atom *atom, void *data)
+{
+	struct ofono_nettime_context *context =3D __ofono_atom_get_data(atom);
+	struct ofono_network_time *info =3D data;
+
+	if (context->driver->info_received =3D=3D NULL)
+		return;
+
+	context->driver->info_received(context, info);
+}
+
+void __ofono_nettime_info_received(struct ofono_modem *modem,
+					struct ofono_network_time *info)
+{
+	__ofono_modem_foreach_atom(modem, OFONO_ATOM_TYPE_NETTIME,
+					nettime_info_received, info);
+}
+
+int ofono_nettime_driver_register(const struct ofono_nettime_driver *drive=
r)
+{
+	DBG("driver: %p name: %s", driver, driver->name);
+
+	nettime_drivers =3D g_slist_prepend(nettime_drivers, (void *)driver);
+
+	return 0;
+}
+
+void ofono_nettime_driver_unregister(const struct ofono_nettime_driver *dr=
iver)
+{
+	DBG("driver: %p name: %s", driver, driver->name);
+
+	nettime_drivers =3D g_slist_remove(nettime_drivers, driver);
+}
diff --git a/src/network.c b/src/network.c
index b2e5821..87a73e3 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1065,6 +1065,17 @@ void ofono_netreg_status_notify(struct ofono_netreg =
*netreg, int status,
 	notify_status_watches(netreg);
 }
 =

+void ofono_netreg_time_notify(struct ofono_netreg *netreg,
+				struct ofono_network_time *info)
+{
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(netreg->atom);
+
+	if (!info)
+		return;
+
+	__ofono_nettime_info_received(modem, info);
+}
+
 static GSList *compress_operator_list(const struct ofono_network_operator =
*list,
 					int total)
 {
diff --git a/src/ofono.h b/src/ofono.h
index 7b13cce..84b5c23 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -115,6 +115,7 @@ enum ofono_atom_type {
 	OFONO_ATOM_TYPE_GPRS_CONTEXT =3D 17,
 	OFONO_ATOM_TYPE_RADIO_SETTINGS =3D 18,
 	OFONO_ATOM_TYPE_STK =3D 19,
+	OFONO_ATOM_TYPE_NETTIME =3D 20,
 };
 =

 enum ofono_atom_watch_condition {
@@ -264,3 +265,10 @@ struct sms;
 =

 void __ofono_message_waiting_mwi(struct ofono_message_waiting *mw,
 				struct sms *sms, gboolean *out_discard);
+
+#include <ofono/nettime.h>
+
+void __ofono_nettime_probe_drivers(struct ofono_modem *modem);
+
+void __ofono_nettime_info_received(struct ofono_modem * modem,
+					struct ofono_network_time *info);
-- =

1.7.0.4


--===============3863049818852391496==--

