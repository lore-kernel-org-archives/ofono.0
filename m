Content-Type: multipart/mixed; boundary="===============4690316061472487014=="
MIME-Version: 1.0
From: Sebastian Arnd <sebastian.arnd@gemalto.com>
Subject: [PATCH] gemalto: add PLS8 support
Date: Wed, 30 Aug 2017 16:27:01 +0200
Message-ID: <1504103221-20448-1-git-send-email-sebastian.arnd@gemalto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4690316061472487014==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am                              |   4 +-
 drivers/atmodem/sim.c                    |  70 ++++-
 drivers/gemaltomodem/gemaltomodem.c      |   3 +
 drivers/gemaltomodem/gemaltomodem.h      |   7 +-
 drivers/gemaltomodem/gprs-context-wwan.c | 436 +++++++++++++++++++++++++++=
++++
 plugins/gemalto.c                        |  82 ++++--
 plugins/udevng.c                         |  15 +-
 7 files changed, 586 insertions(+), 31 deletions(-)
 create mode 100644 drivers/gemaltomodem/gprs-context-wwan.c

diff --git a/Makefile.am b/Makefile.am
index 078e3f1..44d74a2 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -393,8 +393,8 @@ builtin_modules +=3D gemaltomodem
 builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/gemaltomodem/gemaltomodem.h \
 			drivers/gemaltomodem/gemaltomodem.c \
-			drivers/gemaltomodem/location-reporting.c
-
+			drivers/gemaltomodem/location-reporting.c \
+			drivers/gemaltomodem/gprs-context-wwan.c
 =

 if PHONESIM
 builtin_modules +=3D phonesim
diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 7c33c22..17d0be9 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -64,7 +64,7 @@ static const char *pinnum_prefix[] =3D { "%PINNUM:", NULL=
 };
 static const char *oercn_prefix[] =3D { "_OERCN:", NULL };
 static const char *cpinr_prefixes[] =3D { "+CPINR:", "+CPINRE:", NULL };
 static const char *epin_prefix[] =3D { "*EPIN:", NULL };
-static const char *spic_prefix[] =3D { "+SPIC:", NULL };
+static const char *spic_prefix[] =3D { "+SPIC:", "^SPIC:", NULL };
 static const char *pct_prefix[] =3D { "#PCT:", NULL };
 static const char *pnnm_prefix[] =3D { "+PNNM:", NULL };
 static const char *qpinc_prefix[] =3D { "+QPINC:", NULL };
@@ -875,6 +875,62 @@ error:
 	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
 }
 =

+static void at_spic_gemalto_cb(gboolean ok, GAtResult *result,
+							gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_sim_pin_retries_cb_t cb =3D cbd->cb;
+	const char *final =3D g_at_result_final_response(result);
+	GAtResultIter iter;
+	struct ofono_error error;
+	int retries[OFONO_SIM_PASSWORD_INVALID];
+	size_t i;
+	static enum ofono_sim_password_type password_types[] =3D {
+		OFONO_SIM_PASSWORD_SIM_PIN,
+		OFONO_SIM_PASSWORD_SIM_PUK,
+		OFONO_SIM_PASSWORD_PHSIM_PIN,
+		OFONO_SIM_PASSWORD_PHFSIM_PUK,
+		OFONO_SIM_PASSWORD_SIM_PIN2,
+		OFONO_SIM_PASSWORD_SIM_PUK2,
+		OFONO_SIM_PASSWORD_PHNET_PIN,
+		OFONO_SIM_PASSWORD_PHNET_PUK,
+	};
+
+	decode_at_error(&error, final);
+
+	if (!ok) {
+		cb(&error, NULL, cbd->data);
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	for (i =3D 0; i < OFONO_SIM_PASSWORD_INVALID; i++)
+		retries[i] =3D -1;
+
+	for (i =3D 0; i <  ARRAY_SIZE(password_types); i++) {
+		int val;
+
+		if (!g_at_result_iter_next(&iter, "^SPIC:"))
+			goto error;
+
+		if (!g_at_result_iter_next_number(&iter, &val))
+			goto error;
+
+		retries[password_types[i]] =3D val;
+
+		DBG("retry counter id=3D%d, val=3D%d", password_types[i],
+						retries[password_types[i]]);
+	}
+
+	cb(&error, retries, cbd->data);
+
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
+}
+
 #define AT_PCT_SET_RETRIES(retries, pin_type, value) \
 	retries[pin_type] =3D value; \
 	DBG("retry counter id=3D%d, val=3D%d", pin_type, value);
@@ -1104,6 +1160,18 @@ static void at_pin_retries_query(struct ofono_sim *s=
im,
 					at_spic_cb, cbd, g_free) > 0)
 			return;
 		break;
