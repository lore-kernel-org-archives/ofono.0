Content-Type: multipart/mixed; boundary="===============4511989127946222170=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] drivers: add support for Telit LE910 V2 modem
Date: Tue, 24 Jan 2017 12:55:17 -0600
Message-ID: <0d2bc051-546f-6c64-885a-7d7ea5501b11@gmail.com>
In-Reply-To: <0ab04ecf-c383-afcb-b3a2-b3e44e338e65@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4511989127946222170==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Piotr,

On 01/24/2017 08:21 AM, Piotr Haber wrote:
> LE910 V2 is next generation Telit LTE modem.
> It supports 3GPP Rel. 9 LTE Cat. 4 over multiple bands.
> Default USB composition uses PID 0x36 and
> consists of 6 CDC-ACM serial ports and 1 CDC-NCM network adapter.
>
> For network interface configuration after context setup
> see doc/telit-modem.txt
> ---
> Changes in v2:
>  - Fix copyright
>  - De-attach before configuring context
>
>  Makefile.am                           |   6 +-
>  doc/telit-modem.txt                   |  28 ++
>  drivers/telitmodem/gprs-context-ncm.c | 497
> ++++++++++++++++++++++++++++++++++
>  drivers/telitmodem/telitmodem.c       |   2 +
>  drivers/telitmodem/telitmodem.h       |   2 +
>  plugins/le910v2.c                     | 400 +++++++++++++++++++++++++++
>  plugins/udevng.c                      |  38 +++

