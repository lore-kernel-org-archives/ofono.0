Content-Type: multipart/mixed; boundary="===============6567817191016109924=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/2] ifxmodem: add enable/disable ctm support
Date: Tue, 11 Jan 2011 21:59:02 -0800
Message-ID: <1294811942.3873.49.camel@aeonflux>
In-Reply-To: <1294674900-10256-3-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6567817191016109924==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

>  Makefile.am                 |    3 +-
>  drivers/ifxmodem/ctm.c      |  243 +++++++++++++++++++++++++++++++++++++=
++++++
>  drivers/ifxmodem/ifxmodem.c |    2 +
>  drivers/ifxmodem/ifxmodem.h |    3 +
>  4 files changed, 250 insertions(+), 1 deletions(-)
>  create mode 100644 drivers/ifxmodem/ctm.c
> =

> diff --git a/Makefile.am b/Makefile.am
> index 8ad01cd..e6494b1 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -222,7 +222,8 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
>  			drivers/ifxmodem/audio-settings.c \
>  			drivers/ifxmodem/radio-settings.c \
>  			drivers/ifxmodem/gprs-context.c \
> -			drivers/ifxmodem/stk.c
> +			drivers/ifxmodem/stk.c \
> +			drivers/ifxmodem/ctm.c
>  =

