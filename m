Content-Type: multipart/mixed; boundary="===============7766223426055026841=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] ifx: remove setting to offline during modem enable
Date: Wed, 02 Feb 2011 17:55:20 +0100
Message-ID: <1296665720.1520.333.camel@aeonflux>
In-Reply-To: <1296665571-2209-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7766223426055026841==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

>  plugins/ifx.c |   21 ++-------------------
>  1 files changed, 2 insertions(+), 19 deletions(-)
> =

> diff --git a/plugins/ifx.c b/plugins/ifx.c
> index 411c012..ae53193 100644
> --- a/plugins/ifx.c
> +++ b/plugins/ifx.c
> @@ -345,23 +345,6 @@ error:
>  	ofono_modem_set_powered(modem, FALSE);
>  }
>  =

> -static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_da=
ta)
> -{
> -	struct ofono_modem *modem =3D user_data;
> -	struct ifx_data *data =3D ofono_modem_get_data(modem);
> -
> -	DBG("");
> -
> -	if (!ok) {
> -		shutdown_device(data);
> -		ofono_modem_set_powered(modem, FALSE);
> -		return;
> -	}
> -
> -	g_at_chat_send(data->dlcs[AUX_DLC], "AT+XGENDATA", NULL,
> -					xgendata_query, modem, NULL);
> -}
> -
>  static gboolean dlc_setup(gpointer user_data)
>  {
>  	struct ofono_modem *modem =3D user_data;
> @@ -378,8 +361,8 @@ static gboolean dlc_setup(gpointer user_data)
>  	g_at_chat_set_slave(data->dlcs[GPRS2_DLC], data->dlcs[NETREG_DLC]);
>  	g_at_chat_set_slave(data->dlcs[GPRS3_DLC], data->dlcs[NETREG_DLC]);
>  =

> -	g_at_chat_send(data->dlcs[AUX_DLC], "AT+CFUN=3D4", NULL,
> -					cfun_enable, modem, NULL);
> +	g_at_chat_send(data->dlcs[AUX_DLC], "AT+XGENDATA", NULL,
> +					xgendata_query, modem, NULL);

I toughth we talked about CFUN=3D4 in ifx_disable on IRC. This one is
needed to bring the modem up in offline mode. I'd rather not remove this
one.

Regards

Marcel



--===============7766223426055026841==--

