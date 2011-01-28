Content-Type: multipart/mixed; boundary="===============5357546437014130457=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/5] ifxmodem: add NULL check
Date: Fri, 28 Jan 2011 12:59:38 +0100
Message-ID: <1296215978.1520.171.camel@aeonflux>
In-Reply-To: <1296215408-4946-2-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5357546437014130457==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

>  drivers/ifxmodem/radio-settings.c |   15 ++++++++++-----
>  1 files changed, 10 insertions(+), 5 deletions(-)
> =

> diff --git a/drivers/ifxmodem/radio-settings.c b/drivers/ifxmodem/radio-s=
ettings.c
> index fd590ae..6771e00 100644
> --- a/drivers/ifxmodem/radio-settings.c
> +++ b/drivers/ifxmodem/radio-settings.c
> @@ -104,11 +104,13 @@ static void ifx_query_rat_mode(struct ofono_radio_s=
ettings *rs,
>  	struct radio_settings_data *rsd =3D ofono_radio_settings_get_data(rs);
>  	struct cb_data *cbd =3D cb_data_new(cb, data);
>  =

> -	if (g_at_chat_send(rsd->chat, "AT+XRAT?", xrat_prefix,
> -					xrat_query_cb, cbd, g_free) =3D=3D 0) {
> -		CALLBACK_WITH_FAILURE(cb, -1, data);
> -		g_free(cbd);
> -	}
> +	if (cbd && g_at_chat_send(rsd->chat, "AT+XRAT?", xrat_prefix,
> +					xrat_query_cb, cbd, g_free) > 0)
> +		return;

I don't like these constructs. They quickly make the code unreadable and
really complex. Using a

	if (cbd =3D=3D NULL)
		goto failure;

would be a lot cleaner.

It might be just better to make cb_data_new use g_new0 instead of
g_try_new0 and remove all checks for cb_data.

Regards

Marcel



--===============5357546437014130457==--

