Content-Type: multipart/mixed; boundary="===============5918798198951964510=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 06/11] ubloxmodem: add Toby L2 gprs context driver
Date: Wed, 16 Mar 2016 18:25:11 -0500
Message-ID: <56E9EB57.6070308@gmail.com>
In-Reply-To: <1457970664-20782-7-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5918798198951964510==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dragos,

On 03/14/2016 10:50 AM, Dragos Tatulea wrote:
> For now the driver works only with bridged mode for 2G/3G.
>
> Once it activates the context it reads the ip, netmask,
> gw, dns and sets them in the context settings.
> ---
>   Makefile.am                       |   7 +
>   drivers/ubloxmodem/gprs-context.c | 415 +++++++++++++++++++++++++++++++=
+++++++
>   drivers/ubloxmodem/ubloxmodem.c   |  49 +++++
>   drivers/ubloxmodem/ubloxmodem.h   |  25 +++
>   4 files changed, 496 insertions(+)
>   create mode 100644 drivers/ubloxmodem/gprs-context.c
>   create mode 100644 drivers/ubloxmodem/ubloxmodem.c
>   create mode 100644 drivers/ubloxmodem/ubloxmodem.h
>
> diff --git a/Makefile.am b/Makefile.am
> index cde998d..7652cfe 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -374,6 +374,13 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
>   			drivers/speedupmodem/speedupmodem.c \
>   			drivers/speedupmodem/ussd.c
>
> +builtin_modules +=3D ubloxmodem
> +builtin_sources +=3D drivers/atmodem/atutil.h \
> +			drivers/ubloxmodem/ubloxmodem.h \
> +			drivers/ubloxmodem/ubloxmodem.c \
> +			drivers/ubloxmodem/gprs-context.c
> +
> +
>   if PHONESIM
>   builtin_modules +=3D phonesim
>   builtin_sources +=3D plugins/phonesim.c
> diff --git a/drivers/ubloxmodem/gprs-context.c b/drivers/ubloxmodem/gprs-=
context.c
> new file mode 100644
> index 0000000..4b8fb6c
> --- /dev/null
> +++ b/drivers/ubloxmodem/gprs-context.c
> @@ -0,0 +1,415 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2016  EndoCode AG. All rights reserved.
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
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-130=
1  USA
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
> +#include <stdbool.h>
> +#include <errno.h>
> +
> +#include <glib.h>
> +
> +#include <ofono/log.h>
> +#include <ofono/modem.h>
> +#include <ofono/gprs-context.h>
> +
> +#include "gatchat.h"
> +#include "gatresult.h"
> +
> +#include "ubloxmodem.h"
> +
> +static const char *none_prefix[] =3D { NULL };
> +static const char *cgcontrdp_prefix[] =3D { "+CGCONTRDP:", NULL };
> +
> +struct gprs_context_data {
> +	GAtChat *chat;
> +	unsigned int active_context;
> +	char apn[OFONO_GPRS_MAX_APN_LENGTH + 1];
> +	ofono_gprs_context_cb_t cb;
> +	void *cb_data;
> +};
> +
> +#define UBLOX_MAX_DEF_CONTEXT 8

What does this do?  Doesn't seem to be used in this file.

> +
> +/*
> + * CGCONTRDP returns addr + netmask in the same string in the form
> + * of "a.b.c.d.m.m.m.m" for IPv4. IPv6 is not supported so we ignore it.
> + */
> +static int read_addrnetmask(struct ofono_gprs_context *gc,
> +				const char *addrnetmask)

Since this function sets both parameters, how about:

set_address_and_netmask()

> +{
> +	char *dup =3D strdup(addrnetmask);
> +	char *s =3D dup;
> +
> +	const char *addr =3D s;
> +	const char *netmask =3D NULL;
> +
> +	int ret =3D -EINVAL;
> +	int i;
> +
> +	/* Count 7 dots for ipv4, less or more means error. */
> +	for (i =3D 0; i < 8; i++, s++) {
> +		s =3D strchr(s, '.');
> +		if (!s)
> +			break;
> +
> +		if (i =3D=3D 3) {
> +			/* set netmask ptr and break the string */
> +			netmask =3D s+1;
> +			s[0] =3D 0;
> +		}
> +	}
> +
> +	if (i =3D=3D 7) {
> +		ofono_gprs_context_set_ipv4_address(gc, addr, 1);
> +		ofono_gprs_context_set_ipv4_netmask(gc, netmask);
> +
> +		ret =3D 0;
> +	}
> +
> +	free(dup);
> +
> +	return ret;
> +}
> +
> +static void callback_with_error(struct gprs_context_data *gcd, GAtResult=
 *res)

Please inline this function to be more consistent with the rest of the =

codebase.

> +{
> +	struct ofono_error error;
> +
> +	decode_at_error(&error, g_at_result_final_response(res));
> +	gcd->cb(&error, gcd->cb_data);
> +}
> +
> +

