Content-Type: multipart/mixed; boundary="===============8273690069082869973=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v4 4/7] stemodem: Add Radio Settings to STE Modem
Date: Tue, 17 Aug 2010 00:05:43 +0200
Message-ID: <1281996343.23399.50.camel@localhost.localdomain>
In-Reply-To: <1281993134-3926-4-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8273690069082869973==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

>  Makefile.am                       |    3 +-
>  drivers/stemodem/radio-settings.c |  225 +++++++++++++++++++++++++++++++=
++++++
>  drivers/stemodem/stemodem.c       |    2 +
>  drivers/stemodem/stemodem.h       |    2 +
>  4 files changed, 231 insertions(+), 1 deletions(-)
>  create mode 100644 drivers/stemodem/radio-settings.c
> =

> diff --git a/Makefile.am b/Makefile.am
> index 16a3a3d..9462743 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -204,7 +204,8 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
>  			drivers/stemodem/voicecall.c \
>  			drivers/stemodem/gprs-context.c \
>  			drivers/stemodem/caif_socket.h \
> -			drivers/stemodem/if_caif.h
> +			drivers/stemodem/if_caif.h \
> +			drivers/stemodem/radio-settings.c

please put it after or before the gprs-context.c. I wanna keep the atom
drivers together and not intermix with the CAIF includes.
 =

>  builtin_modules +=3D phonesim
>  builtin_sources +=3D plugins/phonesim.c
> diff --git a/drivers/stemodem/radio-settings.c b/drivers/stemodem/radio-s=
ettings.c
> new file mode 100644
> index 0000000..49a7906
> --- /dev/null
> +++ b/drivers/stemodem/radio-settings.c
> @@ -0,0 +1,225 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
> + *  Copyright (C) 2010 ST-Ericsson AB.
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + =


You need to put an empty line after your copyright. Please keep the
style we have for the copyright header.

> *
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
> +#include "stemodem.h"
> +
> +static const char *none_prefix[] =3D { NULL };
> +static const char *cfun_prefix[] =3D { "+CFUN:", NULL };
> +
> +struct radio_settings_data {
> +	GAtChat *chat;
> +};
> +
> +enum ste_radio_mode {
> +	STE_RADIO_OFF =3D 0,
> +	STE_RADIO_ON =3D 1,
> +	STE_RADIO_FLIGHT_MODE =3D 4,
> +	STE_RADIO_GSM_ONLY =3D 5,
> +	STE_RADIO_WCDMA_ONLY =3D 6
> +};

Can you please insert tabs between the constant and the =3D <value>. We
prefer having the enums nicely tabbed.

> +static gboolean ste_mode_to_ofono_mode(enum ste_radio_mode stemode,
> +				enum ofono_radio_access_mode *mode)
> +{
> +	switch (stemode) {
> +	case STE_RADIO_ON:
> +		*mode =3D OFONO_RADIO_ACCESS_MODE_ANY;
> +		return TRUE;
> +	case STE_RADIO_GSM_ONLY:
> +		*mode =3D OFONO_RADIO_ACCESS_MODE_GSM;
> +		return TRUE;
> +	case STE_RADIO_WCDMA_ONLY:
> +		*mode =3D OFONO_RADIO_ACCESS_MODE_UMTS;
> +		return TRUE;
> +	default:
> +		return FALSE;
> +	}
> +}

I prefer that you leave out the default statement and just add a return
FALSE at the end of the function. Deal with missing enum entries and the
compiler complaining by just adding a break.

This has the advantage if you accidentally add a constant the compiler
will warn you instead of just using default statement.

> +static gboolean ofono_mode_to_ste_mode(enum ofono_radio_access_mode mode,
> +				enum ste_radio_mode *stemode)
> +{
> +	switch (mode) {
> +	case OFONO_RADIO_ACCESS_MODE_ANY:
> +		*stemode =3D STE_RADIO_ON;
> +		return TRUE;
> +	case OFONO_RADIO_ACCESS_MODE_GSM:
> +		*stemode =3D STE_RADIO_GSM_ONLY;
> +		return TRUE;
> +
> +	case OFONO_RADIO_ACCESS_MODE_UMTS:
> +		*stemode =3D STE_RADIO_WCDMA_ONLY;
> +		return TRUE;
> +	default:
> +		return FALSE;
> +	}
> +}

Same here. And in addition please remove the empty line in between that
is there for no real reason.