+	case OFONO_VENDOR_CINTERION:
+		if (g_at_chat_send(sd->chat, "AT^SPIC=3D\"SC\",0;"
+					 " ^SPIC=3D\"SC\",1;"
+					 " ^SPIC=3D\"PS\",0;"
+					 " ^SPIC=3D\"PS\",1;"
+					 " ^SPIC=3D\"P2\",0;"
+					 " ^SPIC=3D\"P2\",1;"
+					 " ^SPIC=3D\"PN\",0;"
+					 " ^SPIC=3D\"PN\",1",
+			     spic_prefix, at_spic_gemalto_cb, cbd, g_free) > 0)
+			return;
+		break;
 	case OFONO_VENDOR_TELIT:
 		if (g_at_chat_send(sd->chat, "AT#PCT", pct_prefix,
 					at_pct_cb, cbd, g_free) > 0)
diff --git a/drivers/gemaltomodem/gemaltomodem.c b/drivers/gemaltomodem/gem=
altomodem.c
index 91cf238..01bdb43 100644
--- a/drivers/gemaltomodem/gemaltomodem.c
+++ b/drivers/gemaltomodem/gemaltomodem.c
@@ -35,6 +35,7 @@
 static int gemaltomodem_init(void)
 {
 	gemalto_location_reporting_init();
+	gemaltowwan_gprs_context_init();
 =

 	return 0;
 }
