Content-Type: multipart/mixed; boundary="===============0482882300008428772=="
MIME-Version: 1.0
From: Reinhard Speyerer <rspmn@arcor.de>
Subject: Re: [PATCH v2 2/3] gemalto: add PLS8 support
Date: Mon, 04 Sep 2017 15:28:45 +0200
Message-ID: <20170904132709.GA992@arcor.de>
In-Reply-To: <2ff68a0c-9322-eca5-e592-dd615bc0af6c@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0482882300008428772==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis and Sebastian,
please see my comments/suggestions below.

On Wed, Aug 30, 2017 at 02:22:47PM -0500, Denis Kenzior wrote:
> Hi Sebastian,
> =

> On 08/30/2017 11:30 AM, Sebastian Arnd wrote:
> >diff --git a/drivers/gemaltomodem/gemaltomodem.c b/drivers/gemaltomodem/=
gemaltomodem.c
> >index 91cf238..01bdb43 100644
> >--- a/drivers/gemaltomodem/gemaltomodem.c
> >+++ b/drivers/gemaltomodem/gemaltomodem.c
> >@@ -35,6 +35,7 @@
> >  static int gemaltomodem_init(void)
> >  {
> >  	gemalto_location_reporting_init();
> >+	gemaltowwan_gprs_context_init();
> >  	return 0;
> >  }
> >@@ -42,6 +43,8 @@ static int gemaltomodem_init(void)
> >  static void gemaltomodem_exit(void)
> >  {
> >  	gemalto_location_reporting_exit();
> >+	gemaltowwan_gprs_context_exit();
> >+
> =

> No need for this extra empty line
> =

> >  }
> >  OFONO_PLUGIN_DEFINE(gemaltomodem, "Gemalto modem driver", VERSION,
> >diff --git a/drivers/gemaltomodem/gemaltomodem.h b/drivers/gemaltomodem/=
gemaltomodem.h
> >index 7ea1e8f..3ec2380 100644
> >--- a/drivers/gemaltomodem/gemaltomodem.h
> >+++ b/drivers/gemaltomodem/gemaltomodem.h
> >@@ -21,5 +21,8 @@
> >  #include <drivers/atmodem/atutil.h>
> >-extern void gemalto_location_reporting_init();
> >-extern void gemalto_location_reporting_exit();
> >+extern void gemalto_location_reporting_init(void);
> >+extern void gemalto_location_reporting_exit(void);
> >+extern void gemaltowwan_gprs_context_init(void);
> >+extern void gemaltowwan_gprs_context_exit(void);
> >+
> =

> Extra empty line here as well
> =

> >diff --git a/drivers/gemaltomodem/gprs-context-wwan.c b/drivers/gemaltom=
odem/gprs-context-wwan.c
> >new file mode 100644
> >index 0000000..d87e12f
> >--- /dev/null
> >+++ b/drivers/gemaltomodem/gprs-context-wwan.c
> >@@ -0,0 +1,436 @@
> >+/*
> >+ *
> >+ *  oFono - Open Source Telephony
> >+ *
> >+ *  Copyright (C) 2017 Piotr Haber, Sebastian Arnd. All rights reserved.
> >+ *
> >+ *  This program is free software; you can redistribute it and/or modify
> >+ *  it under the terms of the GNU General Public License version 2 as
> >+ *  published by the Free Software Foundation.
> >+ *
> >+ *  This program is distributed in the hope that it will be useful,
> >+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> >+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >+ *  GNU General Public License for more details.
> >+ *
> >+ */
> >+
> >+#ifdef HAVE_CONFIG_H
> >+#include <config.h>
> >+#endif
> >+
> >+#define _GNU_SOURCE
> >+#include <string.h>
> >+#include <stdlib.h>
> >+#include <stdio.h>
> >+#include <errno.h>
> >+#include <sys/stat.h>
> >+
> >+#include <glib.h>
> >+
> >+#include <ofono/log.h>
> >+#include <ofono/modem.h>
> >+#include <ofono/gprs-context.h>
> >+
> >+#include "gatchat.h"
> >+#include "gatresult.h"
> >+
> >+#include "gemaltomodem.h"
> >+
> >+static const char *none_prefix[] =3D { NULL };
> >+static const char *cgpaddr_prefix[] =3D { "+CGPADDR:", NULL };
> >+static const char *cgcontrdp_prefix[] =3D { "+CGCONTRDP:", NULL };
> >+
> >+enum state {
> >+	STATE_IDLE,
> >+	STATE_ENABLING,
> >+	STATE_DISABLING,
> >+	STATE_ACTIVE,
> >+};
> >+
> >+enum auth_method {
> >+	AUTH_METHOD_NONE,
> >+	AUTH_METHOD_PAP,
> >+	AUTH_METHOD_CHAP,
> >+};
> >+
> >+struct gprs_context_data {
> >+	GAtChat *chat;
> >+	unsigned int active_context;
> >+	char username[OFONO_GPRS_MAX_USERNAME_LENGTH + 1];
> >+	char password[OFONO_GPRS_MAX_PASSWORD_LENGTH + 1];
> >+	enum auth_method auth_method;
> >+	enum state state;
> >+	enum ofono_gprs_proto proto;
> >+	char address[64];
> >+	char netmask[64];
> >+	char gateway[64];
> >+	char dns1[64];
> >+	char dns2[64];
> >+	ofono_gprs_context_cb_t cb;
> >+	void *cb_data;
> >+};
> >+
> >+static void failed_setup(struct ofono_gprs_context *gc,
> >+				GAtResult *result, gboolean deactivate)
> >+{
> >+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> >+	struct ofono_error error;
> >+	char buf[64];
> >+
> >+	DBG("deactivate %d", deactivate);
> >+
> >+	if (deactivate =3D=3D TRUE) {
> >+		sprintf(buf, "AT^SWWAN=3D0,%u", gcd->active_context);
> >+		g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL);
> >+	}
> >+
> >+	gcd->active_context =3D 0;
> >+	gcd->state =3D STATE_IDLE;
> >+
> >+	if (result =3D=3D NULL) {
> >+		CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
> >+		return;
> >+	}
> >+
> >+	decode_at_error(&error, g_at_result_final_response(result));
> >+	gcd->cb(&error, gcd->cb_data);
> >+}
> >+
> >+static void contrdp_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
> >+{
> >+	struct ofono_gprs_context *gc =3D user_data;
> >+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> >+	struct ofono_modem *modem;
> >+	int cid;
> >+	const char *interface;
> >+	GAtResultIter iter;
> >+	gboolean found =3D FALSE;
> >+
> >+	DBG("ok %d", ok);
> >+
> >+	if (!ok) {
> >+		ofono_error("Unable to get context dynamic paramerers");
> >+		failed_setup(gc, result, TRUE);
> >+		return;
> >+	}
> >+
> >+	/*
> >+	 * We're not getting any parameters here as all configuration is done
> >+	 * via dhcp.
> >+	 */
> =

> If you want ConnMan to obtain DNS, Netmask, Gateway, etc via DHCP,
> then ofono_gprs_context_set_ipv4_address should not be used.  This
> forces 'IPv4.Method' to be 'dhcp' instead of 'static'.
> =

> Relying on DHCP is fine, but you pay a bit of extra latency.  So if
> your modem provides this info via +CGCONTRDP, I would use that.
> =

> If you do decide to use DHCP only, is calling +CGPADDR & +CGCONTRDP
> even necessary?
> =


Unfortunately the PLS8 seems to need DHCP to be used as a trigger to
pass IPv4 traffic over the network interface even if the parameters
could be obtained from AT commands.

This restriction also holds for some other Qualcomm firmwares when the
QMI network interface is used in Ethernet mode instead of Raw IP mode.

> >+
> >+	g_at_result_iter_init(&iter, result);
> >+
> >+	while (g_at_result_iter_next(&iter, "+CGCONTRDP:")) {
> >+		if (!g_at_result_iter_next_number(&iter, &cid))
> >+			goto error;
> >+
> >+		if ((unsigned int) cid =3D=3D gcd->active_context)
> >+			found =3D TRUE;
> >+	}
> >+
> >+	if (found =3D=3D FALSE)
> >+		goto error;
> >+
> >+	gcd->state =3D STATE_ACTIVE;
> >+
> >+	modem =3D ofono_gprs_context_get_modem(gc);
> >+	interface =3D ofono_modem_get_string(modem, "NetworkInterface");
> >+
> >+	ofono_gprs_context_set_interface(gc, interface);
> >+	ofono_gprs_context_set_ipv4_address(gc, gcd->address, FALSE);
> >+
> >+	CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
> >+	return;
> >+
> >+error:
> >+	failed_setup(gc, NULL, TRUE);
> >+}
> >+
> >+static void address_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
> >+{
> >+	struct ofono_gprs_context *gc =3D user_data;
> >+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> >+	int cid;
> >+	const char *address;
> >+	char buf[64];
> >+	GAtResultIter iter;
> >+
> >+	DBG("ok %d", ok);
> >+
> >+	if (!ok) {
> >+		ofono_error("Unable to get context address");
> >+		failed_setup(gc, result, TRUE);
> >+		return;
> >+	}
> >+
> >+	g_at_result_iter_init(&iter, result);
> >+
> >+	if (!g_at_result_iter_next(&iter, "+CGPADDR:"))
> >+		goto error;
> >+
> >+	if (!g_at_result_iter_next_number(&iter, &cid))
> >+		goto error;
> >+
> >+	if ((unsigned int) cid !=3D gcd->active_context)
> >+		goto error;
> >+
> >+	if (!g_at_result_iter_next_string(&iter, &address))
> >+		goto error;
> >+
> >+	strncpy(gcd->address, address, sizeof(gcd->address));
> >+	sprintf(buf, "AT+CGCONTRDP=3D%d", gcd->active_context);
> >+
> >+	if (g_at_chat_send(gcd->chat, buf, cgcontrdp_prefix,
> >+					contrdp_cb, gc, NULL) > 0)
> >+		return;
> >+
> >+error:
> >+	failed_setup(gc, NULL, TRUE);
> >+}
> >+
> >+static void activate_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
> >+{
> >+	struct ofono_gprs_context *gc =3D user_data;
> >+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> >+	char buf[64];
> >+
> >+	DBG("ok %d", ok);
> >+
> >+	if (!ok) {
> >+		ofono_error("Unable to activate context");
> >+		failed_setup(gc, result, FALSE);
> >+		return;
> >+	}
> >+
> >+	sprintf(buf, "AT+CGPADDR=3D%u", gcd->active_context);
> >+	if (g_at_chat_send(gcd->chat, buf, cgpaddr_prefix,
> >+					address_cb, gc, NULL) > 0)
> >+		return;
> >+
> >+	failed_setup(gc, NULL, TRUE);
> >+}
> >+
> >+static void setup_cb(gboolean ok, GAtResult *result, gpointer user_data)
> >+{
> >+	struct ofono_gprs_context *gc =3D user_data;
> >+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> >+	char buf[384];
> >+
> >+	DBG("ok %d", ok);
> >+
> >+	if (!ok) {
> >+		ofono_error("Failed to setup context");
> >+		failed_setup(gc, result, FALSE);
> >+		return;
> >+	}
> >+
> >+	if (gcd->username[0] && gcd->password[0])
> >+		sprintf(buf, "AT^SGAUTH=3D%u,%u,\"%s\",\"%s\"",
> >+			gcd->active_context, gcd->auth_method,
> >+			gcd->username, gcd->password);
> >+	else
> >+		sprintf(buf, "AT^SGAUTH=3D%u,0", gcd->active_context);
> >+
> >+	if (g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL) =3D=
=3D 0)
> >+		goto error;
> >+
> >+	sprintf(buf, "AT^SWWAN=3D1,%u", gcd->active_context);
> >+
> >+	if (g_at_chat_send(gcd->chat, buf, none_prefix,
> >+						activate_cb, gc, NULL) > 0)
> >+		return;
> >+
> >+
> =

