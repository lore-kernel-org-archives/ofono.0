Content-Type: multipart/mixed; boundary="===============9202013292264671883=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] linktop: reimplemented with minimum features.
Date: Mon, 27 Jun 2011 10:34:36 -0500
Message-ID: <4E08A30C.7010808@gmail.com>
In-Reply-To: <1309155735-14544-1-git-send-email-mendapara.amit@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9202013292264671883==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Amit,

On 06/27/2011 01:22 AM, Amit Mendapara wrote:
> The device supports subset of ST-Ericsson AT command
> extensions but nither STE nor the MBM plugin works with
> these devices.
> =

> Fixes MeeGo bug #14784
> ---
>  plugins/linktop.c |  120 +++++++++++++++++++++++------------------------=
------
>  1 files changed, 52 insertions(+), 68 deletions(-)
> =


I applied this patch with some amendments:

> diff --git a/plugins/linktop.c b/plugins/linktop.c
> index 953f634..2eb1c55 100644
> --- a/plugins/linktop.c
> +++ b/plugins/linktop.c
> @@ -26,6 +26,7 @@
>  #include <stdio.h>
>  #include <errno.h>
>  #include <stdlib.h>
> +#include <string.h>
>  =


This header doesn't seem necessary

>  #include <glib.h>
>  #include <gatchat.h>
> @@ -45,22 +42,20 @@
>  #include <ofono/cbs.h>
>  #include <ofono/sms.h>
>  #include <ofono/ussd.h>
> -#include <ofono/call-volume.h>
> -#include <ofono/voicecall.h>
>  #include <ofono/gprs.h>
>  #include <ofono/gprs-context.h>
>  #include <ofono/phonebook.h>
>  #include <ofono/radio-settings.h>
>  #include <ofono/log.h>
>  =

> -#include <drivers/atmodem/vendor.h>
>  #include <drivers/atmodem/atutil.h>
> +#include <drivers/atmodem/vendor.h>
>  =


Since you're not using any VENDOR defines, this header is not necessary.
 However I actually question whether signal strength updates work right
now without using the CIND based signal strength updates that MBM uses.

>  static const char *none_prefix[] =3D { NULL };
>  =

>  struct linktop_data {
>  	GAtChat *modem;
> -	GAtChat *control;
> +	GAtChat *aux;
>  	struct ofono_gprs *gprs;
>  	struct ofono_gprs_context *gc;
>  };

<snip>

> @@ -138,10 +133,9 @@ static void linktop_disconnect(gpointer user_data)
>  	struct ofono_modem *modem =3D user_data;
>  	struct linktop_data *data =3D ofono_modem_get_data(modem);
>  =

> -	DBG("");
> +	DBG("%p, data->gc %p", modem, data->gc);
>  =

> -	if (data->gc)
> -		ofono_gprs_context_remove(data->gc);
> +	ofono_gprs_context_remove(data->gc);
>  =

>  	g_at_chat_unref(data->modem);
>  	data->modem =3D NULL;
> @@ -151,7 +145,7 @@ static void linktop_disconnect(gpointer user_data)
>  		return;
>  =

>  	g_at_chat_set_disconnect_function(data->modem,
> -						linktop_disconnect, modem);
> +			linktop_disconnect, modem);

The original formatting was correct

>  =

>  	ofono_info("Reopened GPRS context channel");
>  =

> @@ -232,13 +223,12 @@ static int linktop_disable(struct ofono_modem *mode=
m)
>  		data->modem =3D NULL;
>  	}
>  =


It is not necessary to cancel_all on the modem channel, unref it and set
it to zero, cancel_all is already called automatically from unref.  Not
to mention you do the same thing in cfun_disable.

> -	if (data->control =3D=3D NULL)
> +	if (data->aux =3D=3D NULL)
>  		return 0;
>  =

> -	g_at_chat_cancel_all(data->control);
> -	g_at_chat_unregister_all(data->control);
> -	g_at_chat_send(data->control, "AT+CFUN=3D4", none_prefix,
> -					cfun_disable, modem, NULL);
> +	g_at_chat_cancel_all(data->aux);
> +	g_at_chat_unregister_all(data->aux);
> +	g_at_chat_send(data->aux, "AT+CFUN=3D4", NULL, cfun_disable, modem, NUL=
L);
>  =

>  	return -EINPROGRESS;
>  }
> @@ -247,22 +237,25 @@ static void set_online_cb(gboolean ok, GAtResult *r=
esult, gpointer user_data)
>  {
>  	struct cb_data *cbd =3D user_data;
>  	ofono_modem_online_cb_t cb =3D cbd->cb;
> -	struct ofono_error error;
>  =

> -	decode_at_error(&error, g_at_result_final_response(result));
> -	cb(&error, cbd->data);
> +	if (ok)
> +		CALLBACK_WITH_SUCCESS(cb, cbd->data);
> +	else
> +		CALLBACK_WITH_FAILURE(cb, cbd->data);

The original was actually correct and I updated the mbm plugin to do the
same.

>  }
>  =


Please test my changes and make sure I didn't break anything

Regards,
-Denis

--===============9202013292264671883==--