This really needs to be split up into multiple commits:
1. drivers/* changes + related Makefile.am additions
2. le910v2 plugin + related Makefile.am additions
3. one for udevng changes
4. doc changes

See our patch submission guidelines in HACKING

>  7 files changed, 972 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/telitmodem/gprs-context-ncm.c
>  create mode 100644 plugins/le910v2.c
>
> diff --git a/Makefile.am b/Makefile.am
> index f76971ec..72c4fcfc 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -321,7 +321,8 @@ builtin_modules +=3D telitmodem
>  builtin_sources +=3D drivers/atmodem/atutil.h \
>  			drivers/telitmodem/telitmodem.h \
>  			drivers/telitmodem/telitmodem.c \
> -			drivers/telitmodem/location-reporting.c
> +			drivers/telitmodem/location-reporting.c \
> +			drivers/telitmodem/gprs-context-ncm.c
>
>  builtin_modules +=3D hsomodem
>  builtin_sources +=3D drivers/atmodem/atutil.h \
> @@ -500,6 +501,9 @@ builtin_sources +=3D plugins/quectel.c
>  builtin_modules +=3D ublox
>  builtin_sources +=3D plugins/ublox.c
>
> +builtin_modules +=3D le910v2
> +builtin_sources +=3D plugins/le910v2.c
> +
>  if BLUETOOTH
>  if BLUEZ4
>  builtin_modules +=3D telit
> diff --git a/doc/telit-modem.txt b/doc/telit-modem.txt
> index 1627fb4c..b1b968b7 100644
> --- a/doc/telit-modem.txt
> +++ b/doc/telit-modem.txt
> @@ -17,3 +17,31 @@ GPS:
>    After setting the configuration, a power cycle is required.
>    Port Configiuration #8 is available since firmware 12.00.004.
> Firmware version
>    can be checked using 'AT+CGMR'.
> +
> +LE910 V2
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Default USB composition of LE910V2 uses PID 0x36 (AT#PORTCFG=3D0)
> +and consists of 6 serial ports (CDC-ACM standard, /dev/ttyACMx)
> +and 1 network adapter using CDC-NCM standard (wwanx or usbx).
> +
> +NCM interface configuration follows Telit documentation
> +(both documents available on Telit Download Zone - registration required)
> +"GE/HE/UE910, UL865, LE910 V2 Linux USB Driver - User Guide r0"
> +(document 1VV0301255 Rev.0 - 2016-01-22)
> +and "Telit LE910-V2 NCM SETUP r3"
> +(document 1VV0301246 Rev.3 - 2016-11-29).
> +
> +After context is setup, NCM mode activated and PDP context activated
> +connection configuration can be read using
> +AT+CGPADDR=3Dcontext_id and AT+CGCONTRDP=3Dcontext_id commands.
> +This is done automatically and results available via
> +org.ofono.ConnectionContext.GetProperties DBus method.
> +
> +Then Linux network interface needs to be configured:
> +    ifconfig <Interface> <Address> netmask <Netmask> up
> +    route add default gw <Gateway>
> +    arp -s <Gateway> 11:22:33:44:55:66
> +
> +Only after these steps network interface is usable.
> +
> diff --git a/drivers/telitmodem/gprs-context-ncm.c
> b/drivers/telitmodem/gprs-context-ncm.c
> new file mode 100644
> index 00000000..25f93632
> --- /dev/null
> +++ b/drivers/telitmodem/gprs-context-ncm.c
> @@ -0,0 +1,497 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2017 Piotr Haber. All rights reserved.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> 02110-1301  USA
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#define _GNU_SOURCE
> +#include <string.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <errno.h>
> +#include <sys/stat.h>
> +
> +#include <glib.h>
> +
> +#include <ofono/log.h>
> +#include <ofono/modem.h>
> +#include <ofono/gprs-context.h>
> +
> +#include "gatchat.h"
> +#include "gatresult.h"
> +#include "gatrawip.h"
> +
> +#include "telitmodem.h"
> +
> +static const char *none_prefix[] =3D { NULL };
> +static const char *cgpaddr_prefix[] =3D { "+CGPADDR:", NULL };
> +static const char *cgcontrdp_prefix[] =3D { "+CGCONTRDP:", NULL };
> +
> +enum state {
> +	STATE_IDLE,
> +	STATE_ENABLING,
> +	STATE_DISABLING,
> +	STATE_ACTIVE,
> +};
> +
> +enum auth_method {
> +    AUTH_METHOD_NONE,
> +    AUTH_METHOD_PAP,
> +    AUTH_METHOD_CHAP,
> +};
> +
> +struct gprs_context_data {
> +	GAtChat *chat;
> +	unsigned int active_context;
> +	char username[OFONO_GPRS_MAX_USERNAME_LENGTH + 1];
> +	char password[OFONO_GPRS_MAX_PASSWORD_LENGTH + 1];
> +	enum auth_method auth_method;
> +	enum state state;
> +	enum ofono_gprs_proto proto;
> +	char address[64];
> +	char netmask[64];
> +	char gateway[64];
> +	char dns1[64];
> +	char dns2[64];
> +	ofono_gprs_context_cb_t cb;
> +	void *cb_data;                                  /* Callback data */
> +};
> +
> +static void failed_setup(struct ofono_gprs_context *gc,
> +				GAtResult *result, gboolean deactivate)
> +{
> +	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> +	struct ofono_error error;
> +	char buf[64];
> +
> +	DBG("deactivate %d", deactivate);
> +
> +	if (deactivate =3D=3D TRUE) {
> +		sprintf(buf, "AT+CGACT=3D0,%u", gcd->active_context);
> +		g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL);
> +	}
> +
> +	gcd->active_context =3D 0;
> +	gcd->state =3D STATE_IDLE;
> +
> +	if (result =3D=3D NULL) {
> +		CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
> +		return;
> +	}
> +
> +	decode_at_error(&error, g_at_result_final_response(result));
> +	gcd->cb(&error, gcd->cb_data);
> +}
> +
> +static void session_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
> +{
> +	struct ofono_gprs_context *gc =3D user_data;
> +	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> +	struct ofono_modem *modem;
> +	const char *interface;
> +	const char *dns[3];
> +
> +	DBG("ok %d", ok);
> +
> +	if (!ok) {
> +		ofono_error("Failed to establish session");
> +		failed_setup(gc, result, TRUE);
> +		return;
> +	}
> +
> +	gcd->state =3D STATE_ACTIVE;
> +
> +	dns[0] =3D gcd->dns1;
> +	dns[1] =3D gcd->dns2;
> +	dns[2] =3D 0;
> +
> +	modem =3D ofono_gprs_context_get_modem(gc);
> +	interface =3D ofono_modem_get_string(modem, "NetworkInterface");
> +
> +	ofono_gprs_context_set_interface(gc, interface);
> +	ofono_gprs_context_set_ipv4_address(gc, gcd->address, TRUE);
> +	ofono_gprs_context_set_ipv4_netmask(gc, gcd->netmask);
> +	ofono_gprs_context_set_ipv4_gateway(gc, gcd->gateway);
> +	ofono_gprs_context_set_ipv4_dns_servers(gc, dns);
> +
> +	CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
> +	gcd->cb =3D NULL;
> +	gcd->cb_data =3D NULL;
> +}
> +
> +static void contrdp_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
> +{
> +	struct ofono_gprs_context *gc =3D user_data;
> +	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> +	char buf[64];
> +	int cid, bearer_id;
> +	const char *apn, *ip_mask, *gw;
> +	const char *dns1, *dns2;
> +	GAtResultIter iter;
> +	gboolean found =3D FALSE;
> +
> +	DBG("ok %d", ok);
> +
> +	if (!ok) {
> +		ofono_error("Unable to get context dynamic paramerers");
> +		failed_setup(gc, result, TRUE);
> +		return;
> +	}
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	while (g_at_result_iter_next(&iter, "+CGCONTRDP:")) {
> +		if (!g_at_result_iter_next_number(&iter, &cid))
> +			goto error;
> +		if (!g_at_result_iter_next_number(&iter, &bearer_id))
> +			goto error;
> +		if (!g_at_result_iter_next_string(&iter, &apn))
> +			goto error;
> +		if (!g_at_result_iter_next_string(&iter, &ip_mask))
> +			goto error;
> +		if (!g_at_result_iter_next_string(&iter, &gw))
> +			goto error;
> +		if (!g_at_result_iter_next_string(&iter, &dns1))
> +			goto error;
> +		if (!g_at_result_iter_next_string(&iter, &dns2))
> +			goto error;
> +
> +		if ((unsigned int) cid =3D=3D gcd->active_context) {
> +			found =3D TRUE;
> +			if (gcd->address && strcmp(gcd->address, "") !=3D 0) {
> +			    strncpy(gcd->netmask,
> +				    &ip_mask[strlen(gcd->address)+1],
> +				    sizeof(gcd->netmask));
> +			}
> +			strncpy(gcd->gateway, gw, sizeof(gcd->gateway));
> +			strncpy(gcd->dns1, dns1, sizeof(gcd->dns1));
> +			strncpy(gcd->dns2, dns2, sizeof(gcd->dns2));
> +		}
> +	}
> +
> +	if (found =3D=3D FALSE)
> +		goto error;
> +
> +	ofono_info("IP: %s", gcd->address);
> +	ofono_info("MASK: %s", gcd->netmask);
> +	ofono_info("GW: %s", gcd->gateway);
> +	ofono_info("DNS: %s, %s", gcd->dns1, gcd->dns2);
> +
> +	sprintf(buf, "AT+CGDATA=3D\"M-RAW_IP\",%d", gcd->active_context);
> +	if (g_at_chat_send(gcd->chat, buf, none_prefix,
> +					session_cb, gc, NULL) > 0)
> +		return;
> +
> +error:
> +	failed_setup(gc, NULL, TRUE);
> +}
> +
> +static void address_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)