>  builtin_modules +=3D stemodem
>  builtin_sources +=3D drivers/atmodem/atutil.h \
> diff --git a/drivers/ifxmodem/ctm.c b/drivers/ifxmodem/ctm.c
> new file mode 100644
> index 0000000..17c7f5c
> --- /dev/null
> +++ b/drivers/ifxmodem/ctm.c
> @@ -0,0 +1,243 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
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
> +#include <errno.h>
> +
> +#include <glib.h>
> +
> +#include <ofono/log.h>
> +#include <ofono/modem.h>
> +#include <ofono/ctm.h>
> +
> +#include "gatchat.h"
> +#include "gatresult.h"
> +
> +#include "ifxmodem.h"
> +
> +static const char *none_prefix[] =3D { NULL };
> +static const char *xctms_prefix[] =3D { "XCTMS:", NULL };
> +static const char *xdrv_prefix[] =3D { "XDRV:", NULL };
> +
> +struct ctm_data {
> +	GAtChat *chat;
> +	const char * audio_setting;

you have an extra space between * and audio_setting. Please remove that.

> +	ofono_bool_t enable;
> +};
> +
> +static void xctms_query_cb(gboolean ok, GAtResult *result, gpointer user=
_data)
> +{
> +	struct cb_data *cbd =3D user_data;
> +	ofono_ctm_query_cb_t cb =3D cbd->cb;
> +	struct ofono_error error;
> +	GAtResultIter iter;
> +	int value;
> +	ofono_bool_t enable;
> +
> +	decode_at_error(&error, g_at_result_final_response(result));
> +
> +	if (!ok) {
> +		cb(&error, -1, cbd->data);
> +		return;
> +	}
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (g_at_result_iter_next(&iter, "XCTMS:") =3D=3D FALSE)
> +		goto error;
> +
> +	if (g_at_result_iter_next_number(&iter, &value) =3D=3D FALSE)
> +		goto error;
> +
> +	/* FULL TTY mode status only sent to oFono */
> +	enable =3D (value =3D=3D 1) ? TRUE : FALSE;
> +
> +	cb(&error, enable, cbd->data);
> +
> +	return;
> +
> +error:
> +	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
> +}
> +
> +static void ifx_query_tty(struct ofono_ctm *ctm, ofono_ctm_query_cb_t cb,
> +				void *data)
> +{
> +	struct ctm_data *ctmd =3D ofono_ctm_get_data(ctm);
> +	struct cb_data *cbd =3D cb_data_new(cb, data);
> +
> +	if (cbd =3D=3D NULL)
> +		goto error;
> +
> +	if (g_at_chat_send(ctmd->chat, "AT+XCTMS?", xctms_prefix,
> +				xctms_query_cb, cbd, g_free) > 0)
> +		return;
> +
> +error:
> +	g_free(cbd);
> +
> +	CALLBACK_WITH_FAILURE(cb, -1, data);
> +}
> +
> +static void xctms_modify_cb(gboolean ok, GAtResult *result, gpointer use=
r_data)
> +{
> +	struct cb_data *cbd =3D user_data;
> +	ofono_ctm_set_cb_t cb =3D cbd->cb;
> +	struct ofono_error error;
> +	const char *setting =3D NULL;
> +	struct ofono_ctm *ctm =3D cbd->user;
> +	struct ctm_data *ctmd =3D ofono_ctm_get_data(ctm);
> +	ofono_bool_t enable =3D ctmd->enable;
> +
> +	decode_at_error(&error, g_at_result_final_response(result));
> +
> +	if (!ok) {
> +		cb(&error, cbd->data);
> +		return;
> +	}
> +
> +	if (g_strcmp0(ctmd->audio_setting, "FULL_DUPLEX") =3D=3D 0)
> +		setting =3D "0,0,0,0,0,0,0";
> +	else if (g_strcmp0(ctmd->audio_setting, "BURSTMODE_48KHZ") =3D=3D 0)
> +		setting =3D "0,0,8,0,2,0,0";
> +	else if (g_strcmp0(ctmd->audio_setting, "BURSTMODE_96KHZ") =3D=3D 0)
> +		setting =3D "0,0,9,0,2,0,0";
> +
> +	if (setting) {
> +		char xdrv_buf[64];
> +
> +		/* configure source */
> +		snprintf(xdrv_buf, sizeof(xdrv_buf), "AT+XDRV=3D40,4,%d,%d,%s,%s",
> +						4,
> +						0,
> +						setting,
> +						enable ? "2,5" : "0,0");
> +		g_at_chat_send(ctmd->chat, xdrv_buf, xdrv_prefix, NULL, NULL,
> +				NULL);
> +
> +		/* configure destination */
> +		snprintf(xdrv_buf, sizeof(xdrv_buf), "AT+XDRV=3D40,5,%d,%d,%s,%s",
> +						3,
> +						0,
> +						setting,
> +						enable ? "2,6" : "0,0");
> +
> +		g_at_chat_send(ctmd->chat, xdrv_buf, xdrv_prefix, NULL, NULL,
> +				NULL);
> +	}

Now this is something I don't like at all. It is copied code from the
modem plugin.

The initial discussion was that we need to configure XDRV only once
during init and never have to touch it again. That seems to be not true
anymore. So what is the deal here?

Also if this is required, we might need to figure out a complete
different way of handling this. We can't have this in two places since
that means a full disconnect. Maybe putting this into the audio settings
atom might be better. However before we can do anything, I have to
understand the semantics behind XDRV, normal voice calls and TTY calls.

> +
> +	cb(&error, cbd->data);
> +}
> +
> +static void ifx_set_tty(struct ofono_ctm *ctm, ofono_bool_t enable,
> +				ofono_ctm_set_cb_t cb, void *data)
> +{
> +	struct ctm_data *ctmd =3D ofono_ctm_get_data(ctm);
> +	struct cb_data *cbd =3D cb_data_new(cb, data);
> +	char buf[20];
> +
> +	if (cbd =3D=3D NULL)
> +		goto error;
> +
> +	/* Only FULL TTY mode enabled/disabled */
> +	snprintf(buf, sizeof(buf), "AT+XCTMS=3D%i", enable ? 1 : 0);
> +
> +	if (g_at_chat_send(ctmd->chat, buf, none_prefix,
> +				xctms_modify_cb, cbd, g_free) > 0) {
> +		ctmd->enable =3D enable;
> +		ofono_ctm_set_data(ctm, ctmd);

What is this ctm_set_data doing here. It seems wrong.

> +		cbd->user =3D ctm;
> +	return;

This return is a bit out of order.

> +	}
> +
> +error:
> +	g_free(cbd);
> +
> +	CALLBACK_WITH_FAILURE(cb, data);
> +}
> +
> +static void xctms_support_cb(gboolean ok, GAtResult *result, gpointer us=
er_data)
> +{
> +	struct ofono_ctm *ctm =3D user_data;
> +
> +	if (!ok)
> +		ofono_ctm_remove(ctm);
> +	else
> +		ofono_ctm_register(ctm);

Don't bother with the remove here. We have not been doing that. So just
registering in success case is enough.

> +}
> +
> +static int ifx_ctm_probe(struct ofono_ctm *ctm,
> +				unsigned int vendor, void *data)
> +{
> +	struct ofono_modem *modem;
> +	GAtChat *chat =3D data;
> +	struct ctm_data *ctmd;
> +
> +	ctmd =3D g_try_new0(struct ctm_data, 1);
> +	if (ctmd =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	modem =3D ofono_ctm_get_modem(ctm);
> +	ctmd->audio_setting =3D ofono_modem_get_string(modem, "AudioSetting");
> +	ctmd->chat =3D g_at_chat_clone(chat);
> +
> +	ofono_ctm_set_data(ctm, ctmd);
> +
> +	g_at_chat_send(ctmd->chat, "AT+XCTMS=3D?", xctms_prefix,
> +			xctms_support_cb, ctm, NULL);
> +
> +	return 0;
> +}
> +
> +static void ifx_ctm_remove(struct ofono_ctm *ctm)
> +{
> +	struct ctm_data *ctmd =3D ofono_ctm_get_data(ctm);
> +
> +	ofono_ctm_set_data(ctm, NULL);
> +
> +	g_at_chat_unref(ctmd->chat);
> +	g_free(ctmd);
> +}
> +
> +static struct ofono_ctm_driver driver =3D {
> +	.name           =3D "ifxmodem",
> +	.probe          =3D ifx_ctm_probe,
> +	.remove         =3D ifx_ctm_remove,
> +	.query_tty      =3D ifx_query_tty,
> +	.set_tty        =3D ifx_set_tty,
> +};
> +
> +void ifx_ctm_init()
> +{

We wanna be consistent, so pleace do ifx_ctm_init(void) here.

> +	ofono_ctm_driver_register(&driver);
> +}
> +
> +void ifx_ctm_exit()
> +{

Same here. And for extra bonus points, I accept patches that fixes this
inside the whole oFono tree ;)

It is coding style rule M15 now.

Regards

Marcel



--===============6567817191016109924==--

