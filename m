Content-Type: multipart/mixed; boundary="===============4017766062507923487=="
MIME-Version: 1.0
From: mario@tokarz.eu
Subject: [RFC 1/2] dunmodem: Add stub for gprs-context.
Date: Thu, 04 Aug 2011 18:08:26 +0200
Message-ID: <1312474107-8729-2-git-send-email-mario@tokarz.eu>
In-Reply-To: <1312474107-8729-1-git-send-email-mario@tokarz.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4017766062507923487==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Mario Tokarz <mario.tokarz@bmw-carit.de>

---
 Makefile.am                     |    3 +-
 drivers/dunmodem/dunmodem.c     |    2 +
 drivers/dunmodem/dunmodem.h     |    3 +
 drivers/dunmodem/gprs-context.c |  220 +++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 227 insertions(+), 1 deletions(-)
 create mode 100644 drivers/dunmodem/gprs-context.c

diff --git a/Makefile.am b/Makefile.am
index 9c56711..fbc85d4 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -249,7 +249,8 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/dunmodem/dunmodem.h \
 			drivers/dunmodem/dunmodem.c \
 			drivers/dunmodem/network-registration.c \
-			drivers/dunmodem/gprs.c
+			drivers/dunmodem/gprs.c \
+			drivers/dunmodem/gprs-context.c
 =

 builtin_modules +=3D hfpmodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
diff --git a/drivers/dunmodem/dunmodem.c b/drivers/dunmodem/dunmodem.c
index 35a7dbb..5ed307b 100644
--- a/drivers/dunmodem/dunmodem.c
+++ b/drivers/dunmodem/dunmodem.c
@@ -36,6 +36,7 @@ static int dunmodem_init(void)
 {
 	dun_netreg_init();
 	dun_gprs_init();
+	dun_gprs_context_init();
 =

 	return 0;
 }