@@ -42,6 +43,8 @@ static int gemaltomodem_init(void)
 static void gemaltomodem_exit(void)
 {
 	gemalto_location_reporting_exit();
+	gemaltowwan_gprs_context_exit();
+
 }
 =

 OFONO_PLUGIN_DEFINE(gemaltomodem, "Gemalto modem driver", VERSION,
diff --git a/drivers/gemaltomodem/gemaltomodem.h b/drivers/gemaltomodem/gem=
altomodem.h
index 7ea1e8f..3ec2380 100644
--- a/drivers/gemaltomodem/gemaltomodem.h
+++ b/drivers/gemaltomodem/gemaltomodem.h
@@ -21,5 +21,8 @@
 =

 #include <drivers/atmodem/atutil.h>
 =

-extern void gemalto_location_reporting_init();
-extern void gemalto_location_reporting_exit();
+extern void gemalto_location_reporting_init(void);
+extern void gemalto_location_reporting_exit(void);
+extern void gemaltowwan_gprs_context_init(void);
+extern void gemaltowwan_gprs_context_exit(void);
+
diff --git a/drivers/gemaltomodem/gprs-context-wwan.c b/drivers/gemaltomode=
m/gprs-context-wwan.c
new file mode 100644
index 0000000..d87e12f
--- /dev/null
+++ b/drivers/gemaltomodem/gprs-context-wwan.c
@@ -0,0 +1,436 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2017 Piotr Haber, Sebastian Arnd. All rights reserved.
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
+
+#include "gemaltomodem.h"
+
+static const char *none_prefix[] =3D { NULL };
+static const char *cgpaddr_prefix[] =3D { "+CGPADDR:", NULL };
+static const char *cgcontrdp_prefix[] =3D { "+CGCONTRDP:", NULL };
+
+enum state {
+	STATE_IDLE,
+	STATE_ENABLING,
+	STATE_DISABLING,
+	STATE_ACTIVE,
+};
+
+enum auth_method {
+	AUTH_METHOD_NONE,
+	AUTH_METHOD_PAP,
+	AUTH_METHOD_CHAP,
+};
+
+struct gprs_context_data {
+	GAtChat *chat;
+	unsigned int active_context;
+	char username[OFONO_GPRS_MAX_USERNAME_LENGTH + 1];
+	char password[OFONO_GPRS_MAX_PASSWORD_LENGTH + 1];
+	enum auth_method auth_method;
+	enum state state;
+	enum ofono_gprs_proto proto;
+	char address[64];
+	char netmask[64];
+	char gateway[64];
+	char dns1[64];
+	char dns2[64];
+	ofono_gprs_context_cb_t cb;
+	void *cb_data;
+};
+
+static void failed_setup(struct ofono_gprs_context *gc,
+				GAtResult *result, gboolean deactivate)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	struct ofono_error error;
+	char buf[64];
+
+	DBG("deactivate %d", deactivate);
+
+	if (deactivate =3D=3D TRUE) {
+		sprintf(buf, "AT^SWWAN=3D0,%u", gcd->active_context);
+		g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL);
+	}
+
+	gcd->active_context =3D 0;
+	gcd->state =3D STATE_IDLE;
+
+	if (result =3D=3D NULL) {
+		CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
+		return;
+	}
+
+	decode_at_error(&error, g_at_result_final_response(result));
+	gcd->cb(&error, gcd->cb_data);
+}
+
+static void contrdp_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	struct ofono_modem *modem;
+	int cid;
+	const char *interface;
+	GAtResultIter iter;
+	gboolean found =3D FALSE;
+
+	DBG("ok %d", ok);
+
+	if (!ok) {
+		ofono_error("Unable to get context dynamic paramerers");
+		failed_setup(gc, result, TRUE);
+		return;
+	}
+
+	/*
+	 * We're not getting any parameters here as all configuration is done
+	 * via dhcp.
+	 */
+
+	g_at_result_iter_init(&iter, result);
+
+	while (g_at_result_iter_next(&iter, "+CGCONTRDP:")) {
+		if (!g_at_result_iter_next_number(&iter, &cid))
+			goto error;
+
+		if ((unsigned int) cid =3D=3D gcd->active_context)
+			found =3D TRUE;
+	}
+
+	if (found =3D=3D FALSE)
+		goto error;
+
+	gcd->state =3D STATE_ACTIVE;
+
+	modem =3D ofono_gprs_context_get_modem(gc);
+	interface =3D ofono_modem_get_string(modem, "NetworkInterface");
+
+	ofono_gprs_context_set_interface(gc, interface);
+	ofono_gprs_context_set_ipv4_address(gc, gcd->address, FALSE);
+
+	CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
+	return;
+
+error:
+	failed_setup(gc, NULL, TRUE);
+}
+
+static void address_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	int cid;
+	const char *address;
+	char buf[64];
+	GAtResultIter iter;
+
+	DBG("ok %d", ok);
+
+	if (!ok) {
+		ofono_error("Unable to get context address");
+		failed_setup(gc, result, TRUE);
+		return;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CGPADDR:"))
+		goto error;
+
+	if (!g_at_result_iter_next_number(&iter, &cid))
+		goto error;
+
+	if ((unsigned int) cid !=3D gcd->active_context)
+		goto error;
+
+	if (!g_at_result_iter_next_string(&iter, &address))
+		goto error;
+
+	strncpy(gcd->address, address, sizeof(gcd->address));
+	sprintf(buf, "AT+CGCONTRDP=3D%d", gcd->active_context);
+
+	if (g_at_chat_send(gcd->chat, buf, cgcontrdp_prefix,
+					contrdp_cb, gc, NULL) > 0)
+		return;
+
+error:
+	failed_setup(gc, NULL, TRUE);
+}
+
+static void activate_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	char buf[64];
+
+	DBG("ok %d", ok);
+
+	if (!ok) {
+		ofono_error("Unable to activate context");
+		failed_setup(gc, result, FALSE);
+		return;
+	}
+
+	sprintf(buf, "AT+CGPADDR=3D%u", gcd->active_context);
+	if (g_at_chat_send(gcd->chat, buf, cgpaddr_prefix,
+					address_cb, gc, NULL) > 0)
+		return;
+
+	failed_setup(gc, NULL, TRUE);
+}
+
+static void setup_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	char buf[384];
+
+	DBG("ok %d", ok);
+
+	if (!ok) {
+		ofono_error("Failed to setup context");
+		failed_setup(gc, result, FALSE);
+		return;
+	}
+
+	if (gcd->username[0] && gcd->password[0])
+		sprintf(buf, "AT^SGAUTH=3D%u,%u,\"%s\",\"%s\"",
+			gcd->active_context, gcd->auth_method,
+			gcd->username, gcd->password);
+	else
+		sprintf(buf, "AT^SGAUTH=3D%u,0", gcd->active_context);
+
+	if (g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL) =3D=3D =
0)
+		goto error;
+
+	sprintf(buf, "AT^SWWAN=3D1,%u", gcd->active_context);
+
+	if (g_at_chat_send(gcd->chat, buf, none_prefix,
+						activate_cb, gc, NULL) > 0)
+		return;
+
+
+error:
+	failed_setup(gc, NULL, FALSE);
+}
+
+static void gemaltowwan_gprs_activate_primary(struct ofono_gprs_context *g=
c,
+				const struct ofono_gprs_primary_context *ctx,
+				ofono_gprs_context_cb_t cb, void *data)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	char buf[OFONO_GPRS_MAX_APN_LENGTH + 128];
+	int len =3D 0;
+
+	DBG("cid %u", ctx->cid);
+
+	gcd->active_context =3D ctx->cid;
+	gcd->cb =3D cb;
+	gcd->cb_data =3D data;
+	memcpy(gcd->username, ctx->username, sizeof(ctx->username));
+	memcpy(gcd->password, ctx->password, sizeof(ctx->password));
+	gcd->state =3D STATE_ENABLING;
+	gcd->proto =3D ctx->proto;
+
+	/* We only support CHAP and PAP */
+	switch (ctx->auth_method) {
+	case OFONO_GPRS_AUTH_METHOD_CHAP:
+		gcd->auth_method =3D AUTH_METHOD_CHAP;
+		break;
+	case OFONO_GPRS_AUTH_METHOD_PAP:
+		gcd->auth_method =3D AUTH_METHOD_PAP;
+		break;
+	default:
+		goto error;
+	}
+
+	switch (ctx->proto) {
+	case OFONO_GPRS_PROTO_IP:
+		len =3D snprintf(buf, sizeof(buf), "AT+CGDCONT=3D%u,\"IP\"",
+								ctx->cid);
+		break;
+	case OFONO_GPRS_PROTO_IPV6:
+		len =3D snprintf(buf, sizeof(buf), "AT+CGDCONT=3D%u,\"IPV6\"",
+								ctx->cid);
+		break;
+	case OFONO_GPRS_PROTO_IPV4V6:
+		len =3D snprintf(buf, sizeof(buf), "AT+CGDCONT=3D%u,\"IPV4V6\"",
+								ctx->cid);
+		break;
+	}
+
+	if (ctx->apn)
+		snprintf(buf + len, sizeof(buf) - len - 3,
+					",\"%s\"", ctx->apn);
+
+	if (g_at_chat_send(gcd->chat, buf, none_prefix,
+				setup_cb, gc, NULL) > 0)
+		return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+
+static void deactivate_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+
+	DBG("ok %d", ok);
+
+	gcd->active_context =3D 0;
+	gcd->state =3D STATE_IDLE;
+
+	CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
+}
+
+static void gemaltowwan_gprs_deactivate_primary(struct ofono_gprs_context =
*gc,
+					unsigned int cid,
+					ofono_gprs_context_cb_t cb, void *data)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	char buf[64];
+
+	DBG("cid %u", cid);
+
+	gcd->state =3D STATE_DISABLING;
+	gcd->cb =3D cb;
+	gcd->cb_data =3D data;
+
+	sprintf(buf, "AT^SWWAN=3D0,%u", gcd->active_context);
+
+	if (g_at_chat_send(gcd->chat, buf, none_prefix,
+				deactivate_cb, gc, NULL) > 0)
+		return;
+
+	CALLBACK_WITH_SUCCESS(cb, data);
+}
+
+static void cgev_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs_context *gc =3D user_data;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	const char *event;
+	int cid;
+	GAtResultIter iter;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CGEV:"))
+		return;
+
+	if (!g_at_result_iter_next_unquoted_string(&iter, &event))
+		return;
+
+	if (!g_str_has_prefix(event, "NW DEACT") &&
+			!g_str_has_prefix(event, "ME DEACT") &&
+			!g_str_has_prefix(event, "PDN DEACT"))
+		return;
+
+	if (!g_at_result_iter_skip_next(&iter))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &cid))
+		return;
+
+	DBG("cid %d", cid);
+
+	if ((unsigned int) cid !=3D gcd->active_context)
+		return;
+
+	ofono_gprs_context_deactivated(gc, gcd->active_context);
+
+	gcd->active_context =3D 0;
+	gcd->state =3D STATE_IDLE;
+}
+
+static int gemaltowwan_gprs_context_probe(struct ofono_gprs_context *gc,
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
+	g_at_chat_register(chat, "+CGEV:", cgev_notify, FALSE, gc, NULL);
+
+	return 0;
+}
+
+static void gemaltowwan_gprs_context_remove(struct ofono_gprs_context *gc)
+{
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+
+	DBG("");
+
+	ofono_gprs_context_set_data(gc, NULL);
+
+	g_at_chat_unref(gcd->chat);
+	g_free(gcd);
+}
+
+static void gemaltowwan_gprs_detach_shutdown(struct ofono_gprs_context *gc,
+					unsigned int cid)
+{
+	ofono_gprs_context_deactivated(gc, cid);
+}
+
+static struct ofono_gprs_context_driver driver =3D {
+	.name			=3D "gemaltowwanmodem",
+	.probe			=3D gemaltowwan_gprs_context_probe,
+	.remove			=3D gemaltowwan_gprs_context_remove,
+	.activate_primary	=3D gemaltowwan_gprs_activate_primary,
+	.deactivate_primary	=3D gemaltowwan_gprs_deactivate_primary,
+	.detach_shutdown	=3D gemaltowwan_gprs_detach_shutdown,
+};
+
+void gemaltowwan_gprs_context_init(void)
+{
+	ofono_gprs_context_driver_register(&driver);
+}
+
+void gemaltowwan_gprs_context_exit(void)
+{
+	ofono_gprs_context_driver_unregister(&driver);
+}
diff --git a/plugins/gemalto.c b/plugins/gemalto.c
index 011713e..dcd8f14 100644
--- a/plugins/gemalto.c
+++ b/plugins/gemalto.c
@@ -67,6 +67,7 @@ struct gemalto_data {
 	GAtChat *mdm;
 	struct ofono_sim *sim;
 	gboolean have_sim;
+	gboolean have_net;
 	struct at_util_sim_state_query *sim_state_query;
 	struct gemalto_hardware_monitor *hm;
 };