1 empty line is enough. We don't use more than 1 empty line in a row. =

Yes, we're that pedantic :)

> +static void set_gprs_context_interface(struct ofono_gprs_context *gc)
> +{
> +	struct ofono_modem *modem;
> +	const char *interface;
> +
> +	/* read interface name read at detection time */
> +	modem =3D ofono_gprs_context_get_modem(gc);
> +	interface =3D ofono_modem_get_string(modem, "NetworkInterface");
> +	ofono_gprs_context_set_interface(gc, interface);
> +}
> +
> +static void cgcontrdp_bridge_cb(gboolean ok, GAtResult *result,
> +				gpointer user_data)
> +{
> +	struct ofono_gprs_context *gc =3D user_data;
> +	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> +	GAtResultIter iter;
> +	int cid =3D -1;
> +
> +	const char *laddrnetmask =3D NULL;
> +	const char *gw =3D NULL;
> +	const char *dns[2+1] =3D { NULL, NULL, NULL };

Do dns[3] here.

> +
> +	DBG("ok %d", ok);
> +
> +	if (!ok) {
> +		callback_with_error(gcd, result);

as mentioned above, lets inline the contents of callback_with_error here:
e.g.
decode_at_error(...);
cb(...)

> +
> +		return;
> +	}
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	while (g_at_result_iter_next(&iter, "+CGCONTRDP:")) {
> +		/* tmp vals for ignored fields */
> +		int bearer_id;
> +		const char *apn;
> +
> +		if (!g_at_result_iter_next_number(&iter, &cid))
> +			break;
> +
> +		if (!g_at_result_iter_next_number(&iter, &bearer_id))
> +			break;
> +
> +		if (!g_at_result_iter_next_string(&iter, &apn))
> +			break;
> +
> +		if (!g_at_result_iter_next_string(&iter, &laddrnetmask))
> +			break;
> +
> +		if (!g_at_result_iter_next_string(&iter, &gw))
> +			break;
> +
> +		if (!g_at_result_iter_next_string(&iter, &dns[0]))
> +			break;
> +
> +		if (!g_at_result_iter_next_string(&iter, &dns[1]))
> +			break;
> +	}
> +
> +	set_gprs_context_interface(gc);
> +
> +	if (!laddrnetmask || read_addrnetmask(gc, laddrnetmask) < 0) {
> +		CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
> +		return;
> +	}
> +
> +	if (gw)
> +		ofono_gprs_context_set_ipv4_gateway(gc, gw);
> +
> +	if (dns[0])
> +		ofono_gprs_context_set_ipv4_dns_servers(gc, dns);
> +
> +	CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
> +}
> +
> +static int ublox_read_ip_config_bridge(struct ofono_gprs_context *gc)
> +{
> +	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> +	char buf[64];
> +
> +	/* read ip configuration info */
> +	snprintf(buf, sizeof(buf), "AT+CGCONTRDP=3D%u", gcd->active_context);
> +	return g_at_chat_send(gcd->chat, buf, cgcontrdp_prefix,
> +				cgcontrdp_bridge_cb, gc, NULL);
> +
> +}
> +
> +static void ublox_post_activation(struct ofono_gprs_context *gc)
> +{
> +	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> +
> +	if (ublox_read_ip_config_bridge(gc) < 0)
> +		CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);

Since this is a two line function, it would be easier to read the code =

if it is moved into cgact_enable_cb

In fact, just sending CGCONTRDP inside cgact_enable_cb would be the =

simplest.

> +}
> +
> +static void cgact_enable_cb(gboolean ok, GAtResult *result, gpointer use=
r_data)
> +{
> +	struct ofono_gprs_context *gc =3D user_data;
> +	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> +
> +	DBG("ok %d", ok);
> +	if (!ok) {
> +		gcd->active_context =3D 0;
> +		callback_with_error(gcd, result);
> +
> +		return;
> +	}
> +
> +	ublox_post_activation(gc);
> +}
> +
> +static void cgdcont_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
> +{
> +	struct ofono_gprs_context *gc =3D user_data;
> +	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> +	char buf[64];
> +
> +	DBG("ok %d", ok);
> +
> +	if (!ok) {
> +		gcd->active_context =3D 0;
> +		callback_with_error(gcd, result);
> +
> +		return;
> +	}
> +
> +	snprintf(buf, sizeof(buf), "AT+CGACT=3D1,%u", gcd->active_context);
> +	if (g_at_chat_send(gcd->chat, buf, none_prefix,
> +				cgact_enable_cb, gc, NULL))
> +		return;
> +
> +	CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
> +}
> +
> +static void ublox_activate_ctx(struct ofono_gprs_context *gc)

Lets name this ublox_send_cgdcont, so it is clear what this helper =

function actually does

