Content-Type: multipart/mixed; boundary="===============5464227682615400063=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] plugin: Add plugin for Linktop LW27x data cards
Date: Mon, 14 Feb 2011 13:54:16 -0600
Message-ID: <4D598868.5060403@gmail.com>
In-Reply-To: <1297314940-4315-1-git-send-email-mendapara.amit@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5464227682615400063==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Amit,

On 02/09/2011 11:15 PM, Amit Mendapara wrote:
> Signed-off-by: Amit Mendapara <mendapara.amit@gmail.com>

Please note that we do not use the Signed-off-by.  Configure your git
settings not to send this.

> ---
>  Makefile.am       |    3 +
>  plugins/linktop.c |  357 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 360 insertions(+), 0 deletions(-)
>  create mode 100644 plugins/linktop.c

So I applied this patch, however there's one thing I'd like you to fix:

> +static int linktop_enable(struct ofono_modem *modem)
> +{
> +	struct linktop_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%p", modem);
> +
> +	data->modem =3D open_device(modem, "Modem", "Modem: ");
> +	if (data->modem =3D=3D NULL)
> +		return -EINVAL;
> +
> +	g_at_chat_set_disconnect_function(data->modem,
> +						linktop_disconnect, modem);
> +
> +	data->control =3D open_device(modem, "Control", "Control: ");
> +	if (data->control =3D=3D NULL) {
> +		g_at_chat_unref(data->modem);
> +		data->modem =3D NULL;
> +		return -EIO;
> +	}
> +
> +	g_at_chat_send(data->control, "ATE0 +CMEE=3D1", none_prefix,
> +						NULL, NULL, NULL);
> +
> +	g_at_chat_send(data->modem, "AT", none_prefix,
> +						NULL, NULL, NULL);
> +
> +	g_at_chat_send(data->modem, "AT &F", none_prefix,
> +						NULL, NULL, NULL);
> +
> +	g_at_chat_send(data->control, "AT+CFUN=3D1", none_prefix,
> +					cfun_enable, modem, NULL);
> +

oFono expects the modem driver to power up the modem in an 'offline'
state.  So using CFUN=3D1 is fine, but it might need to be followed by a
CFUN=3D4 afterward.  Look at a few other drivers to see the creative ways
we have tried to address this.

> +	return -EINPROGRESS;
> +}

Regards,
-Denis

--===============5464227682615400063==--