@@ -101,18 +102,31 @@ static void gemalto_debug(const char *str, void *user=
_data)
 	ofono_info("%s%s", prefix, str);
 }
 =

-static GAtChat *open_device(const char *device)
+static GAtChat *open_device(const char *device, char *device_debug_name)
 {
 	GAtSyntax *syntax;
 	GIOChannel *channel;
 	GAtChat *chat;
+	GHashTable *options;
 =

 	DBG("Opening device %s", device);
 =

-	channel =3D g_at_tty_open(device, NULL);
+	options =3D g_hash_table_new(g_str_hash, g_str_equal);
+	if (options =3D=3D NULL)
+		return NULL;
+	/*
+	 * The modem does not answer when the "Baud" attibute is missing
+	 * The supplied value is not making any change. But the "Baud"
+	 * paramenter is needed.
+	 */
+	g_hash_table_insert(options, "Baud", "115200");
+
+	channel =3D g_at_tty_open(device, options);
+	g_hash_table_destroy(options);
 	if (channel =3D=3D NULL)
 		return NULL;
 =

+
 	syntax =3D g_at_syntax_new_gsm_permissive();
 	chat =3D g_at_chat_new(channel, syntax);
 	g_at_syntax_unref(syntax);
@@ -121,6 +135,9 @@ static GAtChat *open_device(const char *device)
 	if (chat =3D=3D NULL)
 		return NULL;
 =

+	if (getenv("OFONO_AT_DEBUG"))
+		g_at_chat_set_debug(chat, gemalto_debug, device_debug_name);
+
 	return chat;
 }
 =