You have contrdp_cb above and a more generic name here.  I'd suggest =

using executed command name as the callback name.  E.g. cgpaddr_cb, =

cgcontrdp_cb, etc.

> +{
> +	struct ofono_gprs_context *gc =3D user_data;
> +	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> +	int cid;
> +	const char *address;
> +	char buf[64];
> +	GAtResultIter iter;
> +
> +	DBG("ok %d", ok);
> +
> +	if (!ok) {
> +		ofono_error("Unable to get context address");
> +		failed_setup(gc, result, TRUE);
> +		return;
> +	}
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "+CGPADDR:"))
> +		goto error;
> +
> +	if (!g_at_result_iter_next_number(&iter, &cid))
> +		goto error;
> +
> +	if ((unsigned int) cid !=3D gcd->active_context)
> +		goto error;
> +
> +	if (!g_at_result_iter_next_string(&iter, &address))
> +		goto error;
> +
> +	strncpy(gcd->address, address, sizeof(gcd->address));
> +
> +	sprintf(buf, "AT+CGCONTRDP=3D%d", gcd->active_context);
> +	if (g_at_chat_send(gcd->chat, buf, cgcontrdp_prefix,
> +					contrdp_cb, gc, NULL) > 0)
> +		return;
> +
> +error:
> +	failed_setup(gc, NULL, TRUE);
> +}
> +
> +static void activate_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
> +{
> +	struct ofono_gprs_context *gc =3D user_data;
> +	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> +	char buf[64];
> +
> +	DBG("ok %d", ok);
> +
> +	if (!ok) {
> +		ofono_error("Unable to activate context");
> +		failed_setup(gc, result, FALSE);
> +		return;
> +	}
> +
> +	sprintf(buf, "AT+CGPADDR=3D%u", gcd->active_context);
> +	if (g_at_chat_send(gcd->chat, buf, cgpaddr_prefix,
> +					address_cb, gc, NULL) > 0)
> +		return;
> +
> +	failed_setup(gc, NULL, TRUE);
> +}
> +
> +static void setup_cb(gboolean ok, GAtResult *result, gpointer user_data)

I'd like a more descriptive callback name.  cgdcont_cb or setup_apn_cb