> No double empty lines please
> =

> >+error:
> >+	failed_setup(gc, NULL, FALSE);
> >+}
> >+
> >+static void gemaltowwan_gprs_activate_primary(struct ofono_gprs_context=
 *gc,
> >+				const struct ofono_gprs_primary_context *ctx,
> >+				ofono_gprs_context_cb_t cb, void *data)
> >+{
> >+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> >+	char buf[OFONO_GPRS_MAX_APN_LENGTH + 128];
> >+	int len =3D 0;
> >+
> >+	DBG("cid %u", ctx->cid);
> >+
> >+	gcd->active_context =3D ctx->cid;
> >+	gcd->cb =3D cb;
> >+	gcd->cb_data =3D data;
> >+	memcpy(gcd->username, ctx->username, sizeof(ctx->username));
> >+	memcpy(gcd->password, ctx->password, sizeof(ctx->password));
> >+	gcd->state =3D STATE_ENABLING;
> >+	gcd->proto =3D ctx->proto;
> >+
> >+	/* We only support CHAP and PAP */
> >+	switch (ctx->auth_method) {
> >+	case OFONO_GPRS_AUTH_METHOD_CHAP:
> >+		gcd->auth_method =3D AUTH_METHOD_CHAP;
> >+		break;
> >+	case OFONO_GPRS_AUTH_METHOD_PAP:
> >+		gcd->auth_method =3D AUTH_METHOD_PAP;
> >+		break;
> >+	default:
> >+		goto error;
> >+	}
> >+
> >+	switch (ctx->proto) {
> >+	case OFONO_GPRS_PROTO_IP:
> >+		len =3D snprintf(buf, sizeof(buf), "AT+CGDCONT=3D%u,\"IP\"",
> >+								ctx->cid);
> >+		break;
> >+	case OFONO_GPRS_PROTO_IPV6:
> >+		len =3D snprintf(buf, sizeof(buf), "AT+CGDCONT=3D%u,\"IPV6\"",
> >+								ctx->cid);
> >+		break;
> >+	case OFONO_GPRS_PROTO_IPV4V6:
> >+		len =3D snprintf(buf, sizeof(buf), "AT+CGDCONT=3D%u,\"IPV4V6\"",
> >+								ctx->cid);
> >+		break;
> =

> You don't actually handle IPv6 or dual-stack contexts up above, e.g.
> you only ever set the IPv4 address...

My tests with a PLS8-E running firmware revision 03.017 showed
IPv6/dualstack-related problems. Please refer to
https://developer.gemalto.com/threads/ipv6dualstack-problems-pls8-e-revisio=
n-03017
for details. Perhaps it might make sense to restrict the PLS8 ofono
integration to IPv4 only for the time being until a newer PLS8
firmware becomes available.

Unless I overlooked something the patch also does not seem to handle the
\XX escaping for non-printable characters used by PLS8 with firmware
revision 03.x (and 02.x?) and AT+CSCS=3D"GSM".

Regards,
Reinhard

--===============0482882300008428772==--

