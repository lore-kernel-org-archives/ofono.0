Content-Type: multipart/mixed; boundary="===============3216795413910245086=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [RFC v1] dunmodem: Add support for DUN
Date: Tue, 29 Nov 2011 15:44:09 +0100
Message-ID: <1322577849-12864-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3216795413910245086==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

WIP
---
 Makefile.am                             |    7 +-
 drivers/dunmodem/devinfo.c              |  110 ++++++++
 drivers/dunmodem/dunmodem.c             |    8 +-
 drivers/dunmodem/dunmodem.h             |    8 +-
 drivers/dunmodem/gprs-context.c         |  221 +++++++++++++++
 drivers/dunmodem/gprs.c                 |    8 +-
 drivers/dunmodem/network-registration.c |  126 +++++++++-
 plugins/dun_dt.c                        |  447 +++++++++++++++++++++++++++=
++++
 8 files changed, 924 insertions(+), 11 deletions(-)
 create mode 100644 drivers/dunmodem/devinfo.c
 create mode 100644 drivers/dunmodem/gprs-context.c
 create mode 100644 plugins/dun_dt.c

diff --git a/Makefile.am b/Makefile.am
index 337aeb7..164f790 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -244,7 +244,9 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/dunmodem/dunmodem.h \
 			drivers/dunmodem/dunmodem.c \
 			drivers/dunmodem/network-registration.c \
-			drivers/dunmodem/gprs.c
+			drivers/dunmodem/gprs.c \
+			drivers/dunmodem/gprs-context.c \
+			drivers/dunmodem/devinfo.c
 =

 builtin_modules +=3D hfpmodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
@@ -370,6 +372,9 @@ builtin_sources +=3D plugins/hfp_ag.c plugins/bluetooth=
.h
 builtin_modules +=3D dun_gw
 builtin_sources +=3D plugins/dun_gw.c plugins/bluetooth.h
 =

+builtin_modules +=3D dun_dt
+builtin_sources +=3D plugins/dun_dt.c plugins/bluetooth.h
+
 builtin_modules +=3D sap
 builtin_sources +=3D plugins/sap.c plugins/bluetooth.h
 =

