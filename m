Content-Type: multipart/mixed; boundary="===============7958006968512848483=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [PATCH] ublox: Do not leave vendor_family unset
Date: Mon, 01 Apr 2019 05:29:03 +0200
Message-ID: <993f3368-d77d-09f6-d1d7-a60e09d55b4b@norrbonn.se>
In-Reply-To: <20190331211919.10720-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7958006968512848483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On 31/03/2019 23:19, richard.rojfors(a)gmail.com wrote:
> From: Richard R=C3=B6jfors <richard@puffinpack.se>
> =

> In a recent patch vendor family was only set if the device
> did not support USBCONF, but that resulted in drivers
> being registered the "generic" vendor. That caused
> for instance netreg to use incorrect cmer mode and fail
> on TOBY-L210.

This patch is correct.  Please apply it, Denis.

Thanks for testing and reporting, Richard.

/Jonas

> ---
>   plugins/ublox.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> =

> diff --git a/plugins/ublox.c b/plugins/ublox.c
> index dc001765..355bdf9e 100644
> --- a/plugins/ublox.c
> +++ b/plugins/ublox.c
> @@ -227,6 +227,8 @@ static void query_model_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
>   =

>   	DBG("Model: %s", data->model->name);
>   =

> +	data->vendor_family =3D OFONO_VENDOR_UBLOX;
> +
>   	if (data->model->flags & UBLOX_F_HAVE_USBCONF) {
>   		if (g_at_chat_send(data->aux, "AT+UUSBCONF?", uusbconf_prefix,
>   					query_usbconf_cb, modem, NULL))
> @@ -234,8 +236,6 @@ static void query_model_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
>   =

>   		ofono_error("Unable to query USB configuration");
>   		goto fail;
> -	} else {
> -		data->vendor_family =3D OFONO_VENDOR_UBLOX;
>   	}
>   =

>   	if (g_at_chat_send(data->aux, "AT+CFUN=3D4", none_prefix,
>=20

--===============7958006968512848483==--