> +{
> +	struct ofono_gprs_context *gc =3D user_data;
> +	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> +	char buf[128];
> +
> +	DBG("ok %d", ok);
> +
> +	if (!ok) {
> +		ofono_error("Failed to setup context");
> +		failed_setup(gc, result, FALSE);
> +		return;
> +	}
> +
> +	if (gcd->username[0] && gcd->password[0])
> +		sprintf(buf, "AT#PDPAUTH=3D%u,%u,\"%s\",\"%s\"",
> +			gcd->active_context, gcd->auth_method,
> +			gcd->username, gcd->password);
> +	else
> +		sprintf(buf, "AT#PDPAUTH=3D%u,0", gcd->active_context);
> +
> +	if (g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL) =3D=
=3D 0)
> +		goto error;
> +
> +	sprintf(buf, "AT#NCM=3D1,%u", gcd->active_context);
> +
> +	if (g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL) =3D=
=3D 0)
> +		goto error;
> +
> +	sprintf(buf, "AT+CGACT=3D1,%u", gcd->active_context);
> +
> +	if (g_at_chat_send(gcd->chat, buf, none_prefix,
> +				activate_cb, gc, NULL) > 0)
> +		return;
> +
> +error:
> +	failed_setup(gc, NULL, FALSE);
> +}
> +
> +static void telitncm_gprs_activate_primary(struct ofono_gprs_context *gc,
> +				const struct ofono_gprs_primary_context *ctx,
> +				ofono_gprs_context_cb_t cb, void *data)
> +{
> +	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> +	char buf[OFONO_GPRS_MAX_APN_LENGTH + 128];
> +	int len =3D 0;
> +
> +	DBG("cid %u", ctx->cid);
> +
> +	gcd->active_context =3D ctx->cid;
> +	gcd->cb =3D cb;
> +	gcd->cb_data =3D data;
> +	memcpy(gcd->username, ctx->username, sizeof(ctx->username));
> +	memcpy(gcd->password, ctx->password, sizeof(ctx->password));
> +	gcd->state =3D STATE_ENABLING;
> +	gcd->proto =3D ctx->proto;
> +
> +	/* We only support CHAP and PAP */
> +	switch (ctx->auth_method) {
> +	case OFONO_GPRS_AUTH_METHOD_CHAP:
> +		gcd->auth_method =3D AUTH_METHOD_CHAP;
> +		break;
> +	case OFONO_GPRS_AUTH_METHOD_PAP:
> +		gcd->auth_method =3D AUTH_METHOD_PAP;
> +		break;
> +	default:
> +		gcd->auth_method =3D AUTH_METHOD_NONE;
> +		break;

This can be either PAP or CHAP.  Shouldn't this be an error?

> +	}
> +
> +	g_at_chat_send(gcd->chat, "AT+CGATT=3D0", none_prefix, NULL, NULL, NULL=
);
> +
> +	switch (ctx->proto) {
> +	case OFONO_GPRS_PROTO_IP:
> +		len =3D snprintf(buf, sizeof(buf), "AT+CGDCONT=3D%u,\"IP\"",
> +								ctx->cid);
> +		break;
> +	case OFONO_GPRS_PROTO_IPV6:
> +		len =3D snprintf(buf, sizeof(buf), "AT+CGDCONT=3D%u,\"IPV6\"",
> +								ctx->cid);
> +		break;
> +	case OFONO_GPRS_PROTO_IPV4V6:
> +		len =3D snprintf(buf, sizeof(buf), "AT+CGDCONT=3D%u,\"IPV4V6\"",
> +								ctx->cid);
> +		break;
> +	}
> +
> +	if (ctx->apn)
> +		snprintf(buf + len, sizeof(buf) - len - 3,
> +					",\"%s\"", ctx->apn);
> +
> +	if (g_at_chat_send(gcd->chat, buf, none_prefix,
> +				setup_cb, gc, NULL) > 0)
> +		return;
> +
> +	CALLBACK_WITH_FAILURE(cb, data);
> +}
> +
> +static void deactivate_cb(gboolean ok, GAtResult *result, gpointer
> user_data)
> +{
> +	struct ofono_gprs_context *gc =3D user_data;
> +	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> +
> +	DBG("ok %d", ok);
> +
> +	gcd->active_context =3D 0;
> +	gcd->state =3D STATE_IDLE;
> +
> +	CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
> +	gcd->cb =3D NULL;
> +	gcd->cb_data =3D NULL;
> +}
> +
> +static void telitncm_gprs_deactivate_primary(struct ofono_gprs_context *=
gc,
> +					unsigned int cid,
> +					ofono_gprs_context_cb_t cb, void *data)
> +{
> +	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> +	char buf[64];
> +
> +	DBG("cid %u", cid);
> +
> +	gcd->state =3D STATE_DISABLING;
> +	gcd->cb =3D cb;
> +	gcd->cb_data =3D data;
> +
> +	sprintf(buf, "AT+CGACT=3D0,%u", gcd->active_context);
> +	if (g_at_chat_send(gcd->chat, buf, none_prefix,
> +				deactivate_cb, gc, NULL) > 0)
> +		return;
> +
> +	CALLBACK_WITH_SUCCESS(cb, data);
> +	gcd->cb =3D NULL;
> +	gcd->cb_data =3D NULL;
> +}
> +
> +static void cgev_notify(GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_gprs_context *gc =3D user_data;
> +	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> +	const char *event;
> +	int cid;
> +	GAtResultIter iter;
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "+CGEV:"))
> +		return;
> +
> +	if (!g_at_result_iter_next_unquoted_string(&iter, &event))
> +		return;
> +
> +	if (g_str_has_prefix(event, "NW DEACT") =3D=3D FALSE)
> +		return;
> +
> +	if (!g_at_result_iter_skip_next(&iter))
> +		return;
> +
> +	if (!g_at_result_iter_next_number(&iter, &cid))
> +		return;
> +
> +	DBG("cid %d", cid);
> +
> +	if ((unsigned int) cid !=3D gcd->active_context)
> +		return;
> +
> +