diff --git a/drivers/dunmodem/devinfo.c b/drivers/dunmodem/devinfo.c
new file mode 100644
index 0000000..8798554
--- /dev/null
+++ b/drivers/dunmodem/devinfo.c
@@ -0,0 +1,110 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+#include <string.h>
+
+#include <glib.h>
+#include <gatchat.h>
+#include <gatresult.h>
+
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/devinfo.h>
+
+#include "dunmodem.h"
+
+struct devinfo_data {
+	char *device_address;
+	guint register_source;
+};
+
+static void dun_query_serial(struct ofono_devinfo *info,
+				ofono_devinfo_query_cb_t cb,
+				void *data)
+{
+	struct devinfo_data *dev =3D ofono_devinfo_get_data(info);
+
+	CALLBACK_WITH_SUCCESS(cb, dev->device_address, data);
+}
+
+static gboolean dun_devinfo_register(gpointer user_data)
+{
+	struct ofono_devinfo *info =3D user_data;
+	struct devinfo_data *dd =3D ofono_devinfo_get_data(info);
+
+	dd->register_source =3D 0;
+
+	ofono_devinfo_register(info);
+
+	return FALSE;
+}
+
+static int dun_devinfo_probe(struct ofono_devinfo *info, unsigned int vend=
or,
+				void *user)
+{
+	const char *device_address =3D user;
+	struct devinfo_data *dd;
+
+	dd =3D g_new0(struct devinfo_data, 1);
+	dd->device_address =3D g_strdup(device_address);
+
+	ofono_devinfo_set_data(info, dd);
+
+	dd->register_source =3D g_idle_add(dun_devinfo_register, info);
+	return 0;
+}
+
+static void dun_devinfo_remove(struct ofono_devinfo *info)
+{
+	struct devinfo_data *dd =3D ofono_devinfo_get_data(info);
+
+	ofono_devinfo_set_data(info, NULL);
+	if (dd =3D=3D NULL)
+		return;
+
+	if (dd->register_source !=3D 0)
+		g_source_remove(dd->register_source);
+
+	g_free(dd->device_address);
+	g_free(dd);
+}
+
+static struct ofono_devinfo_driver driver =3D {
+	.name			=3D "dunmodem",
+	.probe			=3D dun_devinfo_probe,
+	.remove			=3D dun_devinfo_remove,
+	.query_serial		=3D dun_query_serial
+};
+
+void dun_devinfo_init(void)
+{
+	ofono_devinfo_driver_register(&driver);
+}
+
+void dun_devinfo_exit(void)
+{
+	ofono_devinfo_driver_unregister(&driver);
+}
diff --git a/drivers/dunmodem/dunmodem.c b/drivers/dunmodem/dunmodem.c
index 35a7dbb..6df345c 100644
--- a/drivers/dunmodem/dunmodem.c
+++ b/drivers/dunmodem/dunmodem.c
@@ -2,7 +2,7 @@
  *
  *  oFono - Open Source Telephony
  *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2011  BMW Car IT GmbH. All rights reserved.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -36,14 +36,18 @@ static int dunmodem_init(void)
 {
 	dun_netreg_init();
 	dun_gprs_init();
+	dun_gprs_context_init();
+	dun_devinfo_init();
 =

 	return 0;
 }
 =

 static void dunmodem_exit(void)
 {
-	dun_netreg_exit();
+	dun_devinfo_exit();
+	dun_gprs_context_exit();
 	dun_gprs_exit();
+	dun_netreg_exit();
 }
 =

 OFONO_PLUGIN_DEFINE(dunmodem, "Dialup modem driver", VERSION,
diff --git a/drivers/dunmodem/dunmodem.h b/drivers/dunmodem/dunmodem.h
index 4fbd4a5..e35d6ae 100644
--- a/drivers/dunmodem/dunmodem.h
+++ b/drivers/dunmodem/dunmodem.h
@@ -2,7 +2,7 @@
  *
  *  oFono - Open Source Telephony
  *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2011  BMW Car IT GbmH. All rights reserved.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -26,3 +26,9 @@ extern void dun_netreg_exit(void);
 =

 extern void dun_gprs_init(void);
 extern void dun_gprs_exit(void);
+
+extern void dun_gprs_context_init(void);
+extern void dun_gprs_context_exit(void);
+
+extern void dun_devinfo_init(void);
+extern void dun_devinfo_exit(void);
diff --git a/drivers/dunmodem/gprs-context.c b/drivers/dunmodem/gprs-contex=
t.c
new file mode 100644
index 0000000..9b4f6c1
--- /dev/null
+++ b/drivers/dunmodem/gprs-context.c
@@ -0,0 +1,221 @@
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
+#include <stdlib.h>
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
+	void *cb_data;
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
+	const char *dns[3] =3D {dns1, dns2, 0};
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
+	/* open ppp */
+	gcd->ppp =3D g_at_ppp_new();
+
+	if (gcd->ppp =3D=3D NULL)
+		return FALSE;
+
+	/* set connect and disconnect callbacks */
+	g_at_ppp_set_connect_function(gcd->ppp, ppp_connect, gc);
+	g_at_ppp_set_disconnect_function(gcd->ppp, ppp_disconnect, gc);
+
+	if (getenv("OFONO_PPP_DEBUG"))
+		g_at_ppp_set_debug(gcd->ppp, dun_debug, "DunModem (PPP):");
+
+	/* open the ppp connection */
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
+
+	DBG("");
+
+	gcd->cb =3D cb;
+	gcd->cb_data =3D data;
+
+	if (g_at_chat_send(gcd->chat, "ATD*99#", NULL,
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
+	if (gcd->ppp) {
+		g_at_ppp_unref(gcd->ppp);
+		g_at_chat_resume(gcd->chat);
+	}
+
+	ofono_gprs_context_set_data(gc, NULL);
+
+	g_at_chat_unref(gcd->chat);
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
diff --git a/drivers/dunmodem/gprs.c b/drivers/dunmodem/gprs.c
index edfe803..77f6f62 100644
--- a/drivers/dunmodem/gprs.c
+++ b/drivers/dunmodem/gprs.c
@@ -29,7 +29,9 @@
 #include <ofono/log.h>
 #include <ofono/modem.h>
 #include <ofono/gprs.h>
+#include <ofono/netreg.h>
 =

+#include "common.h"
 #include "dunmodem.h"
 =

 static void dun_gprs_set_attached(struct ofono_gprs *gprs, int attached,
@@ -44,6 +46,8 @@ static gboolean dun_gprs_finish_registration(gpointer use=
r_data)
 {
 	struct ofono_gprs *gprs =3D user_data;
 =

+	DBG("");
+
 	ofono_gprs_register(gprs);
 =

 	return FALSE;
@@ -68,9 +72,11 @@ static void dun_gprs_attached_status(struct ofono_gprs *=
gprs,
 						ofono_gprs_status_cb_t cb,
 						void *data)
 {
+	int status =3D NETWORK_REGISTRATION_STATUS_REGISTERED;
+
 	DBG("");
 =

-	CALLBACK_WITH_SUCCESS(cb, 1, data);
+	CALLBACK_WITH_SUCCESS(cb, status, data);
 }
 =

 static struct ofono_gprs_driver driver =3D {
diff --git a/drivers/dunmodem/network-registration.c b/drivers/dunmodem/net=
work-registration.c
index df24b5c..35629d9 100644
--- a/drivers/dunmodem/network-registration.c
+++ b/drivers/dunmodem/network-registration.c
@@ -24,6 +24,7 @@
 #endif
 =

 #include <errno.h>
+#include <string.h>
 =

 #include <glib.h>
 #include <gatchat.h>
@@ -32,6 +33,7 @@
 #include <ofono/log.h>
 #include <ofono/modem.h>
 #include <ofono/netreg.h>
+#include <ofono/gprs.h>
 =

 #include "common.h"
 #include "dunmodem.h"
@@ -42,6 +44,17 @@ struct netreg_data {
 	GAtChat *chat;
 };
 =

+static void extract_mcc_mnc(const char *str, char *mcc, char *mnc)
+{
+	/* Three digit country code */
+	strncpy(mcc, str, OFONO_MAX_MCC_LENGTH);
+	mcc[OFONO_MAX_MCC_LENGTH] =3D '\0';
+
+	/* Usually a 2 but sometimes 3 digit network code */
+	strncpy(mnc, str + OFONO_MAX_MCC_LENGTH, OFONO_MAX_MNC_LENGTH);
+	mnc[OFONO_MAX_MNC_LENGTH] =3D '\0';
+}
+
 static void dun_registration_status(struct ofono_netreg *netreg,
 				ofono_netreg_status_cb_t cb, void *data)
 {
@@ -52,26 +65,123 @@ static void dun_registration_status(struct ofono_netre=
g *netreg,
 	CALLBACK_WITH_SUCCESS(cb, status, -1, -1, -1, data);
 }
 =

-static void dun_current_operator(struct ofono_netreg *netreg,
-				ofono_netreg_operator_cb_t cb, void *data)
+static void current_operator_cb(gboolean ok, GAtResult *result,
+				gpointer user_data)
 {
+	struct cb_data *cbd =3D user_data;
+	ofono_netreg_operator_cb_t cb =3D cbd->cb;
 	struct ofono_network_operator op;
+	GAtResultIter iter;
+	struct ofono_error error;
 =

-	DBG("");
+	int status, act, len;
+	const char *l, *s, *n;
+	gboolean have_long =3D FALSE;
+	char mcc[OFONO_MAX_MCC_LENGTH + 1];
+	char mnc[OFONO_MAX_MNC_LENGTH + 1];
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		cb(&error, NULL, cbd->data);
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+COPS:"))
+		goto error;
 =

-	op.name[0] =3D '\0';
 	op.mcc[0] =3D '\0';
 	op.mnc[0] =3D '\0';
-	op.status =3D 2;
 	op.tech =3D -1;
 =

-	CALLBACK_WITH_SUCCESS(cb, &op, data);
+	while (1) {
+		if (!g_at_result_iter_open_list(&iter))
+			break;
+
+		if (!g_at_result_iter_next_number(&iter, &status))
+			goto error;
+
+		op.status =3D status;
+
+		if (!g_at_result_iter_next_string(&iter, &l))
+			goto error;
+
+		if (strlen(l) > 0) {
+			have_long =3D TRUE;
+			strncpy(op.name, l, OFONO_MAX_OPERATOR_NAME_LENGTH);
+		}
+
+		if (!g_at_result_iter_next_string(&iter, &s))
+			goto error;
+
+		if (strlen(s) > 0 && !have_long)
+			strncpy(op.name, s, OFONO_MAX_OPERATOR_NAME_LENGTH);
+
+		op.name[OFONO_MAX_OPERATOR_NAME_LENGTH] =3D '\0';
+
+		if (!g_at_result_iter_next_string(&iter, &n))
+			goto error;
+
+		len =3D strspn(n, "0123456789");
+
+		if (len !=3D 5 && len !=3D 6)
+			goto error;
+
+		extract_mcc_mnc(n, mcc, mnc);
+
+		strncpy(op.mcc, mcc, OFONO_MAX_MCC_LENGTH);
+		op.mcc[OFONO_MAX_MCC_LENGTH] =3D '\0';
+
+		strncpy(op.mnc, mnc, OFONO_MAX_MNC_LENGTH);
+		op.mnc[OFONO_MAX_MNC_LENGTH] =3D '\0';
+
+		if (!g_at_result_iter_next_number(&iter, &act))
+			goto error;
+
+		if (!g_at_result_iter_close_list(&iter))
+			goto error;
+
+		if (op.status =3D=3D 2)
+			break;
+	}
+
+	if (op.status =3D=3D 2)
+		cb(&error, &op, cbd->data);
+	else
+		cb(&error, NULL, cbd->data);
+
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+
+}
+
+static void dun_current_operator(struct ofono_netreg *netreg,
+				ofono_netreg_operator_cb_t cb, void *data)
+{
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	DBG("");
+
+	if (g_at_chat_send(nd->chat, "AT+COPS=3D?", cops_prefix,
+				current_operator_cb, cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+
+	CALLBACK_WITH_FAILURE(cb, NULL, data);
 }
 =

 static void cops_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
 =

+	DBG("");
+
 	if (!ok)
 		return;
 =

@@ -84,6 +194,8 @@ static int dun_netreg_probe(struct ofono_netreg *netreg,
 	GAtChat *chat =3D user_data;
 	struct netreg_data *nd;
 =

+	DBG("");
+
 	nd =3D g_try_new0(struct netreg_data, 1);
 	if (nd =3D=3D NULL)
 		return -ENOMEM;
@@ -102,6 +214,8 @@ static void dun_netreg_remove(struct ofono_netreg *netr=
eg)
 {
 	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
 =

+	DBG("");
+
 	ofono_netreg_set_data(netreg, NULL);
 =

 	g_free(nd);
diff --git a/plugins/dun_dt.c b/plugins/dun_dt.c
new file mode 100644
index 0000000..ef1424c
--- /dev/null
+++ b/plugins/dun_dt.c
@@ -0,0 +1,447 @@
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
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+#include <glib.h>
+#include <gatchat.h>
+#include <gattty.h>
+#include <ofono.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/log.h>
+#include <ofono/modem.h>
+#include <ofono/gprs.h>
+
+#include <drivers/dunmodem/dunmodem.h>
+
+#include <ofono/dbus.h>
+
+#include "bluetooth.h"
+
+#define BLUEZ_SERIAL_INTERFACE BLUEZ_SERVICE ".Serial"
+
+#ifndef DBUS_TYPE_UNIX_FD
+#define DBUS_TYPE_UNIX_FD -1
+#endif
+
+static DBusConnection *connection;
+static GHashTable *modem_hash;
+
+struct dun_data {
+	char *dun_path;
+	char *address;
+	char *tty;
+	GAtChat *chat;
+	DBusPendingCall *call;
+};
+
+static void dun_debug(const char *str, void *data)
+{
+	ofono_info("%s %s", (const char *) data, str);
+}
+
+static int dun_probe(struct ofono_modem *modem)
+{
+	DBG("%p", modem);
+
+	return 0;
+}
+
+static void dun_remove(struct ofono_modem *modem)
+{
+	struct dun_data *data =3D ofono_modem_get_data(modem);
+
+	if (data->call !=3D NULL)
+		dbus_pending_call_cancel(data->call);
+
+	g_hash_table_remove(modem_hash, data->dun_path);
+
+	g_at_chat_unref(data->chat);
+	data->chat =3D NULL;
+
+	g_free(data->dun_path);
+	g_free(data->address);
+	g_free(data->tty);
+	g_free(data->chat);
+	g_free(data);
+
+	ofono_modem_set_data(modem, NULL);
+}
+
+static void dun_disconnected_cb(gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct dun_data *data =3D ofono_modem_get_data(modem);
+
+	DBG("%p", modem);
+
+	ofono_modem_set_powered(modem, FALSE);
+
+	g_at_chat_unref(data->chat);
+	data->chat =3D NULL;
+}
+
+static GAtChat *open_chat(struct dun_data *dd)
+{
+	GIOChannel *io;
+	GAtSyntax *syntax;
+	GAtChat *chat;
+
+	DBG("");
+
+	io =3D g_at_tty_open(dd->tty, NULL);
+	if (io =3D=3D NULL) {
+		ofono_error("Connection failed: %s (%d)",
+				strerror(errno), errno);
+		return NULL;
+	}
+
+	syntax =3D g_at_syntax_new_gsm_permissive();
+	chat =3D g_at_chat_new(io, syntax);
+
+	g_at_syntax_unref(syntax);
+	g_io_channel_unref(io);
+
+	if (getenv("OFONO_AT_DEBUG"))
+		g_at_chat_set_debug(chat, dun_debug, "DunModem");
+
+	return chat;
+}
+
+static void bt_connect_reply(DBusPendingCall *call, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct dun_data *data =3D ofono_modem_get_data(modem);
+	DBusMessage *reply;
+	DBusError derr;
+	char *tty;
+	GAtChat *chat;
+
+	DBG("%p", modem);
+
+	reply =3D dbus_pending_call_steal_reply(call);
+
+	data->call =3D NULL;
+
+	dbus_error_init(&derr);
+	if (dbus_set_error_from_message(&derr, reply)) {
+		DBG("Connection to bt serial returned with error: %s, %s",
+						derr.name, derr.message);
+
+		dbus_error_free(&derr);
+		goto done;
+	}
+
+	dbus_message_get_args(reply, NULL, DBUS_TYPE_STRING, &tty,
+			DBUS_TYPE_INVALID);
+
+	DBG("%p tty %s", modem, tty);
+
+	data->tty =3D g_strdup(tty);
+
+	chat =3D open_chat(data);
+	if (chat =3D=3D NULL)
+		goto done;
+
+	data->chat =3D chat;
+	g_at_chat_set_disconnect_function(data->chat,
+						dun_disconnected_cb, modem);
+
+	ofono_modem_set_powered(modem, TRUE);
+
+done:
+	dbus_message_unref(reply);
+}
+
+static int dun_enable(struct ofono_modem *modem)
+{
+	struct dun_data *data =3D ofono_modem_get_data(modem);
+	DBusPendingCall *call;
+	int status;
+	char *profile =3D "dun";
+
+	DBG("%p", modem);
+
+	status =3D bluetooth_send_with_reply(data->dun_path,
+					BLUEZ_SERIAL_INTERFACE, "Connect",
+					&call, bt_connect_reply,
+					modem, NULL, DBUS_TIMEOUT,
+					DBUS_TYPE_STRING, &profile,
+					DBUS_TYPE_INVALID);
+	if (status < 0)
+		return -EINVAL;
+
+	data->call =3D call;
+
+	return -EINPROGRESS;
+}
+
+static void bt_disconnect_reply(DBusPendingCall *call, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct dun_data *data =3D ofono_modem_get_data(modem);
+	DBusMessage *reply;
+
+	DBG("%p", modem);
+
+	reply =3D dbus_pending_call_steal_reply(call);
+	dbus_message_unref(reply);
+
+	data->call =3D NULL;
+
+	ofono_modem_set_powered(modem, FALSE);
+
+	g_at_chat_unref(data->chat);
+	data->chat =3D NULL;
+
+	g_free(data->tty);
+	data->tty =3D NULL;
+}
+
+static int dun_disable(struct ofono_modem *modem)
+{
+	struct dun_data *data =3D ofono_modem_get_data(modem);
+	DBusPendingCall *call;
+	int status;
+
+	DBG("%p", modem);
+
+	if (data->tty =3D=3D NULL)
+		return 0;
+
+	status =3D bluetooth_send_with_reply(data->dun_path,
+					BLUEZ_SERIAL_INTERFACE, "Disconnect",
+					&call, bt_disconnect_reply,
+					modem, NULL, DBUS_TIMEOUT,
+					DBUS_TYPE_STRING, &data->tty,
+					DBUS_TYPE_INVALID);
+	if (status < 0)
+		return -EINVAL;
+
+	data->call =3D call;
+
+	return -EINPROGRESS;
+}
+
+static void dun_set_online(struct ofono_modem *modem, ofono_bool_t online,
+			ofono_modem_online_cb_t cb, void *data) {
+	DBG("%p online: %d", modem, online);
+
+	CALLBACK_WITH_SUCCESS(cb, data);
+}
+
+static void dun_pre_sim(struct ofono_modem *modem)
+{
+	struct dun_data *data =3D ofono_modem_get_data(modem);
+	struct ofono_gprs *gprs;
+	struct ofono_gprs_context *gc;
+
+	DBG("%p", modem);
+
+	ofono_devinfo_create(modem, 0, "dunmodem", data->address);
+	ofono_netreg_create(modem, 0, "dunmodem", data->chat);
+	gprs =3D ofono_gprs_create(modem, 0, "dunmodem", data->chat);
+	ofono_gprs_set_cid_range(gprs, 1, 1);
+	gc =3D ofono_gprs_context_create(modem, 0, "dunmodem", data->chat);
+
+	if (gprs && gc)
+		ofono_gprs_add_context(gprs, gc);
+}
+
+static void dun_post_online(struct ofono_modem *modem)
+{
+	DBG("%p", modem);
+}
+
+static void dun_post_sim(struct ofono_modem *modem)
+{
+	DBG("%p", modem);
+}
+
+static struct ofono_modem_driver dun_driver =3D {
+	.name		=3D "dun_dt",
+	.probe		=3D dun_probe,
+	.remove		=3D dun_remove,
+	.enable		=3D dun_enable,
+	.disable	=3D dun_disable,
+	.set_online	=3D dun_set_online,
+	.pre_sim	=3D dun_pre_sim,
+	.post_sim	=3D dun_post_sim,
+	.post_online	=3D dun_post_online
+};
+
+static int dun_bt_probe(const char *device, const char *dev_addr,
+				const char *adapter_addr, const char *alias)
+{
+	struct ofono_modem *modem;
+	struct dun_data *data;
+	char buf[256];
+
+	DBG("");
+
+	/* We already have this device in our hash, ignore */
+	if (g_hash_table_lookup(modem_hash, device) !=3D NULL)
+		return -EALREADY;
+
+	ofono_info("Using device: %s, devaddr: %s, adapter: %s",
+			device, dev_addr, adapter_addr);
+
+	strcpy(buf, "dun/");
+	bluetooth_create_path(dev_addr, adapter_addr, buf + 4, sizeof(buf) - 4);
+
+	modem =3D ofono_modem_create(buf, "dun_dt");
+	if (modem =3D=3D NULL) {
+		DBG("Failed to create modem");
+		return -ENOMEM;
+	}
+
+	DBG("modem %p", modem);
+
+	data =3D g_try_new0(struct dun_data, 1);
+	if (data =3D=3D NULL)
+		goto free;
+
+	data->dun_path =3D g_strdup(device);
+	if (data->dun_path =3D=3D NULL)
+		goto free;
+
+	data->address =3D g_strdup(dev_addr);
+	if (data->address =3D=3D NULL)
+		goto free;
+
+	ofono_modem_set_data(modem, data);
+	ofono_modem_set_name(modem, alias);
+	ofono_modem_register(modem);
+
+	g_hash_table_insert(modem_hash, g_strdup(device), modem);
+	return 0;
+
+free:
+	g_free(data->dun_path);
+	data->dun_path =3D NULL;
+	g_free(data);
+	ofono_modem_remove(modem);
+
+	return -ENOMEM;
+}
+
+static gboolean dun_bt_remove_modem(gpointer key, gpointer value,
+				      gpointer user_data)
+{
+	struct ofono_modem *modem =3D value;
+	struct dun_data *data =3D ofono_modem_get_data(modem);
+	const char *device =3D key;
+	const char *prefix =3D user_data;
+
+	DBG("%p", modem);
+
+	if (data->call !=3D NULL)
+		dbus_pending_call_cancel(data->call);
+
+	if (prefix && g_str_has_prefix(device, prefix) =3D=3D FALSE)
+		return FALSE;
+
+	ofono_modem_remove(modem);
+
+	return TRUE;
+}
+
+static void dun_bt_remove(const char *prefix)
+{
+	DBG("%s", prefix);
+
+	if (modem_hash =3D=3D NULL)
+		return;
+
+	g_hash_table_foreach_remove(modem_hash, dun_bt_remove_modem,
+							(gpointer) prefix);
+}
+
+static void dun_bt_set_alias(const char *device, const char *alias)
+{
+	struct ofono_modem *modem;
+
+	DBG("");
+
+	if (device =3D=3D NULL || alias =3D=3D NULL)
+		return;
+
+	modem =3D	g_hash_table_lookup(modem_hash, device);
+	if (modem =3D=3D NULL)
+		return;
+
+	ofono_modem_set_name(modem, alias);
+}
+
+static struct bluetooth_profile dun_profile =3D {
+	.name		=3D "dun_dt",
+	.probe		=3D dun_bt_probe,
+	.remove		=3D dun_bt_remove,
+	.set_alias	=3D dun_bt_set_alias,
+};
+
+static int dun_init(void)
+{
+	int err;
+
+	DBG("");
+
+	if (DBUS_TYPE_UNIX_FD < 0)
+		return -EBADF;
+
+	connection =3D ofono_dbus_get_connection();
+
+	err =3D ofono_modem_driver_register(&dun_driver);
+	if (err < 0)
+		return err;
+
+	err =3D bluetooth_register_uuid(DUN_GW_UUID, &dun_profile);
+	if (err < 0) {
+		ofono_modem_driver_unregister(&dun_driver);
+		return err;
+	}
+
+	modem_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal,
+						g_free, NULL);
+
+	return 0;
+}
+
+static void dun_exit(void)
+{
+	DBG("");
+
+	bluetooth_unregister_uuid(DUN_GW_UUID);
+	ofono_modem_driver_unregister(&dun_driver);
+
+	g_hash_table_destroy(modem_hash);
+}
+
+OFONO_PLUGIN_DEFINE(dun_dt, "Dial-up Networking Data Terminal Profile Plug=
ins",
+			VERSION, OFONO_PLUGIN_PRIORITY_DEFAULT,
+			dun_init, dun_exit)
-- =

1.7.8.rc1.14.g248db


--===============3216795413910245086==--