> +static void sterat_query_cb(gboolean ok, GAtResult *result, gpointer use=
r_data)
> +{

I prefer if you call this just rat_query_cb and don't bother prefixing
it with ste.

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
> +	if (!g_at_result_iter_next(&iter, "+CFUN:"))
> +		goto err;
> +
> +	if (!g_at_result_iter_next_number(&iter, &value))
> +		goto err;
> +
> +	if (!ste_mode_to_ofono_mode(value, &mode))
> +		goto err;
> +
> +	CALLBACK_WITH_SUCCESS(cb, mode, cbd->data);
> +
> +	return;
> +
> +err:
> +	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
> +}
> +
> +static void ste_query_rat_mode(struct ofono_radio_settings *rs,
> +				ofono_radio_settings_rat_mode_query_cb_t cb,
> +				void *data)
> +{
> +	struct radio_settings_data *rsd =3D ofono_radio_settings_get_data(rs);
> +	struct cb_data *cbd =3D cb_data_new(cb, data);
> +
> +	if (g_at_chat_send(rsd->chat, "AT+CFUN?", cfun_prefix,
> +					sterat_query_cb, cbd, g_free) =3D=3D 0) {
> +		CALLBACK_WITH_FAILURE(cb, -1, data);
> +		g_free(cbd);
> +	}
> +}
> +
> +static void sterat_modify_cb(gboolean ok, GAtResult *result, gpointer us=
er_data)
> +{

Same here. Please call it rat_modify_cb.

> +	struct cb_data *cbd =3D user_data;
> +	ofono_radio_settings_rat_mode_set_cb_t cb =3D cbd->cb;
> +	struct ofono_error error;
> +
> +	decode_at_error(&error, g_at_result_final_response(result));
> +
> +	if (!ok) {
> +		cb(&error, cbd->data);
> +		return;
> +	}
> +
> +	CALLBACK_WITH_SUCCESS(cb, cbd->data);
> +}
> +
> +static void ste_set_rat_mode(struct ofono_radio_settings *rs,
> +				enum ofono_radio_access_mode mode,
> +				ofono_radio_settings_rat_mode_set_cb_t cb,
> +				void *data)
> +{
> +	struct radio_settings_data *rsd =3D ofono_radio_settings_get_data(rs);
> +	struct cb_data *cbd =3D cb_data_new(cb, data);
> +	char buf[20];
> +	enum ste_radio_mode value;
> +
> +	if (!ofono_mode_to_ste_mode(mode, &value)) {
> +		CALLBACK_WITH_FAILURE(cb, data);
> +		g_free(cbd);
> +		return;
> +	}
> +
> +	snprintf(buf, sizeof(buf), "AT+CFUN=3D%u", value);
> +
> +	if (g_at_chat_send(rsd->chat, buf, none_prefix,
> +					sterat_modify_cb, cbd, g_free) =3D=3D 0) {
> +		CALLBACK_WITH_FAILURE(cb, data);
> +		g_free(cbd);
> +	}
> +}
> +
> +static int ste_radio_settings_probe(struct ofono_radio_settings *rs,
> +					unsigned int vendor, void *data)
> +{
> +	GAtChat *chat =3D data;
> +	struct radio_settings_data *rsd;
> +	rsd =3D g_try_new0(struct radio_settings_data, 1);
> +	if (!rsd)
> +		return -ENOMEM;
> +
> +	rsd->chat =3D chat;
> +
> +	ofono_radio_settings_set_data(rs, rsd);
> +	ofono_radio_settings_register(rs);
> +
> +	return 0;
> +}
> +
> +static void ste_radio_settings_remove(struct ofono_radio_settings *rs)
> +{
> +	struct radio_settings_data *rsd =3D ofono_radio_settings_get_data(rs);
> +	ofono_radio_settings_set_data(rs, NULL);
> +	g_free(rsd);
> +}
> +
> +static struct ofono_radio_settings_driver driver =3D {
> +	.name			=3D "stemodem",
> +	.probe			=3D ste_radio_settings_probe,
> +	.remove		=3D ste_radio_settings_remove,
> +	.query_rat_mode	=3D ste_query_rat_mode,
> +	.set_rat_mode		=3D ste_set_rat_mode
> +};
> +
> +void ste_radio_settings_init()
> +{
> +	ofono_radio_settings_driver_register(&driver);
> +}
> +
> +void ste_radio_settings_exit()
> +{
> +	ofono_radio_settings_driver_unregister(&driver);
> +}
> diff --git a/drivers/stemodem/stemodem.c b/drivers/stemodem/stemodem.c
> index c18a8b5..ebc1c70 100644
> --- a/drivers/stemodem/stemodem.c
> +++ b/drivers/stemodem/stemodem.c
> @@ -38,6 +38,7 @@ static int stemodem_init(void)
>  {
>  	ste_voicecall_init();
>  	ste_gprs_context_init();
> +	ste_radio_settings_init();
>  =

>  	return 0;
>  }
> @@ -46,6 +47,7 @@ static void stemodem_exit(void)
>  {
>  	ste_voicecall_exit();
>  	ste_gprs_context_exit();
> +	ste_radio_settings_exit();
>  }
>  =

>  OFONO_PLUGIN_DEFINE(stemodem, "STE modem driver", VERSION,
> diff --git a/drivers/stemodem/stemodem.h b/drivers/stemodem/stemodem.h
> index 267e001..b1691a2 100644
> --- a/drivers/stemodem/stemodem.h
> +++ b/drivers/stemodem/stemodem.h
> @@ -28,3 +28,5 @@ extern void ste_gprs_context_exit();
>  extern void ste_voicecall_init();
>  extern void ste_voicecall_exit();
>  =

> +extern void ste_radio_settings_init();
> +extern void ste_radio_settings_exit();

Rest looks just fine to me.

Regards

Marcel



--===============8273690069082869973==--

