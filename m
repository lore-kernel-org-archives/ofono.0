Content-Type: multipart/mixed; boundary="===============7466837994204033700=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] isigen: create four gprs contexts
Date: Thu, 11 Nov 2010 09:11:28 -0600
Message-ID: <4CDC07A0.6030400@gmail.com>
In-Reply-To: <1289469648-18472-2-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7466837994204033700==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mika,

On 11/11/2010 04:00 AM, Mika Liljeberg wrote:
> ---
>  plugins/isigen.c |   19 ++++++++++++++-----
>  1 files changed, 14 insertions(+), 5 deletions(-)
> =

> diff --git a/plugins/isigen.c b/plugins/isigen.c
> index 838d060..3ea7110 100644
> --- a/plugins/isigen.c
> +++ b/plugins/isigen.c
> @@ -58,6 +58,8 @@
>  #include "drivers/isimodem/mtc.h"
>  #include "drivers/isimodem/debug.h"
>  =

> +#define ISI_DEFAULT_PDPS 4	/* Number of supported PDP contexts */
> +
>  struct isi_data {
>  	struct ofono_modem *modem;
>  	char const *ifname;
> @@ -407,6 +409,7 @@ static void isigen_post_online(struct ofono_modem *mo=
dem)
>  	struct isi_data *isi =3D ofono_modem_get_data(modem);
>  	struct ofono_gprs *gprs;
>  	struct ofono_gprs_context *gc;
> +	int i;
>  =

>  	DBG("(%p) with %s", modem, isi->ifname);
>  =

> @@ -420,13 +423,19 @@ static void isigen_post_online(struct ofono_modem *=
modem)
>  	ofono_call_barring_create(isi->modem, 0, "isimodem", isi->idx);
>  	ofono_call_meter_create(isi->modem, 0, "isimodem", isi->idx);
>  	ofono_radio_settings_create(isi->modem, 0, "isimodem", isi->idx);
> -	gprs =3D ofono_gprs_create(isi->modem, 0, "isimodem", isi->idx);
> -	gc =3D ofono_gprs_context_create(isi->modem, 0, "isimodem", isi->idx);
>  =

> -	if (gprs && gc)
> +	gprs =3D ofono_gprs_create(isi->modem, 0, "isimodem", isi->idx);
> +	if (!gprs)
> +		return;

Tiny nitpick, but please follow the coding style.  Specifically item M1.

> +	for (i =3D 0; i < ISI_DEFAULT_PDPS; i++) {
> +		gc =3D ofono_gprs_context_create(isi->modem, 0,
> +						"isimodem", isi->idx);
> +		if (!gc) {
> +			DBG("Failed to add context %d", i);
> +			break;
> +		}

And again, item M1 here

>  		ofono_gprs_add_context(gprs, gc);
> -	else
> -		DBG("Failed to add context");
> +	}
>  }
>  =

>  static int isigen_enable(struct ofono_modem *modem)

Regards,
-Denis

--===============7466837994204033700==--

