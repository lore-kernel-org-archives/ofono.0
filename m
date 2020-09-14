Content-Type: multipart/mixed; boundary="===============5470520851609642578=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3] Support weird modem in Motorola Droid 4
Date: Mon, 14 Sep 2020 09:48:38 -0500
Message-ID: <76d39f7d-8365-2e51-f523-ac375914c83d@gmail.com>
In-Reply-To: <20200910130545.GA15084@duo.ucw.cz>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5470520851609642578==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On 9/10/20 8:05 AM, Pavel Machek wrote:
> This is basic support for modem in Droid 4, accessed over
> ttyUSB4. That interface is unfortunately quite broken, so we need to
> force very specific SMS mode.
> =


Can you separate this into at least a couple of patches per our patch submi=
ssion =

guidelines? See HACKING, 'Submitting Patches' section.

1 - atmodem / vendor quirks
2 - plugins/droid.c + build changes

> ---
> =

> Resent.
> =

> Best regards,
> 							Pavel
> =

> diff --git a/Makefile.am b/Makefile.am
> index fbb0eff4..9b3fbb8d 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -603,6 +603,9 @@ builtin_sources +=3D plugins/ublox.c
>   builtin_modules +=3D xmm7xxx
>   builtin_sources +=3D plugins/xmm7xxx.c
>   =

> +builtin_modules +=3D droid
> +builtin_sources +=3D plugins/droid.c
> +
>   if BLUETOOTH
>   if BLUEZ4
>   builtin_modules +=3D sap
> diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
> index e750a139..f46cd3a2 100644
> --- a/drivers/atmodem/sim.c
> +++ b/drivers/atmodem/sim.c
> @@ -199,6 +199,7 @@ static void at_sim_read_info(struct ofono_sim *sim, i=
nt fileid,
>   	case OFONO_VENDOR_SPEEDUP:
>   	case OFONO_VENDOR_QUALCOMM_MSM:
>   	case OFONO_VENDOR_SIMCOM:
> +	case OFONO_VENDOR_DROID:
>   		/* Maximum possible length */
>   		len +=3D sprintf(buf + len, ",0,0,255");
>   		break;
> diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
> index d502da72..a9306916 100644
> --- a/drivers/atmodem/sms.c
> +++ b/drivers/atmodem/sms.c
> @@ -349,8 +349,15 @@ static inline void at_ack_delivery(struct ofono_sms =
*sms)
>   			break;
>   		}
>   	} else {
> -		/* Should be a safe fallback */
> -		snprintf(buf, sizeof(buf), "AT+CNMA=3D0");
> +		switch (data->vendor) {
> +		case OFONO_VENDOR_DROID:
> +			snprintf(buf, sizeof(buf), "AT");
> +			break;
> +		default:
> +			/* Should be a safe fallback */
> +			snprintf(buf, sizeof(buf), "AT+CNMA=3D0");
> +			break;
> +		}

I'd rather you just not call at_ack_delivery at all in the case of DROID.  =
In =

fact, I don't think this function gets invoked at all if cnma_enabled is fa=
lse...

>   	}
>   =