@@ -299,47 +316,54 @@ static int gemalto_hardware_monitor_enable(struct ofo=
no_modem *modem)
 	return 0;
 }
 =

+
 static int gemalto_enable(struct ofono_modem *modem)
 {
 	struct gemalto_data *data =3D ofono_modem_get_data(modem);
-	const char *app, *mdm;
+	const char *app, *mdm, *net;
 =

 	DBG("%p", modem);
 =

 	app =3D ofono_modem_get_string(modem, "Application");
 	mdm =3D ofono_modem_get_string(modem, "Modem");
+	net =3D ofono_modem_get_string(modem, "NetworkInterface");
 =

-	if (app =3D=3D NULL || mdm =3D=3D NULL)
+	if (net !=3D NULL)
+		data->have_net =3D TRUE;
+	else
+		data->have_net =3D FALSE;
+
+	if (app =3D=3D NULL || (mdm =3D=3D NULL && !data->have_net))
 		return -EINVAL;
 =

 	/* Open devices */
-	data->app =3D open_device(app);
+	data->app =3D open_device(app, "App");
 	if (data->app =3D=3D NULL)
 		return -EINVAL;
 =

-	data->mdm =3D open_device(mdm);
-	if (data->mdm =3D=3D NULL) {
-		g_at_chat_unref(data->app);
-		data->app =3D NULL;
-		return -EINVAL;
-	}
-
-	if (getenv("OFONO_AT_DEBUG")) {
-		g_at_chat_set_debug(data->app, gemalto_debug, "App");
-		g_at_chat_set_debug(data->mdm, gemalto_debug, "Mdm");
+	/* Mdm device is only requiered when there is no net interface */
+	if (!data->have_net) {
+		data->mdm =3D open_device(mdm, "Mdm");
+		if (data->mdm =3D=3D NULL) {
+			g_at_chat_unref(data->app);
+			data->app =3D NULL;
+			return -EINVAL;
+		}
+		g_at_chat_send(data->mdm, "ATE0", none_prefix,
+						NULL, NULL, NULL);
+		g_at_chat_send(data->mdm, "AT&C0", none_prefix,
+						NULL, NULL, NULL);
 	}
 =

-	g_at_chat_send(data->mdm, "ATE0", none_prefix, NULL, NULL, NULL);
-	g_at_chat_send(data->app, "ATE0 +CMEE=3D1", none_prefix,
-			NULL, NULL, NULL);
-	g_at_chat_send(data->mdm, "AT&C0", none_prefix, NULL, NULL, NULL);
+	g_at_chat_send(data->app, "ATE0", none_prefix, NULL, NULL, NULL);
+	g_at_chat_send(data->app, "AT+CMEE=3D1", none_prefix, NULL, NULL, NULL);
 	g_at_chat_send(data->app, "AT&C0", none_prefix, NULL, NULL, NULL);
-
 	g_at_chat_send(data->app, "AT+CFUN=3D4", none_prefix,
-			cfun_enable, modem, NULL);
+						cfun_enable, modem, NULL);
 =

 	gemalto_hardware_monitor_enable(modem);
 =

+
 	return -EINPROGRESS;
 }
 =