> +{
> +	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> +	char buf[OFONO_GPRS_MAX_APN_LENGTH + 128];
> +	int len;
> +
> +	len =3D snprintf(buf, sizeof(buf), "AT+CGDCONT=3D%u,\"IP\"",
> +				gcd->active_context);
> +
> +	if (gcd->apn)
> +		snprintf(buf + len, sizeof(buf) - len - 3, ",\"%s\"",
> +					gcd->apn);
> +
> +	if (g_at_chat_send(gcd->chat, buf, none_prefix,
> +				cgdcont_cb, gc, NULL) > 0)
> +		return;
> +
> +	CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
> +}
> +
> +#define UBLOX_MAX_USER_LEN 50
> +#define UBLOX_MAX_PASS_LEN 50
> +

Why is this defined here?  Does it belong in a later patch?

> +static void ublox_gprs_activate_primary(struct ofono_gprs_context *gc,
> +				const struct ofono_gprs_primary_context *ctx,
> +				ofono_gprs_context_cb_t cb, void *data)
> +{
> +	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> +
> +	/* IPv6 support not implemented */
> +	if (ctx->proto !=3D OFONO_GPRS_PROTO_IP) {
> +		CALLBACK_WITH_FAILURE(cb, data);
> +		return;
> +	}
> +
> +	DBG("cid %u", ctx->cid);
> +
> +	gcd->active_context =3D ctx->cid;
> +	if (!gcd->active_context) {
> +		ofono_error("can't activate more contexts");
> +		CALLBACK_WITH_FAILURE(cb, data);
> +		return;
> +	}
> +
> +	gcd->cb =3D cb;
> +	gcd->cb_data =3D data;
> +	memcpy(gcd->apn, ctx->apn, sizeof(ctx->apn));

Why do we memcpy the APN into this structure?  If you don't want to make =

this function too long, then just pass the apn as a parameter to =

ublox_activate_ctx.

> +
> +	ublox_activate_ctx(gc);
> +}
> +
> +static void cgact_disable_cb(gboolean ok, GAtResult *result, gpointer us=
er_data)
> +{
> +	struct ofono_gprs_context *gc =3D user_data;
> +	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> +
> +	DBG("ok %d", ok);

Empty line here after DBG, see item M1 in doc/coding-style.txt

> +	if (!ok) {
> +		CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
> +		return;
> +	}
> +
> +	gcd->active_context =3D 0;
> +
> +	CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
> +}
> +
> +static void ublox_gprs_deactivate_primary(struct ofono_gprs_context *gc,
> +					unsigned int cid,
> +					ofono_gprs_context_cb_t cb, void *data)
> +{
> +	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> +	char buf[64];
> +
> +	DBG("cid %u", cid);
> +
> +	gcd->cb =3D cb;
> +	gcd->cb_data =3D data;
> +
> +	snprintf(buf, sizeof(buf), "AT+CGACT=3D0,%u", gcd->active_context);
> +	g_at_chat_send(gcd->chat, buf, none_prefix,
> +			cgact_disable_cb, gc, NULL);
> +}
> +
> +static void cgev_notify(GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_gprs_context *gc =3D user_data;
> +	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> +	GAtResultIter iter;
> +	const char *event;
> +	gint cid;
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "+CGEV:"))
> +		return;
> +
> +	if (!g_at_result_iter_next_unquoted_string(&iter, &event))
> +		return;
> +
> +	if (g_str_has_prefix(event, "NW PDN DEACT")) {
> +		if (!g_at_result_iter_skip_next(&iter))
> +			return;
> +	} else if (g_str_has_prefix(event, "NW DEACT") =3D=3D FALSE)
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
> +	ofono_gprs_context_deactivated(gc, gcd->active_context);
> +	gcd->active_context =3D 0;
> +}
> +
> +
> +static int ublox_gprs_context_probe(struct ofono_gprs_context *gc,
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
> +	g_at_chat_register(chat, "+CGEV:", cgev_notify, FALSE, gc, NULL);
> +
> +	return 0;
> +}
> +
> +static void ublox_gprs_context_remove(struct ofono_gprs_context *gc)
> +{
> +	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> +
> +	DBG("");
> +
> +	ofono_gprs_context_set_data(gc, NULL);
> +
> +	g_at_chat_unref(gcd->chat);
> +
> +	memset(gcd, 0, sizeof(*gcd));
> +}
> +
> +static struct ofono_gprs_context_driver driver =3D {
> +	.name			=3D "ubloxmodem",
> +	.probe			=3D ublox_gprs_context_probe,
> +	.remove			=3D ublox_gprs_context_remove,
> +	.activate_primary	=3D ublox_gprs_activate_primary,
> +	.deactivate_primary	=3D ublox_gprs_deactivate_primary,
> +};
> +
> +


> +void ublox_gprs_context_init(void)
> +{
> +	ofono_gprs_context_driver_register(&driver);
> +}
> +
> +void ublox_gprs_context_exit(void)
> +{
> +	ofono_gprs_context_driver_unregister(&driver);
> +}

<snip>

Looks great. Lets fix these minor nitpicks and I'll apply it.

Regards,
-Denis

--===============5918798198951964510==--

