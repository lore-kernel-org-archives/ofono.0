Content-Type: multipart/mixed; boundary="===============6444742299768760126=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] huaweimodem: Add support for radio settings
Date: Wed, 08 Dec 2010 10:17:34 -0600
Message-ID: <4CFFAF9E.8040602@gmail.com>
In-Reply-To: <1291142496-26103-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6444742299768760126==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

On 11/30/2010 12:41 PM, Lucas De Marchi wrote:
> ---
>  Makefile.am                          |    3 +-
>  drivers/huaweimodem/huaweimodem.c    |    2 +
>  drivers/huaweimodem/huaweimodem.h    |    3 +
>  drivers/huaweimodem/radio-settings.c |  212 ++++++++++++++++++++++++++++=
++++++
>  4 files changed, 219 insertions(+), 1 deletions(-)
>  create mode 100644 drivers/huaweimodem/radio-settings.c
> =

> diff --git a/Makefile.am b/Makefile.am
> index a4c47e8..5d39c23 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -180,7 +180,8 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
>  			drivers/huaweimodem/huaweimodem.c \
>  			drivers/huaweimodem/voicecall.c \
>  			drivers/huaweimodem/audio-settings.c \
> -			drivers/huaweimodem/gprs-context.c
> +			drivers/huaweimodem/gprs-context.c \
> +			drivers/huaweimodem/radio-settings.c
>  =

