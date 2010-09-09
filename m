Content-Type: multipart/mixed; boundary="===============7465036239618133816=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 02/12] atgen changes for setting TE character set
Date: Thu, 09 Sep 2010 09:50:27 -0500
Message-ID: <4C88F433.6070106@gmail.com>
In-Reply-To: <1284035516-21359-3-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7465036239618133816==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 09/09/2010 07:31 AM, Jeevaka Badrappan wrote:
> ---
>  plugins/atgen.c |   59 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 59 insertions(+), 0 deletions(-)
> =

> diff --git a/plugins/atgen.c b/plugins/atgen.c
> index 1ce2467..a8ca177 100644
> --- a/plugins/atgen.c
> +++ b/plugins/atgen.c
> @@ -25,6 +25,8 @@
>  =

>  #include <errno.h>
>  #include <stdlib.h>
> +#include <string.h>
> +#include <stdio.h>
>  =

>  #include <glib.h>
>  #include <gatchat.h>
> @@ -55,6 +57,9 @@
>  #include <ofono/gprs.h>
>  #include <ofono/gprs-context.h>
>  =

> +static const char *none_prefix[] =3D { NULL };
> +static const char *cscs_prefix[] =3D { "+CSCS:", NULL };
> +
>  static const char *tty_opts[] =3D {
>  	"Baud",
>  	"Read",
> @@ -67,6 +72,58 @@ static const char *tty_opts[] =3D {
>  	NULL,
>  };
>  =

> +static const char *best_charset(int supported)
> +{
> +	const char *charset =3D "Invalid";
> +
> +	if (supported & AT_UTIL_CHARSET_GSM)
> +		charset =3D "GSM";
> +
> +	if (supported & AT_UTIL_CHARSET_UTF8)
> +		charset =3D "UTF-8";
> +
> +	return charset;
> +}
> +
> +static void set_charset_cb(gboolean ok, GAtResult *result,
> +				gpointer user_data)
> +{
> +	if (!ok)
> +		ofono_error("Setting character set failed");

Use of functions that do nothing is discouraged.  If CSCS fails, it can
be easily seen from the AT command trace.

> +}
> +
> +static void list_charsets_cb(gboolean ok, GAtResult *result,
> +				gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	GAtChat *chat =3D ofono_modem_get_data(modem);
> +	const char *charset;
> +	int supported =3D 0;
> +	char buf[32];
> +
> +	if (!ok)
> +		return;
> +
> +	if (!at_util_parse_cscs_supported(result, &supported))
> +		return;
> +
> +	charset =3D best_charset(supported);
> +	snprintf(buf, sizeof(buf), "AT+CSCS=3D\"%s\"", charset);
> +
> +	if (!g_at_chat_send(chat, buf, none_prefix, set_charset_cb, modem,
> +			NULL))
> +		ofono_error("AT+CSCS=3D%s request failed", charset);

In general oFono plugins do not check for errors on g_at_chat_send.

There are two reasons:
- There's nothing that can be done anyway, and printing the error is not
really helpful
- The plugin just setup the device, so any errors are most likely
programmer errors.

> +}
> +
> +static void list_charsets(struct ofono_modem *modem)
> +{
> +	GAtChat *chat =3D ofono_modem_get_data(modem);
> +
> +	if (!g_at_chat_send(chat, "AT+CSCS=3D?", cscs_prefix,
> +			list_charsets_cb, modem, NULL))
> +		ofono_error("AT+CSCS=3D? request failed");

Same comment as above..

> +}
> +
>  static int atgen_probe(struct ofono_modem *modem)
>  {
>  	return 0;
> @@ -207,6 +264,8 @@ static void atgen_pre_sim(struct ofono_modem *modem)
>  =

>  	if (sim)
>  		ofono_sim_inserted_notify(sim, TRUE);
> +
> +	list_charsets(modem);
>  }
>  =

>  static void atgen_post_sim(struct ofono_modem *modem)

Regards,
-Denis

--===============7465036239618133816==--