@@ -402,7 +426,8 @@ static void gemalto_set_online(struct ofono_modem *mode=
m, ofono_bool_t online,
 =

 	DBG("modem %p %s", modem, online ? "online" : "offline");
 =

-	if (g_at_chat_send(data->app, command, NULL, set_online_cb, cbd, g_free))
+	if (g_at_chat_send(data->app, command, NULL,
+					set_online_cb, cbd, g_free))
 		return;
 =

 	CALLBACK_WITH_FAILURE(cb, cbd->data);
@@ -419,7 +444,8 @@ static void gemalto_pre_sim(struct ofono_modem *modem)
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->app);
 	ofono_location_reporting_create(modem, 0, "gemaltomodem", data->app);
-	sim =3D ofono_sim_create(modem, 0, "atmodem", data->app);
+	sim =3D ofono_sim_create(modem, OFONO_VENDOR_CINTERION,
+							"atmodem", data->app);
 =

 	if (sim && data->have_sim =3D=3D TRUE)
 		ofono_sim_inserted_notify(sim, TRUE);
@@ -438,7 +464,12 @@ static void gemalto_post_sim(struct ofono_modem *modem)
 	ofono_sms_create(modem, OFONO_VENDOR_CINTERION, "atmodem", data->app);
 =

 	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->app);