>  builtin_modules +=3D calypsomodem
>  builtin_sources +=3D drivers/atmodem/atutil.h \
> diff --git a/drivers/huaweimodem/huaweimodem.c b/drivers/huaweimodem/huaw=
eimodem.c
> index c8b6522..8097a9c 100644
> --- a/drivers/huaweimodem/huaweimodem.c
> +++ b/drivers/huaweimodem/huaweimodem.c
> @@ -36,6 +36,7 @@ static int huaweimodem_init(void)
>  {
>  	huawei_voicecall_init();
>  	huawei_audio_settings_init();
> +	huawei_radio_settings_init();
>  	huawei_gprs_context_init();
>  =

>  	return 0;
> @@ -44,6 +45,7 @@ static int huaweimodem_init(void)
>  static void huaweimodem_exit(void)
>  {
>  	huawei_gprs_context_exit();
> +	huawei_radio_settings_exit();
>  	huawei_audio_settings_exit();
>  	huawei_voicecall_exit();
>  }
> diff --git a/drivers/huaweimodem/huaweimodem.h b/drivers/huaweimodem/huaw=
eimodem.h
> index 03d52ef..596aa08 100644
> --- a/drivers/huaweimodem/huaweimodem.h
> +++ b/drivers/huaweimodem/huaweimodem.h
> @@ -27,5 +27,8 @@ extern void huawei_voicecall_exit();
>  extern void huawei_audio_settings_init();
>  extern void huawei_audio_settings_exit();
>  =

> +extern void huawei_radio_settings_init();
> +extern void huawei_radio_settings_exit();
> +
>  extern void huawei_gprs_context_init();
>  extern void huawei_gprs_context_exit();
> diff --git a/drivers/huaweimodem/radio-settings.c b/drivers/huaweimodem/r=
adio-settings.c
> new file mode 100644
> index 0000000..7f0b223
> --- /dev/null
> +++ b/drivers/huaweimodem/radio-settings.c
> @@ -0,0 +1,212 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2010  Intel Corporation. All rights reserved.
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
> +#include <ofono/radio-settings.h>
> +
> +#include "gatchat.h"
> +#include "gatresult.h"
> +
> +#include "huaweimodem.h"
> +
> +static const char *none_prefix[] =3D { NULL };
> +static const char *xrat_prefix[] =3D { "^SYSCFG:", NULL };
> +
> +struct radio_settings_data {
> +	GAtChat *chat;
> +};
> +
> +static void xrat_query_cb(gboolean ok, GAtResult *result, gpointer user_=
data)

Why is this named xrat query?

> +{
> +	struct cb_data *cbd =3D user_data;
> +	ofono_radio_settings_rat_mode_query_cb_t cb =3D cbd->cb;
> +	enum ofono_radio_access_mode mode;
> +	struct ofono_error error;
> +	GAtResultIter iter;
> +	int value;
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
> +	if (g_at_result_iter_next(&iter, "^SYSCFG:") =3D=3D FALSE)
> +		goto error;
> +
> +	if (g_at_result_iter_next_number(&iter, &value) =3D=3D FALSE)
> +		goto error;
> +
> +	switch (value) {
> +	case 2:
> +		mode =3D OFONO_RADIO_ACCESS_MODE_ANY;
> +		break;
> +	case 13:
> +		mode =3D OFONO_RADIO_ACCESS_MODE_GSM;
> +		break;
> +	case 14:
> +		mode =3D OFONO_RADIO_ACCESS_MODE_UMTS;
> +		break;
> +	default:
> +		CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
> +		return;
> +	}
> +
> +	cb(&error, mode, cbd->data);
> +
> +	return;
> +
> +error:
> +	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
> +}
> +
> +static void huawei_query_rat_mode(struct ofono_radio_settings *rs,
> +				ofono_radio_settings_rat_mode_query_cb_t cb,
> +				void *data)
> +{
> +	struct radio_settings_data *rsd =3D ofono_radio_settings_get_data(rs);
> +	struct cb_data *cbd =3D cb_data_new(cb, data);
> +
> +	if (g_at_chat_send(rsd->chat, "AT^SYSCFG?", xrat_prefix,
> +					xrat_query_cb, cbd, g_free) =3D=3D 0) {

And xrat_query here too?

> +		CALLBACK_WITH_FAILURE(cb, -1, data);
> +		g_free(cbd);
> +	}
> +}
> +
> +static void xrat_modify_cb(gboolean ok, GAtResult *result, gpointer user=
_data)

xrat_modify?

> +{
> +	struct cb_data *cbd =3D user_data;
> +	ofono_radio_settings_rat_mode_set_cb_t cb =3D cbd->cb;
> +	struct ofono_error error;
> +
> +	decode_at_error(&error, g_at_result_final_response(result));
> +	cb(&error, cbd->data);
> +}
> +
> +static void huawei_set_rat_mode(struct ofono_radio_settings *rs,
> +				enum ofono_radio_access_mode mode,
> +				ofono_radio_settings_rat_mode_set_cb_t cb,
> +				void *data)
> +{
> +	struct radio_settings_data *rsd =3D ofono_radio_settings_get_data(rs);
> +	struct cb_data *cbd =3D cb_data_new(cb, data);
> +	char buf[40];
> +	int value =3D 2;
> +
> +	switch (mode) {
> +	case OFONO_RADIO_ACCESS_MODE_ANY:
> +		value =3D 2;
> +		break;
> +	case OFONO_RADIO_ACCESS_MODE_GSM:
> +		value =3D 13;
> +		break;
> +	case OFONO_RADIO_ACCESS_MODE_UMTS:
> +		value =3D 14;
> +		break;
> +	case OFONO_RADIO_ACCESS_MODE_LTE:
> +		goto error;
> +	}
> +
> +	snprintf(buf, sizeof(buf), "AT^SYSCFG=3D%u,0,3FFFFFFF,2,4", value);

These values don't seem to be correct.  At least not after taking a peek
at some of our competitors ;)

> +
> +	if (g_at_chat_send(rsd->chat, buf, none_prefix,
> +					xrat_modify_cb, cbd, g_free) > 0)

xrat_modify again here

> +		return;
> +
> +error:
> +	CALLBACK_WITH_FAILURE(cb, data);
> +	g_free(cbd);
> +}
> +
> +static void xrat_support_cb(gboolean ok, GAtResult *result, gpointer use=
r_data)
> +{

xrat_support?

> +	struct ofono_radio_settings *rs =3D user_data;
> +
> +	if (!ok)
> +		return;
> +
> +	ofono_radio_settings_register(rs);
> +}
> +
> +static int huawei_radio_settings_probe(struct ofono_radio_settings *rs,
> +					unsigned int vendor, void *data)
> +{
> +	GAtChat *chat =3D data;
> +	struct radio_settings_data *rsd;
> +
> +	rsd =3D g_try_new0(struct radio_settings_data, 1);
> +	if (rsd =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	rsd->chat =3D g_at_chat_clone(chat);
> +
> +	ofono_radio_settings_set_data(rs, rsd);
> +
> +	g_at_chat_send(rsd->chat, "AT^SYSCFG=3D?", xrat_prefix,

xrat_prefix?

> +					xrat_support_cb, rs, NULL);
> +
> +	return 0;
> +}
> +
> +static void huawei_radio_settings_remove(struct ofono_radio_settings *rs)
> +{
> +	struct radio_settings_data *rsd =3D ofono_radio_settings_get_data(rs);
> +
> +	ofono_radio_settings_set_data(rs, NULL);
> +
> +	g_at_chat_unref(rsd->chat);
> +	g_free(rsd);
> +}
> +
> +static struct ofono_radio_settings_driver driver =3D {
> +	.name			=3D "huaweimodem",
> +	.probe			=3D huawei_radio_settings_probe,
> +	.remove			=3D huawei_radio_settings_remove,
> +	.query_rat_mode		=3D huawei_query_rat_mode,
> +	.set_rat_mode		=3D huawei_set_rat_mode
> +};
> +
> +void huawei_radio_settings_init()
> +{
> +	ofono_radio_settings_driver_register(&driver);
> +}
> +
> +void huawei_radio_settings_exit()
> +{
> +	ofono_radio_settings_driver_unregister(&driver);
> +}

Regards,
-Denis

--===============6444742299768760126==--