@@ -44,6 +45,7 @@ static void dunmodem_exit(void)
 {
 	dun_netreg_exit();
 	dun_gprs_exit();
+	dun_gprs_context_init();
 }
 =

 OFONO_PLUGIN_DEFINE(dunmodem, "Dialup modem driver", VERSION,
diff --git a/drivers/dunmodem/dunmodem.h b/drivers/dunmodem/dunmodem.h
index 4fbd4a5..3bacdad 100644
--- a/drivers/dunmodem/dunmodem.h
+++ b/drivers/dunmodem/dunmodem.h
@@ -26,3 +26,6 @@ extern void dun_netreg_exit(void);
 =

 extern void dun_gprs_init(void);
 extern void dun_gprs_exit(void);
+
+extern void dun_gprs_context_init(void);
+extern void dun_gprs_context_exit(void);
diff --git a/drivers/dunmodem/gprs-context.c b/drivers/dunmodem/gprs-contex=
t.c
new file mode 100644
index 0000000..c5bd182
--- /dev/null
+++ b/drivers/dunmodem/gprs-context.c
@@ -0,0 +1,220 @@
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
+#include <errno.h>
+
+#include <glib.h>
+#include <gatchat.h>
+#include <gatppp.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/gprs-context.h>
+
+#include "dunmodem.h"
+
+#define STATIC_IP_NETMASK "255.255.255.255"
+
+struct gprs_context_data {
+	GAtChat *chat;
+	GAtPPP *ppp;
+	ofono_gprs_context_cb_t cb;
+	void* cb_data;
+};
+
+static void dun_debug(const char *str, void *data)
+{
+	ofono_info("%s: %s", (const char *) data, str);
+}
+
+static void ppp_connect(const char *interface, const char *local,
+			const char *remote,
+			const char *dns1, const char *dns2,
+			gpointer user_data)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	const char* dns[3] =3D {dns1, dns2, 0};
+
+	DBG("gc %p, interface %s, local %s, remote %s, dns1 %s, dns2 %s",
+		gc, interface, local, remote, dns1, dns2);
+
+	ofono_gprs_context_set_interface(gc, interface);
+	ofono_gprs_context_set_ipv4_address(gc, local, TRUE);
+	ofono_gprs_context_set_ipv4_netmask(gc, STATIC_IP_NETMASK);
+	ofono_gprs_context_set_ipv4_dns_servers(gc, dns);
+
+	CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
+}
+
+static void ppp_disconnect(GAtPPPDisconnectReason reason, gpointer user_da=
ta)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+
+	DBG("");
+
+	g_at_ppp_unref(gcd->ppp);
+	gcd->ppp =3D NULL;
+
+	g_at_chat_resume(gcd->chat);
+
+	DBG("Io %p",  g_at_chat_get_io(gcd->chat));
+
+	CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
+}
+
+static gboolean setup_ppp(struct ofono_gprs_context *gc)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	GAtIO *io;
+
+	DBG("");
+
+	io =3D g_at_chat_get_io(gcd->chat);
+
+	g_at_chat_suspend(gcd->chat);
+
+	gcd->ppp =3D g_at_ppp_new();
+	if (gcd->ppp =3D=3D NULL)
+		return FALSE;
+
+	g_at_ppp_set_connect_function(gcd->ppp, ppp_connect, gc);
+	g_at_ppp_set_disconnect_function(gcd->ppp, ppp_disconnect, gc);
+
+	if (TRUE)
+		g_at_ppp_set_debug(gcd->ppp, dun_debug, "DunModem (PPP):");
+
+	g_at_ppp_open(gcd->ppp, io);
+
+	return TRUE;
+}
+
+static void dialup_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+
+	DBG("");
+
+	if (setup_ppp(gc))
+		return;
+
+	CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
+}
+
+static void dun_gprs_activate_primary(struct ofono_gprs_context *gc,
+				const struct ofono_gprs_primary_context *ctx,
+				ofono_gprs_context_cb_t cb, void *data)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	GAtIO *io =3D  g_at_chat_get_io(gcd->chat);
+
+	DBG("");
+
+	gcd->cb =3D cb;
+	gcd->cb_data =3D data;
+
+	DBG("chat %p, Io %p", gcd->chat, io);
+
+	if(g_at_chat_send(gcd->chat, "ATD*99#", NULL,
+				dialup_cb, gc , NULL))
+		return;
+
+	CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
+}
+
+static void dun_gprs_deactivate_primary(struct ofono_gprs_context *gc,
+						unsigned int cid,
+						ofono_gprs_context_cb_t cb,
+						void *data)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+
+	DBG("");
+
+	gcd->cb =3D cb;
+	gcd->cb_data =3D data;
+
+	if (gcd->ppp =3D=3D NULL)
+		return;
+
+	g_at_ppp_shutdown(gcd->ppp);
+}
+
+static int dun_gprs_context_probe(struct ofono_gprs_context *gc,
+					unsigned int vendor, void *data)
+{
+	GAtChat *chat =3D data;
+	struct gprs_context_data *gcd;
+
+	DBG("");
+
+	gcd =3D g_try_new0(struct gprs_context_data, 1);
+	if (gcd =3D=3D NULL)
+		return -ENOMEM;
+
+	gcd->chat =3D g_at_chat_clone(chat);
+
+	ofono_gprs_context_set_data(gc, gcd);
+
+	return 0;
+}
+
+static void dun_gprs_context_remove(struct ofono_gprs_context *gc)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+
+	DBG("%p", gc);
+
+	if (gcd->ppp)
+		g_at_ppp_unref(gcd->ppp);
+
+	g_at_chat_unref(gcd->chat);
+
+	ofono_gprs_context_set_data(gc, NULL);
+
+	g_free(gcd);
+}
+
+static struct ofono_gprs_context_driver driver =3D {
+	.name			=3D "dunmodem",
+	.probe			=3D dun_gprs_context_probe,
+	.remove			=3D dun_gprs_context_remove,
+	.activate_primary	=3D dun_gprs_activate_primary,
+	.deactivate_primary	=3D dun_gprs_deactivate_primary,
+};
+
+void dun_gprs_context_init(void)
+{
+	ofono_gprs_context_driver_register(&driver);
+}
+
+void dun_gprs_context_exit(void)
+{
+	ofono_gprs_context_driver_unregister(&driver);
+}
-- =

1.7.4.1


--===============4017766062507923487==--