>   	g_at_chat_send(data->chat, buf, none_prefix, at_cnma_cb, NULL, NULL);
> @@ -845,6 +852,7 @@ static gboolean build_cnmi_string(char *buf, int *cnm=
i_opts,
>   	case OFONO_VENDOR_ZTE:
>   	case OFONO_VENDOR_SIMCOM:
>   	case OFONO_VENDOR_QUECTEL:
> +	case OFONO_VENDOR_DROID:
>   		/* MSM devices advertise support for mode 2, but return an
>   		 * error if we attempt to actually use it. */
>   		mode =3D "1";
> @@ -858,9 +866,14 @@ static gboolean build_cnmi_string(char *buf, int *cn=
mi_opts,
>   	if (!append_cnmi_element(buf, &len, cnmi_opts[0], mode, FALSE))
>   		return FALSE;
>   =

> +	mode =3D "21";
> +	if (!data->cnma_enabled)
> +		mode =3D "1";
> +	if (data->vendor =3D=3D OFONO_VENDOR_DROID)
> +		mode =3D "2";
> +

So you want to deliver via +CMT but not do CNMA acks.  Ok I guess...

>   	/* Prefer to deliver SMS via +CMT if CNMA is supported */
> -	if (!append_cnmi_element(buf, &len, cnmi_opts[1],
> -					data->cnma_enabled ? "21" : "1", FALSE))
> +	if (!append_cnmi_element(buf, &len, cnmi_opts[1], mode, FALSE))
>   		return FALSE;
>   =

>   	switch (data->vendor) {
> @@ -1243,7 +1256,9 @@ static void at_csms_status_cb(gboolean ok, GAtResul=
t *result,
>   			goto out;
>   =

>   		if (service =3D=3D 1 || service =3D=3D 128)
> -			data->cnma_enabled =3D TRUE;
> +			if (data->vendor !=3D OFONO_VENDOR_DROID) {
> +				data->cnma_enabled =3D TRUE;
> +			}

<continued from at_ack_delivery discussion>

...which should be false on DROID...?  Also, no need for {}.  See =

doc/coding-style.txt for details.

>   =

>   		if (mt =3D=3D 1 && mo =3D=3D 1)
>   			supported =3D TRUE;
> @@ -1290,6 +1305,8 @@ static void at_csms_query_cb(gboolean ok, GAtResult=
 *result,
>   		goto out;
>   =

>   	switch (data->vendor) {
> +	case OFONO_VENDOR_DROID:
> +		break;
>   	case OFONO_VENDOR_QUECTEL_SERIAL:
>   		g_at_result_iter_next_number(&iter, &status_min);
>   		g_at_result_iter_next_number(&iter, &status_max);
> diff --git a/drivers/atmodem/vendor.h b/drivers/atmodem/vendor.h
> index d839d1e0..2bfd3eb8 100644
> --- a/drivers/atmodem/vendor.h
> +++ b/drivers/atmodem/vendor.h
> @@ -27,6 +27,7 @@ enum ofono_vendor {
>   	OFONO_VENDOR_MBM,
>   	OFONO_VENDOR_GOBI,
>   	OFONO_VENDOR_QUALCOMM_MSM,
> +	OFONO_VENDOR_DROID,
>   	OFONO_VENDOR_OPTION_HSO,
>   	OFONO_VENDOR_ZTE,
>   	OFONO_VENDOR_HUAWEI,
> diff --git a/drivers/atmodem/voicecall.c b/drivers/atmodem/voicecall.c
> index 7ab6567f..6c80bd4e 100644
> --- a/drivers/atmodem/voicecall.c
> +++ b/drivers/atmodem/voicecall.c
> @@ -160,6 +160,10 @@ static void clcc_poll_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
>   			poll_again =3D TRUE;
>   			goto poll_again;
>   		}
> +		if (vd->vendor =3D=3D OFONO_VENDOR_DROID) {
> +			poll_again =3D TRUE;
> +			goto poll_again;
> +		}
>   =

>   		ofono_error("We are polling CLCC and received an error");
>   		ofono_error("All bets are off for call management");
> diff --git a/plugins/droid.c b/plugins/droid.c
> new file mode 100644
> index 00000000..4e048dbb
> --- /dev/null
> +++ b/plugins/droid.c
> @@ -0,0 +1,226 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
> + *  Copyright (C) 2009  Collabora Ltd. All rights reserved.
> + *  Copyright (C) 2020  Pavel Machek. All rights reserved.
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
> +#include <stdlib.h>
> +#include <errno.h>
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
> +#include <ofono/netreg.h>
> +#include <ofono/phonebook.h>
> +#include <ofono/sim.h>
> +#include <ofono/sms.h>
> +#include <ofono/ussd.h>
> +#include <ofono/voicecall.h>
> +
> +#include <drivers/atmodem/vendor.h>
> +
> +static void droid_debug(const char *str, void *user_data)
> +{
> +	const char *prefix =3D user_data;
> +
> +	ofono_info("%s%s", prefix, str);
> +}
> +
> +/* Detect hardware, and initialize if found */
> +static int droid_probe(struct ofono_modem *modem)
> +{
> +	DBG("");
> +
> +	return 0;
> +}
> +
> +static void droid_remove(struct ofono_modem *modem)
> +{
> +	GAtChat *chat =3D ofono_modem_get_data(modem);
> +
> +	DBG("");
> +
> +	if (chat) {
> +		g_at_chat_unref(chat);
> +		ofono_modem_set_data(modem, NULL);
> +	}
> +}
> +
> +static void cfun_set_on_cb(gboolean ok, GAtResult *result, gpointer user=
_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +
> +	DBG("");
> +
> +	if (ok)
> +		ofono_modem_set_powered(modem, TRUE);
> +}
> +
> +/* power up hardware */
> +static int droid_enable(struct ofono_modem *modem)
> +{
> +	GAtSyntax *syntax;
> +	GIOChannel *channel;
> +	GAtChat *chat;
> +	const char *device;
> +
> +	DBG("");
> +
> +	device =3D ofono_modem_get_string(modem, "Device");
> +	if (device =3D=3D NULL)
> +		return -EINVAL;
> +
> +	channel =3D g_at_tty_open(device, NULL);
> +	if (channel =3D=3D NULL)
> +		return -EIO;
> +
> +	syntax =3D g_at_syntax_new_gsm_permissive();
> +	chat =3D g_at_chat_new(channel, syntax);
> +	g_io_channel_unref(channel);
> +	g_at_syntax_unref(syntax);
> +
> +	if (chat =3D=3D NULL)
> +		return -EIO;
> +
> +	if (getenv("OFONO_AT_DEBUG"))
> +		g_at_chat_set_debug(chat, droid_debug, "");

Maybe use at_util_open_device()?

> +
> +	ofono_modem_set_data(modem, chat);
> +
> +	/* ensure modem is in a known state; verbose on, echo/quiet off */
> +	g_at_chat_send(chat, "ATE0Q0V1", NULL, NULL, NULL, NULL);
> +
> +	/* power up modem */
> +	g_at_chat_send(chat, "AT+CFUN=3D1", NULL, cfun_set_on_cb, modem, NULL);
> +
> +	return 0;
> +}
> +

Rest looks OK.

Regards,
-Denis
--===============5470520851609642578==--