No double empty lines

> +	ofono_gprs_context_deactivated(gc, gcd->active_context);
> +
> +	gcd->active_context =3D 0;
> +	gcd->state =3D STATE_IDLE;
> +

No empty lines at end of functions please

> +}
> +
> +static int telitncm_gprs_context_probe(struct ofono_gprs_context *gc,
> +					unsigned int vendor, void *data)
> +{
> +	GAtChat *chat =3D data;
> +	struct gprs_context_data *gcd;
> +
> +	DBG("");
> +
> +	gcd =3D g_try_new0(struct gprs_context_data, 1);
> +	if (gcd =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	gcd->chat =3D g_at_chat_clone(chat);
> +
> +	ofono_gprs_context_set_data(gc, gcd);
> +
> +	chat =3D g_at_chat_get_slave(gcd->chat);

This slave business is only needed for PPP.  Strictly speaking you just =

need a single GAtChat / AT command port to drive this in NCM mode.

> +
> +	g_at_chat_register(chat, "+CGEV:", cgev_notify, FALSE, gc, NULL);
> +
> +	return 0;
> +}
> +
> +static void telitncm_gprs_context_remove(struct ofono_gprs_context *gc)
> +{
> +	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> +
> +	DBG("");
> +
> +	ofono_gprs_context_set_data(gc, NULL);
> +
> +	g_at_chat_unref(gcd->chat);
> +	g_free(gcd);
> +}
> +
> +static struct ofono_gprs_context_driver driver =3D {
> +	.name			=3D "telitncmmodem",
> +	.probe			=3D telitncm_gprs_context_probe,
> +	.remove			=3D telitncm_gprs_context_remove,
> +	.activate_primary	=3D telitncm_gprs_activate_primary,
> +	.deactivate_primary	=3D telitncm_gprs_deactivate_primary,
> +};
> +
> +void telitncm_gprs_context_init(void)
> +{
> +	ofono_gprs_context_driver_register(&driver);
> +}
> +
> +void telitncm_gprs_context_exit(void)
> +{
> +	ofono_gprs_context_driver_unregister(&driver);
> +}
> diff --git a/drivers/telitmodem/telitmodem.c
> b/drivers/telitmodem/telitmodem.c
> index ecb84efb..4aa2c444 100644
> --- a/drivers/telitmodem/telitmodem.c
> +++ b/drivers/telitmodem/telitmodem.c
> @@ -35,6 +35,7 @@
>  static int telitmodem_init(void)
>  {
>  	telit_location_reporting_init();
> +	telitncm_gprs_context_init();
>
>  	return 0;
>  }
> @@ -42,6 +43,7 @@ static int telitmodem_init(void)
>  static void telitmodem_exit(void)
>  {
>  	telit_location_reporting_exit();
> +	telitncm_gprs_context_exit();
>  }
>
>  OFONO_PLUGIN_DEFINE(telitmodem, "Telit modem driver", VERSION,
> diff --git a/drivers/telitmodem/telitmodem.h
> b/drivers/telitmodem/telitmodem.h
> index 2db41787..8a14595a 100644
> --- a/drivers/telitmodem/telitmodem.h
> +++ b/drivers/telitmodem/telitmodem.h
> @@ -23,3 +23,5 @@
>
>  extern void telit_location_reporting_init();
>  extern void telit_location_reporting_exit();
> +extern void telitncm_gprs_context_init();
> +extern void telitncm_gprs_context_exit();
> diff --git a/plugins/le910v2.c b/plugins/le910v2.c
> new file mode 100644
> index 00000000..e758971d
> --- /dev/null
> +++ b/plugins/le910v2.c
> @@ -0,0 +1,400 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2017 Piotr Haber. All rights reserved.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> 02110-1301  USA
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <errno.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <termios.h>
> +#include <string.h>
> +#include <sys/socket.h>
> +
> +#include <glib.h>
> +#include <gatchat.h>
> +#include <gattty.h>
> +
> +#define OFONO_API_SUBJECT_TO_CHANGE
> +#include <ofono/plugin.h>
> +#include <ofono/log.h>
> +#include <ofono/modem.h>
> +#include <ofono/call-barring.h>
> +#include <ofono/call-forwarding.h>
> +#include <ofono/call-meter.h>
> +#include <ofono/call-settings.h>
> +#include <ofono/devinfo.h>
> +#include <ofono/message-waiting.h>
> +#include <ofono/location-reporting.h>
> +#include <ofono/netreg.h>
> +#include <ofono/phonebook.h>
> +#include <ofono/sim.h>
> +#include <ofono/gprs.h>
> +#include <ofono/gprs-context.h>
> +#include <ofono/sms.h>
> +#include <ofono/ussd.h>
> +#include <ofono/voicecall.h>
> +
> +#include <drivers/atmodem/atutil.h>
> +#include <drivers/atmodem/vendor.h>
> +
> +static const char *none_prefix[] =3D { NULL };
> +static const char *qss_prefix[] =3D { "#QSS:", NULL };
> +
> +struct le910v2_data {
> +	GAtChat *chat;		/* AT chat */
> +	GAtChat *modem;		/* Data port */
> +	struct ofono_sim *sim;
> +	ofono_bool_t have_sim;
> +	ofono_bool_t sms_phonebook_added;
> +};
> +

This looks like a fairly close copy of the he910 plugin.  Can these two =

be combined?

> +static void le910v2_debug(const char *str, void *user_data)
> +{
> +	const char *prefix =3D user_data;
> +
> +	ofono_info("%s%s", prefix, str);
> +}
> +
> +static GAtChat *open_device(struct ofono_modem *modem,
> +				const char *key, char *debug)
> +{
> +	const char *device;
> +	GAtSyntax *syntax;
> +	GIOChannel *channel;
> +	GAtChat *chat;
> +	GHashTable *options;
> +
> +	device =3D ofono_modem_get_string(modem, key);
> +	if (device =3D=3D NULL)
> +		return NULL;
> +
> +	DBG("%s %s", key, device);
> +
> +	options =3D g_hash_table_new(g_str_hash, g_str_equal);
> +	if (options =3D=3D NULL)
> +		return NULL;
> +
> +	g_hash_table_insert(options, "Baud", "115200");
> +	channel =3D g_at_tty_open(device, options);
> +	g_hash_table_destroy(options);
> +
> +	if (channel =3D=3D NULL)
> +		return NULL;
> +
> +	syntax =3D g_at_syntax_new_gsm_permissive();
> +	chat =3D g_at_chat_new(channel, syntax);
> +	g_at_syntax_unref(syntax);
> +	g_io_channel_unref(channel);
> +
> +	if (chat =3D=3D NULL)
> +		return NULL;
> +
> +	if (getenv("OFONO_AT_DEBUG"))
> +		g_at_chat_set_debug(chat, le910v2_debug, debug);
> +
> +	return chat;
> +}
> +
> +static void switch_sim_state_status(struct ofono_modem *modem, int statu=
s)
> +{
> +	struct le910v2_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p, SIM status: %d", modem, status);
> +
> +	switch (status) {
> +	case 0:	/* SIM not inserted */
> +		if (data->have_sim =3D=3D TRUE) {
> +			ofono_sim_inserted_notify(data->sim, FALSE);
> +			data->have_sim =3D FALSE;
> +			data->sms_phonebook_added =3D FALSE;
> +		}
> +		break;
> +	case 1:	/* SIM inserted */
> +	case 2:	/* SIM inserted and PIN unlocked */
> +		if (data->have_sim =3D=3D FALSE) {
> +			ofono_sim_inserted_notify(data->sim, TRUE);
> +			data->have_sim =3D TRUE;
> +		}
> +		break;
> +	case 3:	/* SIM inserted, SMS and phonebook ready */
> +		if (data->have_sim =3D=3D FALSE) {
> +			ofono_sim_inserted_notify(data->sim, TRUE);
> +			data->have_sim =3D TRUE;
> +		}
> +		if (data->sms_phonebook_added =3D=3D FALSE) {
> +			ofono_phonebook_create(modem, 0, "atmodem", data->chat);
> +			ofono_sms_create(modem, 0, "atmodem", data->chat);
> +			data->sms_phonebook_added =3D TRUE;
> +		}
> +		break;
> +	default:
> +		ofono_warn("Unknown SIM state %d received", status);
> +		break;
> +	}
> +}
> +
> +static void le910v2_qss_notify(GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	int status;
> +	GAtResultIter iter;
> +
> +	DBG("%p", modem);
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "#QSS:"))
> +		return;
> +
> +	g_at_result_iter_next_number(&iter, &status);
> +
> +	switch_sim_state_status(modem, status);
> +}
> +
> +static void qss_query_cb(gboolean ok, GAtResult *result, gpointer
> user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	int status, mode;
> +	GAtResultIter iter;
> +
> +	DBG("%p", modem);
> +
> +	if (!ok)
> +		return;
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "#QSS:"))
> +		return;
> +
> +	if (!g_at_result_iter_next_number(&iter, &mode))
> +		return;
> +
> +	if (!g_at_result_iter_next_number(&iter, &status))
> +		return;
> +
> +	switch_sim_state_status(modem, status);
> +}
> +
> +static void cfun_enable_cb(gboolean ok, GAtResult *result, gpointer
> user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct le910v2_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	if (!ok) {
> +		g_at_chat_unref(data->chat);
> +		data->chat =3D NULL;
> +
> +		g_at_chat_unref(data->modem);
> +		data->modem =3D NULL;
> +
> +		ofono_modem_set_powered(modem, FALSE);
> +		return;
> +	}
> +
> +	/*
> +	 * Switch data carrier detect signal off.
> +	 * When the DCD is disabled the modem does not hangup anymore
> +	 * after the data connection.
> +	 */
> +	g_at_chat_send(data->chat, "AT&C0", NULL, NULL, NULL, NULL);
> +
> +	data->have_sim =3D FALSE;
> +	data->sms_phonebook_added =3D FALSE;
> +
> +	ofono_modem_set_powered(modem, TRUE);
> +
> +	/*
> +	 * Tell the modem not to automatically initiate auto-attach
> +	 * proceedures on its own.
> +	 */
> +	g_at_chat_send(data->chat, "AT#AUTOATT=3D0", none_prefix,
> +				NULL, NULL, NULL);
> +
> +	/* Follow sim state */
> +	g_at_chat_register(data->chat, "#QSS:", le910v2_qss_notify,
> +				FALSE, modem, NULL);
> +
> +	/* Enable sim state notification */
> +	g_at_chat_send(data->chat, "AT#QSS=3D2", none_prefix, NULL, NULL, NULL);
> +
> +	g_at_chat_send(data->chat, "AT#QSS?", qss_prefix,
> +			qss_query_cb, modem, NULL);
> +}
> +
> +static int le910v2_enable(struct ofono_modem *modem)
> +{
> +	struct le910v2_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	data->modem =3D open_device(modem, "Modem", "Modem: ");
> +	if (data->modem =3D=3D NULL)
> +		return -EINVAL;
> +
> +	data->chat =3D open_device(modem, "Aux", "Aux: ");
> +	if (data->chat =3D=3D NULL) {
> +		g_at_chat_unref(data->modem);
> +		data->modem =3D NULL;
> +		return -EIO;
> +	}
> +
> +	/*
> +	 * Disable command echo and
> +	 * enable the Extended Error Result Codes
> +	 */
> +	g_at_chat_send(data->chat, "ATE0 +CMEE=3D1", none_prefix,
> +				NULL, NULL, NULL);
> +
> +	g_at_chat_send(data->modem, "ATE0", none_prefix,
> +				NULL, NULL, NULL);
> +
> +	/* Set phone functionality */
> +	g_at_chat_send(data->chat, "AT+CFUN=3D1", none_prefix,
> +				cfun_enable_cb, modem, NULL);
> +
> +	return -EINPROGRESS;
> +}
> +
> +static void cfun_disable_cb(gboolean ok, GAtResult *result, gpointer
> user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct le910v2_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	g_at_chat_unref(data->chat);
> +	data->chat =3D NULL;
> +
> +	if (ok)
> +		ofono_modem_set_powered(modem, FALSE);
> +}
> +
> +static int le910v2_disable(struct ofono_modem *modem)
> +{
> +	struct le910v2_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	g_at_chat_cancel_all(data->modem);
> +	g_at_chat_unregister_all(data->modem);
> +	g_at_chat_unref(data->modem);
> +	data->modem =3D NULL;
> +
> +	g_at_chat_cancel_all(data->chat);
> +	g_at_chat_unregister_all(data->chat);
> +
> +	/* Power down modem */
> +	g_at_chat_send(data->chat, "AT+CFUN=3D4", none_prefix,
> +				cfun_disable_cb, modem, NULL);
> +
> +	return -EINPROGRESS;
> +}
> +
> +static void le910v2_pre_sim(struct ofono_modem *modem)
> +{
> +	struct le910v2_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	ofono_devinfo_create(modem, 0, "atmodem", data->chat);
> +	data->sim =3D ofono_sim_create(modem, OFONO_VENDOR_TELIT, "atmodem",
> +					data->chat);
> +}
> +
> +static void le910v2_post_online(struct ofono_modem *modem)
> +{
> +	struct le910v2_data *data =3D ofono_modem_get_data(modem);
> +	struct ofono_gprs *gprs;
> +	struct ofono_gprs_context *gc;
> +
> +	DBG("%p", modem);
> +
> +	ofono_netreg_create(modem, OFONO_VENDOR_TELIT, "atmodem", data->chat);
> +	gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_TELIT, "atmodem",
> +					data->chat);
> +	gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_TELIT, "telitncmmo=
dem",
> +					data->modem);
> +

