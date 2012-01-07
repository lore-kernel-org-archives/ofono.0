Content-Type: multipart/mixed; boundary="===============5231005489283614648=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/5] speedup: Check for supported modem capabilities first
Date: Sat, 07 Jan 2012 12:26:19 -0600
Message-ID: <4F088E4B.7010708@gmail.com>
In-Reply-To: <1326114660-10111-3-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5231005489283614648==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 01/09/2012 07:10 AM, Guillaume Zajac wrote:
> ---
>  plugins/speedup.c |   40 ++++++++++++++++++++++++++++++++++++++--
>  1 files changed, 38 insertions(+), 2 deletions(-)
> =

> diff --git a/plugins/speedup.c b/plugins/speedup.c
> index a90dfe3..f03f8f3 100644
> --- a/plugins/speedup.c
> +++ b/plugins/speedup.c
> @@ -25,6 +25,7 @@
>  =

>  #include <errno.h>
>  #include <stdlib.h>
> +#include <string.h>
>  =

>  #include <glib.h>
>  #include <gatchat.h>
> @@ -47,11 +48,15 @@
>  #include <drivers/atmodem/atutil.h>
>  #include <drivers/atmodem/vendor.h>
>  =

> +static const char *gcap_prefix[] =3D { "+GCAP:", NULL };
> +
>  struct speedup_data {
>  	GAtChat *modem;
>  	GAtChat *aux;
>  	gboolean have_sim;
>  	struct at_util_sim_state_query *sim_state_query;
> +	gboolean have_gsm;
> +	gboolean have_cdma;

It might be a good idea to use a single gboolean, or better yet an enum
here instead.  There's no point to waste 8 bytes when a single byte can do.

>  };
>  =

>  static int speedup_probe(struct ofono_modem *modem)
> @@ -165,6 +170,36 @@ static void cfun_enable(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
>  						2, 20, sim_state_cb, modem);
>  }
>  =

> +static void gcap_support(gboolean ok, GAtResult *result, gpointer user_d=
ata)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct speedup_data *data =3D ofono_modem_get_data(modem);
> +	GAtResultIter iter;
> +	const char *gcap;
> +
> +	if (!ok)
> +		goto done;
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "+GCAP:"))
> +		goto done;
> +
> +	while (g_at_result_iter_next_unquoted_string(&iter, &gcap)) {
> +		if (*gcap =3D=3D '\0')
> +			break;
> +
> +		if (!strcmp(gcap, "+CGSM"))
> +			data->have_gsm =3D TRUE;
> +		else if (!strcmp(gcap, "+CIS707-A"))
> +			data->have_cdma =3D TRUE;
> +	}

First of all, this really belongs in atutil as a convenience function.

Second, why don't we fail on the obvious condition that neither CDMA nor
GSM is detected?

> +
> +done:
> +	g_at_chat_send(data->aux, "AT+CFUN=3D1", NULL,
> +					cfun_enable, modem, NULL);
> +}
> +
>  static int speedup_enable(struct ofono_modem *modem)
>  {
>  	struct speedup_data *data =3D ofono_modem_get_data(modem);
> @@ -185,8 +220,9 @@ static int speedup_enable(struct ofono_modem *modem)
>  	g_at_chat_send(data->modem, "ATE0 +CMEE=3D1", NULL, NULL, NULL, NULL);
>  	g_at_chat_send(data->aux, "ATE0 +CMEE=3D1", NULL, NULL, NULL, NULL);
>  =

> -	g_at_chat_send(data->aux, "AT+CFUN=3D1", NULL,
> -					cfun_enable, modem, NULL);
> +	/* Check for GSM/CDMA capabilities */
> +	g_at_chat_send(data->aux, "ATI", gcap_prefix,
> +					gcap_support, modem, NULL);
>  =

>  	return -EINPROGRESS;
>  }

Regards,
-Denis

--===============5231005489283614648==--

