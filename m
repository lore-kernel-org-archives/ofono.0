Content-Type: multipart/mixed; boundary="===============2955287667679008292=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] added voice call support to ublox plugin
Date: Thu, 09 Aug 2018 11:49:30 -0500
Message-ID: <0a42eaea-df9e-273c-9785-24c25e559137@gmail.com>
In-Reply-To: <1533798051-2920-1-git-send-email-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2955287667679008292==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

On 08/09/2018 02:00 AM, Giacinto Cifelli wrote:
> ---
>   plugins/ublox.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> =


I went ahead and applied this patch, but see my comment below:

> diff --git a/plugins/ublox.c b/plugins/ublox.c
> index cfcdd3f..28aaab4 100644
> --- a/plugins/ublox.c
> +++ b/plugins/ublox.c
> @@ -40,6 +40,7 @@
>   #include <ofono/gprs-context.h>
>   #include <ofono/netmon.h>
>   #include <ofono/lte.h>
> +#include <ofono/voicecall.h>
>   =

>   #include <drivers/atmodem/atutil.h>
>   #include <drivers/atmodem/vendor.h>
> @@ -286,6 +287,14 @@ static void ublox_pre_sim(struct ofono_modem *modem)
>   	DBG("%p", modem);
>   =

>   	ofono_devinfo_create(modem, 0, "atmodem", data->aux);
> +	/*
> +	 * Call support is technically possible only after sim insertion
> +	 * with the module online. However the EMERGENCY_SETUP procedure of
> +	 * the 3GPP TS_24.008 is triggered by the same AT command,
> +	 * and namely 'ATD112;' and 'ATD911;'. Therefore it makes sense to
> +	 * add the voice support as soon as possible.
> +	 */
> +	ofono_voicecall_create(modem, 0, "atmodem", data->aux);

So in general it is discouraged to use the 'atmodem' voicecall driver =

due to the heavy +CLCC polling involved.  Your battery drains real fast =

in that case.  uBlox has its own vendor unsolicited notification that =

removes the need for most of the polling.  See +UCALLSTAT for details.

>   	sim =3D ofono_sim_create(modem, data->vendor_family, "atmodem",
>   					data->aux);
>   =

> =


Regards,
-Denis

--===============2955287667679008292==--