Only the GPRS context driver seems to be different from the HE910, =

right?  Can we handle this with an attribute of some sort.

E.g. if (ofono_modem_get_string(modem, "NetworkInterface") !=3D NULL)

> +	if (gprs && gc)
> +		ofono_gprs_add_context(gprs, gc);
> +}
> +
> +static int le910v2_probe(struct ofono_modem *modem)
> +{
> +	struct le910v2_data *data;
> +
> +	DBG("%p", modem);
> +
> +	data =3D g_try_new0(struct le910v2_data, 1);
> +	if (data =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	ofono_modem_set_data(modem, data);
> +
> +	return 0;
> +}
> +
> +static void le910v2_remove(struct ofono_modem *modem)
> +{
> +	struct le910v2_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	ofono_modem_set_data(modem, NULL);
> +
> +	/* Cleanup after hot-unplug */
> +	g_at_chat_unref(data->chat);
> +	g_at_chat_unref(data->modem);
> +
> +	g_free(data);
> +}
> +
> +static struct ofono_modem_driver le910v2_driver =3D {
> +	.name		=3D "le910v2",
> +	.probe		=3D le910v2_probe,
> +	.remove		=3D le910v2_remove,
> +	.enable		=3D le910v2_enable,
> +	.disable	=3D le910v2_disable,
> +	.pre_sim	=3D le910v2_pre_sim,
> +	.post_online	=3D le910v2_post_online,
> +};
> +
> +static int le910v2_init(void)
> +{
> +	DBG("");
> +
> +	return ofono_modem_driver_register(&le910v2_driver);
> +}
> +
> +static void le910v2_exit(void)
> +{
> +	ofono_modem_driver_unregister(&le910v2_driver);
> +}
> +
> +OFONO_PLUGIN_DEFINE(le910v2, "Telit LE910 V2 driver", VERSION,
> +		OFONO_PLUGIN_PRIORITY_DEFAULT, le910v2_init, le910v2_exit)
> diff --git a/plugins/udevng.c b/plugins/udevng.c
> index 50089129..90ddeeab 100644
> --- a/plugins/udevng.c
> +++ b/plugins/udevng.c
> @@ -957,6 +957,41 @@ static gboolean setup_gemalto(struct modem_info* mod=
em)
>  	return TRUE;
>  }
>
> +static gboolean setup_le910v2(struct modem_info *modem)
> +{
> +	const char *aux =3D NULL, *mdm =3D NULL, *network =3D NULL;
> +	GSList *list;
> +
> +	DBG("%s", modem->syspath);
> +
> +	for (list =3D modem->devices; list; list =3D list->next) {
> +		struct device_info *info =3D list->data;
> +
> +		DBG("%s %s %s %s %s", info->devnode, info->interface,
> +					info->number, info->label, info->sysattr);
> +
> +		if (g_strcmp0(info->interface, "2/2/1") =3D=3D 0) {
> +			if (g_strcmp0(info->number, "00") =3D=3D 0)
> +				aux =3D info->devnode;
> +			else if (g_strcmp0(info->number, "06") =3D=3D 0)
> +				mdm =3D info->devnode;
> +		} else if (info->sysattr && (g_str_has_suffix(info->sysattr,
> +						"CDC NCM") =3D=3D TRUE)) {
> +			network =3D info->devnode;
> +		}
> +	}
> +	DBG("aux=3D%s modem=3D%s network=3D%s", aux, mdm, network);
> +
> +	if (aux =3D=3D NULL || mdm =3D=3D NULL || network =3D=3D NULL)
> +		return FALSE;
> +
> +	ofono_modem_set_string(modem->modem, "Aux", aux);
> +	ofono_modem_set_string(modem->modem, "Modem", mdm);
> +	ofono_modem_set_string(modem->modem, "NetworkInterface", network);
> +
> +	return TRUE;
> +}
> +
>  static struct {
>  	const char *name;
>  	gboolean (*setup)(struct modem_info *modem);
> @@ -984,6 +1019,7 @@ static struct {
>  	{ "quectel",	setup_quectel	},
>  	{ "ublox",	setup_ublox	},
>  	{ "gemalto",	setup_gemalto	},
> +	{ "le910v2",	setup_le910v2,	"device/interface"	},
>  	{ }
>  };
>
> @@ -1226,6 +1262,8 @@ static struct {
>  	{ "gemalto",	"option",	"1e2d",	"0053"	},
>  	{ "gemalto",	"cdc_wdm",	"1e2d",	"0053"	},
>  	{ "gemalto",	"qmi_wwan",	"1e2d",	"0053"	},
> +	{ "le910v2",	"cdc_ncm",	"1bc7", "0036"	},
> +	{ "le910v2",	"cdc_acm",	"1bc7", "0036"	},
>  	{ }
>  };
>

Regards,
-Denis

--===============4511989127946222170==--

