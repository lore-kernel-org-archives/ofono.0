Content-Type: multipart/mixed; boundary="===============3305338810460349824=="
MIME-Version: 1.0
From: Mario Tokarz <mario@tokarz.eu>
Subject: [RFC 1/3] dunmodem: Add baseline for DUN modem driver.
Date: Thu, 07 Jul 2011 10:45:21 +0200
Message-ID: <1310028323-29180-2-git-send-email-mario@tokarz.eu>
In-Reply-To: <1310028323-29180-1-git-send-email-mario@tokarz.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3305338810460349824==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Mario Tokarz <mario.tokarz@bmw-carit.de>

---
 Makefile.am                             |    8 ++
 drivers/dunmodem/dunmodem.c             |   55 ++++++++
 drivers/dunmodem/dunmodem.h             |   39 ++++++
 drivers/dunmodem/gprs-context.c         |  207 +++++++++++++++++++++++++++=
++++
 drivers/dunmodem/gprs.c                 |  101 +++++++++++++++
 drivers/dunmodem/network-registration.c |   96 ++++++++++++++
 6 files changed, 506 insertions(+), 0 deletions(-)
 create mode 100644 drivers/dunmodem/dunmodem.c
 create mode 100644 drivers/dunmodem/dunmodem.h
 create mode 100644 drivers/dunmodem/gprs-context.c
 create mode 100644 drivers/dunmodem/gprs.c
 create mode 100644 drivers/dunmodem/network-registration.c

diff --git a/Makefile.am b/Makefile.am
index ef6196b..c77a793 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -206,6 +206,14 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/calypsomodem/voicecall.c \
 			drivers/calypsomodem/stk.c
 =

+builtin_modules +=3D dunmodem
+builtin_sources +=3D drivers/atmodem/atutil.h \
+			drivers/dunmodem/dunmodem.h \
+			drivers/dunmodem/dunmodem.c \
+			drivers/dunmodem/gprs.c \
+			drivers/dunmodem/gprs-context.c \
+			drivers/dunmodem/network-registration.c
+
 builtin_modules +=3D hfpmodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/hfpmodem/hfpmodem.h \