-	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->mdm);
+
+	if (data->have_net)
+		gc =3D ofono_gprs_context_create(modem, 0,
+						"gemaltowwanmodem", data->app);
+	else
+		gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->mdm);
 =

 	if (gprs && gc)
 		ofono_gprs_add_context(gprs, gc);
@@ -450,7 +481,8 @@ static void gemalto_post_online(struct ofono_modem *mod=
em)
 =

 	DBG("%p", modem);
 =

-	ofono_netreg_create(modem, OFONO_VENDOR_CINTERION, "atmodem", data->app);
+	ofono_netreg_create(modem, OFONO_VENDOR_CINTERION,
+							"atmodem", data->app);
 }
 =

 static struct ofono_modem_driver gemalto_driver =3D {
diff --git a/plugins/udevng.c b/plugins/udevng.c
index aa28bcb..68c8386 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1080,13 +1080,24 @@ static gboolean setup_gemalto(struct modem_info* mo=
dem)
 				net =3D info->devnode;
 			else if (g_strcmp0(info->subsystem, "usbmisc") =3D=3D 0)
 				qmi =3D info->devnode;
+		} else if (g_strcmp0(info->interface, "2/2/1") =3D=3D 0) {
+			if (g_strcmp0(info->number, "00") =3D=3D 0)
+				mdm =3D info->devnode;
+			else if (g_strcmp0(info->number, "02") =3D=3D 0)
+				app =3D info->devnode;
+			else if (g_strcmp0(info->number, "04") =3D=3D 0)
+				gps =3D info->devnode;
+		} else if (g_strcmp0(info->interface, "2/6/0") =3D=3D 0 &&
+			  g_strcmp0(info->number, "0a") =3D=3D 0) {
+				net =3D info->devnode;
 		}
+
 	}
 =

 	DBG("application=3D%s gps=3D%s modem=3D%s network=3D%s qmi=3D%s",
 			app, gps, mdm, net, qmi);
 =

-	if (app =3D=3D NULL || mdm =3D=3D NULL)
+	if (app =3D=3D NULL || (mdm =3D=3D NULL && net =3D=3D NULL))
 		return FALSE;
 =

 	ofono_modem_set_string(modem->modem, "Application", app);
@@ -1499,6 +1510,8 @@ static struct {
 	{ "gemalto",	"option",	"1e2d",	"0053"	},
 	{ "gemalto",	"cdc_wdm",	"1e2d",	"0053"	},
 	{ "gemalto",	"qmi_wwan",	"1e2d",	"0053"	},
+	{ "gemalto",	"cdc_acm",	"1e2d",	"0061"	},
+	{ "gemalto",	"cdc_ether",	"1e2d",	"0061"	},
 	{ "telit",	"cdc_ncm",	"1bc7", "0036"	},
 	{ "telit",	"cdc_acm",	"1bc7", "0036"	},
 	{ }
-- =

2.1.4


--===============4690316061472487014==--

