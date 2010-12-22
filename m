Content-Type: multipart/mixed; boundary="===============0294675295077590376=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 6/8] plugins: add gps atom to mbm
Date: Wed, 22 Dec 2010 15:58:53 -0600
Message-ID: <4D12749D.3090103@gmail.com>
In-Reply-To: <1292531423-22316-7-git-send-email-rafael.zurita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0294675295077590376==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

>  =

> -	if (modem_dev =3D=3D NULL || data_dev =3D=3D NULL)
> +	if (modem_dev =3D=3D NULL || data_dev =3D=3D NULL || gps_dev =3D=3D NUL=
L)
>  		return -EINVAL;

I don't think that failing because the gps device isn't set is such a
good idea.  There might be mbm cards without a gps node.  Let udev
autodetection handle this part.

>  =

>  	data->modem_port =3D create_port(modem_dev);
> @@ -383,6 +389,20 @@ static int mbm_enable(struct ofono_modem *modem)
>  	if (getenv("OFONO_AT_DEBUG"))
>  		g_at_chat_set_debug(data->data_port, mbm_debug, "Data: ");
>  =

> +	data->gps_port =3D create_port(gps_dev);
> +	if (data->gps_port =3D=3D NULL) {
> +		g_at_chat_unref(data->data_port);
> +		data->data_port =3D NULL;
> +
> +		g_at_chat_unref(data->modem_port);
> +		data->modem_port =3D NULL;
> +
> +		return -EIO;
> +	}

So from what I understand we have to send AT*E2GPSNPD to the GPS port in
order to turn it from a regular AT command port into a GPS port.  At
this point this port is no longer usable for AT commands.  Right?

> +
> +	if (getenv("OFONO_AT_DEBUG"))
> +		g_at_chat_set_debug(data->gps_port, mbm_debug, "GPS: ");
> +
>  	g_at_chat_set_disconnect_function(data->data_port,
>  						mbm_disconnect, modem);
>  =

> @@ -415,6 +435,9 @@ static void cfun_disable(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
>  	g_at_chat_unref(data->data_port);
>  	data->data_port =3D NULL;
>  =

> +	g_at_chat_unref(data->gps_port);
> +	data->gps_port =3D NULL;
> +
>  	if (ok)
>  		ofono_modem_set_powered(modem, FALSE);
>  }
> @@ -541,6 +564,9 @@ static void mbm_post_online(struct ofono_modem *modem)
>  					OFONO_GPRS_CONTEXT_TYPE_MMS);
>  		ofono_gprs_add_context(data->gprs, data->gc);
>  	}
> +
> +	data->gps =3D ofono_gps_create(modem, 0,
> +					"mbmmodem", data->gps_port);

If my previous comment is correct, then the gps driver should be running
on the dev port, not on the gps port.

>  }
>  =

>  static struct ofono_modem_driver mbm_driver =3D {

Regards,
-Denis

--===============0294675295077590376==--