diff --git a/drivers/dunmodem/dunmodem.c b/drivers/dunmodem/dunmodem.c
new file mode 100644
index 0000000..79c07ec
--- /dev/null
+++ b/drivers/dunmodem/dunmodem.c
@@ -0,0 +1,55 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2011  BMW Car IT GmbH. All rights reserved.
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
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+#include <glib.h>
+#include <gatchat.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/types.h>
+
+#include "dunmodem.h"
+
+static int dunmodem_init(void)
+{
+	dun_dt_netreg_init();
+	dun_dt_gprs_init();
+	dun_dt_gprs_context_init();
+
+	return 0;
+}
+
+static void dunmodem_exit(void)
+{
+	dun_dt_gprs_context_exit();
+	dun_dt_gprs_exit();
+	dun_dt_netreg_exit();
+}
+
+OFONO_PLUGIN_DEFINE(dunmodem, "Dial-up Network Modem Driver", VERSION,
+		OFONO_PLUGIN_PRIORITY_DEFAULT, dunmodem_init, dunmodem_exit)
diff --git a/drivers/dunmodem/dunmodem.h b/drivers/dunmodem/dunmodem.h
new file mode 100644
index 0000000..8802780
--- /dev/null
+++ b/drivers/dunmodem/dunmodem.h
@@ -0,0 +1,39 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2011  BMW Car IT GmbH. All rights reserved.
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
+#include "gatppp.h"
+
+struct dun_data {
+	char *dun_path;
+	char *tty;
+	struct ofono_gprs *gprs;
+	struct ofono_gprs_context *gc;
+};
+
+extern void dun_dt_netreg_init(void);
+extern void dun_dt_netreg_exit(void);
+
+extern void dun_dt_gprs_init(void);
+extern void dun_dt_gprs_exit(void);
+
+extern void dun_dt_gprs_context_init(void);
+extern void dun_dt_gprs_context_exit(void);
diff --git a/drivers/dunmodem/gprs-context.c b/drivers/dunmodem/gprs-contex=
t.c
new file mode 100644
index 0000000..c479153
--- /dev/null
+++ b/drivers/dunmodem/gprs-context.c
@@ -0,0 +1,207 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2011 BMW Car IT GmbH. All rights reserved.
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
+#include <fcntl.h>
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
+#include "gatppp.h"
+#include <gattty.h>
+
+#include "dunmodem.h"
+
+static void ppp_debug(const char *str, void *data)
+{
+	ofono_info("%s: %s", (const char *) data, str);
+}
+
+struct gprs_context_data {
+	char *tty;
+	GIOChannel *channel;
+	GAtPPP *ppp;
+};
+
+static void ppp_connect(const char *interface, const char *local,
+			const char *remote,
+			const char *dns1, const char *dns2,
+			gpointer user_data)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+
+	DBG("PPP connected %p, %s, %s, %s, %s, %s",
+		gc, interface, local, remote, dns1, dns2);
+
+	/* Update configuration here - this is where work continues. */
+}
+
+static void ppp_disconnect(GAtPPPDisconnectReason reason, gpointer user_da=
ta)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+
+	DBG("ppp disconnecting");
+
+	g_at_ppp_unref(gcd->ppp);
+	gcd->ppp =3D NULL;
+}
+
+static gboolean setup_ppp(struct ofono_gprs_context *gc)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	GAtIO *io;
+
+	DBG("");
+
+	gcd->ppp =3D g_at_ppp_new();
+
+	if (gcd->ppp =3D=3D NULL)
+		return FALSE;
+
+	/* Needs to be read from ENV var in final version */
+	g_at_ppp_set_debug(gcd->ppp, ppp_debug, "PPP");
+
+	g_at_ppp_set_connect_function(gcd->ppp, ppp_connect, gc);
+	g_at_ppp_set_disconnect_function(gcd->ppp, ppp_disconnect, gc);
+
+	io =3D g_at_io_new(gcd->channel);
+	if (io =3D=3D NULL)
+		return FALSE;
+
+	DBG("Connection channel %p with io %p", gcd->channel, io);
+	g_at_ppp_open(gcd->ppp, io);
+
+	DBG("PPP is open");
+
+	return TRUE;
+}
+
+static void dun_dt_gprs_activate_primary(struct ofono_gprs_context *gc,
+				const struct ofono_gprs_primary_context *ctx,
+				ofono_gprs_context_cb_t cb, void *data)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	GIOChannel *channel;
+	int fd;
+
+	DBG("tty for connection %s", gcd->tty);
+
+	fd =3D open(gcd->tty, O_RDWR);
+	if (fd < 0)
+		goto error;
+
+	channel =3D g_io_channel_unix_new(fd);
+	DBG("Opened %s as channel %p with fd %d", gcd->tty, channel, fd);
+
+	if (channel =3D=3D NULL)
+		goto error;
+
+	gcd->channel =3D channel;
+
+	setup_ppp(gc);
+
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void dun_dt_gprs_deactivate_primary(struct ofono_gprs_context *gc,
+						unsigned int cid,
+						ofono_gprs_context_cb_t cb,
+						void *data)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+
+	DBG("Disconnect PPP");
+
+	if (gcd->ppp =3D=3D NULL)
+		return;
+
+	g_at_ppp_shutdown(gcd->ppp);
+}
+
+static int dun_dt_gprs_context_probe(struct ofono_gprs_context *gc,
+					unsigned int vendor, void *data)
+{
+	struct dun_data *dd =3D data;
+	struct gprs_context_data *gcd;
+
+	DBG("");
+
+	gcd =3D g_try_new0(struct gprs_context_data, 1);
+	if (gcd =3D=3D NULL)
+		return -ENOMEM;
+
+	ofono_gprs_context_set_data(gc, gcd);
+
+	gcd->tty =3D g_strdup(dd->tty);
+
+	return 0;
+}
+
+static void dun_dt_gprs_context_remove(struct ofono_gprs_context *gc)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+
+	DBG("%p", gc);
+
+	if (gcd->ppp)
+		g_at_ppp_unref(gcd->ppp);
+
+	ofono_gprs_context_set_data(gc, NULL);
+
+	g_free(gcd);
+}
+
+static struct ofono_gprs_context_driver driver =3D {
+	.name			=3D "dunmodem",
+	.probe			=3D dun_dt_gprs_context_probe,
+	.remove		=3D dun_dt_gprs_context_remove,
+	.activate_primary	=3D dun_dt_gprs_activate_primary,
+	.deactivate_primary	=3D dun_dt_gprs_deactivate_primary,
+};
+
+void dun_dt_gprs_context_init(void)
+{
+	ofono_gprs_context_driver_register(&driver);
+}
+
+void dun_dt_gprs_context_exit(void)
+{
+	ofono_gprs_context_driver_unregister(&driver);
+}
diff --git a/drivers/dunmodem/gprs.c b/drivers/dunmodem/gprs.c
new file mode 100644
index 0000000..3fbde1a
--- /dev/null
+++ b/drivers/dunmodem/gprs.c
@@ -0,0 +1,101 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2011  BMW Car IT GmbH. All rights reserved.
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
+#include <ofono/gprs.h>
+
+#include "gatchat.h"
+#include "gatppp.h"
+#include "gatresult.h"
+
+#include "dunmodem.h"
+
+static void dun_dt_gprs_set_attached(struct ofono_gprs *gprs, int attached,
+						ofono_gprs_cb_t cb, void *data)
+{
+	DBG("");
+
+	CALLBACK_WITH_SUCCESS(cb, data);
+}
+
+static gboolean dun_dt_gprs_finish_registration(gpointer user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+
+	ofono_gprs_register(gprs);
+
+	return FALSE;
+}
+
+static int dun_dt_gprs_probe(struct ofono_gprs *gprs,
+					unsigned int vendor, void *data)
+{
+	DBG("");
+
+	g_timeout_add(500, dun_dt_gprs_finish_registration, gprs);
+
+	return 0;
+}
+
+static void dun_dt_gprs_remove(struct ofono_gprs *gprs)
+{
+	DBG("");
+}
+
+static void dun_dt_gprs_attached_status(struct ofono_gprs *gprs,
+						ofono_gprs_status_cb_t cb,
+						void *data)
+{
+	DBG("");
+
+	CALLBACK_WITH_SUCCESS(cb, 1, data);
+}
+
+static struct ofono_gprs_driver driver =3D {
+	.name			=3D "dunmodem",
+	.probe			=3D dun_dt_gprs_probe,
+	.remove		=3D dun_dt_gprs_remove,
+	.set_attached		=3D dun_dt_gprs_set_attached,
+	.attached_status	=3D dun_dt_gprs_attached_status,
+};
+
+void dun_dt_gprs_init(void)
+{
+	ofono_gprs_driver_register(&driver);
+}
+
+void dun_dt_gprs_exit(void)
+{
+	ofono_gprs_driver_unregister(&driver);
+}
diff --git a/drivers/dunmodem/network-registration.c b/drivers/dunmodem/net=
work-registration.c
new file mode 100644
index 0000000..a9acec0
--- /dev/null
+++ b/drivers/dunmodem/network-registration.c
@@ -0,0 +1,96 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2011  BMW Car IT GmbH. All rights reserved.
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
+
+#include <glib.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/netreg.h>
+
+#include "gatchat.h"
+#include "gatppp.h"
+#include "gatresult.h"
+#include "common.h"
+
+#include "dunmodem.h"
+
+static gboolean dun_netreg_register(gpointer user_data)
+{
+	struct ofono_netreg *netreg =3D user_data;
+
+	DBG("");
+
+	ofono_netreg_register(netreg);
+
+	return FALSE;
+}
+
+static int dun_netreg_probe(struct ofono_netreg *netreg, unsigned int vend=
or,
+				void *user_data)
+{
+	struct dun_data *data =3D user_data;
+
+	DBG("%p", data);
+
+	g_idle_add(dun_netreg_register, netreg);
+
+	return 0;
+}
+
+static void dun_netreg_remove(struct ofono_netreg *netreg)
+{
+	DBG("");
+}
+
+static void dun_registration_status(struct ofono_netreg *netreg,
+					ofono_netreg_status_cb_t cb,
+					void *data)
+{
+	DBG("");
+
+	CALLBACK_WITH_SUCCESS(cb, 1, -1, -1, -1, netreg);
+}
+
+static struct ofono_netreg_driver driver =3D {
+	.name				=3D "dunmodem",
+	.probe				=3D dun_netreg_probe,
+	.remove				=3D dun_netreg_remove,
+	.registration_status		=3D dun_registration_status
+};
+
+void dun_dt_netreg_init(void)
+{
+	ofono_netreg_driver_register(&driver);
+}
+
+void dun_dt_netreg_exit(void)
+{
+	ofono_netreg_driver_unregister(&driver);
+}
-- =

1.7.4.1


--===============3305338810460349824==--

