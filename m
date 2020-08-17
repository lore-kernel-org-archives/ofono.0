Content-Type: multipart/mixed; boundary="===============8166547738590851463=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 1/4] drivers: gemalto: add gprs-context driver
Date: Mon, 17 Aug 2020 14:23:21 -0500
Message-ID: <74ef862d-9027-45e6-7510-7c2b12959551@gmail.com>
In-Reply-To: <20200815214358.69100-2-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8166547738590851463==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sergey,

On 8/15/20 4:43 PM, Sergey Matyukevich wrote:
> Some gemalto modems provide USB ethernet interfaces for data path.
> Implement gprs-context driver for such modems to send data via
> USB ethernet rather than fallback to PPP.
> =

> Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
> ---
>   Makefile.am                         |   3 +-
>   drivers/gemaltomodem/gemaltomodem.c |   4 +-
>   drivers/gemaltomodem/gemaltomodem.h |   3 +
>   drivers/gemaltomodem/gprs-context.c | 280 ++++++++++++++++++++++++++++
>   4 files changed, 288 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/gemaltomodem/gprs-context.c
> =


This looks fine to me.  My only 2 nitpicks are:

1. We do not use S-o-B, so feel free to drop those in the future or I will =
just =

drop them when applying.

> +
> +static int gemalto_gprs_context_probe(struct ofono_gprs_context *gc,
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

2. We now prefer to use g_new0 for small structure allocations as these can=
't =

really fail on Linux userspace in practice.  Keeps the code shorter as well.

> +	gcd->chat =3D g_at_chat_clone(chat);
> +

Regards,
-Denis
--===============8166547738590851463==--

